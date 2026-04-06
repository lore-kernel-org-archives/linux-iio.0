Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA11332610
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775450374; cv=none; b=TQ5V6x469TwM+Zsh7K0/uTotSBkhfj6/SOVWMtmVwRZ8dWUJkIE06IHtjOYwH/o57kSgsIUBQ5Q7UvXDIaqoiyCykJopSQXqpG/C2xD9ZCsdDI+6nLKPrzzNPaiyCMJyk3S40+3at/wiLmIwWdgKhPHhYk2r7FvIYVTQgl0bghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775450374; c=relaxed/simple;
	bh=exu8oRPFvaUwd/x6xwtOQbe+s0ME5lDwo7ojHbgx33s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyhiQUqg07xXHO0C1+gg+H+nI3GDN6S1iWo6F9Cr9Ip9m1tBcrOLAFw9VTyjN4hIuXyve6lXZ/g8CcZYilkBdwykUN3Ve0yDS9bS3l16D1xuLnATumqXszwjJiHSViQvYAkfT7UA+ZwjhPNZw7DNnaRZBvl8pNJgDmEzGspO5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB70900V; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB70900V"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1271195d2a7so7625396c88.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775450373; x=1776055173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh6XhPAF80uBHigYDps0enG5D0ugVfrEjPXkEuqC+6M=;
        b=FB70900V8Rk7MbvjQ7qIQiSo9WfkwzLw/0VYrFMS/YBDsE+pZ5WYVNVQjXNw8hZ3Vq
         QoG55oqujhBNBuTkRHLBHfExPFm06qDfXCUKcrqY95mZ7Ax4b5Uvut2xD7PqatBcz/nd
         DqdAwyN0e8uDuz2tgkB7/oh++lJYqi8I80JfIi5FFD1iYvhqn8oFccAREhGTWgLMnx3E
         ydXBeJQ4ECjGRGn6XXYajWNvbaA9fPWhYTaHKycFWs71TJSQcxIbTAmFVx6IBiMXU8Q3
         biXE4VrGmadfWtCSitgFd7pu0emcipJlm/kzRr3iF7zjI58CwJRVb6LE7z/c95yRpdtk
         3rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775450373; x=1776055173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zh6XhPAF80uBHigYDps0enG5D0ugVfrEjPXkEuqC+6M=;
        b=CEX2Vv5n0HOz9vPJ7PEo+ULtH+G+47qAXmKT4p3C6vqBoZUUmU55BJL4S4SkyXOI6j
         3m1lY6p8JL9AbsBIvjhr3ePUMv0EyHnU0pWnXhepFcvvVwtp0doJKBQwUE3SjoaqQp9T
         lvZjWrrrOAMctTEgKs7RCOID5YiukY1BA6xJ1iYCVap22JX0FY2KU0HqHzFAY/3i98RD
         D+7VVufSK7RWckHZL0Xxer8JKdL/7w5mC2kCGoUmPu9iKNPgAtDCZHY+T5u5zeH5nLh+
         Zp011v0SCnJruCzB0yxQycqvSzwiPCMkarSWOfXRUqCOaDYlMK8gwOq49ME/YPuP+XjI
         +m/g==
X-Forwarded-Encrypted: i=1; AJvYcCWWRXq5och1A96zrznkNSiBp2TpFqkXBXhTrh33Hd/7rkLbQKJ4nRqdaMR1GxKPIoY40WYbLQ8HGW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7tHMsOIgyGXd7OiExkA4JKfkLtfGGM4pX2fN96EBNItWMMEY
	DKxuBgC5f8xnxyLtTVk+L05zPWb7OylzpY18PcNwlequ7Qw55RGOtLiK
X-Gm-Gg: AeBDiesFs6O1pOHIINOZNbTPqT7AS0Y9P9Yxr/nQXhe1eRVKE7zcCgA0Su3SVPK5Ehc
	cLQlKD6GB/95kCTndWJ9EXcLBx447T0iQQ+Nw+tKkgrnXRbj6VjLVD/FLbsQUiK57qjSnBbaFug
	MAhmkpSpm0Q3sDsDzdf/lneL857/pHsmca5scJX8EdUGm2ZzLfhCsWu6vhggmxlres9LaAt2WGN
	8YPSNpuxYouXqGe4vzF+knjS3TnuK2ulwwOELN0E1zIrLil33uTn32r3lCrxWjZogsaklcR4YTd
	Q+feuS7Q5qKjJyQBEyybMmiJm33ZJRsTvQhNjnPOmvrvdOP0z8qdpEdsP8Dz+sQnw284AaLAVSi
	MxNeFwf4cD/ljxm819/GXqc+8Podh4JipTCEQAVqgjXJr1kzqnSZT6sn+YqJghvZATlnYoYZQQe
	h8EodfW21MXQLNSRJnmL4E+tEgztqtbrs253kiCrNR1n7BABLoHp+WaicReL1PV4qMUrSB8Yl/n
	N094e78eciOHDI=
X-Received: by 2002:a05:7022:23a4:b0:12a:8176:f3b1 with SMTP id a92af1059eb24-12bfb6ed00cmr5864357c88.6.1775450372713;
        Sun, 05 Apr 2026 21:39:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fe13:98b9:9e98:d1bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm15182005c88.0.2026.04.05.21.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:39:31 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 05 Apr 2026 21:39:24 -0700
Subject: [PATCH v5 2/4] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ti-ads7950-facelift-v5-2-1f980ed3cf9e@gmail.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-6911d

spi_setup() specifies that it returns 0 on success or negative error on
failure. Therefore we can simply check for the return code being 0 or
not.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 6e9ea9cc33bf..c31c706c92a9 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -520,7 +520,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi->bits_per_word = 16;
 	spi->mode |= SPI_CS_WORD;
 	ret = spi_setup(spi);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&spi->dev, "Error in spi setup\n");
 		return ret;
 	}

-- 
2.53.0.1213.gd9a14994de-goog

