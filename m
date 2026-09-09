Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D594582F9;
	Wed,  9 Sep 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942507; cv=none; b=bm8/eikjO1O+38ZFHXvCNi5LWISiCFbjn5jxxP72NI6bEkSyoa99ZQVL9Tup2Udcosxn9RFHOV90s3Ze5lcxVQNw9HK7H80FthnSflTK6bkrnE1fZTm1pp0Eun3X7H4TDOVfA0K9e1qlK0s7n2OR3IrMqZqGzX1HUAQBFrbSJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942507; c=relaxed/simple;
	bh=i7WpoL1qVtGjoFhBgpzCjOdL+pfVTEsfstRk7nzMVac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIPqOmHs5lsmoTBNh4dIP8G9CVh7aTtjwu+ayfD8p2KOtviEslOD5DrFE9r1hNWRbTqq3ODw6g9Ov/w16Fz/cbrLiCJ5VvTlF8UbztLyQ1t9LryssGsJ/0mZ5YK4SGwGa+WRmfKBvXxTLvRKDnI4jha1FO2QJFxADaSgqKvxqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z0nlKANw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z0nlKANw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6897kRoE2763506;
	Wed, 9 Sep 2026 04:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xULnj
	SEHord/eXvQP6+P7gu71y6kWTY81ENNfhcxJa0=; b=Z0nlKANwCSWIazslVVObl
	eB59GAqavoJM9Bzen+WHOAkhIZzwvkDuj4nv4k9cn3Y1DhTajNK8yuGMGEnmMW6E
	mw3UKB17/E7DopyeM2EYn3kq1GEP/9dCmIY0Ll+8D9qM90E+RtI3qDt3xjUU/Smg
	rcgG4FFa0EuwWIlaXO6Ml1CbR3CmchIS498mzjyft4COfHTF5gnV/pGDevBjqR8e
	cG2mVpvZhWsBBMWB5qnwEtLkTS1bjEqFyXCYk/Imh0aos+bTY3NHzJ1Cz0RDjH/k
	JBpnEvXy/RJd/uDAQbs0tt280aZZthuRLYw9FJp0oaezXbLIhJGuJCKF/KyG3B15
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dc6309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 04:28:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6898SIoe001436
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 04:28:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 04:28:17 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.171])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6898RxF7032752;
	Wed, 9 Sep 2026 04:28:10 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/3] iio: adc: ltc2497: add LTC2499 internal temperature channel
Date: Wed, 9 Sep 2026 11:27:51 +0300
Message-ID: <20260909082755.366269-3-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909082755.366269-1-andrei.stancovici@analog.com>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6aa118a3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=oH3iYeRb2tCmVxh1MEoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX70G8SsQgBqXX
 rTDdit4RRAqhTWk99GycktZWNWzg2uznBVVc1aBZAZctUy2wWA3U9A9Zhkmc110JiJA44Inklnm
 x4Wgk9pVeQLGFJC6at/7zy4l5bJksPVa83ik/7gl+65m86H5rhmQ
X-Proofpoint-ORIG-GUID: gwca-IOP1Lv6ZaxpRTZxwIObHhuDCt_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX1OoNj6sTmsko
 B3UxXlSFUsJ4yyXJVVVxhIT1zBN7GTIuh4nyQmc2qarJE3I38aSjwBPFe1fo1YrcAnbe5+BT7Ey
 p8rZJr+ZXi2C9XH2i2/YgPclqwKbC6jjKMPT+9aIBWkELPdJKCzpkz/CmDRfYmrVE3MVrnMyKkc
 H/Rz79LhWzMyn99v26r07OgZdyUsv58yuYbFI0a4Ui1RM33KYOv9NdAwfZ6hxVY1b81nyc6KaD3
 7JP9oR2TlgCz5Rkn4Tsb1BX8B21ZyDfsmUxuAY14rq9KJkQ0O1J6zMSD85Gc53/MiBZldVCb8RH
 e3LgP63xc0ptT/g2fx/hlIWltP+J3QuQ8E2FfwLFvC03F0nNgpKoQPy+6fA+j3lV74vd+CiugXm
 W4s8ZEvmxJQdhRT5E8YfJQaSIOj8sCfuWcDuusAo35c4D/omqSq6/l9rnAaaSpvVS7JriZpyBka
 dLHNQmxJ9m4/xfZG43w==
X-Proofpoint-GUID: gwca-IOP1Lv6ZaxpRTZxwIObHhuDCt_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090092

The LTC2499 includes an internal temperature sensor.  Expose it as an
IIO_TEMP channel with raw, scale and offset.

Scale and offset are derived from the reference voltage, so reading them
returns an error if firmware does not describe a vref-supply.  As this is
a new feature on a part that already works without it, failing probe is
not an option.

Selecting the sensor needs a second command byte, and the part keeps the
configuration it last latched unless that byte is sent again.  Voltage
reads on this part therefore also send the second byte.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v4:
- Description cut down to what a reader needs: the sensor, the ABI it
  exposes and the vref dependency. The PTAT derivation and the
  num_channels detail are gone; the maths stays as comments next to the
  code that does it.
- struct ltc2497_chip_info: booleans moved last, as requested, with one
  deviation I should flag - I hoisted `name` to the front rather than
  only shifting the flags down. pahole, LP64, all three instances:

      as posted (flags after resolution)   16 B, 2 B hole,             48 B
      flags moved last, as requested       24 B, 4 B hole + 6 B tail,  72 B
      name, resolution, flags last (v4)    16 B, no hole,              48 B

  The pre-series struct already had a 4-byte hole after `resolution` and
  the flags fell into it, which is why the posted version did not grow.
  Moving them to the end leaves that hole and adds tail padding. Hoisting
  the pointer puts the flags last as asked and removes the hole. On ILP32
  all three orderings are 12 B. If you would rather have the literal
  reorder, say so and I will take the 24 B.
