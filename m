Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363732;
	b=FxwhlUxtxttTXAnhOWgwVp2pf0mfaIwXmEr0F0sboT8IaajZOajkilHDiQPoqS0l450D
	 ApRL1hYwgoRYpI2a3Rh5hvzfv6gPCn33HUGMM9ZS8XSB98+rjcHy39uC6Wdj4pPWnok3Y
	 Um+iSWBIroyzy6bFnY2O4JCb1uuNRESdnmWkGCDVTxaPM0bXH7bijhyV40RG4wqj+IEW3
	 5FxcrV7/DHCaeFPoNN7ZQ2gy7qHhWcPP2eON8BBkymOCTEo1xoHtramgQDoDIdyOts39F
	 zlIk5hT0ilz62/o19e7fDIkNW3B9wnn5OL/9/aBTIrSudD2I4dky3VJIm3OMfmO9RZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M7/R3LmLUP9HCLPp+1CZga6AX7kccFyKSghLPQjiFI0=;
	b=5NjscF586/QaymFYXMQgHO2og7wbvZI15UpdA7yfGVk8RC/YxGOQstqdF1X57Ij5VktK
	 8VmcEn/1X6Hy24eY0kdoV2RuC2+TcAi3PBGgzdRDetEL99bri93gUw48wVOvcwdZZkdoK
	 6S/8NO7Tegj9tWUWVBd3rUYxa/Sa+8nNYdCa5qSxi1NvAlRwPsd/O/uFUG0E+/V7A1Mq/
	 DCrXJaQrBOS53qbFu5koUPtAMg7gkek8TjBNuo//WFIBnA1DPXHBfCzihal/enYCriHMv
	 rRpf1PBITlw19JyO5Sf8NAK2Lo7fge1B8sskmCg6u8Ci3BR1X0YzSpSh5PCM6Pyzkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Wy93/5Vl";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BC606A31C
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 12:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6BC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wy93/5Vl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso472429f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363730; x=1793968530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7/R3LmLUP9HCLPp+1CZga6AX7kccFyKSghLPQjiFI0=;
        b=Wy93/5Vl1e12IqRE65omU8GhbZMP/kBPFIZsru8ISA7tan8uB3EvGSrj+pUH/KjUWY
         JXmnJ35a+hOvAoaoOVc5VDf2+OIWJNw2LhFtGmg67V1bXfSDUy03kmhv6L3KYfh08NVr
         qERWjayJgtiqCHKtl/fIWvweSlyfrp1TThsw/lMlBPPEYYDCrGLj7Rx2Q66PgOUf1a7q
         mPCPFc6K9PWPD69NinrBkk8JoD6L2GR+vvJCJhOAc3xe07Oikq2Q5plFXCHd8OaqVNXh
         HM4bqs4WM+fgqjQMKsI2xhIhF1TWP7DCMMcBELfOA7aR644EH7+ooQUbYGSXWquRB2lr
         xQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363730; x=1793968530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7/R3LmLUP9HCLPp+1CZga6AX7kccFyKSghLPQjiFI0=;
        b=HHkRLStNbkuGvm4uDUVDeCjuWygyw1owpWT1HfJiZQd0dQ2vmKJ9wU/w++GCbWdsM4
         1tH3XotWsI5gogf3i1z7EiGkttNnZ9nGm19x0I62SZ70E8ARFcDk5PAWmGFV9Vz8ApD2
         UfVO62PjMHxWG8OI+1809jFSegsz01te6fLVqbN98HHgXlSwLxgzq3tV18zi7/T+48z5
         mjeOCkTXk7mVOv2XPTALNcUY3lZq5s3YyUE6roa7kgIdQD78IkLpPw0RzOoK98gZLVmW
         CYKexvMfSzp0RIRO3/4ikgG/+o6ayWyMpyUVQlnkZUcIfhqg3aynj5DESizxknt4JC3N
         Sctw==
