Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963731E47CC
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900534; cv=none; b=kqUwjbKYjAQ6D1PCyuvWd3fYxTV2+U30sXj1NoT3wquZWxj+wjHJzFuBxWLnuc7QHE9bSAfuzD5PiyqQHqJCS3zRyk7e5oiMbri/NdTiS/ZSh33HIcC4utSaGbnY11ZkemwQ5beKqUKWMYGFkkoQRfuGdPrrfBiLiR+gJFhpTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900534; c=relaxed/simple;
	bh=JjkQ46yG8p0a6c9D14dqWVJYigSn20ev39pBlgmVkBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ5fi1rU/Nu+gqupE6ZIUTavZv1MNnQ0wolaipXLThR8ys6j0astfAdomb7RzciCr1V2IbAAvmU3h2Kw2wtU3vQYL2n716U5UaY1W0gXJNjez3aMCMBlY+wzfvsg/vs2Eld19Pk1U2SNQkCiR6Z21V2/wNrvenf8nSn79NpoUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkO15hWe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkO15hWe"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794911acb04so50385977b3.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900533; x=1772505333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7iGixlg0fjOS+Dh9LySNPkYFcBUk+pqdTwPH6+Zlvs=;
        b=KkO15hWeVtt39fM8N+XTKysoSZT+Cuf6NlUk4ud4G3I2vFfNw7XUw6RhCMlvyfEaSn
         X6FP5AdEccBAFBWzl1Ncwz2fseSg4VHgbHPDFrYK+XRUhNoowU8Z7a06VuW7FymZZ5hY
         2V3smkmxDLA2rZ1rFIzPx3Y5gEmW2gBpJ7+tfl2blq4U4pvZacJXLFm2kNSvGFLHgCaL
         XlJQfHRN5QNXxpDzZY8tF4nYsHEBBzI0k9HC0dVTRHAMcMzBVY/aCLp6vZDR0vHj/IFb
         SoVcViP1ZiuegDyrp90ESCmhiE6lhBbDhnnoRwBv6qnf3C+YBXQeePhU+Plw0r5BUjCx
         L5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900533; x=1772505333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7iGixlg0fjOS+Dh9LySNPkYFcBUk+pqdTwPH6+Zlvs=;
        b=KWrlGvQ4eSNgzs6lTI9Qfmox49IPyK2k8NG2Y7vwEjCrtPswAJvG4GENzGYd4Mmusv
         zt68cXykz+jrKKzeKNLX05o89wOiyZr69UUGqPt404uNXDgJecbVHe0nHtI56NZEOVJF
         jTx4vmzjm8CcyS2d+9+qbDJwZMXM+uPMqJeSDJ978uKigwBCkbNh40gG1FvutvfUeZLv
         TCH5iBUXJPccQdMufRLaa7R8EriU4DUDBzcxIKxJzdotWPXvdX5MD101cbPfkLiem5G1
         qxLPjRIgDYvmbfP73O/A5jGC2O9J5Mzz77P+9IsIkHP30xzCEuItqG6SejAdVqUvHy+S
         cv4A==
X-Forwarded-Encrypted: i=1; AJvYcCVP97FClm0L0fk4gY62wcla39QS1gZ1nAN14+4cxe5csfoaUqYrEdsNI2zkwAHviWTyNSpXoEwhroI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCq6Z6wwd/3Kl8l0fcDnXCkxxkn8eGKwfrZRCWzQA3VyMQU9ei
	A8uyt0AomgvHBkaJFQSfzDusapnfVzxt+AtJHLuv9nTrChQl95mWaJ+L
X-Gm-Gg: ATEYQzwFOGjca8oy+t81biJ/O3T1FeKBPLeOY9TdGZpXg3u2LXITqRTgRjK3E4mRnZG
	vpHovmqshamt+KjVAn+f1LfOA8bZ47AI5lb8MCa7xfgD8x/5LKqEOxVe6CAvDxgrf//79K0CBEp
	kjNaktjidQG0QjjzzcaMSQSWlYmxjDMk4uPLPjrQUmOCkidJSe9WDY3/IanPRu84bDX8b62Itfw
	VrmLkblUnjdKCjjVoEPe4LiSBUILU0pwUMr1KGJDr/xPJEjCp/WPtapSb7hpXVfdx2YOD+vQ70i
	0BowC8fXPJo0qBsCvLc0DTnwuFSNM/eTU/DI0SHIv39xjwyjrZ0TnLw4R4QsIum49w5dFqOtzKC
	00OzctWh6U9bXBfZklBmIHHDcLFJFATHZLfLxDA2rVz3JCBIgsK53a6pCo2vfEOq5EaEjYq1KeH
	PIJO7Rj9l58qdg20XZrjfvdfbaoGRh6nLvZddw56C+Ur91UsRBd2DFz0K3RQqficVfIjnB8IFn/
	0Mibcomn9bQ+qroYN4VJG57
X-Received: by 2002:a05:690c:6c89:b0:798:3051:2f22 with SMTP id 00721157ae682-7983051331amr73611867b3.49.1771900532669;
        Mon, 23 Feb 2026 18:35:32 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982d985074sm39585407b3.0.2026.02.23.18.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:35:32 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2 2/4] iio: gyro: mpu3050: Fix irq resource leak
Date: Mon, 23 Feb 2026 20:35:09 -0600
Message-ID: <20260224023511.274038-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224023511.274038-1-ethantidmore06@gmail.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt handler is setup but only a few lines down if
iio_trigger_register() fails the function returns without properly
releasing the handler:

        ret = request_threaded_irq(irq,
                                   mpu3050_irq_handler,
                                   mpu3050_irq_thread,
                                   irq_trig,
                                   mpu3050->trig->name,
                                   mpu3050->trig);

...

        ret = iio_trigger_register(mpu3050->trig);
        if (ret)
                return ret;

        indio_dev->trig = iio_trigger_get(mpu3050->trig);

        return 0;
}

Add cleanup goto to resolve resource leak.

Detected by Smatch:
drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
'irq' from request_threaded_irq() not released on lines: 1124.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 06162d886b59..b6e05afbe512 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1121,11 +1121,16 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 
 	ret = iio_trigger_register(mpu3050->trig);
 	if (ret)
-		return ret;
+		goto err_iio_trigger;
 
 	indio_dev->trig = iio_trigger_get(mpu3050->trig);
 
 	return 0;
+
+err_iio_trigger:
+	free_irq(mpu3050->irq, mpu3050->trig);
+
+	return ret;
 }
 
 int mpu3050_common_probe(struct device *dev,
-- 
2.53.0

