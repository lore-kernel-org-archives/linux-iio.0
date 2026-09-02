Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2638E5EF;
	Wed,  2 Sep 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331486; cv=none; b=miDEzHYPL7tlTH+AJQogppaPXEoAjpvQFxYNCa/HwpSUTS8tM1McQH2FLOeGQlS0Xb+p496do1errJrd/4lZrtgqz13Rw8fXKB6ORPFMdkXqYhbvLSSRJWbMfH2MPCVE9/W6kbQXLO/fHhewlmd4Pu+aDPE9tjuiP2eNxNIWk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331486; c=relaxed/simple;
	bh=8ZV7CrAU9qzcbk+UjUFiSJW6bAQ/9BDjw0sqW+GmwUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEwvr/R8FuxMmVC83MCaa+QdaK+zeHaWS8x1vuaeJyd2cToo4GteUH0FFcL8SjWgRTVvf9zHlZzbYtggY3/4ntaKvnBdfIyAdQ6fbKCDupuLHf3UwMRJWkhPiHBr40QXWLMftMADdBKNvNyuigtqnnhHTQ9gJMs3S3+HU5RuULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n4xvTWl0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n4xvTWl0"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Tve62490725;
	Wed, 2 Sep 2026 02:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DWLfc
	QZTmUYYYieZ2wy+VYRfUkaS5sj7uhW9pwJBvxQ=; b=n4xvTWl04S0KE1fOaLJnz
	BGs6M3FbQPGYTQN4uhp5owWNGl8NtexQTRriiXEGYzp8jDw3y/pFPbNGfGMloqp3
	00q/ZujeNgYoPqROR54Op3LzdyPum8Sv2RdeMvitR0F0vWLDbmH/IM4KU0pP7WmK
	ATjGvdq05VpshOBZt3u6g7ZT+QwYfspCplo8RPC5wJN9jZnV6vo00EGavgDr2DJY
	3Svw7tBXXgF2EEput2O3hI0enYVkz/c5Rg6Rw4l3uuVu10yGdt6DfdtaBx9txJf3
	sgBGyogBm+cafKHOgJNF0S9YUZJo7RSy1l7w7+lpKybktlavzqW8Ns9fK/iU0Q6M
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge469am72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 02:44:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6826icZQ061185
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 02:44:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 02:44:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 02:44:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 02:44:38 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6826iJ63018111;
	Wed, 2 Sep 2026 02:44:34 -0400
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
Subject: [PATCH v3 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Date: Wed, 2 Sep 2026 09:44:12 +0300
Message-ID: <20260902064415.132588-4-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902064415.132588-1-andrei.stancovici@analog.com>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iW_blLJlaz2e7d99b2icjFu_S4wEJLkx
X-Authority-Analysis: v=2.4 cv=LuCiDHdc c=1 sm=1 tr=0 ts=6a97c5d7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=At-u3ODHGOAtwVYOHAcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfX8CRQTF7AkWhu
 yX5H6PmgDcDU850EFTUTBLuLPTy9KeTVJKSDRwEuNxuYCT6VZNVYRCMxXzi8oZNnW4+ZIu+iU3M
 /4xEtmFEr7dkxa001zyxVzSz4EGHCQuJbzFodEqZSW9qKoBaZH7/XfnzvZDHL6b9kIlbr00nZjI
 h2E5SMP2cDgKQodvOg6NxoUS1ia5qhHWIdDmGxBdBQhWkNjY/aqiPy4j0eVEUOFlvMdlYP3/0AE
 rudKHOZo/owdD+BSHgwsmYupi27xCaLM8td4HP8clZtkIikpvJc6afoM6ng7nZ5TcRkLnH+Gf4S
 f6vPUzoGWg+BtsfgJTzIkaqIJIgJ3oZmdrp9oV2Ro6JRuoGK6QnuMx+dxaosxcqiDTBquO9Zf1I
 hg6354HOxdoQIjj+FTMy5Pi7G4HwtGLYrzxb5yDCDMxvcSJE8iwi4bbY3+KbnG1rTlG4H0FPL1q
 AnOXrZ/guf37OBMTbew==
X-Proofpoint-ORIG-GUID: iW_blLJlaz2e7d99b2icjFu_S4wEJLkx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfX7YR2TFEReoHf
 LX7CX42UCms+5kyUhGFT69l9CCq1MLsILuDhQuJ8MDO7ZA1qkNPYc0+o0vLzTRjLSTS2v0OcIpT
 g358LV6PLFAgSkUkZN3xcjVZdLXovztoLNW5BKyTtD/beexwWKje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020059

The LTC2499 supports a 2x output rate (SPD bit in the second
configuration byte).  In 2x mode the offset auto-calibration is
disabled, roughly doubling the conversion rate (~13.6Hz vs ~6.8Hz in
simultaneous 50/60Hz rejection) while leaving linearity and full-scale
errors unchanged (datasheet).  During a temperature measurement the part
always converts at 1x regardless of SPD.

Expose the rate through the standard sampling_frequency /
sampling_frequency_available ABI on the voltage channels only: SPD is
ignored for temperature conversions, so the temperature channel
deliberately carries no SAMP_FREQ attribute.  A new has_speed_mode
capability flag gates the feature (LTC2499); the two-byte command path
is now taken for has_temp || has_speed_mode, since both features need the
second config byte.

The conversion-time wait becomes mode dependent: 150ms at 1x, 76ms at 2x
(datasheet t_CONV max, simultaneous rejection, rounded up).  The wait is
keyed on the conversion currently in flight, whose duration is fixed by
the mode that was active when it started - not by the newly selected
mode.  This matters on a 1x->2x switch: a 1x conversion may still be
running when the first 2x read arrives, and reprogramming the device
before it finishes would be NACKed with -EIO.  Timing is centralized in
ltc2497core_conv_time_ms() so a future FA/FB rejection-mode selection
can extend it into a [rejection][speed] lookup without touching callers.

LTC2496/LTC2497 (no speed mode) keep the single-byte path and the
unchanged 150ms wait.

Validated on a live LTC2499: 20 reads take ~3.1s at 1x and ~1.6s at 2x
(~0.5x, no -EIO), voltage and temperature readings stay sane in both
modes, and the temperature/voltage interleave (sticky-PTAT) regression
still passes at 1x and 2x.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 177 +++++++++++++++++++++++++++++++--
 drivers/iio/adc/ltc2497.c      |  28 ++++--
 drivers/iio/adc/ltc2497.h      |  34 ++++++-
 3 files changed, 220 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 6df9c72bd8cf..3589cabd3c8e 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -7,6 +7,8 @@
  */
 
 #include <linux/delay.h>
+#include <linux/device/devres.h>
+#include <linux/gfp.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/math64.h>
@@ -21,24 +23,57 @@
 #define LTC2497_DIFF			0
 #define LTC2497_SIGN			BIT(3)
 
-static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
+/*
+ * Output-rate modes, indexed by ltc2497core_driverdata.sped_2x
+ * (0 = 1x, the power-on default; 1 = 2x, LTC2499 only).  The advertised
+ * sampling_frequency and the conversion-time budget are two views of the same
+ * mode, so they are kept in lock-step here and can never drift apart.  Only the
+ * two simultaneous 50/60Hz rejection rates are reachable today; adding FA/FB
+ * rejection selection later turns this into a [rejection][speed] lookup without
+ * changing any caller.
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
+	return ltc2497core_conv_time_ms_tbl[ddata->sped_2x];
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
@@ -50,9 +85,18 @@ static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 
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
 
@@ -62,7 +106,17 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
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
 
@@ -71,6 +125,8 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 		return ret;
 
 	ddata->time_prev = ktime_get();
+	/* The read above auto-starts the next conversion in the current mode. */
+	ddata->conv_time_prev = conv_time_ms;
 
 	return ret;
 }
