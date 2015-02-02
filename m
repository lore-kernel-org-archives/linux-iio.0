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
Subject: [PATCH RESEND v3 1/3] mfd/axp20x: change battery cell name to fuel gauge
Date: Mon,  2 Feb 2015 15:41:41 -0800
Message-Id: <94002239142b80ddd090f39325c9adaa17c9da9f.1422909564.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
References: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
References: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Name changes to the battery cell structure to a
more generic cell type: fuel gauge.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Acked-By: Sebastian Reichel <sre@kernel.org>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/mfd/axp20x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

v1: 01/07/14
v2: 01/22/14
- replaced the const in axp20x_acpi_match declaration
v3: same as v2

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index b1b580a..0acbe52 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -87,7 +87,7 @@ static struct resource axp20x_pek_resources[] = {
 	},
 };
 
-static struct resource axp288_battery_resources[] = {
+static struct resource axp288_fuel_gauge_resources[] = {
 	{
 		.start = AXP288_IRQ_QWBTU,
 		.end   = AXP288_IRQ_QWBTU,
@@ -350,9 +350,9 @@ static struct mfd_cell axp288_cells[] = {
 		.resources = axp288_charger_resources,
 	},
 	{
-		.name = "axp288_battery",
-		.num_resources = ARRAY_SIZE(axp288_battery_resources),
-		.resources = axp288_battery_resources,
+		.name = "axp288_fuel_gauge",
+		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
+		.resources = axp288_fuel_gauge_resources,
 	},
 	{
 		.name = "axp288_pmic_acpi",
-- 
1.9.1
