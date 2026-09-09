Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D00455622;
	Wed,  9 Sep 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942508; cv=none; b=kP9tL5s4Oi4MtEXpy9tsqDOVtsHUiZFbuv3dW8oX2K4L6Z3SxHXOsCOyGI5f9HD1gju8bF4thkyVP5Bvd9hxWxKhuuWPrRclQO0+Bk+T6SpEDmD626SbNw3xF0Z0IjOP1nR9VFmiURJnd9baIRswFOJWLiXxh4+AafAR5HuJW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942508; c=relaxed/simple;
	bh=A44j0GA22AUbtWPElv5ZndciXH6u8cj3zOC1mYRHrMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBuGsOz+Rj7Vx6MYCACwTr68oIEvdsJrfWmPgf2pdTspk0YfdEVEHuVFTJSVhWTSLvPVjS8iIIsUNgjWojwa6zsZMsOtMCVlBtlz71YcSpl6cHd8ur0tH4gbaX9Dcv6MYJ35gSmB5ZkDHjw7Lsz7dg5Y8UOqRPMSPycJPp38Z+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GjX2YbdM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GjX2YbdM"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6897wPXm2763878;
	Wed, 9 Sep 2026 04:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PQkNQ
	U7zapyrvcToz/o5ddsZJyuAPXhUHM/vecUkA4o=; b=GjX2YbdMvudA3ARBjaFtY
	AWACvdNjhk/3q4hxmcYJA5WhiPzQe8+HTqIX7eaeEi2dEumlT/0nX7vKjU8xoQC1
	h5NTItCQZpWLf9+n4p+5wh9ESFTvaGgurMdg2742wd5vvU+hM/rPbw9UzEWVpq7c
	zCHQW+cWOsIsU4Eqop7BtjTeUOgiS7fT6usTP+4cBub5dBJMt/JDvMw2VxSwPV+O
	f1fdbLVfKmZX/Sgp7MQW6EQ8HPEnyxgYanokeVacAtb/4Ta6kLMrJN7VIs/Ianet
	4Hf4PxVBVzp6l66H+CtaVbwR3fOVMRG+fi4hGC+RwPvET4Ojc+ZUpV4O6z8zCVMQ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dc630c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 04:28:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6898SK8V001446
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 04:28:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 04:28:19 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.171])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6898RxF8032752;
	Wed, 9 Sep 2026 04:28:13 -0400
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
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v4 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Date: Wed, 9 Sep 2026 11:27:52 +0300
Message-ID: <20260909082755.366269-4-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909082755.366269-1-andrei.stancovici@analog.com>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6aa118a5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=JFow1UHeAF9eE4mkUcAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX7jLorGaIePVB
 1NA185KR6BkWfgGWhYVst0TULnsHYIoK//JrRlkI5KUf9LpBxf2zZaYEZpxlaCLCh+6c50ifQJQ
 WMK2XXj3o4fLPkFdH367weUN/SJ5joDmqpk10t6t+cpYxDzNZNb9
X-Proofpoint-ORIG-GUID: -_HQDFmjrT8Ybdj1ToOPRf_m8Zgl_Eza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX9dJJBVYX7Tu0
 nuBxvVJ6ttme3SSjPqtIfsUpTjezPAhIafFFuVXjqJy7/X7SrMrhRuFNE/Tgj524eQBF35zkCV3
 up0sdUoEtbidht2m10qeKdfBnsD48W5TqmI/SYe/go/nl7J/7yVJLvmYPrM8pkrTlJiuEO4hOcU
 A/vYdpWJFfuHWpN5/rP2IIJQM5G/fAG4hjVHK7uyUuHFZ2ErZvmbawmV5GF4t8P+BuJA86++AGA
 j0W/Niz4CZ5LPFoegEoaurkJse2+6UtJ26qR/7EVW5n4JWP05WzslVd75yQk8+KSugz3J3vQ7rr
 +Jx0aJ0FCo9R07QAevfAlNw1qkcnrkr+0EGc6u+q2H5zv8pQzx520nAQcWR/qdTFPJA5ee5FY7H
 1Zh89jBF+ekE09ihnnzHfLhZCFAWMOtXQx1MKzA29L6ovoiQ1i6MJLtF7Ixd/qSqLIKWNiqQOMp
 FjKYq+aKlJQpcCN6Lzg==