X-Forwarded-Encrypted: i=1; AKwUvBx+xvZvg40+TpEZvaoITF9M66+4EN8R06Ygw9Yn3WuXWVg2UEpt7U8ztUEt/L8FNBXWWOetaJwLX9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU6K2FOyTmblkklwL/bOibw0vTZ6hoTjVLL+EBGGTrT/Ip/xk2
	Z9X8G+38cfsN88/YhJid5XEAh9o82+S2EXENsylUT7VXu6F9i7mEQGY=
X-Gm-Gg: AYBFou26713DixLuxfZmkuHyfOthds/PagX67sOC0sdUhec7qLM/WcZEGMGFv7r12Up
	GPYbHMaFZ0NWV3ULEt/GEP5Mof4nMRIufQ6or1QNDgMYKz68aYma4WuuG/zLybASSAJSiNrnFo3
	QN2qPgmf7UM7C+wTL9qBjo1yxGWu89GswZoG8uQlhkTsLl9FFcJ9StRAQ2GPmrGI4QIm0fNuZUj
	PEIEBtcm41Lujzgm6zz+I7TIzYr/Kz81Rqo4NGKCfrR9uZ0uaBdUuE50pQyvRAWaXjKCi/eJ8he
	aH3UZDShe+mplIweXiHX2TjPzqVQ6cf3d2gBRr2uTe3Rf9Rb8HSvpHtBzKFjgTdUU44va1v9uLr
	ocB6KqOAk2F/JZ5nsVh5/QB8S/anOhshXEGP2KqKNk/PzkjGB5lAzFqETdwmZvMR/+Sz5cYZGx3
	6gw4QVJzkJim17PL3Uo4h3EAXuYeZWYTihvI3Ww3d3f9RQYD3LDwOhF4kIkayF3AWV9XCh/uX1b
	gFJ0MJ5TTG1/1mJTcpI7h418B6AeikNcnzWOMlSh0c9+8JZVHna3JjEY9yA+nMZQatqf0UGcg==
X-Received: by 2002:a05:600c:83c5:b0:4a1:f377:5c75 with SMTP id 5b1f17b1804b1-4ac19329ea4mr38828955e9.33.1793363729731;
        Fri, 30 Oct 2026 05:35:29 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm3084970f8f.11.2026.10.30.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:35:29 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v5] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Fri, 30 Oct 2026 12:35:28 +0000
Message-ID: <20261030123528.606107-1-tristmd@gmail.com>
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
Changes in v5:
- Keep existing declaration order, only add new 'count' variable, per
  Andy Shevchenko
- Replace (count & ~1u) with min_t() cap and i + 1 < count loop bound
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
 drivers/iio/adc/pac1934.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c4405..cdb730217d46c 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1091,6 +1091,7 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	union acpi_object *rez;
 	struct device *dev = &client->dev;
 	unsigned short bi_dir_mask;
+	unsigned int count;
 	int idx, i;
 	guid_t guid;
 
@@ -1098,11 +1099,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	guid_parse(PAC1934_DSM_UUID, &guid);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 0,
+				      PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez)
 		return -EINVAL;
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	count = min_t(unsigned int, rez->package.count,
+		      PAC1934_MAX_NUM_CHANNELS * 2);
+	for (i = 0; i + 1 < count; i += 2) {
 		idx = i / 2;
 		info->labels[idx] =
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
@@ -1119,7 +1124,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	ACPI_FREE(rez);
 
-	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
+	rez = acpi_evaluate_dsm_typed(handle, &guid, 1,
+				      PAC1934_ACPI_GET_UOHMS_VALS,
+				      NULL, ACPI_TYPE_PACKAGE);
 	if (!rez) {
 		/*
 		 * initializing with default values
@@ -1130,7 +1137,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
-	for (i = 0; i < rez->package.count; i++) {
+	count = min_t(unsigned int, rez->package.count,
+		      PAC1934_MAX_NUM_CHANNELS);
+	for (i = 0; i < count; i++) {
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1138,9 +1147,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
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
@@ -1150,9 +1165,15 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
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

