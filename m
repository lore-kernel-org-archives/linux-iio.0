Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/11] staging/iio: (iio_hwmon) Basic devicetree support
Date: Thu, 31 Jan 2013 13:43:00 -0800
Message-Id: <1359668588-13678-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

Add 'iio-hwmon' OF compatibility table entry to enable OF matches.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/iio/iio_hwmon.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index 7f260ea..6a5bc5f 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -165,10 +165,16 @@ static int iio_hwmon_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id iio_hwmon_of_match[] = {
+	{ .compatible = "iio-hwmon", },
+	{ }
+};
+
 static struct platform_driver __refdata iio_hwmon_driver = {
 	.driver = {
 		.name = "iio_hwmon",
 		.owner = THIS_MODULE,
+		.of_match_table = iio_hwmon_of_match,
 	},
 	.probe = iio_hwmon_probe,
 	.remove = iio_hwmon_remove,
-- 
1.7.9.7
