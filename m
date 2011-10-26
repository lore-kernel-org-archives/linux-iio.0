Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de,
	gregkh@suse.de,
	thomas.petazzoni@free-electrons.com,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/7] staging:iio:snoop example of rawest level of push interface
Date: Wed, 26 Oct 2011 16:54:18 +0100
Message-Id: <1319644458-30630-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
References: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is called garbage in it's Kconfig entry for a reason,
but it shows how things work at the lowest possible level.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig     |    5 ++
 drivers/staging/iio/Makefile    |    1 +
 drivers/staging/iio/iio_snoop.c |   94 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ca139fb..f1dbc2c 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -12,6 +12,11 @@ menuconfig IIO
 	  drivers/staging/iio/Documentation for more information.
 if IIO
 
+config IIO_SNOOP
+       tristate "dubious hack driver"
+       help
+         Garbage.
+
 config IIO_ST_HWMON
        tristate "Hwmon driver that uses channels specified via iio maps"
        depends on HWMON
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index d5ca5cf..bd639ed 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -18,6 +18,7 @@ iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
 obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 
 obj-$(CONFIG_IIO_ST_HWMON) += iio_hwmon.o
+obj-$(CONFIG_IIO_SNOOP) += iio_snoop.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/staging/iio/iio_snoop.c b/drivers/staging/iio/iio_snoop.c
new file mode 100644
index 0000000..1f5abdb
--- /dev/null
+++ b/drivers/staging/iio/iio_snoop.c
@@ -0,0 +1,94 @@
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include "buffer.h"
+#include "inkern.h"
+
+static int iio_snoop_store_to(struct iio_buffer *buffer, u8 *data, s64 timestamp)
+{
+	printk(" snoop %d %d\n", data[0], data[1]);
+	return 0;
+}
+
+static struct iio_buffer_access_funcs iio_snoop_access = {
+	.store_to = &iio_snoop_store_to,
+};
+
+struct iio_snoop_buffer {
+	struct iio_buffer buf;
+};
+
+struct iio_snoop_state {
+	struct iio_channel **channels;
+	struct iio_snoop_buffer buf;
+};
+
+static int __devinit iio_snoop_probe(struct platform_device *pdev)
+{
+	struct iio_snoop_state *st;
+	int ret;
+
+	printk("probing snoop\n");
+	st= kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL)
+	    return -ENOMEM;
+
+	st->channels = iio_st_channel_get_all(&pdev->dev, NULL);
+	if (IS_ERR(st->channels)) {
+		ret = PTR_ERR(st->channels);
+		goto error_free_state;
+	}
+
+	st->buf.buf.access = &iio_snoop_access;
+	//cheat.
+	st->buf.buf.scan_mask = kzalloc(sizeof(long)*10, GFP_KERNEL);
+	INIT_LIST_HEAD(&st->buf.buf.demux_list);
+	/* naughty ;) */
+	set_bit(3, st->buf.buf.scan_mask);
+
+	platform_set_drvdata(pdev, st);
+	printk("update bufffers\bn");
+	iio_update_buffers(st->channels[0]->indio_dev, &st->buf.buf, NULL);
+
+	return 0;
+error_free_state:
+	kfree(st);
+	return ret;
+}
+
+static int __devexit iio_snoop_remove(struct platform_device *pdev)
+{
+	struct iio_snoop_state *st = platform_get_drvdata(pdev);
+	iio_update_buffers(st->channels[0]->indio_dev, NULL, &st->buf.buf);
+	iio_st_channel_release_all(st->channels);
+
+	kfree(st);
+	return 0;
+}
+
+static struct platform_driver __refdata iio_snoop_driver = {
+	.driver = {
+		.name = "iio_snoop",
+		.owner = THIS_MODULE,
+	},
+	.probe = iio_snoop_probe,
+	.remove = __devexit_p(iio_snoop_remove),
+};
+
+static int iio_snoop_init(void)
+{
+	return platform_driver_register(&iio_snoop_driver);
+}
+module_init(iio_snoop_init);
+
+static void iio_snoop_exit(void)
+{
+	platform_driver_unregister(&iio_snoop_driver);
+}
+module_exit(iio_snoop_exit);
+
+MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
+MODULE_DESCRIPTION("IIO snoop buffer driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.7
