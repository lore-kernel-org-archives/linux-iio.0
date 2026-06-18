Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51A3148C5
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824587; cv=none; b=CFAezsCj+pRC7sSuiZ/ParOB61hXSHKTkD9ntWBjuV04YQLuYSQIeBx7wVw3imECGtOOevcD16EMeb8Y8oySmELkFRnp7YFoPJ1wirQoZnrllfNNEF4YTJzSWlnEDJX5jXuyLT3/U6/sx8km5ykvDKNBwhZRDA6ejAanRKW4qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824587; c=relaxed/simple;
	bh=Yl43fJ+M2G/qfrX+KfbFEywxPQM4iuILGhuxCI2P3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL75hZuAvN1jSH3LqYbevutgJK+h3eotIq9FOJ5wdY7YEXkd8koGjgsuugL1ZhW33qydDRGKxHlQMWpe5UjlSQqYnslFT72N+I0h/g+GbZS2uoL8hj+wyy+Z+HIKDGjlMVCpzWAHJLrCBYMh0AxlliH768Jfy7IRWeBCTdMCPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDjVuReS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDjVuReS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1362416b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824586; x=1782429386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GQHd7wRPytVTo36B6mMnCcjncWbjB7P6uAbRfLAPmg=;
        b=jDjVuReSA4XlWY4U5ac2zHKwD595UVuUcbbyhyVxy2fKcRigggmU8OuVpzQNiBp02F
         fZ10rs6Ji8V7hwBrlZ1sPncCqpFCjAy9F9VpbDQ+xqObxS4tvffGshfdnkiQJ/51XHM/
         X9LxjrVlZ/4LHTWCSNNHdkbnylw7A3fykh2S/3QCVBsnRGXUU2VdliDv7kbrZsZE6cHx
         GVUJvCV/Xy61+/Ywde0EaBuOfFTkC3ODj+bUx7LuxWsL1YfQdHQGI8mdjDKp//SU9lpv
         eznp2wZlyHpS3KAvBgj+kIXmAo1uY/ck5D71+oRPBvY9NYrBiRDe7GKQW0BaZFZ7iP3w
         O/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824586; x=1782429386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GQHd7wRPytVTo36B6mMnCcjncWbjB7P6uAbRfLAPmg=;
        b=mAoP5p3R5+lKZYJT4QJW/qmNjBY1iNVB9gVPIe97ICroKYfMKAIMtvs8q2KF/4J0XI
         Pyn/1ShZWdIrgU4MXfzng61QhHjzhOpoHrST7mBHXKIf3iCoCdSLctBxZxcd2s5YBlxx
         bxmtOK0wuX2DmU9MaLo2+aSfz/hjpcCAufCzt8ZWT7kB4YKAfh+VDbdLSQ9HmuX8k5nw
         JrAsJ/0sfbU/ILJ6NRn0xFRZcGaJ0A9eeH6GGogGiLSnXTYRFxj7kJd3ORRCZkFI11cs
         VfLsBxW5hlbDsESTLxM9M473snwR8zaMbffK57g5TMsXgHvGSpuSoSlBX/gtwBCud4Ad
         QT5A==
X-Forwarded-Encrypted: i=1; AFNElJ+d6/vw0yTIdHQWuvInKjeyYagvWrlD4Uogq0SaGaC1/WSpVRuDla4itIJZqXAKi43GXTuVlhTWykw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnwXOSD/Tm+h6wXiFi3X4WePjpXBmlIZAgVhrcGfzZzzcf11W
	avCZgvAyzlF7HHDzrV/+Re8i/bfe+8L18Iw4iORk9bZuGaS3I1DvYNar
X-Gm-Gg: AfdE7cn4JNclHMTq79gpbrssInV3JMkmiEn82vn2U5S1BVybbw6VeKh+EgRDYILJoup
	7VmgTsqlRGdQCtAISDaIctZuNfXO1sWxlw8oMedY9PhuZpeaKCHXSvlCRniv+x0Pq2a25tzLYty
	0au4Oczzy8EmELJOU5GIfpALwK3ihF/IvyzNIs66Mu3myT2NDzfO7/DqsOcw4e8sNvcA+ueRS89
	YWlnQRMo1r/nmrXICJfsMwmXcXQhze6SKM9oerhT17DRykMz+hrRPtU/kjo3ingMQALtZ+p/S3D
	CbVj5jOsTPZu2DMy+wnUY7v07/d8nVPGthrIbjOAZzdC7hzvwmhIzfktmI/r9l0hqh5UO3+/rU4
	O4DncgksAdp2KrTnE0Ms4zYE4R5Y7FWiuot8Pvt20nri20dvzM9NPB2I2lh11KDFjt1U+SLnHgc
	1EhMStxGtpHllxqHBAzrRtGOV6kFXoYV5GJREviZRLPByVVzq0QFbuLTJ4abn1H8Ssf4dWiaL2L
	2WOuMkX
X-Received: by 2002:a05:6a00:bd88:b0:83f:250d:59c with SMTP id d2e1a72fcca58-845508b0d44mr998339b3a.39.1781824586121;
        Thu, 18 Jun 2026 16:16:26 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:25 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.or
Subject: [PATCH 1/5] iio: adc: ti-adc081c: use dev_err_probe for probe time error
Date: Fri, 19 Jun 2026 04:44:34 +0530
Message-ID: <20260618231543.413771-2-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618231543.413771-1-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies error handling and ensures consistent error reporting.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc081c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 33f82bdfeb94..29dd7cf25f79 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -190,10 +190,8 @@ static int adc081c_probe(struct i2c_client *client)
 
 	err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
 					      adc081c_trigger_handler, NULL);
-	if (err < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(&client->dev, err, "iio triggered buffer setup failed\n");
 
 	return devm_iio_device_register(&client->dev, iio);
 }
-- 
2.54.0

