# Zabbix

Educational repository for learning Zabbix monitoring, infrastructure observability, and basic server monitoring configuration.

## Overview

This project contains Zabbix setup experiments, configuration examples, and learning materials for practicing infrastructure monitoring with Linux, Bash, databases, and networking tools.

> This repository is intended for education and practice, not production deployment.

## Table of Contents

- [Features](#features)
- [Technologies](#technologies)
- [Installation](#installation)
- [Usage](#usage)
- [Topics Covered](#topics-covered)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Features

- Zabbix configuration practice
- Linux server monitoring examples
- Host and network monitoring exercises
- Trigger and alert experimentation
- Template-based monitoring practice
- Bash-based installation script

## Technologies

- Zabbix
- Linux
- Bash
- MySQL
- PHP frontend
- Nginx
- Zabbix Agent

## Installation

Clone the repository:

```bash
git clone https://github.com/sevii-ia/Zabbix.git
cd Zabbix
````

Make the installation script executable:

```bash
chmod +x install.sh
```

Run the script:

```bash
./install.sh
```

## Usage

After installation, open Zabbix in your browser:

```text
http://localhost
```

Use the Zabbix web interface to configure hosts, templates, triggers, alerts, and monitoring dashboards.

## Topics Covered

* Host monitoring
* Network monitoring
* Metrics collection
* Triggers and alerts
* Templates
* Linux server monitoring
* Docker monitoring
* DevOps monitoring basics

## Troubleshooting

If the install script fails, check that:

* You are running Ubuntu 24.04 or a compatible system
* You have `sudo` privileges
* MySQL is installed and running
* The Zabbix repository package URL is still valid
* The `install.sh` script is complete before running it

The current `install.sh` appears to be a single-line draft and may need formatting or completion before reliable execution.

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.