- Why the second command byte is sent on every conversion rather than
  only when the latched configuration already differs: simplicity. It
  costs one extra byte per conversion, and a conversion takes 150 ms, so
  tracking the latched state to avoid it does not pay for itself. The
  code comment now records that the unconditional send is deliberate; the
  rationale itself is here rather than in the commit message.
- Added the Datasheet: trailer.
- Andy's Reviewed-by is kept. The only code change in this patch since v3
  is the member reorder he asked for, plus one sentence of comment.

 drivers/iio/adc/ltc2497-core.c | 58 +++++++++++++++++++++++++++++++---
 drivers/iio/adc/ltc2497.c      | 36 +++++++++++++++++++++
 drivers/iio/adc/ltc2497.h      | 14 +++++++-
 3 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2dc5c7044269..6df9c72bd8cf 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -9,9 +9,11 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/units.h>
 
 #include "ltc2497.h"
 
@@ -95,10 +97,45 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret / 1000;
-		*val2 = ddata->chip_info->resolution + 1;
+		switch (chan->type) {
+		case IIO_TEMP:
+			/*
+			 * raw is normalised to 2^(resolution + 1), i.e.
+			 * raw = 2 * DATAOUT24, so the PTAT scale (datasheet
+			 * Vref / 1570 per Kelvin) doubles its denominator and,
+			 * in m°C, becomes Vref_uV / 3140000.
+			 */
+			*val = ret;
+			*val2 = 3140000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VOLTAGE:
+			*val = ret / (MICRO / MILLI);
+			*val2 = ddata->chip_info->resolution + 1;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
 
-		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			ret = regulator_get_voltage(ddata->ref);
+			if (ret < 0)
+				return ret;
+			if (ret == 0)
+				return -EINVAL;
+			/*
+			 * 0 °C == 273.15 K must map to raw + offset such that
+			 * (raw + offset) * scale == 0 m°C, i.e.
+			 *   offset = -273150 / scale
+			 *          = -273150 * 3140000 / Vref_uV
+			 * Computed in 64-bit to avoid overflow.
+			 */
+			*val = div_s64(ABSOLUTE_ZERO_MILLICELSIUS * 3140000LL, ret);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 
 	default:
 		return -EINVAL;
@@ -126,6 +163,14 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	.differential = 1, \
 }
 
+#define LTC2497_TEMP_CHANNEL { \
+	.type = IIO_TEMP, \
+	.address = LTC2497_TEMP_ADDR, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
+			      BIT(IIO_CHAN_INFO_OFFSET), \
+}
+
 static const struct iio_chan_spec ltc2497core_channel[] = {
 	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
 	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
@@ -159,6 +204,7 @@ static const struct iio_chan_spec ltc2497core_channel[] = {
 	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
 	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
 	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_TEMP_CHANNEL,
 };
 
 static const struct iio_info ltc2497core_info = {
@@ -183,7 +229,11 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc2497core_channel;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+	/* Only the ltc2499 has a temperature channel; it is the last entry. */
+	if (ddata->chip_info->has_temp)
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+	else
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) - 1;
 
 	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index c1668b5a351e..ea55b417213a 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -84,6 +84,41 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 			return 0;
 	}
 
+	/*
+	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
+	 * configuration via a second command byte and only re-evaluate it when
+	 * that byte has EN2 set; a single byte, or a second byte with EN2 = 0,
+	 * means "keep previous".  A one-byte channel select therefore cannot pull
+	 * the device back out of temperature mode, so a voltage read after a
+	 * temperature read would keep returning the PTAT result.  Always drive the
+	 * second byte with EN2 set on these parts: IM = 1 for a temperature read,
+	 * EN2 alone (IM = 0) to (re)select an external input.  FA = FB = 0 keeps
+	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
+	 * conversion time the driver's wait already covers.
+	 *
+	 * The byte could be skipped while the latched configuration is already
+	 * the one wanted; it is sent on every conversion for simplicity.
+	 */
+	if (ddata->chip_info->has_temp) {
+		u8 cmd[2];
+
+		if (address == LTC2497_TEMP_ADDR) {
+			cmd[0] = LTC2497_ENABLE | LTC2497_CONFIG_DEFAULT;
+			cmd[1] = LTC2499_EN2 | LTC2499_IM;
+		} else {
+			cmd[0] = LTC2497_ENABLE | address;
+			cmd[1] = LTC2499_EN2;
+		}
+
+		ret = i2c_master_send(st->client, cmd, sizeof(cmd));
+		if (ret < 0) {
+			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
+		return 0;
+	}
+
 	ret = i2c_smbus_write_byte(st->client,
 				   LTC2497_ENABLE | address);
 	if (ret)
@@ -137,6 +172,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.has_temp = true,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 64e81c95a3dd..2b797fd19651 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -4,9 +4,21 @@
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
 #define LTC2497_CONVERSION_TIME_MS	150ULL
 
+/*
+ * Sentinel passed as `address` to result_and_measure() to request a
+ * temperature conversion instead of a voltage channel.  Valid channel
+ * addresses fit in 5 bits (0x00–0x1F), so 0xFF is unambiguous.
+ */
+#define LTC2497_TEMP_ADDR		0xFF
+
+/* Second config-byte bits (LTC2499 / LTC2493 only) */
+#define LTC2499_EN2			BIT(7)	/* enable second config byte */
+#define LTC2499_IM			BIT(6)	/* 1 = measure internal temp sensor */
+
 struct ltc2497_chip_info {
-	u32 resolution;
 	const char *name;
+	u32 resolution;
+	bool has_temp;
 };
 
 struct ltc2497core_driverdata {
-- 
2.43.0