X-Proofpoint-GUID: -_HQDFmjrT8Ybdj1ToOPRf_m8Zgl_Eza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090092

The LTC2499 can convert at twice the output rate by disabling the offset
auto-calibration.  Expose it through sampling_frequency and
sampling_frequency_available on the voltage channels.  The part ignores
the setting while measuring temperature, so the temperature channel does
not carry the attribute.

The wait before a result is read is keyed on the conversion currently in
flight, whose duration is fixed by the mode that was active when it
started rather than by the mode just selected.  Otherwise the first read
after a 1x -> 2x switch can reprogram the part while a 1x conversion is
still running, which the part NACKs.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v4:
- The channel table is now two static const tables selected in probe,
  replacing the devm_kmemdup() copy and runtime fix-up of a shared table.
  The 32 voltage entries moved into a macro that emits the whole table
  (same shape as DEFINE_AD7380_2_CHANNEL); the move is mechanical and the
  entries are unchanged. Checked two ways: the preprocessor expansion of
  the non-speed table is identical to v3 apart from the added
  info_mask_shared_by_type_available = 0, and the sysfs attribute tree of
  both parts is byte-identical before and after.
- Comments trimmed: the rounding rationale, the msleep granularity note
  and the FA/FB aside are gone; the paragraph explaining what 2x actually
  does is kept.
- Naming settled on speed_2x / has_speed_mode throughout; the v3 mix of
  speed / sped / SPD is gone.
- Description shortened. The in-flight conversion-time paragraph is kept
  because it is the part that is not obvious from the code.
- struct ltc2497_chip_info reordered as described in patch 2/3.
- Added the Datasheet: trailer.

 drivers/iio/adc/ltc2497-core.c | 242 ++++++++++++++++++++++++++-------
 drivers/iio/adc/ltc2497.c      |  28 ++--
 drivers/iio/adc/ltc2497.h      |  17 ++-
 3 files changed, 228 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 6df9c72bd8cf..fcf10e86da17 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -21,24 +21,54 @@
 #define LTC2497_DIFF			0
 #define LTC2497_SIGN			BIT(3)
 
-static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
+/*
+ * Output-rate modes, indexed by ltc2497core_driverdata.speed_2x
+ * (0 = 1x, the power-on default; 1 = 2x, LTC2499 only).  The advertised
+ * sampling_frequency and the conversion-time budget are two views of the same
+ * mode, so they are kept in lock-step here.
+ */
+static const int ltc2497core_samp_freq_avail[] = {
+	6, 800000,	/* 1x: ~6.8 Hz  (1 / t_CONV_1 typ 146.9ms) */
+	13, 600000,	/* 2x: ~13.6 Hz (1 / t_CONV_2 typ  73.6ms) */
+};
+
+static const unsigned int ltc2497core_conv_time_ms_tbl[] = {
+	LTC2497_CONV_TIME_1X_MS,		/* 1x */
+	LTC2499_CONV_TIME_2X_MS,		/* 2x */
+};
+
+static unsigned int ltc2497core_conv_time_ms(struct ltc2497core_driverdata *ddata,
+					     u8 address)
+{
+	/*
+	 * SPD is ignored by the part during a temperature measurement: it
+	 * always converts at 1x, so budget the 1x time regardless of the
+	 * selected voltage-channel mode.
+	 */
+	if (address == LTC2497_TEMP_ADDR)
+		return ltc2497core_conv_time_ms_tbl[0];
+
+	return ltc2497core_conv_time_ms_tbl[ddata->speed_2x];
+}
+
+static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata,
+				 unsigned int conv_time_ms)
 {
 	s64 time_elapsed;
 
 	time_elapsed = ktime_ms_delta(ktime_get(), ddata->time_prev);
 
-	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
+	if (time_elapsed < conv_time_ms) {
 		/* delay if conversion time not passed
 		 * since last read or write
 		 */
-		if (msleep_interruptible(
-		    LTC2497_CONVERSION_TIME_MS - time_elapsed))
+		if (msleep_interruptible(conv_time_ms - time_elapsed))
 			return -ERESTARTSYS;
 
 		return 0;
 	}
 
-	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
+	if (time_elapsed - conv_time_ms <= 0) {
 		/* We're in automatic mode -
 		 * so the last reading is still not outdated
 		 */
@@ -50,9 +80,18 @@ static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 
 static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, int *val)
 {
+	unsigned int conv_time_ms = ltc2497core_conv_time_ms(ddata, address);
 	int ret;
 
-	ret = ltc2497core_wait_conv(ddata);
+	/*
+	 * Wait for the conversion currently in flight, whose duration was fixed
+	 * by the mode active when it was started (ddata->conv_time_prev).  This
+	 * can be longer than the freshly selected mode's time - e.g. a 1x
+	 * conversion is still running when the first 2x read arrives after a
+	 * sampling_frequency change - and reprogramming the device before it
+	 * finishes would be NACKed (-EIO).
+	 */
+	ret = ltc2497core_wait_conv(ddata, ddata->conv_time_prev);
 	if (ret < 0)
 		return ret;
 
@@ -62,7 +101,17 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 			return ret;
 		ddata->addr_prev = address;
 
-		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS))
+		/*
+		 * The reprogram above starts a conversion in the new mode.
+		 * Record its start time and duration before sleeping, so that if
+		 * msleep_interruptible() is interrupted the conversion state is
+		 * already consistent: the next retry then waits only the time
+		 * remaining from the real start instead of from a stale
+		 * time_prev, which would let it reprogram/read too early.
+		 */
+		ddata->time_prev = ktime_get();
+		ddata->conv_time_prev = conv_time_ms;
+		if (msleep_interruptible(conv_time_ms))
 			return -ERESTARTSYS;
 	}
 
