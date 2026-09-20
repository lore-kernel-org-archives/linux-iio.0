Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537643DEBE
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920278; cv=none; b=AU53zN+J2McYy3HVqsN2GfosZsLSu4N3Z1fKSp2jPuUFixA4iTUeVzWTFcXGhp42fmNEgGDGwf6ycOnfUlWQYP37kdXSObn12umxaD7/rmILSv4p5cr9KTZwGkcWbJTmBfoDAHeH70cfrd2UeqM3y4iDQw73xyXouVhFxM5+7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920278; c=relaxed/simple;
	bh=4Q0MaRhk7dORf7/0yfsW2Fab3UNfOB07rplrxV62BhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTl6fcd9pJkXTbOu08ESWaZI+hYpBeArRMKopxWfkFFoZakMjLumeX3y43t9jGacJACZulNg24lXhyfsQEKxTRhP1npEmrVcCXJhMozQx0HkLozKJm0+5C4lEwMQ8zwoHrBW31PcIrr5jdPjo4XoP2+xWSQCY0jqY+DHt2O4TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx5XRGuF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx5XRGuF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so1231817f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789920271; x=1790525071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ig3jH0x1Y9g8A0aQSq295NLuP2JJYwzb3U2m9Tl0kOU=;
        b=Jx5XRGuFd/ivRgeYutrw6WDRrIZMPA8QstD+GaMWcezW80pj0pSXjPxryDbLtRQDYI
         9hJttpz7/nxzgY6xIHLc5+qZlAjhp8Hr1xO1CJ/1jA+GuL+HihJlBS2Yxb8IXuooQO/l
         UfVUeOlJrYNOwuvRt2O3xs4jx4R0YcRIomL19S8lNZ7DdX1ISPAuhRE0XuYY6Qsm27zl
         g1At+Nw4ttOaVnKuwt0q78ovIRXfTaDdgmpY+jo0SUcHsDoB9gE6u6qcqVvc9Rjq3B3Q
         9liWHMQsts3Cy9EejC0MICHc3Wtsh9iZQm5zUWLTmGDyRtXNA0AIfDWlpngnlEEHFy88
         gTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789920271; x=1790525071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ig3jH0x1Y9g8A0aQSq295NLuP2JJYwzb3U2m9Tl0kOU=;
        b=RKsA9OhSA0UNXG4RJ2TCIqid+7nTjz60WCUJIy9XP7T4RgTRKbrpJIAFniEM6drTyg
         wEmmPskdd8/QhEZmv/kkpW8wp/PVPA8zQ+FxjtqljZvGIT9y3EsnnkyyASaW7+SABNsy
         yr50xDZb1KTUQIH/6NzmF7DqknkCa3rw4rXwFm5D+uYW4ALGmGfLWiywlIWY7Ko0OkuW
         vv58TZyYaexzt0rLPvlDYC1H3chtGX5s6Fl5DKpbmt3Z5P8t6aHTXnx3Tzd4P2iM8JaH
         PBJpREtxdyr/kKJinxMNYCDG5v2C6jvdrOYKEt3nBeaC+0AZbC5mJ+T3NL94Wwo1z2q9
         WmbQ==
X-Gm-Message-State: AFuF++mssLwqO6AcM+9545WkJa4VHJspeZsSd4e3UbjUGwx5ne0WT5U/
	S00jJEP+J3NQ0W61cIkxDcntWxAN/0N/tWKI3PuTtwmEdL7s1TGMede5WWJzSwMB
