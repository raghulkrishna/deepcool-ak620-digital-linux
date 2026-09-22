# DeepCool AK Series Digital Air Cooler Monitor on Linux

This project enables monitoring of temperature and CPU utilization on DeepCool's AK series digital air cooler for Linux systems.

## Dependencies

This script requires the following dependencies:
- Python 3
- `hid`
- `psutil`

Available supported models:
- `ak620`
- `ak500s`

### Direct binary install (easiest option)
```
sudo wget https://raw.githubusercontent.com/mooseh/deepcool-ak620-digital-linux/refs/heads/main/dist/cooler-display -O /usr/local/bin/cooler-display
sudo chmod +x /usr/local/bin/cooler-display
sudo wget https://raw.githubusercontent.com/mooseh/deepcool-ak620-digital-linux/refs/heads/main/deepcool-ak-series-digital.service -O /lib/systemd/system/deepcool-ak-series-digital.service
```

Before enabling the service, edit `ExecStart` in `/lib/systemd/system/deepcool-ak-series-digital.service` to match your model, sensor, and preferred options (see the flags list below), then apply it:
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now deepcool-ak-series-digital.service
```

### Building from source Step-by-Step Guide

1. **Clone the Repository**: The script and necessary configuration files are hosted on GitHub. Use git to clone the repository to your local machine.
    ```bash
    git clone https://github.com/raghulkrishna/deepcool-ak620-digital-linux
    ```

2. **Navigate to the Project Directory**: Change your current directory to the newly cloned project folder.
    ```bash
    cd deepcool-ak620-digital-linux
    ```

2. **Install Python Dependencies**: First, you need to install the necessary Python libraries, `hid` and `psutil`. These libraries allow the script to interact with the hardware and monitor system resources.

    Create a virtual environment in the venv folder and use it
    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```

    Open a terminal and run the following commands:
    ```bash
    pip3 install -r requirements.txt
    ```
    Note: If you encounter permission errors, try adding --user to install the packages for your user only or use sudo to install them system-wide (not recommended for `pip`).

4. **Look up the hardware temperature sensor**: Retrieve hardware temperature sensor label in the system. Run the following Python code snippet.
    ```bash
    python -c "import psutil; print(psutil.sensors_temperatures().keys());"
    ```

5. **Build the binary**:
    ```bash
    pyinstaller --onefile --name cooler-display main.py
    ```

6. **Test the binary**:
    #### default (AK620 with temp and usage)
    ```bash
    ./dist/cooler-display
    ```
    #### ak520s model
    ```bash
    ./dist/cooler-display --model ak500s
    ```

    #### Other run modes, see options below:
    ```
    options:
        -h, --help            show this help message and exit
        --model {ak620,ak500s}
                                Specify the model of the cooler.
        --disable-temp, -dt   Show CPU temperature on the cooler.
        --disable-utils, -du  Show CPU utilization on the cooler.
        --sensor, -s SENSOR   Set the sensor to read the temperature from.
        --interval, -i INTERVAL Set the update interval in seconds: default(2)
    ```

## Troubleshooting

1) If you encounter any errors related to HIDAPI or psutil, ensure the dependencies are installed correctly (`pip3 install -r requirements.txt`).
2) Make sure the cooler is properly connected to your system and that the correct `--model` flag is set for your hardware.
3) How to verify Product ID and Vendor ID ?  use lsusb -v to get the list of devices ans search for your cooler.
4) `hid.HIDException`: unable to open device.
You need to configure udev:
```bash
sudo mkdir -p /etc/udev/rules.d/
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"' | sudo tee /etc/udev/rules.d/92-viia.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Credits
https://github.com/Algorithm0/deepcool-digital-info