@@ -137,6 +193,81 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * Only advertised on the voltage channels of parts with a speed
+		 * mode; the sampling frequency is a property of the selected 1x/2x
+		 * mode, not of an individual conversion.
+		 */
+		mutex_lock(&ddata->lock);
+		*val = ltc2497core_samp_freq_avail[ddata->sped_2x * 2];
+		*val2 = ltc2497core_samp_freq_avail[ddata->sped_2x * 2 + 1];
+		mutex_unlock(&ddata->lock);
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
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
+	bool sped_2x;
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
+		sped_2x = i / 2;
+
+		mutex_lock(&ddata->lock);
+		ddata->sped_2x = sped_2x;
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
 	default:
 		return -EINVAL;
 	}
@@ -209,6 +340,8 @@ static const struct iio_chan_spec ltc2497core_channel[] = {
 
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
+	.read_avail = ltc2497core_read_avail,
+	.write_raw = ltc2497core_write_raw,
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
@@ -235,6 +368,34 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	else
 		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) - 1;
 
+	/*
+	 * Parts with a speed mode expose in_voltage_sampling_frequency and
+	 * in_voltage_sampling_frequency_available on the voltage channels only.
+	 * SPD is ignored during a temperature measurement, so the temperature
+	 * channel deliberately carries no SAMP_FREQ attribute.  Patch a private
+	 * copy of the shared channel array so parts without a speed mode stay
+	 * untouched.
+	 */
+	if (ddata->chip_info->has_speed_mode) {
+		struct iio_chan_spec *channels;
+
+		channels = devm_kmemdup(dev, ltc2497core_channel,
+					sizeof(ltc2497core_channel), GFP_KERNEL);
+		if (!channels)
+			return -ENOMEM;
+
+		for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
+			if (channels[i].type != IIO_VOLTAGE)
+				continue;
+			channels[i].info_mask_shared_by_type |=
+				BIT(IIO_CHAN_INFO_SAMP_FREQ);
+			channels[i].info_mask_shared_by_type_available |=
+				BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		}
+
+		indio_dev->channels = channels;
+	}
+
 	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
 	if (ret < 0)
 		return ret;
