Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36389 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcBVBBW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 20:01:22 -0500
Received: by mail-lb0-f173.google.com with SMTP id x1so73678951lbj.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Feb 2016 17:01:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3A917D7D-9096-413D-BF11-6823CAA39A1D@jic23.retrosnub.co.uk>
References: <1456024891-20046-1-git-send-email-mranostay@gmail.com> <3A917D7D-9096-413D-BF11-6823CAA39A1D@jic23.retrosnub.co.uk>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 21 Feb 2016 17:00:41 -0800
Message-ID: <CAKzfze_ZPsJRafq_XEjyi_y158HPQ+AgzKfOHZxmQMmNya4adw@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: add TI tpl0102 support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 21, 2016 at 8:26 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 21 February 2016 03:21:31 GMT+00:00, Matt Ranostay <mranostay@gmail.com> wrote:
>>Add support for the TI family of digital potentiometers.
>>
>>Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Various comments inline but basically a nice simple driver.
>
> Jonathan
>>---
>> drivers/iio/potentiometer/Kconfig   |  11 +++
>> drivers/iio/potentiometer/Makefile  |   1 +
>>drivers/iio/potentiometer/tpl0102.c | 166
>>++++++++++++++++++++++++++++++++++++
>> 3 files changed, 178 insertions(+)
>> create mode 100644 drivers/iio/potentiometer/tpl0102.c
>>
>>diff --git a/drivers/iio/potentiometer/Kconfig
>>b/drivers/iio/potentiometer/Kconfig
>>index fd75db7..9d7aa66 100644
>>--- a/drivers/iio/potentiometer/Kconfig
>>+++ b/drivers/iio/potentiometer/Kconfig
>>@@ -17,4 +17,15 @@ config MCP4531
>>         To compile this driver as a module, choose M here: the
>>         module will be called mcp4531.
>>
>>+config TPL0102
>>+      tristate "Texas Instruments digital potentiometer driver"
>>+      depends on I2C
> Regmap depency as well.
Noted

