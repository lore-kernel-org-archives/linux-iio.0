Return-Path: <jacob.jun.pan@linux.intel.com>
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	IIO <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Cc: Carlo Caione <carlo@caione.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Aaron Lu <aaron.lu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/3] iio: adc: Add module device table for autoloading
Date: Tue, 11 Nov 2014 11:30:08 -0800
Message-Id: <1415734210-5657-2-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Aaron Lu <aaron.lu@intel.com>

Add the module device id table so that the driver can be automatically
loaded once the platform device is created.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 4800286..4a6cf43 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -238,15 +238,23 @@ static int axp288_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id axp288_adc_id_table[] = {
+	{ .name = "axp288_adc" },
+	{},
+};
+
 static struct platform_driver axp288_adc_driver = {
 	.probe = axp288_adc_probe,
 	.remove = axp288_adc_remove,
+	.id_table = axp288_adc_id_table,
 	.driver = {
 		.name = "axp288_adc",
 		.owner = THIS_MODULE,
 	},
 };
 
+MODULE_DEVICE_TABLE(platform, axp288_adc_id_table);
+
 module_platform_driver(axp288_adc_driver);
 
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
-- 
1.9.1
