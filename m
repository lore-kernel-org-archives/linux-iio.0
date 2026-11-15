Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722465;
	b=OyM5RXkFqKW4r8/8STJm/FvwVRiJurJq6oVXwTrwi3Lswn06tPrfdWIJak5bZM9r0Utd
	 isFI4WQG4M3fzSG4k2qSDskh1A/6BR8LxcB+qmWc2zghIFeYn8URBh+Hg35TerYKbgfWf
	 r7Lyr5SKfS2Y80iZI0p4l1LG/pZKV5qALmlx4NWr0V6PFDdclFc4m/8ohyJ+ASLC3EIar
	 NHKqSpHxQssnNrsPbkOoSHKp9oPV9/HNG1vZYb1pdgKQ/kac0YItB5J8YQqGAlVHrMcag
	 FPgV7zWtZ21uDqxtQCPq73wcEL7oPqrqSvslkVaSCtSrrauTJVN7u4t5YgTJn+CuKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=evrsLISEmBq3rBFDfEEHLkUem3e6YiI3I6JGfBRstXk=;
	b=Mjh+uufs0T3d/DclOFipkuWEOxV6r01IMgGJre9uVDo2tIsPBtMX6u4p6+D5RI+BmCM7
	 4/kqwQEoWCrrxd/ZYLFuhkNrLKPOOEV64JR8QMgCVxBRBSYELLRHhz8iIwdOCcgcHdV69
	 pEiyxb64WMKv8EflaDEvgoabW9NH+smRXq6l0zDr+xqeM4BtcQ1/23PGxKUsrFUGZ9bQA
	 yhmKw1ly8PPMMikzNT4GVgdN4rztZ7bDYznH9EocQMj+dAbA3A4ZtLPvsyFfwXg8wDp1O
	 MlTu0nHEFx6GB/juRioyXYXqG5a8TbzLam0Ibre/GjYSZlJTB2E9CEs+PU8xNFBy6gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NJ1OA/M/";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C8606A323
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 06:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09C8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJ1OA/M/
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so1783200a91.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 22:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794722464; x=1795327264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evrsLISEmBq3rBFDfEEHLkUem3e6YiI3I6JGfBRstXk=;
        b=NJ1OA/M/qiQAr1Bi7XV6mumbaEZdT6frXIT11+PEOtSjfoEkO469DUS/Virz30Ts8M
         LouMWY9TVEEPFrchB5V4WDyyCXaNa1cq/QioPaLsslaYs2x085z7qEw1XuWxgagKQCTB
         U+R02IJz63ZF/9/MOeKQ/wA6IRsik0w5XcVXkI6pnFb0WEq+sJAce++vMq3PazcJTpJm
         ajzDZKK81cDRVlFZVxTpQSrxVBZ4XRLTG0nRvkc94uq+i55w5Fk8+E6/ABAqSslemMRt
         7fduW5sVGmT97cRqGkMbTNkLSNBzt+DW+dtQppqoJ5h23qaW/BhSVDz4RlLiWkyiFNiR
         6Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722464; x=1795327264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evrsLISEmBq3rBFDfEEHLkUem3e6YiI3I6JGfBRstXk=;
        b=JQ4/UIWsbxUCcE3DLbZoP4F0j/Jib1UiwV9iVGYCcRsD/jOeCCJZIVM06jLuaxYx5P
         sZI66itfdQqvRoNfIt6qA8cZrGSTv33ttF3i58Qti32Z/ceNbFVQDF6/gMCS3n2WkyIC
         ShDkVrC2T7IycrBcs/MPeEwX70A1Lo+hZ2IpNtFU+gMhxaQkroQqssFl6nMBKm7qRzVq
         XMBCQoWG4TGcyoHxDbDmdMnlFLFq68NwHv50rq8Mga+IuwqQPrFfXvM4xofeVfGDqMqJ
         wSwNFNEX/g9q2DSWg8zNMdEdlqeU68cvdc1oRUTABct7HhgWD9AowXI/ojeor6SFOucO
         IQsQ==
X-Gm-Message-State: APuU4Z8qaTn3pGwwW8tMSAQJ+I1hGPWVaNxpujDFqQSPpaiJE0VNx5iK
	U4tkgHnsiwf8QKHdAOfuF+ft1ImY2Fk2PRltVue4FU9tbnmRE1u8oxbJytS4WdbzLFs=
