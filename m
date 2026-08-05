Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0140801B;
	Wed,  5 Aug 2026 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923080; cv=none; b=Lp7x0dH8Evjv9H9S5Bg3qmBuRYTlpQ3qmOH77gJlT4I7vXZE+a+5Koxw+Xug3lbcDWufltMCYsH16G4h/jSARi3uomzXiIXckxQD8mMnvKAarDGHS24kKzVZdK+Iu3ipfQIT/fia4zxw5mbYhJbZSqi3yN+SxNwLJg/ouKmkMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923080; c=relaxed/simple;
	bh=yb0xKUapvJnCWOHV60cjW7djSJixitves0GEU58FpVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAwu1YgZReGv0e//NZgLLtTZ8pBoiPCjaFFFzV4XPvteL3hTC4YOucfChA6e7Xp9/1ZUZo+JAIt5KArd6CtVI1Hg+1xMdkZPG40xqrWE/vfZGtJRnu/ujTpWgS1PtnF5lkFPn5UiB7XaDyCgBSnzgkQE7gdEXdzWfUgdq8o1yuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1k1BbTmI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1k1BbTmI"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758g8I73960948;
	Wed, 5 Aug 2026 05:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S8ooO
	pgrSSCKeYXLCuwSoqS4TDisObHa4PZb9dJMOQc=; b=1k1BbTmIfs2hEK06EgVRb
	Jb327xzU9YT7W9l5QRVzSnrVpoVlWu16IeKIxg+7S1X8gp6BB3iR9a0Z9bzTsNZR
	SsBndAM0A/phZGcumHGouQAl4pxnvIKCvbF/dqU1ZOCbxOxfxl5uy1fFhtWRzKcZ
	GyJbdGY0u0fprwDi9/80wFRK5bdPT6olNb+JcyiVTJQsKwNwPUS44SNjcXJBBpRo
	srFqlpPfNsgcdZNtOOOA+5eKIuGh3bd/IaOjiIVsGMDaLpMvQBZkesEZNQrUgqwx
	oc4TtoQNVTb9CUSaIAHcyxJGAgamhPsdyFWht+8M0LUHWKmMP2t/D3Wmkn59byOY
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fue73dbha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:44:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6759iWa4005003
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 05:44:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 05:44:32 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.201])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6759iBgK028984;
	Wed, 5 Aug 2026 05:44:27 -0400
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
Subject: [PATCH 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Date: Wed, 5 Aug 2026 12:41:29 +0300
Message-ID: <20260805094135.11762-4-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805094135.11762-1-andrei.stancovici@analog.com>
References: <20260805094135.11762-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8iROjLZLyrFUIIoCGUsbgwQnPOT76i3H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX4zspaf1dzfMJ
 LtcwusZS565ZVPiFQczAoIc9fgbEcyBzd6dY4nC+9T/SNKP/bf+UxATxxmhSDR54b80otuq06vo
 tR3dnyQW7AJ+gwWuFrxGGbBpUGRB5nV2PyDKi0gAdHUAmH0zffbl
X-Authority-Analysis: v=2.4 cv=aY9RWxot c=1 sm=1 tr=0 ts=6a730601 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=e1H5YwhzkXPnqTTOc78A:9
X-Proofpoint-ORIG-GUID: 8iROjLZLyrFUIIoCGUsbgwQnPOT76i3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfXy6HVj8tK9NAc
 CLRUReqoFQInbUFYyFw/bbyDMZBIzJmhmUI1fs+Hfab7kR11PxnrNQ6cgEoyo7iqAybLA/nzV6f
 HD7ZdP5jFzB/q5rzZjjprIduEM1GUkfDe2UyDVP+LVepBsNmVWab/stKqMWACWdtewgxWMVEjo9
 IMOUg/9DXEoyDBZ7qaJnLheuAhDZ3CEqTarAAAr7MIcP/5VFUqZ8nwOnaw8gsUSMRKn40rIZPBv
 C9QvAeILKLYqFUonvNUXA3OGI8LOO3Q+Xs5eL6DPPIlZPx/YiZdWVIjomc8ZKMVm0hCv4IkTx2y
 1bDmPiaZc4qvWiHq0E/rzhPkkO80lR3xwM16f2o+4VWQcLzcuKuBykZdJ0/WxwiAxAOotRT2Szx
 CacwZ8WVEfPS3kgO08zeCJ4g/Wt/BoUavjhIW2KyjFMLd1SQ785QcDo7aIdud5GBuiGeBKQEN3H
 2ju3jY8yq1xOL9FeG5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

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
 drivers/iio/adc/ltc2497-core.c | 169 +++++++++++++++++++++++++++++++--
 drivers/iio/adc/ltc2497.c      |  24 +++--
 drivers/iio/adc/ltc2497.h      |  24 ++++-
 3 files changed, 200 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 4ca7271ca007..68b53a983e05 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -7,12 +7,14 @@
  */
 
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include "ltc2497.h"
 
@@ -20,24 +22,57 @@
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
@@ -49,9 +84,18 @@ static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 
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
 
@@ -61,7 +105,9 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 			return ret;
 		ddata->addr_prev = address;
 
-		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS))
+		/* The reprogram above starts a conversion in the new mode. */
+		ddata->conv_time_prev = conv_time_ms;
+		if (msleep_interruptible(conv_time_ms))
 			return -ERESTARTSYS;
 	}
 
@@ -70,6 +116,8 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 		return ret;
 
 	ddata->time_prev = ktime_get();
+	/* The read above auto-starts the next conversion in the current mode. */
+	ddata->conv_time_prev = conv_time_ms;
 
 	return ret;
 }
