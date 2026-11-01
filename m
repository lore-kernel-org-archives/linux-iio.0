Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554661;
	b=gb61rF2J9Zn0dDvRK5NWFYDH9QcPqUlyksvvIcCmtpzXZB2tkTqGazu8ddyV7JtN7Ot2
	 +10NyQI0m9C4A51maS1bshYv3Zq6xhBvRhRL8NmJW/L6Wh9FkAov6aluwc89hIkmPWm3B
	 nryGC4xP8EIoDO8AzJNHAcmNS7wIJc+DIJ9nOUC7JE5ApD+yhdjXeGVYGy10CuD0L86yi
	 JXhI5K2CnKaL8QfAowp6WgmViGg71TQjfN6VCC8YcPPjH/rPWLCiPLZRXkPawVqOzmTg4
	 bnDq4huUp1Pmtm6a4MvwWyR/rTtuocdbnhEYmzzRKRJX6u6/Juf8mnVId3Cq1SvAqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eB0kdOTnG3P2Sh4qiSQpalvzR45IED+OZpLicKstFZM=;
	b=UD7+L/Bn7duKjZ0OwjcCASd9INqcHlAPilrTWqnv0TXn3a2tlgp4kaXiYOXD9FA0gB3H
	 nl2qZ725H64XHMlW+qf/ExZ/IOVrOTNM4qnNIZwPku7/lnPvrycO5Bp1lXLNBmxPb0Nq8
	 1T2+hj1+M5jIStSzwqR0WcvL916CscRbSGTC3j9ItWA6HXucOEp4u331KCQqvK+8LyniL
	 WBqTZIg8Z0fm8IGPkVxxw7phMggRiwXJOOCnL5M/FzBcLb2lisIGBD+MGv7bt2mW18mRn
	 J6og2Ng3asae8BPwvb++k4GUME8fH9WNWtLlK7i3EciFLW89BvJAe5tjrhcny53ywTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8AWwCgr;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EC606A325
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 17:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1EC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8AWwCgr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a208d93758so24221565e9.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554658; x=1794159458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eB0kdOTnG3P2Sh4qiSQpalvzR45IED+OZpLicKstFZM=;
        b=M8AWwCgr42vPOCVjMajuHHLyVq6bxBzvSzjDYAVT4eASD+G8asISDUPzaxxbXSJmTD
         cbqrCoEWTO4GmPW2VVzki0SRWOyljwWsoKQ3392tdZS3bSq/qLXHiD8Kvbe7ZNZhGsqZ
         d2Ww/fSeVpi9mG0NUnkE8Vo/fCz5exqg+uK+EvCkSZ2cA9p2UqgHXptBu3GDUnM5xwVO
         O+5NIRGOG1FAeUqqqSRtChjKVgYsXtG4GBDuTRo8RVevm6KxbeC1R2Xu/AF0ASMZ6Ih6
         vuJd3cOtdUHUdrVUCTmVBk8qXLsqYv++v4VupqMrdwXlZm6tvVP636lv6O/m7fxPqKf2
         E1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554658; x=1794159458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eB0kdOTnG3P2Sh4qiSQpalvzR45IED+OZpLicKstFZM=;
        b=aml3y73UNdokeJmYARZZodiR8m3RpYJA0w8p3UKODYiFUOfM1RknuxXD2BKQF2EPHf
         C/uz6I6Uc2qIM2y2WCOnjArv/n+787yWxhrZxEqlBoAxyZSvEETSlBL+GzzZZZXighuF
         kJB0cTmE5p4fJRvtVdbJURsENQe1BJFKEccRmpMTi/GYUTDYSBc7r39YJivlm1i1RNEq
         LIvwqAX+zCHlvmpMjP90gmjpDZirPXHXMBddX4Sm8EQmR833bEzZBWOuU195VLjDQQK1
         /Ym4SYOOumRSEtXQPmhUD5O1QLskXXpEUkHr425BzHo/S4l50nUGCbCfxIfabMVZCFI1
         dwLA==
X-Forwarded-Encrypted: i=1; AKwUvBzBbsXB6mIhcfuOuEuMLX7Yoxo7sievdouMUvOrfBehfAPuxFs50yg3h1QiQiUopgxBfkflnBtl3V0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTdx2BKcqIe73kw1Zc2Vp0DxaWuXypIrJ+Rkbs02Q8QC0lbmgx
	LUYp+gHKEWrLxciInPOiPX3C31N5jVJHxN3QX0SFP96aZF1Hl6mPkjPRGycJ