>>+      help
>>+        Say yes here to build support for the Texas Instruments
>>+        TPL0102, TPL0402
>>+        digital potentiometer chips.
>>+
>>+        To compile this driver as a module, choose M here: the
>>+        module will be called tpl0102.
>>+
>> endmenu
>>diff --git a/drivers/iio/potentiometer/Makefile
>>b/drivers/iio/potentiometer/Makefile
>>index 8afe492..b563b49 100644
>>--- a/drivers/iio/potentiometer/Makefile
>>+++ b/drivers/iio/potentiometer/Makefile
>>@@ -4,3 +4,4 @@
>>
>> # When adding new entries keep the list in alphabetical order
>> obj-$(CONFIG_MCP4531) += mcp4531.o
>>+obj-$(CONFIG_TPL0102) += tpl0102.o
>>diff --git a/drivers/iio/potentiometer/tpl0102.c
>>b/drivers/iio/potentiometer/tpl0102.c
>>new file mode 100644
>>index 0000000..6f610b2
>>--- /dev/null
>>+++ b/drivers/iio/potentiometer/tpl0102.c
>>@@ -0,0 +1,166 @@
>>+/*
>>+ * tpl0102.c - Support for Texas Instruments digital potentiometers
>>+ *
>>+ * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
>>+ *
>>+ * This program is free software; you can redistribute it and/or
>>modify
>>+ * it under the terms of the GNU General Public License as published
>>by
>>+ * the Free Software Foundation; either version 2 of the License, or
>>+ * (at your option) any later version.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>+ * GNU General Public License for more details.
>>+ *
>>+ * TODO: enable/disable hi-z output control
>>+ */
>>+
>>+#include <linux/module.h>
>>+#include <linux/i2c.h>
>>+#include <linux/regmap.h>
>>+#include <linux/iio/iio.h>
>>+
>>+struct tpl0102_cfg {
>>+      int wipers;
>>+      int max_pos;
>>+      int kohms;
>>+};
>>+
>>+enum tpl0102_type {
>>+      TPL0102_104,
>>+      TPL0401_103,
>>+      CAT5140_503,
>>+      CAT5140_104,
> Numeric / alphabetical order preferred.
Ok.

>>+};
>>+
>>+static const struct tpl0102_cfg tpl0102_cfg[] = {
>>+      /* ti parts */
>>+      [TPL0102_104] = { .wipers = 2, .max_pos = 256, .kohms = 100 },
>>+      [TPL0401_103] = { .wipers = 1, .max_pos = 128, .kohms = 10, },
>>+      /* on-semiconductor parts */
>>+      [CAT5140_503] = { .wipers = 1, .max_pos = 256, .kohms = 50, },
>>+      [CAT5140_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
> Alphabetical order would be a little better.

Ok
>>+};
>>+
>>+struct tpl0102_data {
>>+      struct regmap *regmap;
>>+      unsigned long devid;
>>+};
>>+
>>+static const struct regmap_config tpl0102_regmap_config = {
>>+      .reg_bits = 8,
>>+      .val_bits = 8,
>>+};
>>+
>>+#define TPL0102_CHANNEL(ch) {                                 \
>>+      .type = IIO_RESISTANCE,                                 \
>>+      .indexed = 1,                                           \
>>+      .output = 1,                                            \
>>+      .channel = (ch),                                        \
>>+      .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>>+      .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
>>+}
>>+
>>+static const struct iio_chan_spec tpl0102_channels[] = {
>>+      TPL0102_CHANNEL(0),
>>+      TPL0102_CHANNEL(1),
>>+};
>>+
>>+static int tpl0102_read_raw(struct iio_dev *indio_dev,
>>+                          struct iio_chan_spec const *chan,
>>+                          int *val, int *val2, long mask)
>>+{
>>+      struct tpl0102_data *data = iio_priv(indio_dev);
>>+
>>+      switch (mask) {
>>+      case IIO_CHAN_INFO_RAW: {
>>+              return regmap_read(data->regmap, chan->channel, val)
>>+                                 ? -EIO : IIO_VAL_INT;
>>+      }
> Doesn't regmap_read return specific errors?
>>+      case IIO_CHAN_INFO_SCALE:
>>+              *val = 1000 * tpl0102_cfg[data->devid].kohms;
>>+              *val2 = tpl0102_cfg[data->devid].max_pos;
>>+              return IIO_VAL_FRACTIONAL;
>>+      }
>>+
>>+      return -EINVAL;
>>+}
>>+
>>+static int tpl0102_write_raw(struct iio_dev *indio_dev,
>>+                           struct iio_chan_spec const *chan,
>>+                           int val, int val2, long mask)
>>+{
>>+      struct tpl0102_data *data = iio_priv(indio_dev);
>>+
>>+      if (mask != IIO_CHAN_INFO_RAW)
>>+              return -EINVAL;
>>+
>>+      if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
>>+              return -EINVAL;
>>+
>>+      return regmap_write(data->regmap, chan->channel, val & 0xff);
> Mask add anything given you have already checked the range?

Paranoid I guess :). Will drop.
>>+}
>>+
>>+static const struct iio_info tpl0102_info = {
>>+      .read_raw = tpl0102_read_raw,
>>+      .write_raw = tpl0102_write_raw,
>>+      .driver_module = THIS_MODULE,
>>+};
>>+
>>+static int tpl0102_probe(struct i2c_client *client,
>>+                       const struct i2c_device_id *id)
>>+{
>>+      struct device *dev = &client->dev;
> Local dev variable doesn't add anything here and makes code slightly less obvious.
>>+      struct tpl0102_data *data;
>>+      long devid = id->driver_data;
>>+      struct iio_dev *indio_dev;
>>+
>>+      if (!i2c_check_functionality(client->adapter,
>>+                                   I2C_FUNC_SMBUS_WORD_DATA))
>>+              return -ENOTSUPP;
>>+
>>+      indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>+      if (!indio_dev)
>>+              return -ENOMEM;
>>+      data = iio_priv(indio_dev);
>>+      i2c_set_clientdata(client, indio_dev);
>>+
>>+      data->devid = devid;
> Why local devid variable?
Referenced below but seeing it is only used once it doesn't have to be local.

>>+      data->regmap = devm_regmap_init_i2c(client, &tpl0102_regmap_config);
>>+      if (IS_ERR(data->regmap)) {
>>+              dev_err(dev, "regmap initialization failed\n");
>>+              return PTR_ERR(data->regmap);
>>+      }
>>+
>>+      indio_dev->dev.parent = dev;
>>+      indio_dev->info = &tpl0102_info;
>>+      indio_dev->channels = tpl0102_channels;
>>+      indio_dev->num_channels = tpl0102_cfg[devid].wipers;
>>+      indio_dev->name = client->name;
>>+
>>+      return iio_device_register(indio_dev);
> devm_ or you need to explicitly unregister in a remove function.
Oops. Will fix in v2.
>
>>+}
>
>>+
>>+static const struct i2c_device_id tpl0102_id[] = {
>>+      { "tpl0102-104", TPL0102_104 },
>>+      { "tpl0401-103", TPL0401_103 },
>>+      { "cat5140-503", CAT5140_503 },
>>+      { "cat5140-104", CAT5140_104 },
>>+      {}
>>+};
>>+MODULE_DEVICE_TABLE(i2c, tpl0102_id);
>>+
>>+static struct i2c_driver tpl0102_driver = {
>>+      .driver = {
>>+              .name = "tpl0102",
>>+      },
>>+      .probe = tpl0102_probe,
>>+      .id_table = tpl0102_id,
>>+};
>>+
>>+module_i2c_driver(tpl0102_driver);
>>+
>>+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>+MODULE_DESCRIPTION("TPL0102 digital potentiometer");
>>+MODULE_LICENSE("GPL");
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
