Return-Path: <todd.e.brandt@linux.intel.com>
From: Todd Brandt <todd.e.brandt@linux.intel.com>
To: sre@kernel.org,
	dbaryshkov@gmail.com,
	david.woodhouse@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com,
	jacob.jun.pan@linux.intel.com,
	sameo@linux.intel.com,
	lee.jones@linaro.org,
	dwmw2@infradead.org,
	jic23@kernel.org
Subject: [PATCH RESEND v3 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Mon,  2 Feb 2015 15:41:40 -0800
Message-Id: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

New power_supply driver at driver/power which interfaces with the
axp20x mfd driver as a cell. Provides battery info, monitors for
changes, and generates alerts on temperature and capacity issues

Todd Brandt (3):
  mfd/axp20x: change battery cell name to fuel gauge
  mfd/axp20x: add support for fuel gauge cell
  X-Power AXP288 PMIC Fuel Gauge Driver

v1: 01/07/14
v2: 01/22/14
- replaced the const in axp20x_acpi_match declaration
- reformatted the commit text
- added IIO as driver dependency
- moved debug info to debugfs in file fuelgauge
- added HEALTH_COLD value to health calculation
- added better cleanup to remove call
        cancelling any delayed work calls
        unregistration of the power_supply
v3: 01/28/14
- moved debugs create and init config regs after error case
- freed the virqs in the remove function
- remove .owner field as it is populated automatically

 drivers/mfd/axp20x.c              |    8 +-
 drivers/power/Kconfig             |    9 +
 drivers/power/Makefile            |    1 +
 drivers/power/axp288_fuel_gauge.c | 1151 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h        |   43 +-
 5 files changed, 1206 insertions(+), 6 deletions(-)
 create mode 100644 drivers/power/axp288_fuel_gauge.c

-- 
1.9.1