X-Gm-Gg: AYBFou1FHJnlzy1IN9BDe34oVSQ9y7+LZzERNyHfHB4E308o1i1aE6Vin5I4aDSe5hz
	/GjegLfkpe3o/KlqB2p4Wn9NJP78fwVAXqZ068FYo8N5LWVbGk1hyYl/hokJ2AaiV6CaE8awm3T
	xepRewFCtWaxkTXRg5NPOj25E/XenMRCD5ypyPd4PEyLR55FoVqcAkSwgFARM+dfdXrG23JbnxT
	G8HdvDNU0EeG8hBjqB21rVyFDsOGBph4VgGhuLwkHhy50uye53zHH26r98K8pOEdILXxQRTN0O9
	dA4NvlOizQtaEETAzpiIS1NPkmfHOSdKWWKRJrK8sk8PBsNXTLrMbbMuNT53Za7PTNOnL+hC9V2
	TqRLu3tX0WcxHS++McYHGDzgaJyaL4v/lQDzam7dIZy4KiDIshfbjT/PtV3qF29MjL4cDUAxTUB
	eiWXMiilU+yCkp5u/26VG9UoPDSJ933IgSUjNzwxyhWfVK8FtFb53sRkSRN4NY7PRwFU3i+FYkn
	5+1it9JoCTV8G2LjUQ+KiOChgwIERkFuX3BFmSe06NVX2GGpm+lzpyou+HQj/ne6PbclUEYhA==
X-Received: by 2002:a05:600c:3547:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ac1889d442mr183348275e9.22.1793554658148;
        Sun, 01 Nov 2026 09:37:38 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3f9sm16722870f8f.4.2026.11.01.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:37:37 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v6] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Sun,  1 Nov 2026 17:37:36 +0000
Message-ID: <20261101173736.1792283-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
times to read channel configuration but does not validate the returned
object type or array bounds:

  1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
     firmware returns a different type, accessing rez->package.count
     and rez->package.elements on a non-package object produces
     unpredictable values.

  2. The loop bounds use rez->package.count directly without capping
     to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
     than expected causes writes past the fixed-size labels[],
     shunts[], and active_channels[] arrays.

  3. The bipolar and sample rate DSM calls access elements[0] without
     verifying package.count >= 1.

Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
return type at evaluation time.  Cap loop iterations to
PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
accessing elements[0].

Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v6:
- Replace min_t() with min(), per Andy Shevchenko

Changes in v5:
- Keep existing declaration order, only add new 'count' variable, per
  Andy Shevchenko
- Replace (count & ~1u) with min() cap and i + 1 < count loop bound
  to avoid unsigned literal question, per Andy Shevchenko

Changes in v4:
- Reorder variable declarations to reverse xmas tree, per Andy Shevchenko
- Drop casts from min() parameters, per Andy Shevchenko

Changes in v3:
- Use acpi_evaluate_dsm_typed() instead of manual type checks, per
  Andy Shevchenko
- Use (count & ~1u) for the name+mohm loop bound to ensure pairs
  are complete, per Andy Shevchenko
- Drop Fixes: and Cc: stable tags since this is hardening rather
  than a fix for a specific regression, per Jonathan Cameron
 drivers/iio/adc/pac1934.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c44059..30c2225a59ee92 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1091,6 +1091,7 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	union acpi_object *rez;
 	struct device *dev = &client->dev;
 	unsigned short bi_dir_mask;
+	unsigned int count;
 	int idx, i;
 	guid_t guid;
 
@@ -1098,11 +1099,14 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	guid_parse(PAC1934_DSM_UUID, &guid);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 0,
+				      PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	count = min(rez->package.count, PAC1934_MAX_NUM_CHANNELS * 2);
+	for (i = 0; i + 1 < count; i += 2) {
 		idx = i / 2;
 		info->labels[idx] =
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
@@ -1119,7 +1123,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	ACPI_FREE(rez);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 1,
+				      PAC1934_ACPI_GET_UOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez) {
 		/*
 		 * initializing with default values
@@ -1130,7 +1136,8 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
-	for (i = 0; i < rez->package.count; i++) {
+	count = min(rez->package.count, PAC1934_MAX_NUM_CHANNELS);
+	for (i = 0; i < count; i++) {
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1138,9 +1145,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	ACPI_FREE(rez);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 1,
+				      PAC1934_ACPI_GET_BIPOLAR_SETTINGS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
+	if (rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	bi_dir_mask = rez->package.elements[0].integer.value;
 	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
@@ -1150,9 +1163,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	ACPI_FREE(rez);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 1,
+				      PAC1934_ACPI_GET_SAMP,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
+	if (rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	info->sample_rate_value = rez->package.elements[0].integer.value;
 
-- 
2.47.3