@@ -71,6 +120,8 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 		return ret;
 
 	ddata->time_prev = ktime_get();
+	/* The read above auto-starts the next conversion in the current mode. */
+	ddata->conv_time_prev = conv_time_ms;
 
 	return ret;
 }
@@ -137,32 +188,113 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * Only advertised on the voltage channels of parts with a speed
+		 * mode; the sampling frequency is a property of the selected 1x/2x
+		 * mode, not of an individual conversion.
+		 */
+		mutex_lock(&ddata->lock);
+		*val = ltc2497core_samp_freq_avail[ddata->speed_2x * 2];
+		*val2 = ltc2497core_samp_freq_avail[ddata->speed_2x * 2 + 1];
+		mutex_unlock(&ddata->lock);
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
 	default:
 		return -EINVAL;
 	}
 }
 
-#define LTC2497_CHAN(_chan, _addr, _ds_name) { \
+static int ltc2497core_read_avail(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = ltc2497core_samp_freq_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(ltc2497core_samp_freq_avail);
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2497core_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
+	unsigned int i;
+	bool speed_2x;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/* Match the (val, val2) pair against the advertised rates. */
+		for (i = 0; i < ARRAY_SIZE(ltc2497core_samp_freq_avail); i += 2) {
+			if (val == ltc2497core_samp_freq_avail[i] &&
+			    val2 == ltc2497core_samp_freq_avail[i + 1])
+				break;
+		}
+		if (i == ARRAY_SIZE(ltc2497core_samp_freq_avail))
+			return -EINVAL;
+
+		speed_2x = i / 2;
+
+		mutex_lock(&ddata->lock);
+		ddata->speed_2x = speed_2x;
+		/*
+		 * The new speed only takes effect once the second command byte
+		 * is reprogrammed, so force the next read to reprogram rather
+		 * than reuse the value already latched for this address.
+		 * LTC2497_CONFIG_DEFAULT is not a valid channel/temperature
+		 * address, so it is a safe re-arm sentinel (as used at probe).
+		 *
+		 * A conversion started under the old speed may still be in
+		 * flight; its own duration (conv_time_prev), not the new mode's,
+		 * still gates the next reprogram, so the timing state is left
+		 * untouched here.
+		 */
+		ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
+		mutex_unlock(&ddata->lock);
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+#define LTC2497_CHAN(_chan, _addr, _ds_name, _extra_mask) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (_chan), \
 	.address = (_addr | (_chan / 2) | ((_chan & 1) ? LTC2497_SIGN : 0)), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | (_extra_mask), \
+	.info_mask_shared_by_type_available = (_extra_mask), \
 	.datasheet_name = (_ds_name), \
 }
 