X-Gm-Gg: AYBFou0S8rYmP9moDNguBrfhSPBNtTqaai/wAu0lEhix8SSYixQiUL5BaiiIl9j4A5d
	bUhwoYHrjc9cVYwSkVCBjWiYEVTMYoXy8BBG7lnCTO6fMPhTMcjglFbDD2F47qlzTJBV7CWdf5I
	j3yHpaCT/TMBm+kTv3jZezwrCrDv0p3PUMJZIv3SZjrgi4zt5ODQ+NFE36hVzbyzuwT0nbC10K+
	DXsaSlGuplbnswi7NkFGIAmafuTs1WD2ov4hGMS+wZCUrJQWOS3peZYkElv86OM/ZaOzj9iCHK3
	iUOvk8Ugshar615aWMFVJH/+xDarjcVCVJvdXZ+9iD17F5/wnl0goJ1fbne2KMhPsECpbGOE+ts
	4ryZfSC3KzWji1bNyRh6LteJLerrMgpqsMS+T3IchIBdPZqwXRHoqDlzAHGBic/gzsCOgr9b0wu
	EuU7kxAQCywAWgh+6fgnbtDW8prcqe0hNQhh7D3HGCFLxZvwEXkjhFImpL356FWUNMWvg8d0uvg
	zLCt70/ykTiui1nOK7WAR1zwW/yVNScBe1atQMWzgFMAZsNAWAzoEwGuktSWmhtaOv6nP78xxnC
	jYe/ltJ6UwQ+4VPYR2y87CWb4EV30d68IQ4gzppp+Gawv5arxGLSA7Rt6ItG14OxOdKGaLvlxea
	E
X-Received: by 2002:a17:90b:1dc8:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3b1b0b5b55bmr6838746a91.44.1794722463886;
        Sat, 14 Nov 2026 22:01:03 -0800 (PST)
Received: from not-op-Victus-by-HP-Gaming-Laptop-15-fb3xxx ([2001:4490:48e1:a6d:b698:9913:39f1:6954])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm10988889a91.10.2026.11.14.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:01:03 -0800 (PST)
From: Akshat Chandra <notmissinge@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	andy@kernel.org,
	Lukasz Kulga <lukasz.kulga@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: chemical: Add support for Sensirion SGP41
Date: Sun, 15 Nov 2026 11:29:40 +0530
Message-ID: <20261115055941.362185-3-notmissinge@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115055941.362185-1-notmissinge@gmail.com>
References: <20261115055941.362185-1-notmissinge@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Sensirion SGP41 VOC and NOx gas sensor,
connected over I2C.

Expose raw VOC and NOx signals as resistance channels and
allow userspace to write temperature and relative humidity
compensation values.

Run sensor conditioning lazily before the first raw measurement.
Calculate an estimated VOC index and leave NOx-index calculation
to userspace.

Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  11 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/sgp41.c  | 542 ++++++++++++++++++++++++++++++++++
 3 files changed, 554 insertions(+)
 create mode 100644 drivers/iio/chemical/sgp41.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b22afa1f6d59..cbb6a51b1cfd 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -210,6 +210,17 @@ config SENSIRION_SGP40
 	  To compile this driver as module, choose M here: the
 	  module will be called sgp40.
 
+config SENSIRION_SGP41
+	tristate "Sensirion SGP41 gas sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build I2C interface to support Sensirion SGP41 gas
+	  sensor
+
+	  To compile this driver as module, choose M here: the
+	  module will be called sgp41.
+
 config SPS30
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2287a00a6b75..90041aaa41fe 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SEN0322)	+= sen0322.o
 obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
+obj-$(CONFIG_SENSIRION_SGP41)	+= sgp41.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
 obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
