Return-Path: <quentin.schulz@free-electrons.com>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] hwmon: iio_hwmon: delay probing with late_initcall
Date: Thu,  1 Sep 2016 16:05:03 +0200
Message-Id: <1472738705-20145-2-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

iio_channel_get_all returns -ENODEV when it cannot find either phandles and
properties in the Device Tree or channels whose consumer_dev_name matches
iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
which might be probed after iio_hwmon.

This makes sure iio_hwmon is probed after all iio drivers which provides
channels to iio_hwmon are probed, be they present in the DT or using
iio_map_list.

This replaces module_platform_driver() by an explicit code variant which
calls late_initcall() install of module_init(), meaning it probes after
all the drivers using module_init() as their init.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v4:
 - use platform_driver_register instead of platform_register_drivers,

v3:
 - use late_initcall instead of deferring probe,

 drivers/hwmon/iio_hwmon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index b550ba5..c509779 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -192,7 +192,17 @@ static struct platform_driver __refdata iio_hwmon_driver = {
 	.remove = iio_hwmon_remove,
 };
 
-module_platform_driver(iio_hwmon_driver);
+static int __init iio_hwmon_late_init(void)
+{
+	return platform_driver_register(&iio_hwmon_driver);
+}
+late_initcall(iio_hwmon_late_init);
+
+static void __exit iio_hwmon_exit(void)
+{
+	platform_driver_unregister(&iio_hwmon_driver);
+}
+module_exit(iio_hwmon_exit);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("IIO to hwmon driver");
-- 
2.5.0