-#define LTC2497_CHAN_DIFF(_chan, _addr) { \
+#define LTC2497_CHAN_DIFF(_chan, _addr, _extra_mask) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 1 : 0), \
 	.channel2 = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 0 : 1),\
 	.address = (_addr | _chan), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | (_extra_mask), \
+	.info_mask_shared_by_type_available = (_extra_mask), \
 	.differential = 1, \
 }
 
+/*
+ * SPD is ignored by the part during a temperature measurement, so the
+ * temperature channel carries no sampling-frequency attribute.
+ */
 #define LTC2497_TEMP_CHANNEL { \
 	.type = IIO_TEMP, \
 	.address = LTC2497_TEMP_ADDR, \
@@ -171,44 +303,55 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 			      BIT(IIO_CHAN_INFO_OFFSET), \
 }
 
-static const struct iio_chan_spec ltc2497core_channel[] = {
-	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
-	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
-	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
-	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
-	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
-	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
-	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
-	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
-	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
-	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
-	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
-	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
-	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
-	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
-	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
-	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_TEMP_CHANNEL,
-};
+/*
+ * Parts with a speed mode advertise sampling_frequency on their voltage
+ * channels; the two tables are otherwise identical.
+ */
+#define LTC2497_DEFINE_CHANNELS(_name, _extra_mask)                     \
+static const struct iio_chan_spec _name[] = {                           \
+	LTC2497_CHAN(0, LTC2497_SGL, "CH0", _extra_mask),               \
+	LTC2497_CHAN(1, LTC2497_SGL, "CH1", _extra_mask),               \
+	LTC2497_CHAN(2, LTC2497_SGL, "CH2", _extra_mask),               \
+	LTC2497_CHAN(3, LTC2497_SGL, "CH3", _extra_mask),               \
+	LTC2497_CHAN(4, LTC2497_SGL, "CH4", _extra_mask),               \
+	LTC2497_CHAN(5, LTC2497_SGL, "CH5", _extra_mask),               \
+	LTC2497_CHAN(6, LTC2497_SGL, "CH6", _extra_mask),               \
+	LTC2497_CHAN(7, LTC2497_SGL, "CH7", _extra_mask),               \
+	LTC2497_CHAN(8, LTC2497_SGL, "CH8", _extra_mask),               \
+	LTC2497_CHAN(9, LTC2497_SGL, "CH9", _extra_mask),               \
+	LTC2497_CHAN(10, LTC2497_SGL, "CH10", _extra_mask),             \
+	LTC2497_CHAN(11, LTC2497_SGL, "CH11", _extra_mask),             \
+	LTC2497_CHAN(12, LTC2497_SGL, "CH12", _extra_mask),             \
+	LTC2497_CHAN(13, LTC2497_SGL, "CH13", _extra_mask),             \
+	LTC2497_CHAN(14, LTC2497_SGL, "CH14", _extra_mask),             \
+	LTC2497_CHAN(15, LTC2497_SGL, "CH15", _extra_mask),             \
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_TEMP_CHANNEL,                                           \
+}
+
+LTC2497_DEFINE_CHANNELS(ltc2497core_channel, 0);
+LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq,
+			BIT(IIO_CHAN_INFO_SAMP_FREQ));
 
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
+	.read_avail = ltc2497core_read_avail,
+	.write_raw = ltc2497core_write_raw,
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
@@ -228,7 +371,10 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2497core_channel;
+	if (ddata->chip_info->has_speed_mode)
+		indio_dev->channels = ltc2497core_channel_samp_freq;
+	else
+		indio_dev->channels = ltc2497core_channel;
 	/* Only the ltc2499 has a temperature channel; it is the last entry. */
 	if (ddata->chip_info->has_temp)
 		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
@@ -259,6 +405,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
 	ddata->time_prev = ktime_get();
