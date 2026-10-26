Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056154;
	b=s06wI0RXyurG4US860WOtEp3nK0ogJ5jmBop6chhjidZcADmXR/8hDvFaGTYYa99oe9T
	 EzpZcyXgHZ+mHefFu0gjMK8AailxamELmDYCO1tDPJtzJhQslrupEXUB9CFIx5bBfVe9Q
	 2xkRxYrR48DuHP3oRKR4VYRJEtOREa2oHtTP0KRQXor37HXdAbY6/aqVM4OUl5Y/UqFNl
	 DLwW7fGT7M4bnffJ3Mnba+xkvH32H2EIgHe+Ps9lVyHsbdovrSkn5pLiDDFpTEUhc1ewJ
	 mzrecamEZBS0gf+qP0Hsv+agMb9GrPIUDzff2wtL+j/oWQsx0/e7hnaJ+jmfd3MnkdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
	b=KBqEwqGP9TB6RpeQ41X+t4P12WGnElkdvjLdd9o7r1kWYEc5Y2TeGUnWa6az/7uWZf0O
	 g//dTj+FXi+/IVP9HFAcC36ON0PYi4RDk/fzqAbM7Zm/e7fzJcsGTaDfFQcPjAnHOkHQK
	 jRg00ErCsjS3A3cL89OnzLinKRlfGgRaCKRyqjkS1vrB02Kte+xdM0ngEwl+T/C1jQ39T
	 V8hLAhHpmmDnXpZ0iE0uZWBiWLmaEJMepeZy0TKCGV08kT5qtIuJyxYUbUz2IZ3ilmCVd
	 KTfSEer+nXwbkiOKGPF/mHlW+anfiJA/CTD3fSbnef9BbsiJ+hpCUhQVsYUMhTkqf5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fkbUb/56";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB2606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBB2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fkbUb/56
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2348025e9.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793056153; x=1793660953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
        b=fkbUb/56Bl74RQSphNz0p8W+Mm2Ev/DD+y4zNjH64dRcg/FKJBexRdR1kcS3oX10Vw
         bVZ0CfGuyq2Yd4JtIObFLCtxnUGssJ+dBDtwpsPMna2aUh0pVgFp6ytjfYSV9Tz1Nwe6
         gi2f5XdZAg2vT5gwASgzLqAEFDwE6x3mpfWFMaSVFz6iJceK9eDMaTBmqmlGyM+Z8JSd
         f3hGAFFJfFw3QrW4ve1JsE3v81nNwFkK/C/kYdGK9N1q74KO3BuDAKzkWtt8XySaW7xs
         mMty9CwigLU0wvj7vBIOeKcaOeJqgnUsFp32eFvrPsDG+Mw0ErwCwU7crwsBGOPt0ryv
         MzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793056153; x=1793660953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/9dj9p0jw42E2EuvvjFl6cSZqQkfF2nRLQFIDKRY8g=;
        b=d3BSgPdH3DXTX0sQmTIdz4FfslYq8LCSHMhIsG9CKPEwBfAp3sRU75/Z6wQcSZWn4s
         fV5O5mPAYpigzDLf2EObHZxNxaliOG3OZUaCkNR2BAvhxaesTEx1NXpg/gS1a8eXt5jY
         jI1+APV9m+8Cvn9VjHYpBJB7w+9fRNPFPbwygog6RgVeX2dXaXZVetB59sh19nZYnGzR
         Tn+pRICAdAEZ7UaNHH5pwiYopC0bRnHPZieYIOq1vLfNbyIskQQzGDxm6rAQ3nTvN30A
         FSvKUsqUQhzHoCXD7cIKFXh9gBy8Lgdka/4erE6E1xbOmqWvAU7btuzhndnPacdumgQc
         rHEw==
X-Forwarded-Encrypted: i=1; AKwUvBwubx0usVmfBSHOKJElyZqhZa60mIerzsBvZX93dV0HxWrR9LvRo8QYVRcG5VUAfrTyav3LAxuFMEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiIBemz/GKY8euMZC1SBmDee9ZdTzusNV87dlr5RvkOHwoGifj
	jDPAM6rk6wDOe5Is9xUdqw54p+8KskJTKRCzSAKwDwxYQJRsCQ4orSM=
X-Gm-Gg: AYBFou14AgJq07U+7pFoU+fy0JzxUslmGu11c1V0rhb55ysxFnuWoFV88q/PD4F840/
	dc9S0JUJec6WfozdmQNr0ULlmpeJG8r3plIbvazBcCy6ticJOXle9l7OREOzSvzVXYXNlH2VBxy
	4Kh+JsA/0REjnMeVT7bhnjmKVV31K2qoKMo7AKx5oF11UrgsiS+GuJmZr/rQYDkkJ2J1VGJck+K
	TTfVe2+aI8tZN6YLf5zchd9V37gvm1wh7brTMIDY2MujqzpupBerzrzrH2HwngXjzGyM2U/qmzx
	tzvQn/EEFtSebOGWdNZvNGvBJ9MQKyqJ/SJnK9IKrXkkyfTITeNR5A35kFIdgJEtRR1DgE8PqPp
	9kXp39DxvMyz9TztjpAOme3cBTs9d6y5oZZ5QX93csaGsA5lXtFQSVbwUwofrUCTvXKP4QD6VM7
	m6FHKHeYys48azT2btMCzuCqYsQoPDs+GpwrG9nqsySX2gPYbi5HwBbB1KLaZFtd2iUX/Ww8TDa
	vlfgfXDnjyr/XDvqpI53Bp76F+YP+ZJZCiFqw==
X-Received: by 2002:a05:600c:45c4:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a7bfec4e49mr19489675e9.2.1793056152703;
        Mon, 26 Oct 2026 16:09:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm229425455e9.5.2026.10.26.16.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:09:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] iio: adc: pac1934: validate ACPI _DSM return type and bounds
Date: Mon, 26 Oct 2026 23:09:10 +0000
Message-ID: <20261026230910.2569782-1-tristan@talencesecurity.com>
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

Add ACPI_TYPE_PACKAGE validation after each acpi_evaluate_dsm() call,
cap loop iterations to PAC1934_MAX_NUM_CHANNELS, and verify package
count >= 1 before accessing elements[0].

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/adc/pac1934.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c4405..43c4705c27be7 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1101,8 +1101,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
-	for (i = 0; i < rez->package.count; i += 2) {
+	for (i = 0; i + 1 < rez->package.count &&
+	     i / 2 < PAC1934_MAX_NUM_CHANNELS; i += 2) {
 		idx = i / 2;
 		info->labels[idx] =
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
@@ -1130,7 +1135,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
-	for (i = 0; i < rez->package.count; i++) {
+	if (rez->type != ACPI_TYPE_PACKAGE) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rez->package.count &&
+	     i < PAC1934_MAX_NUM_CHANNELS; i++) {
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1141,6 +1152,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	bi_dir_mask = rez->package.elements[0].integer.value;
 	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
@@ -1153,6 +1168,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
 	if (!rez)
 		return -EINVAL;
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
+		ACPI_FREE(rez);
+		return -EINVAL;
+	}
 
 	info->sample_rate_value = rez->package.elements[0].integer.value;
 
-- 
2.47.3

