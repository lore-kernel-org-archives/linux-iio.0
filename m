Return-Path: <poeschel@lemonage.de>
From: Lars Poeschel <poeschel@lemonage.de>
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Subject: [PATCH v4 4/5] i2c: add viperboard i2c master driver
Date: Mon, 19 Nov 2012 16:36:04 +0100
Cc: linus.walleij@linaro.org,
 sameo@linux.intel.com,
 linux-kernel@vger.kernel.org,
 jic23@cam.ac.uk,
 khali@linux-fr.org,
 ben-linux@fluff.org,
 w.sang@pengutronix.de,
 grant.likely@secretlab.ca,
 linux-iio@vger.kernel.org
References: <1352126906-4560-1-git-send-email-larsi@wh2.tu-dresden.de> <1352126906-4560-4-git-send-email-larsi@wh2.tu-dresden.de>
In-Reply-To: <1352126906-4560-4-git-send-email-larsi@wh2.tu-dresden.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201211191636.04541.poeschel@lemonage.de>
List-ID: <linux-iio@vger.kernel.org>

As I got no feedback on the previous patch yet, I answer myself upcounting
the patch version. I had to change the setting of the bus frequency as
there was no usb capable memory used in patch v3
=2D- >8 --
=46rom 7a0759ee25a19f7f623543f491be5dee83f195a7 Mon Sep 17 00:00:00 2001
=46rom: Lars Poeschel <poeschel@lemonage.de>
Date: Fri, 12 Oct 2012 14:12:23 +0200
Subject: [PATCH v4 4/5] i2c: add viperboard i2c master driver

This adds the mfd cell to use the i2c part of the Nano River Technologies
viperboard as i2c master.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
=2D--
 drivers/i2c/busses/Kconfig          |   10 +
 drivers/i2c/busses/Makefile         |    1 +
 drivers/i2c/busses/i2c-viperboard.c |  480 +++++++++++++++++++++++++++++++=
++++
 drivers/mfd/viperboard.c            |    3 +
 include/linux/mfd/viperboard.h      |    2 +
 5 files changed, 496 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-viperboard.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 65dd599..405a0fb 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -819,6 +819,16 @@ config I2C_TINY_USB
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-tiny-usb.
=20
+config I2C_VIPERBOARD
+	tristate "Viperboard I2C master support"
+	depends on MFD_VIPERBOARD && USB
+	help
+	  Say yes here to access the I2C part of the Nano River
+	  Technologies Viperboard as I2C master.
+          See viperboard API specification and Nano
+          River Tech's viperboard.h for detailed meaning
+          of the module parameters.
+
 comment "Other I2C/SMBus bus drivers"
=20
 config I2C_ACORN
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 2d33d62..7e8befd 100644
=2D-- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_I2C_PARPORT)	+=3D i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+=3D i2c-parport-light.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+=3D i2c-taos-evm.o
 obj-$(CONFIG_I2C_TINY_USB)	+=3D i2c-tiny-usb.o
+obj-$(CONFIG_I2C_VIPERBOARD)	+=3D i2c-viperboard.o
=20
 # Other I2C/SMBus bus drivers
 obj-$(CONFIG_I2C_ACORN)		+=3D i2c-acorn.o
diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-v=
iperboard.c
new file mode 100644
index 0000000..f5fa20d
=2D-- /dev/null
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -0,0 +1,480 @@
+/*
+ *  Nano River Technologies viperboard i2c master driver
+ *
+ *  (C) 2012 by Lemonage GmbH
+ *  Author: Lars Poeschel <poeschel@lemonage.de>
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute  it and/or modify =
it
+ *  under  the terms of  the GNU General  Public License as published by t=
he
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#include <linux/usb.h>
+#include <linux/i2c.h>
+
+#include <linux/mfd/viperboard.h>
+
+struct vprbrd_i2c {
+	struct i2c_adapter i2c;
+	u8 bus_freq_param;
+};
+
+/* i2c bus frequency module parameter */
+static u8 i2c_bus_param;
+static unsigned int i2c_bus_freq =3D 100;
+module_param(i2c_bus_freq, int, 0);
+MODULE_PARM_DESC(i2c_bus_freq,
+	"i2c bus frequency in khz (default is 100) valid values: 10, 100, 200, 40=
0, 1000, 3000, 6000");
+
+static int vprbrd_i2c_status(struct i2c_adapter *i2c,
+	struct vprbrd_i2c_status *status, bool prev_error)
+{
+	u16 bytes_xfer;
+	int ret;
+	struct vprbrd *vb =3D (struct vprbrd *)i2c->algo_data;
+
+	/* check for protocol error */
+	bytes_xfer =3D sizeof(struct vprbrd_i2c_status);
+
+	ret =3D usb_control_msg(vb->usb_dev, usb_rcvctrlpipe(vb->usb_dev, 0),
+		VPRBRD_USB_REQUEST_I2C, VPRBRD_USB_TYPE_IN, 0x0000, 0x0000,
+		status, bytes_xfer, VPRBRD_USB_TIMEOUT_MS);
+
+	if (ret !=3D bytes_xfer)
+		prev_error =3D true;
+
+	if (prev_error) {
+		dev_err(&i2c->dev, "failure in usb communication\n");
+		return -EREMOTEIO;
+	}
+
+	dev_dbg(&i2c->dev, "  status =3D %d\n", status->status);
+	if (status->status !=3D 0x00) {
+		dev_err(&i2c->dev, "failure: i2c protocol error\n");
+		return -EPROTO;
+	}
+	return 0;
+}
+
+static int vprbrd_i2c_receive(struct usb_device *usb_dev,
+	struct vprbrd_i2c_read_msg *rmsg, int bytes_xfer)
+{
+	int ret, bytes_actual;
+	int error =3D 0;
+
+	/* send the read request */
+	ret =3D usb_bulk_msg(usb_dev,
+		usb_sndbulkpipe(usb_dev, VPRBRD_EP_OUT), rmsg,
+		sizeof(struct vprbrd_i2c_read_hdr), &bytes_actual,
+		VPRBRD_USB_TIMEOUT_MS);
+
+	if ((ret < 0)
+		|| (bytes_actual !=3D sizeof(struct vprbrd_i2c_read_hdr))) {
+		dev_err(&usb_dev->dev, "failure transmitting usb\n");
+		error =3D -EREMOTEIO;
+	}
+
+	/* read the actual data */
+	ret =3D usb_bulk_msg(usb_dev,
+		usb_rcvbulkpipe(usb_dev, VPRBRD_EP_IN), rmsg,
+		bytes_xfer, &bytes_actual, VPRBRD_USB_TIMEOUT_MS);
+
+	if ((ret < 0) || (bytes_xfer !=3D bytes_actual)) {
+		dev_err(&usb_dev->dev, "failure receiving usb\n");
+		error =3D -EREMOTEIO;
+	}
+	return error;
+}
+
+static int vprbrd_i2c_addr(struct usb_device *usb_dev,
+	struct vprbrd_i2c_addr_msg *amsg)
+{
+	int ret, bytes_actual;
+
+	ret =3D usb_bulk_msg(usb_dev,
+		usb_sndbulkpipe(usb_dev, VPRBRD_EP_OUT), amsg,
+		sizeof(struct vprbrd_i2c_addr_msg), &bytes_actual,
+		VPRBRD_USB_TIMEOUT_MS);
+
+	if ((ret < 0) ||
+			(sizeof(struct vprbrd_i2c_addr_msg) !=3D bytes_actual)) {
+		dev_err(&usb_dev->dev, "failure transmitting usb\n");
+		return -EREMOTEIO;
+	}
+	return 0;
+}
+
+static int vprbrd_i2c_read(struct vprbrd *vb, struct i2c_msg *msg)
+{
+	int ret;
+	u16 remain_len, bytes_xfer, len1, len2,
+		start =3D 0x0000;
+	struct vprbrd_i2c_read_msg *rmsg =3D
+		(struct vprbrd_i2c_read_msg *)vb->buf;
+
+	remain_len =3D msg->len;
+	rmsg->header.cmd =3D VPRBRD_I2C_CMD_READ;
+	while (remain_len > 0) {
+		rmsg->header.addr =3D cpu_to_le16(start + 0x4000);
+		if (remain_len <=3D 255) {
+			len1 =3D remain_len;
+			len2 =3D 0x00;
+			rmsg->header.len0 =3D remain_len;
+			rmsg->header.len1 =3D 0x00;
+			rmsg->header.len2 =3D 0x00;
+			rmsg->header.len3 =3D 0x00;
+			rmsg->header.len4 =3D 0x00;
+			rmsg->header.len5 =3D 0x00;
+			remain_len =3D 0;
+		} else if (remain_len <=3D 510) {
+			len1 =3D remain_len;
+			len2 =3D 0x00;
+			rmsg->header.len0 =3D remain_len - 255;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0x00;
+			rmsg->header.len3 =3D 0x00;
+			rmsg->header.len4 =3D 0x00;
+			rmsg->header.len5 =3D 0x00;
+			remain_len =3D 0;
+		} else if (remain_len <=3D 512) {
+			len1 =3D remain_len;
+			len2 =3D 0x00;
+			rmsg->header.len0 =3D remain_len - 510;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0xff;
+			rmsg->header.len3 =3D 0x00;
+			rmsg->header.len4 =3D 0x00;
+			rmsg->header.len5 =3D 0x00;
+			remain_len =3D 0;
+		} else if (remain_len <=3D 767) {
+			len1 =3D 512;
+			len2 =3D remain_len - 512;
+			rmsg->header.len0 =3D 0x02;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0xff;
+			rmsg->header.len3 =3D remain_len - 512;
+			rmsg->header.len4 =3D 0x00;
+			rmsg->header.len5 =3D 0x00;
+			bytes_xfer =3D remain_len;
+			remain_len =3D 0;
+		} else if (remain_len <=3D 1022) {
+			len1 =3D 512;
+			len2 =3D remain_len - 512;
+			rmsg->header.len0 =3D 0x02;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0xff;
+			rmsg->header.len3 =3D remain_len - 767;
+			rmsg->header.len4 =3D 0xff;
+			rmsg->header.len5 =3D 0x00;
+			remain_len =3D 0;
+		} else if (remain_len <=3D 1024) {
+			len1 =3D 512;
+			len2 =3D remain_len - 512;
+			rmsg->header.len0 =3D 0x02;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0xff;
+			rmsg->header.len3 =3D remain_len - 1022;
+			rmsg->header.len4 =3D 0xff;
+			rmsg->header.len5 =3D 0xff;
+			remain_len =3D 0;
+		} else {
+			len1 =3D 512;
+			len2 =3D 512;
+			rmsg->header.len0 =3D 0x02;
+			rmsg->header.len1 =3D 0xff;
+			rmsg->header.len2 =3D 0xff;
+			rmsg->header.len3 =3D 0x02;
+			rmsg->header.len4 =3D 0xff;
+			rmsg->header.len5 =3D 0xff;
+			remain_len -=3D 1024;
+			start +=3D 1024;
+		}
+		rmsg->header.tf1 =3D cpu_to_le16(len1);
+		rmsg->header.tf2 =3D cpu_to_le16(len2);
+
+		/* first read transfer */
+		ret =3D vprbrd_i2c_receive(vb->usb_dev, rmsg, len1);
+		if (ret < 0)
+			return ret;
+		/* copy the received data */
+		memcpy(msg->buf + start, rmsg, len1);
+
+		/* second read transfer if neccessary */
+		if (len2 > 0) {
+			ret =3D vprbrd_i2c_receive(vb->usb_dev, rmsg, len2);
+			if (ret < 0)
+				return ret;
+			/* copy the received data */
+			memcpy(msg->buf + start + 512, rmsg, len2);
+		}
+	}
+	return 0;
+}
+
+static int vprbrd_i2c_write(struct vprbrd *vb, struct i2c_msg *msg)
+{
+	int ret, bytes_actual;
+	u16 remain_len, bytes_xfer,
+		start =3D 0x0000;
+	struct vprbrd_i2c_write_msg *wmsg =3D
+		(struct vprbrd_i2c_write_msg *)vb->buf;
+
+	remain_len =3D msg->len;
+	wmsg->header.cmd =3D VPRBRD_I2C_CMD_WRITE;
+	wmsg->header.last =3D 0x00;
+	wmsg->header.chan =3D 0x00;
+	wmsg->header.spi =3D 0x0000;
+	while (remain_len > 0) {
+		wmsg->header.addr =3D cpu_to_le16(start + 0x4000);
+		if (remain_len > 503) {
+			wmsg->header.len1 =3D 0xff;
+			wmsg->header.len2 =3D 0xf8;
+			remain_len -=3D 503;
+			bytes_xfer =3D 503 + sizeof(struct vprbrd_i2c_write_hdr);
+			start +=3D 503;
+		} else if (remain_len > 255) {
+			wmsg->header.len1 =3D 0xff;
+			wmsg->header.len2 =3D (remain_len - 255);
+			bytes_xfer =3D remain_len +
+				sizeof(struct vprbrd_i2c_write_hdr);
+			remain_len =3D 0;
+		} else {
+			wmsg->header.len1 =3D remain_len;
+			wmsg->header.len2 =3D 0x00;
+			bytes_xfer =3D remain_len +
+				sizeof(struct vprbrd_i2c_write_hdr);
+			remain_len =3D 0;
+		}
+		memcpy(wmsg->data, msg->buf + start,
+			bytes_xfer - sizeof(struct vprbrd_i2c_write_hdr));
+
+		ret =3D usb_bulk_msg(vb->usb_dev,
+			usb_sndbulkpipe(vb->usb_dev,
+			VPRBRD_EP_OUT), wmsg,
+			bytes_xfer, &bytes_actual, VPRBRD_USB_TIMEOUT_MS);
+		if ((ret < 0) || (bytes_xfer !=3D bytes_actual))
+			return -EREMOTEIO;
+	}
+	return 0;
+}
+
+static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
+		int num)
+{
+	struct i2c_msg *pmsg;
+	int i, ret,
+		error =3D 0;
+	struct vprbrd *vb =3D (struct vprbrd *)i2c->algo_data;
+	struct vprbrd_i2c_addr_msg *amsg =3D
+		(struct vprbrd_i2c_addr_msg *)vb->buf;
+	struct vprbrd_i2c_status *smsg =3D (struct vprbrd_i2c_status *)vb->buf;
+
+	dev_dbg(&i2c->dev, "master xfer %d messages:\n", num);
+
+	for (i =3D 0 ; i < num ; i++) {
+		pmsg =3D &msgs[i];
+
+		dev_dbg(&i2c->dev,
+			"  %d: %s (flags %d) %d bytes to 0x%02x\n",
+			i, pmsg->flags & I2C_M_RD ? "read" : "write",
+			pmsg->flags, pmsg->len, pmsg->addr);
+
+		/* msgs longer than 2048 bytes are not supported by adapter */
+		if (pmsg->len > 2048)
+			return -EINVAL;
+
+		mutex_lock(&vb->lock);
+		/* directly send the message */
+		if (pmsg->flags & I2C_M_RD) {
+			/* read data */
+			amsg->cmd =3D VPRBRD_I2C_CMD_ADDR;
+			amsg->unknown2 =3D 0x00;
+			amsg->unknown3 =3D 0x00;
+			amsg->addr =3D pmsg->addr;
+			amsg->unknown1 =3D 0x01;
+			amsg->len =3D cpu_to_le16(pmsg->len);
+			/* send the addr and len, we're interested to board */
+			ret =3D vprbrd_i2c_addr(vb->usb_dev, amsg);
+			if (ret < 0)
+				error =3D ret;
+
+			ret =3D vprbrd_i2c_read(vb, pmsg);
+			if (ret < 0)
+				error =3D ret;
+
+			ret =3D vprbrd_i2c_status(i2c, smsg, error);
+			if (ret < 0)
+				error =3D ret;
+			/* in case of protocol error, return the error */
+			if (error < 0)
+				goto error;
+		} else {
+			/* write data */
+			ret =3D vprbrd_i2c_write(vb, pmsg);
+
+			amsg->cmd =3D VPRBRD_I2C_CMD_ADDR;
+			amsg->unknown2 =3D 0x00;
+			amsg->unknown3 =3D 0x00;
+			amsg->addr =3D pmsg->addr;
+			amsg->unknown1 =3D 0x00;
+			amsg->len =3D cpu_to_le16(pmsg->len);
+			/* send the addr, the data goes to to board */
+			ret =3D vprbrd_i2c_addr(vb->usb_dev, amsg);
+			if (ret < 0)
+				error =3D ret;
+
+			ret =3D vprbrd_i2c_status(i2c, smsg, error);
+			if (ret < 0)
+				error =3D ret;
+
+			if (error < 0)
+				goto error;
+		}
+		mutex_unlock(&vb->lock);
+	}
+	return 0;
+error:
+	mutex_unlock(&vb->lock);
+	return error;
+}
+
+static u32 vprbrd_i2c_func(struct i2c_adapter *i2c)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+/* This is the actual algorithm we define */
+static const struct i2c_algorithm vprbrd_algorithm =3D {
+	.master_xfer	=3D vprbrd_i2c_xfer,
+	.functionality	=3D vprbrd_i2c_func,
+};
+
+static int __devinit vprbrd_i2c_probe(struct platform_device *pdev)
+{
+	struct vprbrd *vb =3D dev_get_drvdata(pdev->dev.parent);
+	struct vprbrd_i2c *vb_i2c;
+	int ret;
+	int pipe;
+
+	vb_i2c =3D kzalloc(sizeof(*vb_i2c), GFP_KERNEL);
+	if (vb_i2c =3D=3D NULL)
+		return -ENOMEM;
+
+	/* setup i2c adapter description */
+	vb_i2c->i2c.owner =3D THIS_MODULE;
+	vb_i2c->i2c.class =3D I2C_CLASS_HWMON;
+	vb_i2c->i2c.algo =3D &vprbrd_algorithm;
+	vb_i2c->i2c.algo_data =3D vb;
+	/* save the param in usb capabable memory */
+	vb_i2c->bus_freq_param =3D i2c_bus_param;
+
+	snprintf(vb_i2c->i2c.name, sizeof(vb_i2c->i2c.name),
+		 "viperboard at bus %03d device %03d",
+		 vb->usb_dev->bus->busnum, vb->usb_dev->devnum);
+
+	/* setting the bus frequency */
+	if ((i2c_bus_param <=3D VPRBRD_I2C_FREQ_10KHZ)
+		&& (i2c_bus_param >=3D VPRBRD_I2C_FREQ_6MHZ)) {
+		pipe =3D usb_sndctrlpipe(vb->usb_dev, 0);
+		ret =3D usb_control_msg(vb->usb_dev, pipe,
+			VPRBRD_USB_REQUEST_I2C_FREQ, VPRBRD_USB_TYPE_OUT,
+			0x0000, 0x0000, &vb_i2c->bus_freq_param, 1,
+			VPRBRD_USB_TIMEOUT_MS);
+	    if (ret !=3D 1) {
+		dev_err(&pdev->dev,
+			"failure setting i2c_bus_freq to %d\n", i2c_bus_freq);
+		ret =3D -EIO;
+		goto error;
+	    }
+	} else {
+		dev_err(&pdev->dev,
+			"invalid i2c_bus_freq setting:%d\n", i2c_bus_freq);
+		ret =3D -EIO;
+		goto error;
+	}
+
+	vb_i2c->i2c.dev.parent =3D &pdev->dev;
+
+	/* attach to i2c layer */
+	i2c_add_adapter(&vb_i2c->i2c);
+
+	platform_set_drvdata(pdev, vb_i2c);
+
+	return 0;
+
+error:
+	kfree(vb_i2c);
+	return ret;
+}
+
+static int __devexit vprbrd_i2c_remove(struct platform_device *pdev)
+{
+	struct vprbrd_i2c *vb_i2c =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D i2c_del_adapter(&vb_i2c->i2c);
+
+	return ret;
+}
+
+static struct platform_driver vprbrd_i2c_driver =3D {
+	.driver.name	=3D "viperboard-i2c",
+	.driver.owner	=3D THIS_MODULE,
+	.probe		=3D vprbrd_i2c_probe,
+	.remove		=3D __devexit_p(vprbrd_i2c_remove),
+};
+
+static int __init vprbrd_i2c_init(void)
+{
+	switch (i2c_bus_freq) {
+	case 6000:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_6MHZ;
+		break;
+	case 3000:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_3MHZ;
+		break;
+	case 1000:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_1MHZ;
+		break;
+	case 400:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_400KHZ;
+		break;
+	case 200:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_200KHZ;
+		break;
+	case 100:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_100KHZ;
+		break;
+	case 10:
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_10KHZ;
+		break;
+	default:
+		pr_warn("invalid i2c_bus_freq (%d)\n", i2c_bus_freq);
+		i2c_bus_param =3D VPRBRD_I2C_FREQ_100KHZ;
+	}
+
+	return platform_driver_register(&vprbrd_i2c_driver);
+}
+subsys_initcall(vprbrd_i2c_init);
+
+static void __exit vprbrd_i2c_exit(void)
+{
+	platform_driver_unregister(&vprbrd_i2c_driver);
+}
+module_exit(vprbrd_i2c_exit);
+
+MODULE_AUTHOR("Lars Poeschel <poeschel@lemonage.de>");
+MODULE_DESCRIPTION("I2C master driver for Nano River Techs Viperboard");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:viperboard-i2c");
diff --git a/drivers/mfd/viperboard.c b/drivers/mfd/viperboard.c
index 4b2ffbf..a7b5b34 100644
=2D-- a/drivers/mfd/viperboard.c
+++ b/drivers/mfd/viperboard.c
@@ -41,6 +41,9 @@ static struct mfd_cell vprbrd_devs[] =3D {
 	{
 		.name =3D "viperboard-gpio",
 	},
+	{
+		.name =3D "viperboard-i2c",
+	},
 };
=20
 static int vprbrd_probe(struct usb_interface *interface,
diff --git a/include/linux/mfd/viperboard.h b/include/linux/mfd/viperboard.h
index 42d339f..ef78514 100644
=2D-- a/include/linux/mfd/viperboard.h
+++ b/include/linux/mfd/viperboard.h
@@ -42,6 +42,8 @@
 #define VPRBRD_USB_TYPE_OUT	    0x40
 #define VPRBRD_USB_TYPE_IN	    0xc0
 #define VPRBRD_USB_TIMEOUT_MS       100
+#define VPRBRD_USB_REQUEST_I2C_FREQ 0xe6
+#define VPRBRD_USB_REQUEST_I2C      0xe9
 #define VPRBRD_USB_REQUEST_MAJOR    0xea
 #define VPRBRD_USB_REQUEST_MINOR    0xeb
 #define VPRBRD_USB_REQUEST_GPIOA    0xed
=2D-=20
1.7.10.4