+	/* Power-on default mode is 1x; a conversion is already in flight. */
+	ddata->conv_time_prev = LTC2497_CONV_TIME_1X_MS;
 
 	mutex_init(&ddata->lock);
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index ea55b417213a..15458d4e21a1 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -85,21 +85,24 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 	}
 
 	/*
-	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
-	 * configuration via a second command byte and only re-evaluate it when
-	 * that byte has EN2 set; a single byte, or a second byte with EN2 = 0,
-	 * means "keep previous".  A one-byte channel select therefore cannot pull
-	 * the device back out of temperature mode, so a voltage read after a
-	 * temperature read would keep returning the PTAT result.  Always drive the
-	 * second byte with EN2 set on these parts: IM = 1 for a temperature read,
-	 * EN2 alone (IM = 0) to (re)select an external input.  FA = FB = 0 keeps
-	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
-	 * conversion time the driver's wait already covers.
+	 * Parts with a second config byte (LTC2499: internal PTAT sensor and/or
+	 * the 2x speed mode) latch their converter configuration from that byte
+	 * and only re-evaluate it when EN2 is set; a single byte, or a second
+	 * byte with EN2 = 0, means "keep previous".  A one-byte channel select
+	 * therefore cannot pull the device back out of temperature mode, so a
+	 * voltage read after a temperature read would keep returning the PTAT
+	 * result.  Always drive the second byte with EN2 set on these parts:
+	 *   - temperature read: IM = 1 (SPD is ignored by the part in
+	 *     temperature mode and is left 0 here);
+	 *   - voltage read: IM = 0 (external input), plus SPD when 2x is
+	 *     selected.
+	 * FA = FB = 0 keeps the power-on simultaneous 50/60Hz rejection, whose
+	 * worst-case conversion time the driver's wait already covers.
 	 *
 	 * The byte could be skipped while the latched configuration is already
 	 * the one wanted; it is sent on every conversion for simplicity.
 	 */
-	if (ddata->chip_info->has_temp) {
+	if (ddata->chip_info->has_temp || ddata->chip_info->has_speed_mode) {
 		u8 cmd[2];
 
 		if (address == LTC2497_TEMP_ADDR) {
@@ -108,6 +111,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		} else {
 			cmd[0] = LTC2497_ENABLE | address;
 			cmd[1] = LTC2499_EN2;
+			if (ddata->speed_2x)
+				cmd[1] |= LTC2499_SPD;
 		}
 
 		ret = i2c_master_send(st->client, cmd, sizeof(cmd));
@@ -173,6 +178,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 		.resolution = 24,
 		.name = "ltc2499",
 		.has_temp = true,
+		.has_speed_mode = true,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 2b797fd19651..cee9a2f50b82 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -2,7 +2,17 @@
 
 #define LTC2497_ENABLE			0xA0
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+
+/*
+ * Conversion-time bounds used to gate reads.  Each value is the datasheet
+ * t_CONV maximum, rounded UP to the next whole millisecond.
+ *
+ * The 2x mode (LTC2499_SPD, LTC2499 only) disables the offset auto-calibration
+ * to roughly double the output rate; adding the 2x wait time is what makes the
+ * SPD control actually faster.
+ */
+#define LTC2497_CONV_TIME_1X_MS		150ULL	/* ceil(t_CONV_1 simult. max 149.9) */
+#define LTC2499_CONV_TIME_2X_MS		76ULL	/* ceil(t_CONV_2 simult. max  75.1) */
 
 /*
  * Sentinel passed as `address` to result_and_measure() to request a
@@ -14,11 +24,13 @@
 /* Second config-byte bits (LTC2499 / LTC2493 only) */
 #define LTC2499_EN2			BIT(7)	/* enable second config byte */
 #define LTC2499_IM			BIT(6)	/* 1 = measure internal temp sensor */
+#define LTC2499_SPD			BIT(3)	/* 1 = 2x output rate (offset cal off) */
 
 struct ltc2497_chip_info {
 	const char *name;
 	u32 resolution;
 	bool has_temp;
+	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
 };
 
 struct ltc2497core_driverdata {
@@ -28,6 +40,9 @@ struct ltc2497core_driverdata {
 	struct mutex lock;
 	const struct ltc2497_chip_info	*chip_info;
 	u8 addr_prev;
+	bool speed_2x;	/* SPD: false = 1x (default), true = 2x */
+	/* Conversion time (ms) of the conversion currently in flight. */
+	unsigned int conv_time_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
 };
-- 
2.43.0