@@ -259,6 +420,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
 	ddata->time_prev = ktime_get();
+	/* Power-on default mode is 1x; a conversion is already in flight. */
+	ddata->conv_time_prev = LTC2497_CONV_TIME_1X_MS;
 
 	mutex_init(&ddata->lock);
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 79c87bac05e1..3cd30545da2e 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -85,18 +85,21 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
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
 	 */
-	if (ddata->chip_info->has_temp) {
+	if (ddata->chip_info->has_temp || ddata->chip_info->has_speed_mode) {
 		u8 cmd[2];
 
 		if (address == LTC2497_TEMP_ADDR) {
@@ -105,6 +108,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		} else {
 			cmd[0] = LTC2497_ENABLE | address;
 			cmd[1] = LTC2499_EN2;
+			if (ddata->sped_2x)
+				cmd[1] |= LTC2499_SPD;
 		}
 
 		ret = i2c_master_send(st->client, cmd, sizeof(cmd));
@@ -170,6 +175,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 		.resolution = 24,
 		.name = "ltc2499",
 		.has_temp = true,
+		.has_speed_mode = true,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 71fa4ad408ee..83bc27a0de0b 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -2,7 +2,29 @@
 
 #define LTC2497_ENABLE			0xA0
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+
+/*
+ * Conversion-time bounds used to gate reads.  Each value is the datasheet
+ * t_CONV maximum, rounded UP to the next whole millisecond.  Rounding is
+ * always towards +inf (a ceiling), never to nearest: the number is only used
+ * as a *minimum* wait - the argument to msleep_interruptible() and the
+ * threshold compared against ktime_ms_delta() - so it must never fall below
+ * the true worst case, or a read can be issued before the result is ready and
+ * return -EIO.  Both of those APIs operate in whole milliseconds (msleep also
+ * rounds up to the next jiffy, typically 1-10 ms), so storing sub-millisecond
+ * precision would not change the actual wait; the whole-ms ceiling is exact
+ * for this purpose.
+ *
+ * The driver only ever programs simultaneous 50/60Hz rejection (FA/FB
+ * selection is not implemented), so only those two rates are listed.  The 1x
+ * value also covers the LTC2496/LTC2497, which have no speed mode.
+ *
+ * The 2x mode (LTC2499_SPD, LTC2499 only) disables the offset auto-calibration
+ * to roughly double the output rate; adding the 2x wait time is what makes the
+ * SPD control actually faster.
+ */
+#define LTC2497_CONV_TIME_1X_MS		150ULL	/* ceil(t_CONV_1 simult. max 149.9) */
+#define LTC2499_CONV_TIME_2X_MS		76ULL	/* ceil(t_CONV_2 simult. max  75.1) */
 
 /*
  * Sentinel passed as `address` to result_and_measure() to request a
@@ -14,10 +36,12 @@
 /* Second config-byte bits (LTC2499 / LTC2493 only) */
 #define LTC2499_EN2			BIT(7)	/* enable second config byte */
 #define LTC2499_IM			BIT(6)	/* 1 = measure internal temp sensor */
+#define LTC2499_SPD			BIT(3)	/* 1 = 2x output rate (offset cal off) */
 
 struct ltc2497_chip_info {
 	u32 resolution;
 	bool has_temp;
+	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
 	const char *name;
 };
 
@@ -28,6 +52,14 @@ struct ltc2497core_driverdata {
 	struct mutex lock;
 	const struct ltc2497_chip_info	*chip_info;
 	u8 addr_prev;
+	bool sped_2x;	/* SPD: false = 1x (default), true = 2x */
+	/*
+	 * Conversion time (ms) of the conversion currently in flight.  It is
+	 * fixed by the mode active when that conversion was started, which
+	 * differs from the newly selected mode for the first read after a
+	 * sampling_frequency change.
+	 */
+	unsigned int conv_time_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
 };
-- 
2.43.0

