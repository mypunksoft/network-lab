#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Использование: $0 arch|debian|windows10" >&2
}

if (( $# == 0 )); then
    if [[ ! -t 0 ]]; then
        usage
        exit 2
    fi
    printf 'Для какой ВМ включить запись пакетов?\n1) arch\n2) debian\n3) windows10\n'
    read -r -p 'Номер: ' choice
    case "$choice" in
        1) vm=arch ;;
        2) vm=debian ;;
        3) vm=windows10 ;;
        *) echo 'Неверный номер' >&2; exit 2 ;;
    esac
elif (( $# == 1 )); then
    vm=$1
else
    usage
    exit 2
fi

case "$vm" in
    arch|debian|windows10) ;;
    *) usage; exit 2 ;;
esac

state=$(virsh -c qemu:///system domstate "$vm")
if [[ $state != running ]]; then
    echo "ВМ $vm сейчас выключена. Сначала запустите её в Cockpit." >&2
    exit 1
fi

unit="vmcap@$vm.service"
sudo systemctl start "$unit"
sleep 1
if ! systemctl is-active --quiet "$unit"; then
    echo "Запись не запустилась. Подробности: sudo journalctl -u $unit -n 20" >&2
    exit 1
fi

echo "Запись трафика $vm включена. Файлы: /mnt/disk1/vm-pcaps/$vm/"
echo "Остановить вручную: sudo systemctl stop $unit"
echo 'При выключении ВМ запись остановится сама.'
