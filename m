Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731832;
	b=ji1cC+/VDM7pMhcLvYv3bnBpSoizy/Bhoxq2zdWPQbv8mh+twAsWrtON3mcQfhE+FloF
	 +Iq2Hiy2WTU7pPyC33CwIvqWy48AQX3d5Dn2Ber7FxuOvBWbWFvlLjb3VrkMsfF2apOQj
	 HFMnmyD/z2KRklMzIOefc9V28neumERuM/kMBbIOh2eP6ooIzAbZvmrrqSdBSmjJoHeJN
	 uKr+bl2lzNHUpzljSmZ/+pEN3hDJNP2UrgnSabzi4BqsH5bE0NTncCCQZNeokfz1zd3A3
	 coXAPJqhVJ4xS3J7+6sFiXpFAX4qyciiQTBFH2ZR4u3gGyW3VBsbzt+fmeoiLwd+Itw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2+BNVfT+YGkM3Yz+ODfgwGeUEMVddxdSBH48iV1scYY=;
	b=qs3Cu0B6mdWAftEiOZgTqrbZUmFS6zshh3//7r5JZ+0ZMPeJBTJBBAZ3VARIJlZSH0Ku
	 JbB4zScRltYG4+dHTPteXCYNa+IdS5EXjkocUpwUm8RlBRLOBsRPzcH5GP6iu/0ggN5tV
	 cl8w/2g2jeByByel6r14whkF0lgG5KBnCqQ0xp4C1pQZzDV1aoRVb5gjxHsSrTC1pnnWz
	 0WSDfW5jPqZlbQZtDU6waVBPDL9CmrzA34Uv+he4fC29JKBvFEHhKKoGxSxxtch/iVn4h
	 nlbG2ns7QuFSj4cX7eiT6RbdNkdTZsNPE9MjejdXLusE9bz/gYUo0WxlCNsiGCSaH4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kyKhgmWO;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1115606A326
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 18:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1115606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kyKhgmWO
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df54150dfso2318794f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731830; x=1794336630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+BNVfT+YGkM3Yz+ODfgwGeUEMVddxdSBH48iV1scYY=;
        b=kyKhgmWOK0i9NSCzSqQhh1tie3DdyVlciR2eGqB4dj4kY/gYUy/7IVOd8gaRQwcpBT
         MqXfbz5SfcJD4T2B94Ndx2XJuF75XdRoSKoEojKsEmNl/PTBVuMiFJgqadnZYnX275nW
         NIgvLvwll9px8W+NvzMiuBBAPbpPuMSiJinVrN8DfFkwgakIu2sdvIGEzzo0js0kg065
         v/80Zop1sMFspL8eawTb0qlm9cGqUeOnqfiXgKUL1q0ZFoUf19ytWTuWV9eDBtEdeL58
         fQHEEzSm91xKgFIA6TY+tXcGRmEuRMigDnhItAQ8M2m/pnV7MQjBGZeMzCxYgj2SvaQH
         u80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731830; x=1794336630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+BNVfT+YGkM3Yz+ODfgwGeUEMVddxdSBH48iV1scYY=;
        b=gRN6e4B/Ph901L71iF+pLfsWQJf9m9YEJ7qWBTVXe+iPtbPvLcrqJqyeDnzNUi/Xct
         SRlZzgAEbt341OdfqMAhqg6g0HSpa2gTWw/7JrunexNR8vVp3EgiW4Olb/EXD+YPKMKx
         jD9VUcqtl8k2ItcMc+Sa1/csjt1GUR3Y7+Geilk87mFp7EgGAug742XbnTTJYzO3Kzan
         xmH0hU9C59ZMQ4X9WCbXA+BdcIhBdsjRMrusAAHOPHewEUwz5ERx4kyX5Q0plOZh5iIK
         rcxVvZqib9QpUhg+fj7K0x73+xTtEVuNCOeCH0KBBlPEzvgfz7yFoY+ILGwLOVroBk92
         i13g==
X-Forwarded-Encrypted: i=1; AKwUvBw+c2kd8QMvZDyqt1xt2J3tbM4f+aijYYkaPfCbRChsMSoTlvJeZgCNvdeBRKluFPkWfjy3QtECuA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ddXC9JmKtUYjNtn14g6ggpQlRvM4S049VnZh6pCPG2pCwzl9N
	qyO4trtRIXBdLZB3Zem0vQizBYllblaT0XL5qe7AFG3AXvgIdSQrgPY=
X-Gm-Gg: AYBFou0tFLgJqvpOOCbxp3NXmLEdfxvaUCZZa4PnmKh6mTagTxHS5iwjbgR8DrIhaY2
	UZs93jY3tF+P4lWxlfKt9ap1ZxHZBjSYWOD6DAS6wzp7PD0jkpDLkmSlW9Qbx818Kg7E4TOCZA7
	9/WhrbHLFqN3wbrJPnQzAHiLM75ZMtM++hBvDXHWfbGXLBMe/qZXkDa3NAkGMxAl4wR6zMBYX+3
	6gbXsxYeewrTHPG+MwDouPB3imJovoG4hNWLJ1ag1+Tp4sRyy4whgKl5FdBHgcerBE6qopvuBW1
	JHIDLyOfEw8JxNS7JX4di04TCiUlY98UxkpMGl1elUn/mG40jufyjxhrcSGLgsxltQatR3TPTTc
	whu11R7YLeRlFVND4lhkngUL1ctaWoh/1cI12WpMAuNqJ6gFGYzAaTBcpqqAQLy4Dd1UAioy64v
	TjZOqlxNVpOu9JGLaoMGqzKsac2SeQ++JIZ5lhFS4xVpFuzTC0Je/YwCiOiLnkyFmLrxV76A1f3
	ITKXFE6PSx9zGf/0PtWg8MshStWXlTyxWfnimRpRvHDjVP5cmJow20Burc=
X-Received: by 2002:a05:6000:3109:b0:48d:fa9c:7838 with SMTP id ffacd0b85a97d-48e6e2bc07amr34627188f8f.2.1793731829766;
        Tue, 03 Nov 2026 10:50:29 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd507c78sm22132f8f.54.2026.11.03.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:50:27 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v7] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Tue,  3 Nov 2026 18:50:26 +0000
Message-ID: <20261103185026.3139023-1-tristmd@gmail.com>
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
Changes in v7:
- Round package.count to pairs with & ~1 inside min() and simplify
  loop condition from i + 1 < count to i < count, per Andy Shevchenko

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
index 5e901ab25c8e8..fcdfe5f3b9190 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1094,6 +1094,7 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	union acpi_object *rez;
 	struct device *dev = &client->dev;
 	unsigned short bi_dir_mask;
+	unsigned int count;
 	int idx, i;
 	guid_t guid;
 
@@ -1101,11 +1102,14 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	guid_parse(PAC1934_DSM_UUID, &guid);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 0,
+				      PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	count = min(rez->package.count & ~1, PAC1934_MAX_NUM_CHANNELS * 2);
+	for (i = 0; i < count; i += 2) {
 		idx = i / 2;
 		info->labels[idx] =
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
@@ -1122,7 +1126,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	ACPI_FREE(rez);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 1,
+				      PAC1934_ACPI_GET_UOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez) {
 		/*
 		 * initializing with default values
@@ -1133,7 +1139,8 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
-	for (i = 0; i < rez->package.count; i++) {
+	count = min(rez->package.count, PAC1934_MAX_NUM_CHANNELS);
+	for (i = 0; i < count; i++) {
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1141,9 +1148,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
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
@@ -1153,9 +1166,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
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

