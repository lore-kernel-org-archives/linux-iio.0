Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD97313E3B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003821; cv=none; b=mrwmaEaOEKLhJsaz6xv0biIN8pfWjYpfQ2JYqekSgLKiuDAQ/QGBd1zqDqoU3brU78ErdRM4mf/uLekGCrUpJfjTFUgrPI2JeKedzkar9D1/FqeIB2gPxlxMobBpZVCdFemFH5jlS3F5Kd8u6S3sX1JMPOXJ0D0K511cwtHZmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003821; c=relaxed/simple;
	bh=SomMXQMUuqQ9puJg/elt7woziBoLt88xB52B85k+sEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEUoXBzrUMGUnGVTZGJnJVe9KzmVNRRopstchbpsgJ9bD+BZErldaKzi5DZY6g+dKnLMjfUOQLeDI7Hbdn1NF1JkPOgwDITXvYQzGxmayyOmuxn0MHg5teuc2Wm6rRPZcy8QpjC3TYRk4k+asYJGxcwRqfy3Vxkib4qP/tEMhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoDyHsT4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoDyHsT4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-448528f4e69so616064f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003818; x=1779608618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
        b=UoDyHsT4a7UV/Gb0gAlXcvRfHdo7Ew1to8uN5nhoK3wkNKvSpuXcN8ybuPKGgXJ5Gq
         F5FygrKjTfVoDpq0gMCEVUmzZLn0myik+tK05B1huvBePkSSaObfbuATBKElDZrJaCuV
         NzwPrDcB69NMYJ1VWPT457YAtcvRlfgRwhdzwcw1Nuq/DpcA2P526bSHLcfrwwaNhUgt
         QykMeA1sE9/zo/OeBe85N4uHmvc3evI0S/biiXAiQGSgsb7YVEnsILf3K+garNYvX1MY
         jw2tJgVpZQYHmrnNrRhADBjE7Kj9EsakvKDWiH/HDzf6Zymy4fT91NbNn2VEUVN3p8j0
         5zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003818; x=1779608618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
        b=MpLXoc7WFU8OShQaNwQxSI3pZdhx5bC02VIOlCFY7YCaBZm6T6ifu+w1nwmNewG1jX
         vVjiOyMlsmok74b4s/BY/SQNcE6mdoOF8cYWeMfRWlu1TG4akHrdBtspILjrRBz6Pcu7
         ViIWi9Va6N87ysnC5+yrKQeVGy70TvzKo6g2GFvlVLk831r9ulcwJWY2NzEt6+md2kLx
         x7wsAMctKylNwmfjyUN9Wj4CqtODg/6PUUvrx1bebFehu43PZiaSAHOIJbkXHgmAhAFa
         e4R9vB+rbk7CfbOUW8dgd8cyoQQ84xcNrGftLwMZ4sggBMpYihVPnDikyAK8oKEpUcEw
         VVNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FCHEUhW3cEMcKdSQqUEjxFzbXmyJiCqken7I0yvfbhcwb4NDLS2YyZGubBnabliJD8MJeB9+lUUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV09wuBk8ButU2jRNG62eIr9WzmfbnZmk1dcSnka08V/+ZbEio
	aDRKGC3/cucJ5OlVpYPr45qLtQFLSveLfhx/z2JT+LsavB9xsephHnnZ
X-Gm-Gg: Acq92OGKoDDN2UT1An8+4XWkS/qckkmb1yYDT06Ca/Sclw84jlXWTM43V5BPHesf68b
	YxTo9yZd/Q6Ggzk9FzE58270sUZhMaU/27wmcJxmpD02NBnqH21KmzH8m0jMk9Ure8QG8dZxulT
	FBxf4lEduxwarkCdBLcKJ2CNacT4u7XMsheFK2Td/rv4JVmhc+NoPaF8grJSF1DDtH8YWRMnTbI
	WtC72jmj9x8KwzIW3EKf8iyfMaL1fvg7eZooglxFxNYaCyXhYQO51ntcseneupErYhyI79ZdW5k
	vhtPPaOLxE6VbWCKB40ay96fMvXsfuJCJ8jBIEkyNIp5QNUmbguc40Z8FyZgCL1l2ab1otOLmZj
	376U4sxq789thfkRffN9MdAsgqFfRse4JaQIJdcC1c08oeRYRSjn77bthvm3yh9yYIN6muICqsi
	LjzCKfPm8PfUNv
X-Received: by 2002:a05:6000:2508:b0:454:9655:43af with SMTP id ffacd0b85a97d-45e5c30d598mr14636187f8f.0.1779003817436;
        Sun, 17 May 2026 00:43:37 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 4/6] mfd: lm3533: set DMA mask
Date: Sun, 17 May 2026 10:43:04 +0300
Message-ID: <20260517074306.30937-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 131eb1a1c8eb..c7914afd564c 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -499,6 +499,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 			lm3533->have_leds = true;
 	}
 
+	/* Parent I2C controller uses DMA, LM3533 and child devices do not */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0

