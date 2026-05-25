Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9051F30A4
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673201; cv=none; b=GbtPG+wITfeMTKVybRw2JRmxXWZ6l0aFkwN2MByGPMmjd3fc0zXSu17cPquXQHhQlrcunyLVRUfgAeGxLv3LW0CC8gzdCZD5fnXqcIJZR8dUd0JoUTMbJ+LZGgn/lDzpniK3FJDBaYDE9MccqSMpB7WdIH4xyxa344YOTS70WAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673201; c=relaxed/simple;
	bh=YS6jCjPN/UIoggB95tUfxTv9uEHe7AlMRn11CmiFLdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+FCeQ1KOXyjNTZsneU6DB54ru7rQHvwo7W+ohUK4lYPfFTUBQYYZ76xyTxRq5SesWQzeh1G1FOWaIV6XZawFPWJ6KrFhDUz8eFvWkeIRHcf1/3GIT0HowjFzq5czeEXyb5G0zAN3f7fHorTcpaEBu+8V0x/tyYujtK4TflCqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=K9iizGgS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="K9iizGgS"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e61e251966so589144a34.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673195; x=1780277995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XIM9OnRzGFA/35nH6Wlvv7D5+fTDWpMhEIG9GUqhfM=;
        b=K9iizGgSTN6G9m1jktlLYXT3jtTSFPULjsPnd3+z6nZVvIkRC+xTzRc2GxsKsgZYtl
         BhDurdZ/E1AAmAm0u6al5Pgi9GunlFvXPspvTRB86LNLVsCzC7b3ddkq4B4v6/Zr86K0
         fNhPTeu9P95zN7t5wu/sJJDyZaD+A1acALzwUTI+y1RH2zGUhpbhqhG9vDNxxnPmk2Yf
         IrZiW1CSUqZTblSJtVe1ybUb2RZwNEaTaR0F0k/os9nz7vgXH8oLwzfWKTjMFwdfwPPu
         qn5cB9jpYnZzSX0FMXPGiV6hy19tj7chOECU5NFLfbxxc7VcE5s6ENjDRn3ZxQEPBzaw
         bSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673195; x=1780277995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9XIM9OnRzGFA/35nH6Wlvv7D5+fTDWpMhEIG9GUqhfM=;
        b=S5eWvVTAQF0awJ06PzJvMjEzLi7ccZt8vQCvz/RMRlkDgr4eIUpU+uALX6yIb417Db
         VUKIpV/jRAV2LuPE7PFZ1jzVneoZBvoB/pSSZL0MmkT79n+F8rhyzNopt0IZ3ucc7YDa
         bv18o9hmsdbd4d23YTfBfdbLT7LVwtinXXVz5DcJT+Keijc1aeQIVlUwjjgsLryQ5mLc
         /xvFNwNF8ySMGHCjelcf5gitfsdRNtGwpa5JjktYVCfD7tjlJiQjt2+txgSAj246qtpG
         m6adTPWZ9oaVkIJjqa1UV8l9VYjxrVVZb2J8NCfNdxpJots27zs00QFEPSLcbK5QXaXN
         t3nA==
X-Gm-Message-State: AOJu0YyeP2mk/B9QL8me4NgxxeWFAr+cjRgVDRNGjN43ZU15FiIDi8nW
	YCMgDj+0B7MdJjH7n5YdMwBzy2ezPWT3V4gcc/XOTmbIHQJNRn8a32ni0j8FOjuf8xA=
X-Gm-Gg: Acq92OHcttiKxqSInJSP0AuONXaei03w6x2T66z+2rEX/SVlifhDs5J5FyVq0dwoWMK
	7jawMgbxIsvbNwVlUEQdOL7MyzP2/UhrykGtFw3Bxb+e1Q9r0WuLE0onAbnu7KSBGhDVDBidmTo
	GtvVBEklRjqkFOun3Cr0sIi+7E/2ZD79dW7DXbMZsGbw2fNVcAYQdskmdIodGoeLXKk2Bb6HC4U
	p9PjJUqVOCfd7PXRh5cfPdNX9YtTpWvsniux6nG/QMbKDe1c254l+BoGJ8DTK29ek01p0S4Bf0y
	B1fH5QnaSbcu91qK/yclgFshPAqulkcBX3NYPLVbOV8TnTZpHc2C6YNJ2hxffoEgQ3J+iPXIrit
	ZzaCnaEYRAhYkTjhIPpablKQ80n/P58UpKcAwegTvuGcjPHDXo//Ten9vQRvpGfzsiRRQl7ddhE
	224XlXUXQtEsS+Jm1QD8APJrOQ96o9
X-Received: by 2002:a05:6830:2b28:b0:7e5:68ca:8856 with SMTP id 46e09a7af769-7e5ff0cd9a8mr7659996a34.26.1779673195498;
        Sun, 24 May 2026 18:39:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:38 -0500
Subject: [PATCH v2 6/9] iio: adc: stm32-adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-6-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YS6jCjPN/UIoggB95tUfxTv9uEHe7AlMRn11CmiFLdc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6hFHAQyCONXja9H0qJtqJqKBq0yFqO1V5bYl
 UUyScLbRw+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoRQAKCRDCzCAB/wGP
 wErzB/wMCUV6Kulh51VMVLYxbDxRqv2BQZyM4BEr7RGpkMe/7Sr5HhXXNKGKeXJlc5yf57l7AsA
 vEsbN8YovaCmH8igLt9085Ee1QmvXe7rqmLPxILVsisABoUotxEWojib1VpHUyh0y+5oKbvCkFI
 un9trVfnhd2Fkr/rMxT6n347Q6AgHgxxzlckMEsMl8COcXXQGhHNuk+yxIcrU3Pom7uFoleeXXb
 ZLcYLd8BJMp+OBmBH0kreyAOK7vuqjllPoTjNkQnZRLUYY/HtjMCQGYwC6UZm4XYtO1aP9kGOyK
 JJaCG5ByQgdUjZh0Z6DER1eRR/h5VNepua6TfjsZTrje3fw8
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/stm32-adc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 46106200bb86..5c5170b19b56 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2443,15 +2443,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 	scan_index = ret;
 
 	if (timestamping) {
-		struct iio_chan_spec *timestamp = &channels[scan_index];
-
-		timestamp->type = IIO_TIMESTAMP;
-		timestamp->channel = -1;
-		timestamp->scan_index = scan_index;
-		timestamp->scan_type.sign = 's';
-		timestamp->scan_type.realbits = 64;
-		timestamp->scan_type.storagebits = 64;
-
+		channels[scan_index] = IIO_CHAN_SOFT_TIMESTAMP(scan_index);
 		scan_index++;
 	}
 

-- 
2.43.0