diff --git a/drivers/iio/chemical/sgp41.c b/drivers/iio/chemical/sgp41.c
new file mode 100644
index 000000000000..f094ba22b7aa
--- /dev/null
+++ b/drivers/iio/chemical/sgp41.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sgp41 - Support for Sensirion SGP41 Gas Sensor
+ *
+ * Copyright (C) 2026 Akshat Chandra <notmissinge@gmail.com>
+ *
+ * I2C slave address: 0x59
+ *
+ * Datasheet can be found here:
+ * https://www.sensirion.com/file/datasheet_sgp41
+ *
+ * There are two functionalities supported:
+ *
+ * 1) read raw logarithmic resistance value from sensor
+ *    --> useful to pass it to the algorithm of the sensor vendor for
+ *    measuring deteriorations and improvements of air quality.
+ *    The values can be read from the in_resistance_voc_raw and
+ *    in_resistance_nox_raw.
+ *
+ * 2) calculate an estimated VOC index (0 - 500) and expose it through
+ *    the in_concentration_voc_input attribute.
+ *
+ *    The VOC index is calculated using the raw VOC resistance and a
+ *    configurable calibration bias, exposed through
+ *    in_resistance_voc_calibbias (default 30000).
+ *
+ * The driver does not calculate a NOx index.
+ *
+ * Conditioning runs before the first raw measurement, once per second
+ * for a total of 10 seconds.
+ *
+ * Compensation values for relative humidity and temperature can be
+ * configured through the corresponding output attributes.
+ *
+ * The sensor heater is turned off when the device is removed.
+ */
+
+#include<linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#define SGP41_CALC_POWER   14
+#define SGP41_CRC8_POLYNOMIAL		0x31
+#define SGP41_CRC8_INIT		0xff
+
+#define SGP41_COND_ITERATIONS		10
+#define SRAW_VOC           1
+#define SRAW_NOX           2
+
+DECLARE_CRC8_TABLE(sgp41_crc8_table);
+
+struct sgp41_data {
+	struct device *dev;
+	struct i2c_client *client;
+
+	int rht;
+	int temp;
+
+	int voc_calibbias;
+
+	struct mutex lock; /* Protects sensor state and I2C transaction.*/
+	bool conditioned;
+	u8 condition_count; /*Counter for conditioning_cmd sent.*/
+};
+
+struct sgp41_tg_measure {
+	u8 command[2];
+	__be16 rht_ticks;
+	u8 rht_crc;
+	__be16 temp_ticks;
+	u8 temp_crc;
+} __packed;
+
+struct sgp41_tg_result {
+	__be16 voc_res_ticks;
+	u8 voc_res_crc;
+	__be16 nox_res_ticks;
+	u8 nox_res_crc;
+} __packed;
+
+static const struct iio_chan_spec sgp41_channels[] = {
+	{
+		.type = IIO_RESISTANCE,/*VOC*/
+		.channel = SRAW_VOC,
+		.extend_name = "voc",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_RESISTANCE,/*NOX*/
+		.channel = SRAW_NOX,
+		.extend_name = "nox",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_TEMP,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+/*
+ * taylor approximation of e^x:
+ * y = 1 + x + x^2 / 2 + x^3 / 6 + x^4 / 24 + ... + x^n / n!
+ *
+ * Because we are calculating x real value multiplied by 2^power we get
+ * an additional 2^power^n to divide for every element. For a reasonable
+ * precision this would overflow after a few iterations. Therefore we
+ * divide the x^n part whenever its about to overflow (xmax).
+ */
+
+static u32 sgp41_exp(int exp, u32 power, u32 rounds)
+{
+	u32 x, y, xp;
+	u32 factorial, divider, xmax;
+	int sign = 1;
+	u32 i;
+
+	if (exp == 0) {
+		return 1 << power;
+	} else if (exp < 0) {
+		sign = -1;
+		exp *= -1;
+	}
+
+	xmax = 0x7FFFFFFF / exp;
+	x = exp;
+	xp = 1;
+	factorial = 1;
+	y = 1 << power;
+	divider = 0;
+
+	for (i = 1; i <= rounds; i++) {
+		xp *= x;
+		factorial *= i;
+		y += (xp >> divider) / factorial;
+		divider += power;
+		/* divide when next multiplication would overflow */
+		if (xp >= xmax) {
+			xp >>= power;
+			divider -= power;
+		}
+	}
+
+	if (sign == -1)
+		return (1 << (power * 2)) / y;
+	else
+		return y;
+}
+
+static void temp_rht_payload(struct sgp41_data *data,
+			     struct sgp41_tg_measure *tg)
+{
+	s64 ticks;
+	u16 ticks16;
+
+	ticks = div_s64((s64)data->rht * 65535, 100000);
+	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);
+	tg->rht_ticks = cpu_to_be16(ticks16);
+	tg->rht_crc = crc8(sgp41_crc8_table, (u8 *)&tg->rht_ticks, 2,
+			   SGP41_CRC8_INIT);
+
+	ticks = div_s64((s64)(data->temp + 45000) * 65535, 175000);
+	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);
+	tg->temp_ticks = cpu_to_be16(ticks16);
+	tg->temp_crc = crc8(sgp41_crc8_table, (u8 *)&tg->temp_ticks, 2,
+			    SGP41_CRC8_INIT);
+}
+
+static int sgp41_calc_voc(struct sgp41_data *data, u16 voc_raw, int *voc)
+{
+	int x;
+	u32 exp = 0;
+	int voc_calibbias;
+
+	/* we calculate as a multiple of 16384 (2^14) */
+	scoped_guard(mutex, &data->lock)
+		voc_calibbias = data->voc_calibbias;
+
+	x = ((int)voc_raw - voc_calibbias) * 106;
+		/* voc = 500 / (1 + e^x) */
+	exp = sgp41_exp(x, SGP41_CALC_POWER, 18);
+	*voc = 500 * ((1 << (SGP41_CALC_POWER * 2)) / ((1 << SGP41_CALC_POWER) + exp));
+
+	dev_dbg(data->dev, "voc_raw: %d voc_calibbias: %d x: %d exp: %u voc: %d\n",
+		voc_raw, data->voc_calibbias, x, exp, *voc);
+
+	return 0;
+}
+
+static int sgp41_run_conditioning(struct sgp41_data *data)
+{
+	struct sgp41_tg_measure tg = {
+		.command = { 0x26, 0x12 },
+	};
+	int i;
+	int ret;
+
+	for (i = 0; i < SGP41_COND_ITERATIONS; i++) {
+		if (data->condition_count!= i)
+			i = data->condition_count;
+
+		temp_rht_payload(data, &tg);
+		ret = i2c_master_send(data->client, (const char *)&tg,
+				      sizeof(tg));
+		if (ret != sizeof(tg)) {
+			dev_warn(data->dev,
+				 "i2c_master_send ret: %d sizeof: %zu\n",
+				 ret, sizeof(tg));
+			return ret < 0 ? ret : -EIO;
+		}
+		data->condition_count++;
+		msleep(50);
+
+		if (i != SGP41_COND_ITERATIONS - 1)
+			msleep(950);
+	}
+
+	data->conditioned = true;
+
+	return 0;
+}
+
+static int sgp41_heater_off(struct sgp41_data *data)
+{
+	u8 heater_off_cmd[2] = { 0x36, 0x15 };
+	int ret;
+
+	ret = i2c_master_send(data->client, heater_off_cmd,
+			      sizeof(heater_off_cmd));
+	if (ret != sizeof(heater_off_cmd)) {
+		dev_warn(data->dev,
+			 "i2c_master_send ret: %d sizeof: %zu\n",
+			 ret, sizeof(heater_off_cmd));
+		return ret < 0 ? ret : -EIO;
+	}
+	data-> conditioned = false;
+	data->condition_count = 0;
+	dev_dbg(data->dev, "heater turned off\n");
+
+	return 0;
+}
+
+static int sgp41_measure_raw(struct sgp41_data *data,
+			     u16 *voc_raw, u16 *nox_raw)
+{
+	struct sgp41_tg_measure tg = {
+		.command = { 0x26, 0x19 },
+	};
+	struct sgp41_tg_result tgres;
+	u8 crc;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	if (!data->conditioned) {
+		ret = sgp41_run_conditioning(data);
+		if (ret) {
+			sgp41_heater_off(data);
+			return ret;
+		}
+	}
+
+	temp_rht_payload(data, &tg);
+
+	ret = i2c_master_send(data->client, (const char *)&tg, sizeof(tg));
+	if (ret != sizeof(tg)) {
+		dev_warn(data->dev,
+			 "i2c_master_send ret: %d sizeof: %zu\n",
+			 ret, sizeof(tg));
+		return ret < 0 ? ret : -EIO;
+	}
+
+	msleep(50);
+
+	ret = i2c_master_recv(data->client, (u8 *)&tgres, sizeof(tgres));
+	if (ret < 0)
+		return ret;
+
+	if (ret != sizeof(tgres)) {
+		dev_warn(data->dev,
+			 "i2c_master_recv ret: %d sizeof: %zu\n",
+			 ret, sizeof(tgres));
+		return -EIO;
+	}
+
+	crc = crc8(sgp41_crc8_table, (u8 *)&tgres.voc_res_ticks, 2,
+		   SGP41_CRC8_INIT);
+	if (crc != tgres.voc_res_crc) {
+		dev_err(data->dev, "CRC error while measure-voc_raw\n");
+		return -EIO;
+	}
+
+	crc = crc8(sgp41_crc8_table, (u8 *)&tgres.nox_res_ticks, 2,
+		   SGP41_CRC8_INIT);
+	if (crc != tgres.nox_res_crc) {
+		dev_err(data->dev, "CRC error while measure-nox_raw\n");
+		return -EIO;
+	}
+
+	*voc_raw = be16_to_cpu(tgres.voc_res_ticks);
+	*nox_raw = be16_to_cpu(tgres.nox_res_ticks);
+
+	return 0;
+}
+
+static int sgp41_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val,
+			  int *val2, long mask)
+{
+	struct sgp41_data *data = iio_priv(indio_dev);
+	u16 voc_raw;
+	u16 nox_raw;
+	int ret;
+	int voc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_RESISTANCE: {
+			ret = sgp41_measure_raw(data, &voc_raw, &nox_raw);
+			if (ret)
+				return ret;
+
+			switch (chan->channel) {
+			case SRAW_VOC:
+				*val = voc_raw;
+				return IIO_VAL_INT;
+			case SRAW_NOX:
+				*val = nox_raw;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		}
+		case IIO_TEMP: {
+			guard(mutex)(&data->lock);
+			*val = data->temp;
+			return IIO_VAL_INT;
+		}
+		case IIO_HUMIDITYRELATIVE: {
+			guard(mutex)(&data->lock);
+			*val = data->rht;
+			return IIO_VAL_INT;
+		}
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->channel2) {
+		case IIO_MOD_VOC:
+			ret = sgp41_measure_raw(data, &voc_raw, &nox_raw);
+			if (ret)
+				return ret;
+
+			ret = sgp41_calc_voc(data, voc_raw, &voc);
+			if (ret)
+				return ret;
+
+			*val = voc / (1 << SGP41_CALC_POWER);
+		/*
+		 * calculation should fit into integer, where:
+		 * voc <= (500 * 2^SGP41_CALC_POWER) = 8192000
+		 * (with SGP41_CALC_POWER = 14)
+		 */
+		*val2 = ((voc % (1 << SGP41_CALC_POWER)) * 244) /
+			(1 << (SGP41_CALC_POWER - 12));
+		dev_dbg(data->dev, "voc: %d val: %d.%06d\n",
+			voc, *val, *val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->channel) {
+		/*For VOC Calibration,*/
+		case SRAW_VOC: {
+			guard(mutex)(&data->lock);
+			*val = data->voc_calibbias;
+			return IIO_VAL_INT;
+		}
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sgp41_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int val,
+			   int val2, long mask)
+{
+	struct sgp41_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_TEMP: {
+			if (val < -45000 || val > 130000)
+				return -EINVAL;
+
+			guard(mutex)(&data->lock);
+			data->temp = val;
+			return 0;
+		}
+		case IIO_HUMIDITYRELATIVE: {
+			if (val < 0 || val > 100000)
+				return -EINVAL;
+
+			guard(mutex)(&data->lock);
+			data->rht = val;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->channel) {
+		/*For VOC Calibration,*/
+		case SRAW_VOC: {
+			if (val < 20000 || val > 52768)
+				return -EINVAL;
+
+			guard(mutex)(&data->lock);
+			data->voc_calibbias = val;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+
+static void sgp41_remove(struct i2c_client *client)
+{
+	int ret;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct sgp41_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	guard(mutex)(&data->lock);
+	ret = sgp41_heater_off(data);
+	if (ret)
+	dev_warn(data->dev, "Failed to turn off heater: %d\n", ret);
+}
+
+static const struct iio_info sgp41_info = {
+	.read_raw = sgp41_read_raw,
+	.write_raw = sgp41_write_raw,
+};
+
+static int sgp41_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sgp41_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->dev = dev;
+	data->conditioned = false;
+	data->condition_count = 0;
+
+	crc8_populate_msb(sgp41_crc8_table, SGP41_CRC8_POLYNOMIAL);
+
+	mutex_init(&data->lock);
+
+	/*default values.*/
+	data->rht = 50000;
+	data->temp = 25000;
+	data->voc_calibbias = 30000; /*resistance raw value for voc index of 250*/
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get/enable vdd supply\n");
+
+	indio_dev->info = &sgp41_info;
+
+	if (id)
+		indio_dev->name = id->name;
+	else
+		indio_dev->name = "sgp41";
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sgp41_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sgp41_channels);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		dev_err(dev, "failed to register iio device\n");
+
+	return ret;
+}
+
+static const struct i2c_device_id sgp41_id[] = {
+	{ .name = "sgp41" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sgp41_id);
+
+static const struct of_device_id sgp41_dt_ids[] = {
+	{ .compatible = "sensirion,sgp41" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, sgp41_dt_ids);
+
+static struct i2c_driver sgp41_driver = {
+	.driver = {
+		.name = "sgp41",
+		.of_match_table = sgp41_dt_ids,
+	},
+	.probe = sgp41_probe,
+	.id_table = sgp41_id,
+	.remove = sgp41_remove,
+};
+
+module_i2c_driver(sgp41_driver);
+
+MODULE_AUTHOR("Akshat Chandra <notmissinge@gmail.com>");
+MODULE_DESCRIPTION("Sensirion SGP41 gas sensor");
+MODULE_LICENSE("GPL");
--
2.53.0