@@ -134,6 +182,81 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
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
+	bool sped_2x;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/* Match the (val, val2) pair against the advertised rates. */
+		for (i = 0; i < ARRAY_SIZE(ltc2497core_samp_freq_avail); i += 2) {
+			if (val == ltc2497core_samp_freq_avail[i] &&
+			    val2 == ltc2497core_samp_freq_avail[i + 1])
+				break;
+		}
+		if (i >= ARRAY_SIZE(ltc2497core_samp_freq_avail))
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
@@ -206,6 +329,8 @@ static const struct iio_chan_spec ltc2497core_channel[] = {
 
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
+	.read_avail = ltc2497core_read_avail,
+	.write_raw = ltc2497core_write_raw,
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
@@ -231,6 +356,34 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	if (!ddata->chip_info->has_temp)
 		indio_dev->num_channels--;
 
+	/*
+	 * Parts with a speed mode expose in_voltage_sampling_frequency /
+	 * _available on the voltage channels only.  SPD is ignored during a
+	 * temperature measurement, so the temperature channel deliberately
+	 * carries no SAMP_FREQ attribute.  Patch a private copy of the shared
+	 * channel array so parts without a speed mode stay untouched.
+	 */
+	if (ddata->chip_info->has_speed_mode) {
+		struct iio_chan_spec *channels;
+		unsigned int i;
+
+		channels = devm_kmemdup(dev, ltc2497core_channel,
+					sizeof(ltc2497core_channel), GFP_KERNEL);
+		if (!channels)
+			return -ENOMEM;
+
+		for (i = 0; i < indio_dev->num_channels; i++) {
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
@@ -255,6 +408,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
 	ddata->time_prev = ktime_get();
+	/* Power-on default mode is 1x; a conversion is already in flight. */
+	ddata->conv_time_prev = LTC2497_CONV_TIME_1X_MS;
 
 	mutex_init(&ddata->lock);
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 2ff53b292f74..3fc31d418cf4 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -85,16 +85,19 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 	}
 
 	/*
-	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
-	 * configuration via a second command byte and only re-evaluate it when
-	 * that byte has EN2 set; a single byte, or a second byte with EN2 = 0,
-	 * means "keep previous". A one-byte channel select therefore cannot pull
-	 * the device back out of temperature mode, so a voltage read after a
-	 * temperature read would keep returning the PTAT result. Always drive the
-	 * second byte with EN2 set on these parts: IM | temperature-rejection for
-	 * a temperature read, EN2 alone (IM = 0) to (re)select an external input.
+	 * Parts with a second config byte (LTC2499: internal PTAT sensor and/or
+	 * the 2x speed mode) latch their converter configuration from that byte
+	 * and only re-evaluate it when EN2 is set; a single byte, or a second
+	 * byte with EN2 = 0, means "keep previous". A one-byte channel select
+	 * therefore cannot pull the device back out of temperature mode, so a
+	 * voltage read after a temperature read would keep returning the PTAT
+	 * result. Always drive the second byte with EN2 set on these parts:
+	 *   - temperature read: IM = 1 (SPD is ignored by the part in
+	 *     temperature mode and is left 0 here);
+	 *   - voltage read: IM = 0 (external input), plus SPD when 2x is
+	 *     selected.
 	 */
-	if (ddata->chip_info->has_temp) {
+	if (ddata->chip_info->has_temp || ddata->chip_info->has_speed_mode) {
 		u8 cmd[2];
 
 		if (address == LTC2497_TEMP_ADDR) {
@@ -103,6 +106,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		} else {
 			cmd[0] = LTC2497_ENABLE | address;
 			cmd[1] = LTC2499_EN2;
+			if (ddata->sped_2x)
+				cmd[1] |= LTC2499_SPD;
 		}
 
 		ret = i2c_master_send(st->client, cmd, sizeof(cmd));
@@ -168,6 +173,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 		.resolution = 24,
 		.name = "ltc2499",
 		.has_temp = true,
+		.has_speed_mode = true,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 1da2cfec3b6a..5707ee3ff8a5 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -2,7 +2,19 @@
 
 #define LTC2497_ENABLE			0xA0
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+
+/*
+ * Worst-case conversion times (datasheet t_CONV max).  The driver only ever
+ * programs simultaneous 50/60Hz rejection (FA/FB selection is not implemented),
+ * so only those two rates are listed.  The 1x value also covers the
+ * LTC2496/LTC2497, which have no speed mode.
+ *
+ * The 2x mode (LTC2499_SPD, LTC2499 only) disables the offset auto-calibration
+ * to roughly double the output rate; adding the 2x wait time is what makes the
+ * SPD control actually faster.
+ */
+#define LTC2497_CONV_TIME_1X_MS		150ULL	/* t_CONV_1 simult. max 149.9 */
+#define LTC2499_CONV_TIME_2X_MS		76ULL	/* t_CONV_2 simult. max  75.1 */
 
 /*
  * Sentinel passed as `address` to result_and_measure() to request a
@@ -14,11 +26,13 @@
 /* Second config-byte bits (LTC2499 / LTC2493 only) */
 #define LTC2499_EN2			BIT(7)	/* enable second config byte */
 #define LTC2499_IM			BIT(6)	/* 1 = measure internal temp sensor */
+#define LTC2499_SPD			BIT(3)	/* 1 = 2x output rate (offset cal off) */
 
 struct ltc2497_chip_info {
 	u32 resolution;
 	const char *name;
 	bool has_temp;
+	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
 };
 
 struct ltc2497core_driverdata {
@@ -28,6 +42,14 @@ struct ltc2497core_driverdata {
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