X-Gm-Gg: AYBFou21dMIWtF7H1QJGqSPsdPgXH/TSlGOy5HpLQB0/7UhYc4bg/Kp1vQM2TTOIfo6
	U/5btPkg1CU0gxVhUAdSXHh1Ez3dJkS+tAMzgjddeHh+bItXPqKNsJqRQ4LUYQdQUUp6rdOiYUk
	qGhQGdmMI5hUIB/POj67SZtzBS9k6idGvsBVorPUGGthVV3BRwhOeDs8GjEN8Zbmry/qg8lAN1n
	v+E3NUmxj3M/42Z3pLAPzw7irt+QLfGn/kj2OYzWjbnSuuos4aKF0iJknu/REP/7z0XAb56AQ4J
	0gpXC754jzL9Uhk8Q99m50cpyOAXkgKtEpRhqax9miClgiuDpPf6QMybzeSyQjN74FPe2H6M6Cg
	IVO7skXSRn6k4tegicTBNRyYG0Q03OEtKmszSJa6DVHqVXPIybz4vmLuhbuCeY+wAYoVoH8vSzI
	SvZp1WeECEDredtDuEOKdFzqtoH5vfl29FPooUytVhu1aUbXVMUUmQMmDWoJuA8HH9Aeokek1W+
	lhGHiAGiMGftPS4cD9jK4LFSDvzFjpVvYLxSp8A5eFy2d1OaYEsU7lujLWhvV24aD8NjGsyRmKe
	R7iU2Js=
X-Received: by 2002:a05:6000:4028:b0:487:40a:5ba8 with SMTP id ffacd0b85a97d-4871e25e2demr16925137f8f.15.1789920271055;
        Sun, 20 Sep 2026 09:04:31 -0700 (PDT)
