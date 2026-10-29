Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292966;
	b=AoNikCdVDHCUSu+dB/5MPvnt3JjeWIxWlcOD2MjufFPf7v+PbbVbSY2hjozDAXnYqc58
	 cGnq9ZMt5pnk6Rldg+J515HDs0R2Ye1t2AwkYtOZPU2M4FMmFBQCGCmEjmKbGLpgxLP5F
	 mOpd85Py5bt95CZtgiDAtC4e2W9lZnsoorZX6xmV3UdS/m6Ll689/Nc8kLRtvGpAiE/B0
	 m9T2vJvxkgRdl4tjpz54hFnXw0MoqU2j4d+OQ8U/rX20DhxhhxzXi769jH4ZnI9qf99Vu
	 Cx9HUNAXNuHg28sW2cvFkrEAjcsjp3C7Vh3CkqAFvtfjDcl/MZKSUQxydwLCw23ld2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9yn4GzvRoaBXfVfumrImiA4cqBiQbn6L5zw3E/B/u6E=;
	b=zUgHECQn1VlCY63vlGB/oj2JsZhrIjiWhl1Gl7LDILUQDvuxeLFom+ywqI2zug3p3oYo
	 2oCpx6eygLYmwuifbMRJzixLLf8LxgctkYgIH53qDHw7DCRnYw8YZgojwscK6DABP4+My
	 IqIJ1xh+si0wpg7rVUbsesXcas6knooXBRWMSUuRt0h6ZhKq5xf4rrw/Aqte3EQUQA34i
	 SfkzlO2/8GolGcqdBH/bzDnWOK0OBcF/OlUzWWKChbuKevfdPtLC4nGS/J94qcq1n9bS1
	 lVjudczpUM0cVgqx2nagDxz7mdAgB/G+EHF9qxMym1ol7DaQK9A9QWQfs0bk4/MgDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5xd8QiA;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1C606A321
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 16:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C1C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5xd8QiA
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso20712955e9.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292965; x=1793897765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9yn4GzvRoaBXfVfumrImiA4cqBiQbn6L5zw3E/B/u6E=;
        b=q5xd8QiATHRWOzTvgALEAx4iBXPRhh7cC3KEeOfSH4N5qlYpWj+Y/Lc1PARiI7k15k
         sg9Ej/gHGi1uHOctYZC37xLUkZZvJVNSiyv3BIeoNW1Gqp1BHRSn4yhsKyIRWRYoBBDD
         k+ONuWFbztgcZzkavQg+cS5N9m7MJHSAM+9kgqg0Ah8fcAX6hAyPVhyOzZhwZ9V17nyA
         e1m8dH2WnfIAYIJTRIJpoYy4BkAm6vNTzZMPbJlgFkQr192cv9ExgheGpwI81L922k8D
         BketzgOUqfCb0M546EG/Js6ee9lBNXd4EiqkcudDUDkTyjjEU94I17r+xaa2icNlgvtq
         gN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292965; x=1793897765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yn4GzvRoaBXfVfumrImiA4cqBiQbn6L5zw3E/B/u6E=;
        b=01W7jKBa8PIH8vif6T0iOGlWxr1otxCKnm92Acuy8F35rJXFROPBnhiBwsO5G4ANXc
         CqVrjFGl3huKnaOsnHphl7qYcHn4kuDIgHXiB+C7oyGPJ/zP6JLKEKN7RLqTiR82ryms
         31jQAnFVVfeQP+5t85O6LIs+zKd0Xz51SyziRGZf/MZJwfKCdARPumuZnVc5aaX3S0X5
         IoW48VbRqUvOpZhkH6aOh6NJD7gvRRmNTCRTmkKFULi8qqJ6lHCcwJhSAvuOP1ZiKEjU
         zHCtJCeNXBYHGGeihguLbHSyxHbKL7ka6vD/qLxc0KrNr5Klx2XXDWSTuL5e8D6m6ldC
         jbcw==
X-Forwarded-Encrypted: i=1; AKwUvBxoXFqoVx6BFl56aH03/SmOaawDB1zAPtXfOJ07id0INkun0ftW63r3+zIjV36i0qi6pRVchm6akWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIblaNbxy2LGjBE3EzJnzau9Yr9b+0U8KvtNa8t/14EQkDAq72I
	QTIQfgBqxRYHAm6wipUzYoiqKdL0ZSxlwbFlGj1vzskvKKxs127oaOg=
X-Gm-Gg: AYBFou2lQZLSCRl0tK2uL2lh1Pm4OlK7DPDR0Kq+ahJSg3e+i81aTkDqSS5N+mDyT2v
	68o83B5/jdAegDJ8RIYNBlY6wO7kGiiWeXFPXaeVMAM10y8l5HsvnGVbSlKv4qQDaMG347M0tLR
	oFNT2VCnuoSk7YhQbP1pfa10qA/A+OUD5gRhusR2v+FXwtyLJCFvSaKkMswalli1YKuvtvXa3kO
	74rIaxYcWSHFW3I9vE03mdf3BxHP635yhRkNOc1xSUzETp8/dBD0kBIfkLZO599hUvmJApgn5Rk
	Be+60hOcJ1W8afmOHR1bXxO3t+RIG5usA84mJl9VEayYANdTM80LfwR6Tk9ZDhGecumEQ3xs/OS
	vjcA412hdYLUjhhVgd/FcSBBxZEr4zEQzGgbmD+xy96oAo+usofhNjEjnU/xfqd5kQa7uXzrEdg
	U04qs85ZNL2kn5uYoIfeuU+aus/SLvv4QJnpvzkbA91V2fKjX7DMn1nVsraNckgN7C1ac7fGRb8
	pBrx/8/W9LjgZrVAdiQSB67u7+ZC5xZnxU2UmWXFLHgLQdRtXBzRaiu6YAo5tu6y2v/41zfug==
X-Received: by 2002:a05:600c:3f06:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a966c3ff0emr140304915e9.22.1793292964506;
        Thu, 29 Oct 2026 09:56:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80285b2dsm76194635e9.13.2026.10.29.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:56:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Thu, 29 Oct 2026 16:56:02 +0000
Message-ID: <20261029165602.3265518-1-tristmd@gmail.com>
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

Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
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
 drivers/iio/adc/pac1934.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c4405..0ff742ccc66b2 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1087,22 +1087,26 @@ static int pac1934_chip_identify(struct pac1934_chip_info *info)
 static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 					     struct pac1934_chip_info *info)
 {
-	acpi_handle handle;
-	union acpi_object *rez;
 	struct device *dev = &client->dev;
 	unsigned short bi_dir_mask;
-	int idx, i;
+	union acpi_object *rez;
+	acpi_handle handle;
+	unsigned int count;
 	guid_t guid;
+	int idx, i;
 
 	handle = ACPI_HANDLE(dev);
 
 	guid_parse(PAC1934_DSM_UUID, &guid);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 0,
+				      PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	count = min(rez->package.count & ~1u, PAC1934_MAX_NUM_CHANNELS * 2);
+	for (i = 0; i < count; i += 2) {
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

