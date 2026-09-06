Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E492B2D7
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788694970; cv=none; b=nW22d7innl6RBQaQ48TMFqCGU+c7eu5iyw6sPoqNc0QPj9nzDAbP2hLaW1/N1DaCf6HcjuqbUMkl6CIOGcu0vlR5BcNh7jyn0TOLoOBflkTTtmNJttPnTCK39UxpLbjM3iTJRN2Pii3usXdHRtEB1Ih8mSvrrMjNhjbrYROb+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788694970; c=relaxed/simple;
	bh=NIQQl+i9frKLvSCB+7kcoSU4oLwDtFg0IeJm24mSZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0OPPX2lBfGKgC1XFsGZlViW9zUNT0Ydh9QSxhsLwRT9dW38xcaar7WU2AvauYFhtACyUgSi0BaT9MNAfCZSwObQoDZHmR9q5OLNM/GjUodzMIPSNtiIKjp+8oSNm4jqYHrKvyxJDNvn3L1VME/6l7NHX03xHf9Jldi8oVtQa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALzEeLS2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALzEeLS2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4843f205a5bso1409618f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788694967; x=1789299767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bT/+VklbXB9D3LLWbRPzUjVHEWAbPJFAktyLnI06KDE=;
        b=ALzEeLS2A+kgS8TRj9q604puuXVaKrL8rRsDByZQDcCztimGft5KxcnhjdaWuzlvCL
         bIPxXwUJU+aKzFBOl/bPJI42pCYnMvMfk1rw3HjQx54Hc6M4l+iJuRjOkeL58t8VFnwa
         ckSL7K3RG0psz13smyf+QxGY1gOBaZoSJzytOGK0DdfWVnkJOmM3Rtw6lU6ywIAaCDNf
         G28RaUnLVstdJhXDdqWAWOD3tM4wHfUvxbBThwsp6YBbYwfpmvT6AjwKtL+PhrBSaTR6
         qcuQOc4qssHbtiIAvgAwj0ie1lzSkJMf0Al6PWOWCQUH14Evar4KUwT+UiC7QRoG0cze
         srGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788694967; x=1789299767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bT/+VklbXB9D3LLWbRPzUjVHEWAbPJFAktyLnI06KDE=;
        b=dCcrHNE3CsWxQ8VIdEnYocXnDSAed9nQQzujz7znKIG2UHHdPA6ZviVie1sFcfdPsG
         gwlguqLHhtsO1cQpM4VzMwJ3VSJT+5dpmmqKcexFXFUmVKoJpIgoQG6g7M6oYKHDBepY
         ilV5kNW+Rh4KZ5ZFn8qpXEfEe5nBqLGWYljCPPRXZvxJVZL1Yuuga+VirJfyP5iWDj0n
         yzoB0lepKzw7GrRSwGHGzaNjWi8bxFBaulwSlOKNzoYMGK5sXGuCOyiXfTYauDn0XgXq
         tigSLTChOi/0q5RH/+nheDTxN9IE/zYV9F1RWH4CRaCxwAcJ+TNHEAB6JldwwAja+t/C
         YFwA==
X-Forwarded-Encrypted: i=1; AKwUvBzICrnZ10WNh+vRR3ZLXD35hDAC3cDzHOBgtyKtdBsREhhZhDMryE9gkzNOy/Rvv5mSv0I7Xi8Rc0M=@vger.kernel.org
X-Gm-Message-State: AFuF++nILeaFqzPFJye1mI+UkK6rEM4Z5R8gMwbdlpRU6waEfYcyO4d5
	n+nUemUTbh/SffMlyXAobTteGEGtMWycOU0+mnmPKr7PnTE22TrkcH5B
X-Gm-Gg: AYBFou32q1zrx5EorjQWGDjuVA86TQ5nDehsOt7ywQi0l3mgva3u+1AEuhhB8pteaI1
	Zm4aELKW6CJsCLESp4yj59pSQWjY/NifkEVvLgZks5/LQZN/EnVcHhkfFLJ/HhvglG7bSJB+UZu
	uyLdtOyFINxwtdXyWl71RZ2DiwHbuEYfdJM5nE57dKPiUtOlP56F4na0kuspPhi93TchHb/jxu5
	IEgRojYk+y84SZXSrwxq4AowaYnAlem8LuW0Du+eObHjPUkIgfgfGHekTJfwsoG/wysS/4hwQjY
	7xp7eWz3TMm8gA7JusXT/uQPZ/oshfLADUDd9naLQ1baV6AfcpDNj/sjgTpKGl0NEDnx/aSKL8L
	McrkJZeq9ZKrezcB21vjv0mZkRtcTM2JuBqPtNFRTPsdxZAUDKueom5YTgtpUDF6GPRcPMJPznx
	TSWDfVKB6WKmOspFqtshV2ACiMW/kPI60W60W2/Cigmr6xKYNwlzzip8DAZhVbX4ASfFjvdFFwU
	iFQEbu8
X-Received: by 2002:a05:6000:25c7:b0:485:8a46:b3ba with SMTP id ffacd0b85a97d-4858a46b4edmr16892697f8f.34.1788694966717;
        Sun, 06 Sep 2026 04:42:46 -0700 (PDT)
Received: from fedora ([154.182.82.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm19356223f8f.22.2026.09.06.04.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:42:46 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 1/2] staging: iio: adc: ad7816: Serialize SPI read operations
Date: Sun,  6 Sep 2026 14:40:48 +0300
Message-ID: <20260906114049.32912-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mutex to serialize SPI read operations and prevent data corruption. Used guard(mutex) and devm_mutex_init() for safer and automatic cleanup.
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..ab80b3a889bb 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -14,6 +14,8 @@
 #include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -65,7 +67,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
-	__be16 buf;
+
+	guard(mutex)(&chip->lock);
 
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
@@ -360,6 +363,10 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
+	if (ret)
+		return ret;
+
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-- 
2.54.0