Received: from SegFaultinator.localdomain ([37.142.157.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459d409sm15065717f8f.33.2026.09.20.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:04:30 -0700 (PDT)
From: Yuval Saar <thefireking@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc,
	Yuval Saar <thefireking@gmail.com>
Subject: [PATCH v2] iio: adc: mcp3422: use read_avail() for available attributes
Date: Sun, 20 Sep 2026 19:00:29 +0300
Message-ID: <20260920160247.1224672-1-thefireking@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919195507.94130-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Custom sysfs show functions only expose the sampling frequency and
scale lists to userspace. Use read_avail() and the channel _available
masks so the IIO core creates sampling_frequency_available and
in_voltage_scale_available. Sysfs names and formatted output are
unchanged, and in-kernel IIO consumers can query the lists directly.

Replace magic numbers(chip ids and sample-rate values) with named constants.

Compile tested. checkpatch --strict clean. Sysfs names and available-list
text checked against IIO core formatters. No hardware.

Assisted-by: LLM
Signed-off-by: Yuval Saar <thefireking@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 168 ++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 36ba00edf..239438dc7 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -19,11 +19,9 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/sysfs.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
 #define MCP3422_SRATE_MASK	GENMASK(3, 2)
@@ -39,6 +37,25 @@
 #define MCP3422_PGA_8	3
 #define MCP3422_CONT_SAMPLING	BIT(4)
 
+/* Sample rates in SPS. MCP3422_SRATE_* above are the config-bit encodings. */
+#define MCP3422_SPS_240	240
+#define MCP3422_SPS_60	60
+#define MCP3422_SPS_15	15
+#define MCP3422_SPS_3	3
+
+/*
+ * i2c_device_id.driver_data / adc->id. MCP3421-4 are 18-bit (3 SPS
+ * available); MCP3425-8 are 16-bit and omit that rate.
+ */
+#define MCP3421_ID		1
+#define MCP3422_ID		2
+#define MCP3423_ID		3
+#define MCP3424_ID		4
+#define MCP3425_ID		5
+#define MCP3426_ID		6
+#define MCP3427_ID		7
+#define MCP3428_ID		8
+
 #define MCP3422_CHAN(_index) \
 	{ \
 		.type = IIO_VOLTAGE, \
@@ -47,27 +64,33 @@
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
 				| BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_type_available = \
+				BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all_available = \
+				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	}
 
-static const int mcp3422_scales[4][4] = {
-	{ 1000000, 500000, 250000, 125000 },
-	{ 250000,  125000, 62500,  31250  },
-	{ 62500,   31250,  15625,  7812   },
-	{ 15625,   7812,   3906,   1953   } };
+/* IIO_VAL_INT_PLUS_NANO lists: { integer, nano } per PGA gain. */
+static const int mcp3422_scale_avail[][8] = {
+	[MCP3422_SRATE_240] = { 0, 1000000, 0, 500000, 0, 250000, 0, 125000 },
+	[MCP3422_SRATE_60]  = { 0, 250000,  0, 125000, 0, 62500,  0, 31250  },
+	[MCP3422_SRATE_15]  = { 0, 62500,   0, 31250,  0, 15625,  0, 7812   },
+	[MCP3422_SRATE_3]   = { 0, 15625,   0, 7812,   0, 3906,   0, 1953   },
+};
 
 /* Constant msleep times for data acquisitions */
-static const int mcp3422_read_times[4] = {
-	[MCP3422_SRATE_240] = 1000 / 240,
-	[MCP3422_SRATE_60] = 1000 / 60,
-	[MCP3422_SRATE_15] = 1000 / 15,
-	[MCP3422_SRATE_3] = 1000 / 3 };
-
-/* sample rates to integer conversion table */
-static const int mcp3422_sample_rates[4] = {
-	[MCP3422_SRATE_240] = 240,
-	[MCP3422_SRATE_60] = 60,
-	[MCP3422_SRATE_15] = 15,
-	[MCP3422_SRATE_3] = 3 };
+static const int mcp3422_read_times[] = {
+	[MCP3422_SRATE_240] = 1000 / MCP3422_SPS_240,
+	[MCP3422_SRATE_60] = 1000 / MCP3422_SPS_60,
+	[MCP3422_SRATE_15] = 1000 / MCP3422_SPS_15,
+	[MCP3422_SRATE_3] = 1000 / MCP3422_SPS_3 };
+
+/* sample rates to integer conversion table; 3 SPS is last and 18-bit only */
+static const int mcp3422_sample_rates[] = {
+	[MCP3422_SRATE_240] = MCP3422_SPS_240,
+	[MCP3422_SRATE_60] = MCP3422_SPS_60,
+	[MCP3422_SRATE_15] = MCP3422_SPS_15,
+	[MCP3422_SRATE_3] = MCP3422_SPS_3 };
 
 /* sample rates to sign extension table */
 static const int mcp3422_sign_extend[4] = {
@@ -169,7 +192,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 	case IIO_CHAN_INFO_SCALE:
 
 		*val1 = 0;
-		*val2 = mcp3422_scales[sample_rate][pga];
+		*val2 = mcp3422_scale_avail[sample_rate][2 * pga + 1];
 		return IIO_VAL_INT_PLUS_NANO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -199,8 +222,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 		if (val1 != 0)
 			return -EINVAL;
 
-		for (i = 0; i < ARRAY_SIZE(mcp3422_scales[0]); i++) {
-			if (val2 == mcp3422_scales[sample_rate][i]) {
+		for (i = 0; i < ARRAY_SIZE(mcp3422_scale_avail[0]) / 2; i++) {
+			if (val2 == mcp3422_scale_avail[sample_rate][2 * i + 1]) {
 				adc->pga[req_channel] = i;
 
 				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
@@ -213,17 +236,17 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (val1) {
-		case 240:
+		case MCP3422_SPS_240:
 			temp = MCP3422_SRATE_240;
 			break;
-		case 60:
+		case MCP3422_SPS_60:
 			temp = MCP3422_SRATE_60;
 			break;
-		case 15:
+		case MCP3422_SPS_15:
 			temp = MCP3422_SRATE_15;
 			break;
-		case 3:
-			if (adc->id > 4)
+		case MCP3422_SPS_3:
+			if (adc->id > MCP3424_ID)
 				return -EINVAL;
 			temp = MCP3422_SRATE_3;
 			break;
@@ -256,45 +279,34 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-static ssize_t mcp3422_show_samp_freqs(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
-
-	if (adc->id > 4)
-		return sprintf(buf, "240 60 15\n");
-
-	return sprintf(buf, "240 60 15 3\n");
-}
-
-static ssize_t mcp3422_show_scales(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static int mcp3422_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
 {
-	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
+	struct mcp3422 *adc = iio_priv(indio_dev);
 	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 
-	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
-		mcp3422_scales[sample_rate][0],
-		mcp3422_scales[sample_rate][1],
-		mcp3422_scales[sample_rate][2],
-		mcp3422_scales[sample_rate][3]);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = mcp3422_scale_avail[sample_rate];
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(mcp3422_scale_avail[0]);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = mcp3422_sample_rates;
+		*type = IIO_VAL_INT;
+		if (adc->id <= MCP3424_ID)
+			*length = ARRAY_SIZE(mcp3422_sample_rates);
+		else
+			/* 16-bit parts: drop trailing 3 SPS entry */
+			*length = ARRAY_SIZE(mcp3422_sample_rates) - 1;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
 }
 
-static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
-		mcp3422_show_samp_freqs, NULL, 0);
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		mcp3422_show_scales, NULL, 0);
-
-static struct attribute *mcp3422_attributes[] = {
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group mcp3422_attribute_group = {
-	.attrs = mcp3422_attributes,
-};
-
 static const struct iio_chan_spec mcp3421_channels[] = {
 	MCP3422_CHAN(0),
 };
@@ -313,9 +325,9 @@ static const struct iio_chan_spec mcp3424_channels[] = {
 
 static const struct iio_info mcp3422_info = {
 	.read_raw = mcp3422_read_raw,
+	.read_avail = mcp3422_read_avail,
 	.write_raw = mcp3422_write_raw,
 	.write_raw_get_fmt = mcp3422_write_raw_get_fmt,
-	.attrs = &mcp3422_attribute_group,
 };
 
 static int mcp3422_probe(struct i2c_client *client)
@@ -344,20 +356,20 @@ static int mcp3422_probe(struct i2c_client *client)
 	indio_dev->info = &mcp3422_info;
 
 	switch (adc->id) {
-	case 1:
-	case 5:
+	case MCP3421_ID:
+	case MCP3425_ID:
 		indio_dev->channels = mcp3421_channels;
 		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
 		break;
-	case 2:
-	case 3:
-	case 6:
-	case 7:
+	case MCP3422_ID:
+	case MCP3423_ID:
+	case MCP3426_ID:
+	case MCP3427_ID:
 		indio_dev->channels = mcp3422_channels;
 		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
 		break;
-	case 4:
-	case 8:
+	case MCP3424_ID:
+	case MCP3428_ID:
 		indio_dev->channels = mcp3424_channels;
 		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
 		break;
@@ -382,14 +394,14 @@ static int mcp3422_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp3422_id[] = {
-	{ .name = "mcp3421", .driver_data = 1 },
-	{ .name = "mcp3422", .driver_data = 2 },
-	{ .name = "mcp3423", .driver_data = 3 },
-	{ .name = "mcp3424", .driver_data = 4 },
-	{ .name = "mcp3425", .driver_data = 5 },
-	{ .name = "mcp3426", .driver_data = 6 },
-	{ .name = "mcp3427", .driver_data = 7 },
-	{ .name = "mcp3428", .driver_data = 8 },
+	{ .name = "mcp3421", .driver_data = MCP3421_ID },
+	{ .name = "mcp3422", .driver_data = MCP3422_ID },
+	{ .name = "mcp3423", .driver_data = MCP3423_ID },
+	{ .name = "mcp3424", .driver_data = MCP3424_ID },
+	{ .name = "mcp3425", .driver_data = MCP3425_ID },
+	{ .name = "mcp3426", .driver_data = MCP3426_ID },
+	{ .name = "mcp3427", .driver_data = MCP3427_ID },
+	{ .name = "mcp3428", .driver_data = MCP3428_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp3422_id);

base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00
-- 
2.43.0

---
v2:
- Use read_avail() instead of custom sysfs show functions (Jonathan)
- Use a known identity on Signed-off-by (Maxwell, Jonathan)
- Replace magic numbers (chip ids and sample rates) with named constants
v1: https://lore.kernel.org/linux-iio/20260919195507.94130-1-thefireking@gmail.com/
