Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37061 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbbKJQH5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2015 11:07:57 -0500
Received: by wmww144 with SMTP id w144so7092035wmw.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2015 08:07:56 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com, Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 3/4] iio: ina2xx: add debugfs reg access
Date: Tue, 10 Nov 2015 17:07:32 +0100
Message-Id: <1447171653-12756-4-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

     iio:device0: ina226
...
      3 device-specific attributes found:
                attr 0: in_calibscale value: 10000
                attr 1: in_mean_raw value: 4
                attr 2: in_sampling_frequency value: 455

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-iio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
index 92169e1..3e4a4b0 100644
--- a/drivers/iio/adc/ina2xx-iio.c
+++ b/drivers/iio/adc/ina2xx-iio.c
@@ -321,7 +321,19 @@ static const struct iio_chan_spec ina2xx_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static int ina2xx_debug_reg(struct iio_dev *indio_dev,
+			    unsigned reg, unsigned writeval, unsigned *readval)
+{
+	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
+
+	if (!readval)
+		return regmap_write(chip->regmap, reg, writeval);
+
+	return regmap_read(chip->regmap, reg, readval);
+}
+
 static const struct iio_info ina2xx_info = {
+	.debugfs_reg_access = &ina2xx_debug_reg,
 	.read_raw = &ina2xx_read_raw,
 	.write_raw = &ina2xx_write_raw,
 	.driver_module = THIS_MODULE,
-- 
1.9.1

