Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D838F24C;
	Wed,  2 Sep 2026 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331482; cv=none; b=bF/aiPrvJuCU7uTCnmIkcLlaP3jfpBGXsqonQRhgFcnTTRlECvhE6+5k04pCzw8GQd2HwFIcYoyyFFL90Ye/DeWai2DNkSC4oEBG6VjCS+JbdxGaxpbRhh3OuRpzF6b+1GOydcGBjaVDVCBcqZxra+hUNpOZVufjNdHgxwacmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331482; c=relaxed/simple;
	bh=Si5NWwL8mYgtadrz463OcEMi6QG4S9UTENQ/WKWw6EE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7a8a4ve+6bMNfmzdWi98/ScjMN3HncaLbjuhfrlNmTgn7KVwkh4yk5wDiO6HPfPJ7Tsro8/Fgs0D5uT1yay1GBi2bxeOPJZc7YVyNBB6wCWeJ3CvzxDr8AzdQj5v4NOigO4bU5tLM5ok6EeVNWSrftugvbyuTi3s6gqIBC1wxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oRVJP9/K; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oRVJP9/K"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826U53R1318268;
	Wed, 2 Sep 2026 02:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0Z0ve
	gNIRRONyQl+/JnuVAy0eWKRA7SnrGhNw4/bL8k=; b=oRVJP9/KrWjRmZPg3I0LH
	aDnTb7SY/3Ky/2C6SFyqk3Ev5etPY3FPoycze5VjcU4pbZZJvrAgB5CzCgyvknU2
	KI1FXGxaxukhBR77AdA4Y9wImau+2oeF6wUyyIQg3wQOr2wh8BZnrYxXShGu/a4n
	mqDHnz0EUK+39OrZRkpghiZM58Jemt5UlxCXFSMRrztaSG8SzEEyX4H1YRVjpkKk
	2jWxYUHx+9q6BhKSu5ZQnKkpvaULLM+2KdYOF3TUu3aCPW2i6ML7EL1r8F+IND1l
	X4m9azfoVIEL+Rh19Phnlps3fta28E7OhSD1AFcHwGlqXC6d/xfpprCOhJGflKXZ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1jr85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 02:44:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6826iZ0h061182
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 02:44:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 02:44:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 02:44:35 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6826iJ62018111;
	Wed, 2 Sep 2026 02:44:31 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v3 2/3] iio: adc: ltc2497: add LTC2499 internal temperature channel
Date: Wed, 2 Sep 2026 09:44:11 +0300
Message-ID: <20260902064415.132588-3-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902064415.132588-1-andrei.stancovici@analog.com>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a97c5d4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=WqbBa0nbqy7j7haUM7sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YrFuEWsUk-XszrOSKIrYCGHOfLLVLUT8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfXz8Dhdi8zQYbm
 b3JwcYAFoYCjncXWKknIV8WKEwDgDsDRsCg3sEp3JMIVSuIKMtxha8BBtX6XN2pRuMCh/Q0oiCO
 itKQLx9Ies5d0FJAB8/T/yjtaneBxjI1Va65CW7kSLvEhn0zbVs3
X-Proofpoint-ORIG-GUID: YrFuEWsUk-XszrOSKIrYCGHOfLLVLUT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfXzrxmP0xZrIcj
 ju/WVVBdAl7Q/wDwu3s7yBOPfJ4U0qy778tpW0GMeEuJNZ3RgDMSRzO3cW98+8/9X5AEBOxIcQI
 nT0Updl4qApzSLkXh+E6pt7w2919hiqtUlR6j+oVHuv7ScW07mfYNinjMDHP3m98E0y8vdFqsZ/
 0t0GIisQ+rsn3yWbOXofQ8SxfuSaGUQgqgoiAb6PduCkqbN58pwkbUSzsbDuj33ymNEyqWBuKMU
 GvfU28B1zbW+H0IzsFr3DjbV91rWqp0ZnY/5DzMJZZWFbqxbOV3J5Q/L+SAAG7G0TJgOli/dtXa
 tPe/zFDFN+rjaDJAQLDU6q34DVjuCWrVNYzM3flVON74R7ZAUh/a+xrMnO3eJUitBSIGcn4NB7T
 kHfUKAa4YgmzrCm8N4O4G//3fjPxl/l5a/Le9ybkieswdsHF8FhqdaPFTaoOUKlYO8J2nFlV44d
 XpohAVbTSnlQ0jmqhKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020059

The LTC2499 has an internal PTAT (proportional to absolute temperature)
sensor that is activated by a second I2C configuration byte (EN2 | IM).
Expose it as an IIO_TEMP channel providing raw, scale and offset so the
standard IIO formula

	T[m°C] = (raw + offset) * scale

reconstructs the temperature.

The PTAT sensor yields the absolute temperature as

	T(K) = DATAOUT24 * Vref / 1570		(Vref in volts)

The raw value exported here is sign-extended and normalised to
2^(resolution + 1) == 2^25, i.e. raw = 2 * DATAOUT24, so on the IIO
milli-degree-Celsius convention

	scale[m°C/LSB] = Vref_uV / 3140000
	offset         = -273150 * 3140000 / Vref_uV

The scale and offset are derived from the reference voltage returned by
regulator_get_voltage(); its error is propagated as before, so a board
that fails to describe vref-supply gets a clear read error instead of a
silently wrong temperature. No board-specific reference value is assumed
in the driver.

The single temperature channel is appended as the last entry of the
shared channel array and excluded via num_channels for parts without an
internal sensor, so the existing LTC2497 channel layout and device name
are unchanged.

The LTC2499 latches its converter configuration from the second command
byte and only re-evaluates it when that byte has EN2 set. EN2 | IM
selects the internal temperature sensor. Because a single-byte command,
or a second byte with EN2 = 0, means "keep previous", a one-byte channel
select cannot pull the device back out of temperature mode: after a
temperature read every subsequent voltage read would keep returning the
PTAT result instead of the selected input. Temperature support is
therefore only correct if the voltage path also emits a second command
byte that re-selects an external input.

Send two-byte commands for all conversions on parts that have the sensor
(has_temp):

	temperature:	EN2 | IM
	voltage:	EN2			(IM = 0 -> external input)

The LTC2497 and LTC2496, which lack the second-byte mechanism, keep using
the original single-byte channel select and are unchanged.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 58 +++++++++++++++++++++++++++++++---
 drivers/iio/adc/ltc2497.c      | 33 +++++++++++++++++++
 drivers/iio/adc/ltc2497.h      | 12 +++++++
 3 files changed, 99 insertions(+), 4 deletions(-)

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
index c1668b5a351e..79c87bac05e1 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -84,6 +84,38 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
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
@@ -137,6 +169,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.has_temp = true,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 64e81c95a3dd..71fa4ad408ee 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -4,8 +4,20 @@
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
 	u32 resolution;
+	bool has_temp;
 	const char *name;
 };
 
-- 
2.43.0

