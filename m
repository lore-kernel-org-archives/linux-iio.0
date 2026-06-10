Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5C427A0C
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105856; cv=none; b=oDIaN8ZBUnfpu27pp2pCqaA4vHE1ovLPxWFNK4AdBsjHghANCUP+11SEOAQUBJGosEdMOrBc2UTN0yH2kddDJrA9voFBJYs5oedgyGGHXKXud1CtFv6Ro73OJ7d7RGNcUNfv60n7MVkjx2qpMFhgrqR89YoIfo8vXHFx9vcfQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105856; c=relaxed/simple;
	bh=zeDgyTBDqnREMAI7AorF+q+8aD6bpAndr/erU2poByA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0yVnop43qhTvbMi6b6Xn2FW685Lf5QOG/qNhPQGRqQLZEP2le6Luhce1e6gyrKJ4RRV3okGnXtRyhdd/EvUbgC5uys0n4CXNXmhC6GzEjBcIjwTM/DCS6QvqDU+GuJ66pU4zXcU06GwuXuo0hjUwhrJfJb2WJd/6KVl4NeKt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFQrSRVs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFQrSRVs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso4821022a91.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105854; x=1781710654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulYd5wVpca5yg2jxVlzL+HIPf3pvEYlKHmeoeqLMtp8=;
        b=RFQrSRVscw8g412+2CuF4tQam0Bc3KypUSrNE6ew2HET9g09UejMN0pZvBAhecoLYF
         yjefXsnEZE7cnMfva5QN8Y0TjHfOZd19CjZNV9VhwQCiLUybuXFTdZK33JYHBd3IXcVO
         8ocqTxzHtOO97PmH6NqbP7xFnL8o8BxZxixRxE6AjJ0KFjUOXuxM5NNqtoE/fsojdrcB
         mjMTTRInkGLbQNleOwuG55MUv9jgrq/RCxomPYVgT9wr5drMwqnwFMszEA/u9SMbe2O4
         HeMW9sMDxigZq/ZRytzRQr2sEL1A/rh3yRRmE9MC3Ndaqaz+gLGdVh2EQs5MbkfBo7wQ
         L/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105854; x=1781710654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulYd5wVpca5yg2jxVlzL+HIPf3pvEYlKHmeoeqLMtp8=;
        b=cMCMk5/VQfCV13/rDKoEshOhTGefOnUpTPDDNFmpFX/QuIIBzR0KIjJS3dmyyNwlSj
         SrDslDayoYTsvNmY0rCZw1iD5+T0CIlfaW37HN8bl52PiIsldXTR/7ld1xfXi2n4dcOb
         6fbW8jU1nrLnRBCKSacg7JwfH4dRcmFEaFHIahYki4xCtm2qkyoP10EGDqVdtPMYzf8T
         sP9ywZ7Zo4FhVoZq536qjS1BY+7MFRHQeYwMt8aUeFH6XWjF9e7QnX/sXeT4hOBgE7/X
         ox0CETiChsbotl89AE9SatXiJuYUjha7C3IEXFey2aGdLM+oWgel+ZBE/EPJa5V/9MNE
         060w==
X-Forwarded-Encrypted: i=1; AFNElJ/G9evLAl/TFvUepVxW0oHH4b+cgXx8LJUayj9CyxjTkUST0Wd+WwZqnhA7lpttzvoBunNKk3sycIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxOiYCOyPeZZ+igyWXAnFTuf9DI6olyZW6WTKHMjEfyYe40Hw
	Ti3+0ZpyC7EL8hyGa0v7yTNRZIAXOVc9AifrZfP4dJWhXnF4FifCyXCX
X-Gm-Gg: Acq92OHRxZZVS4OYn7FUH6Ywdt0MoVVYdBcgyRWmlZOd0INYkVmYE6a1BMYURJp9WPu
	tEKRjF8eeehETZks0WK+FvL+VhGo55QIhE9a2J+wpTfr/2R1xvqfIuKm76fSQ0ViF0szAGhjBkB
	2tL+aXY9Rh3SwGmf93s6VXlog7ZdaJpkhdmVJTpeM8jeiwpMhjjRs9z0KFu5FgePe8I/ZcxEQUM
	WKMqpBK7qGTZlwaOoYwFiGCcucFoaZRzUGkB5xgcwnixMGJZicDOszPJ3qN8O6T/V+n9ItUDT04
	6qUYYeSzT+lR1gKfonQs5/ya4u4EtC0cLRBhZl39ofzqBDQpCQSTI4++Q93AKZrehTDIsG2x6VL
	KITV0iAr9f8+UePOvak368ORlEF72QV3WJLgRCRtSlKiCihLwz4jj+0H6lLsp9pbtWvUcd3i1rl
	MRZr25fJ7vMo+ga0/CMbmrNFSX0URxFQKwV3kkDwmmQHZ14zg6jvQpF9tMxO8=
X-Received: by 2002:a17:90b:35c1:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-370f0678ed1mr27145694a91.16.1781105853594;
        Wed, 10 Jun 2026 08:37:33 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:33 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:06 +0530
Subject: [PATCH v2 5/7] iio: orientation: hid-sensor-incl-3d: use u32
 instead of unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-5-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..c7fbff498be7 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -189,7 +189,7 @@ static const struct iio_info incl_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -212,7 +212,7 @@ static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -247,7 +247,7 @@ static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int incl_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct incl_3d_state *st)
 {
 	int ret;

-- 
2.34.1

