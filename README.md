# AK620 Digital Air Cooler Monitor on Linux

This project enables monitoring of temperature and CPU utilization on DeepCool's AK620 digital air cooler for Linux systems. The solution has been tested on Ubuntu 23 with a Ryzen 7950X3D CPU. Customization may be required in the temperature section for other CPUs.

## Dependencies

This script requires the following dependencies:
- Python 3
- `hidapi`
- `psutil`

You can install by running the provided `setup.sh` script:
```bash
./setup.sh
```

## Troubleshooting

1) If you encounter any errors related to HIDAPI or psutil, ensure that the dependencies are installed correctly by running the setup.sh script.
2) Make sure the AK620 digital air cooler is properly connected to your system and that the correct Vendor ID and Product ID are set in the script.

Credits
https://github.com/Algorithm0/deepcool-digital-info