Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99C31690E
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888583; cv=none; b=DZz6rwoh3KPKwYLzskHkJVtxwseQJ+D1vfy0wTIZ6A826Mf13BreJiTjJ15p145LoGhcPLvdgHwlnH7MqxiXPYbosQAwrf9FwYMR+aeKxfvKdAGcbEdYACvt5CRgjzhCej/aeEtpSdP97+bw+u3dH6izMDcq879keVF/TgpThIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888583; c=relaxed/simple;
	bh=O4P9DqgsLO0ggYk/A+NnFTIlCaBQLwfcSQj+hsSCfTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lq7c/0Mvrq/BYX8zEUUXuPBAQEcV7imEXp2dqTTGk0G1z9aifaa+hS5h0SpSQLa3za4tFROP9CIPpTfy+dKN2dq90EqgycdqCnDJLx/WSBeJLDd6BYZ62X9tHguBeuUmiCq8xEu5x+bQBpvNsS/i0gZiSye+4TA2DzWdKvZdIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTG/d7s5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTG/d7s5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b3ae4a8eso627271f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 05:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772888580; x=1773493380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkf6tTocDUZNevY9vbEFhIWKQSii4421LsB7XFDej1U=;
        b=BTG/d7s5IrrEOGVsUWHq7OBOFFQeRT3kAojPd5gk3w19WmbPQv9bVQrfrRq8cep6p2
         uHDsqJdRH5ijXAjTUU5mLR8WCs9eXNyZR5vrIlNCrcbv+DetDzJlFhG1AP1sjZg1dhQx
         QzHHLYBHHxJ7AjbG+BMoiDQZ2OD6z3f/myrNtLHN1vExRYHDxYfdQ0o6yBri6tHvExOZ
         0WxfkB9P9MpgKfU/uguqbE/wVqzXa5kKfP24J6JqIZ4GUMN9Sr4xrnvRJgxzuHRacCag
         oiMKtaiXx+jtANNOXf6mg97hso6zi5fYVK3tySV1EKGRwm6yUKuw02hfa1E5YEGTwNDy
         1frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772888580; x=1773493380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wkf6tTocDUZNevY9vbEFhIWKQSii4421LsB7XFDej1U=;
        b=djH6VT0UswOy3zj/0j/XBlulFzUZOoNF7ZglH/ye6GZivANxgQAGaizo5SSnw8FRs7
         ljKWb5A6N3iNwj6BbgEAZi/PFezXFn7ASYBt/ous8wBHr/MdAbw/Vq4fzj4Bo0FrHjuh
         vKitHBI2NfDUuxbqDSyjPLl+igWqdNgjvLliK4MykU7o4Z/kF6v4dyEKZdKls8zpPWy0
         5krkL9itiRBv30725x8eWZ0rnXfWVXLfntId4pJEIdfeqovi8BW7FqBBH52Rc+tci87K
         4DhvInfBcN+EbLpLQd7331ZO3/H/dGbN+8+mTIi7IE93rmqI8nPY1tHSDKNmYMgGjx9A
         i/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi+15jxvydbMDRf1SbLX1KY99kf6EbsrdAYbG/fmkNN4qyGTcZFhfvJzJG9BG5/74JJSGxKlGz4IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxediHp5SH4dvh7fciwMWKUMTRlojZ3CJAHmmKZHufL0YkzpS7I
	05J/4r06i8hDI2mjOpLUff/joaJnLxV6ht09gORtJaj0G6yrLEHxWSVF
X-Gm-Gg: ATEYQzxl7N1y5/Dl0Ge2uW71i8kDKMsixe1bT2kdrDcHCA1/5Fz3R9vsYBAwAfzhHRI
	p8B0oS3Wi7uAxtcimdlHsDnbkqRTosT4wf82RFBpA8nGsQtqk+lKSBKJ2dU+9QcaTjATza+k5Fh
	S9VTrOulzqgO+xBrNn3xPj6vryAayC+EJUS3LLD2jZ7Ujk89RrYyFi9zdINVTqLPdFhv+ZMzh7H
	0WMdPNzrk1satPFA6S07JZ2klu132cqdd/y7ggovYHg3VkZr//vlel/2f+fsgB1gxwYFGQnk3Y3
	hBsmEith42oXvGDkn7D8B26E391DDrkiG8wpmhyj36WItXkVFOcNeYsw3eOQYciEBfZ+XekHrAu
	+BboXbJzHyTA3IgIc8l5QEl52oio6ikEu/0tLsEWsc2lyTVzCdUlsE4F4og+XzuZsIFb4I/fFQu
	JkyPRsC9Y+xAgTCTpMy1soD+bv4+402ZmpehKj+Ca68WR6pFVkN6scNBhxnxAt98V2SklAyiN0D
	0J1JHSD/AV5YKB8jmb4GTnmZILLRQavTvdUjpdNZdLKxfdV9+1T
X-Received: by 2002:a05:600c:350e:b0:483:7d93:9f8a with SMTP id 5b1f17b1804b1-48526916b0dmr55900635e9.1.1772888580500;
        Sat, 07 Mar 2026 05:03:00 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485244b6e9esm70816245e9.5.2026.03.07.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 05:03:00 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: palmas_gpadc: Fix leading space indentation
Date: Sat,  7 Mar 2026 17:02:14 +0400
Message-ID: <20260307130213.174010-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix lines starting with spaces instead of tabs to comply with the
kernel coding style.

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 3f433064618e..f9995e28b10f 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -521,16 +521,16 @@ static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
 
 	val = (val * 1000) / adc->adc_info[adc_chan].gain;
 
-        if (adc->adc_info[adc_chan].is_uncalibrated) {
+	if (adc->adc_info[adc_chan].is_uncalibrated) {
 		/* 2% worse */
 		min_gain_error -= 20;
 		min_offset_error = -36;
-        } else {
+	} else {
 		val = (val * adc->adc_info[adc_chan].gain_error -
 		       adc->adc_info[adc_chan].offset) /
 			1000;
 		min_offset_error = -2;
-        }
+	}
 
 	return palmas_gpadc_threshold_with_tolerance(val,
 						     min_INL,
-- 
2.52.0

