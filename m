Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34916 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966186AbbBEAYt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 4 Feb 2015 19:24:49 -0500
From: Todd Brandt <todd.e.brandt@linux.intel.com>
To: sre@kernel.org, dbaryshkov@gmail.com
Cc: dwmw2@infradead.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
	jacob.jun.pan@linux.intel.com, sameo@linux.intel.com,
	lee.jones@linaro.org, david.woodhouse@intel.com, jic23@kernel.org
Subject: [PATCH v4 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Wed,  4 Feb 2015 16:24:35 -0800
Message-Id: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

New power_supply driver at driver/power which interfaces with the
axp20x mfd driver as a cell. Provides battery info, monitors for
changes, and generates alerts on temperature and capacity issues

Sebestian, please review the patch set and consider it for 3.20 rc1.
I've applied it over git.infradead.org/battery-2.6.git/master and
verified that it works. Thanks.

Todd Brandt (3):
  mfd/axp20x: change battery cell name to fuel gauge
  mfd/axp20x: add support for fuel gauge cell
  X-Power AXP288 PMIC Fuel Gauge Driver

v1: 01/07/15
v2: 01/22/15
- replaced the const in axp20x_acpi_match declaration
- reformatted the commit text
- added IIO as driver dependency
- moved debug info to debugfs in file fuelgauge
- added HEALTH_COLD value to health calculation
- added better cleanup to remove call
        cancelling any delayed work calls
        unregistration of the power_supply
v3: 01/28/15
- moved debugs create and init config regs after error case
- freed the virqs in the remove function
- remove .owner field as it is populated automatically
v4: 02/04/15
- re-applied to Sebastian Reichel's repo git.infradead.org/battery-2.6.git

 drivers/mfd/axp20x.c              |    8 +-
 drivers/power/Kconfig             |    9 +
 drivers/power/Makefile            |    1 +
 drivers/power/axp288_fuel_gauge.c | 1151 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h        |   43 +-
 5 files changed, 1206 insertions(+), 6 deletions(-)
 create mode 100644 drivers/power/axp288_fuel_gauge.c

-- 
2.1.0

