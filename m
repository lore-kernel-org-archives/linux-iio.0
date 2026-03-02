Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309E3D6CDE
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456815; cv=none; b=f1ZXsngM5cAAwRQzqWf5YbaFZ6XrAB7D8QMnsCFaBi5ZXBMN7kQMXn3UEcAIhsFh8rmNOX5LEMwl7NBaneHNa4nxP6eIcaeq7b8t9dcLS2Kt8hYPH4sd7a8fv7o77LmUdZbIGly5to59+He6Z1ykrT/xp47B3Mjv6GDDXTAwUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456815; c=relaxed/simple;
	bh=eJYQ5YvtPHTQPiSfzoq2ScstbsQx5eZ3LHmpQIhH8vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4+EedCwoQfc5BXaVp5iaLUfrVe/gP+DamG70/Zj9JKEc2meypngE9UWYHWHdutrqJxfZvBOHR38kKYwkPW1t3piuMPIH+lP376kqp3+0WjjxDJpCTMZnEtIBlQYlSgFbM5xsVwoaDm7pRE+9FHIMOBviN+5Up5OjFPCkSvvZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWXjIEfv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWXjIEfv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3599126be32so385511a91.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 05:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772456813; x=1773061613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=redOa/mq1A5/vGoB89xwTvVxlbWjSEO176qz4hWguZs=;
        b=fWXjIEfvWDTGjl950tWPNf7fyhB0LfrEdBCxgVMl6oqUmBhwhK/IVaiisvOkgbxAy7
         A617nE+sl2p08GjBgVpodJ6jSlHA2H8Y3j5lp5p2zFf1piq4tz6gqqpKWA5sy7EmxE5c
         G+dEvpqjjfNXcIdtFO2ZQyNfLpqbAbXgjz65X1YQ2oCwnO3mrIcxPgsW6xfQ8AE8Q1gg
         aqcyKefPlpadLGJjhk71bY9DgN3K7dvscUXmbeQtLsgBt997JhHFnKXtD0rfbp7zgKhX
         rPfYWLIZvNwNQ6A3JUe1tgYG5mML/toOPh80CbjqxwLpfHB2+Y76PS2/sN47kjj/FGB9
         LIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456813; x=1773061613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=redOa/mq1A5/vGoB89xwTvVxlbWjSEO176qz4hWguZs=;
        b=ewIpgOFAk85/04RlwDt5qVRwuH0DFhK83nEm6xf7mMF6b7BRcPKaskhUtPXt9Qjj33
         Ktm0cIkuQvCpaNsxoT5CIhxQuUwm1aXdhuPfmvUSeFDtFzzxwUIlLOS2oJjuivVNyuOo
         5dYOEaGmsMwdmjHA3yFzqp0LfaJuW7O2UnkwUdUiLzoyF5f1aznIfC7oMZIW9r4mG6/O
         1ksjIwnJhzaZJUnFV47DGTq3BfivGOaWbwsNPpo4yBO8ctZcOcUhxJiKst4dSNy7Yvs1
         G2vUufsnBmGnfl7VDHKkljEAh9Uv1xs2YBR1kcMJBs1Mfe3RkTgpdRf1Y64csWH18eAf
         qNYA==
X-Forwarded-Encrypted: i=1; AJvYcCVC+IFnOyDMCycvhHOH9YuG1hTNaDHq2hMAp+cK/h12r3UQsMK6X87+tDmHxIVAklPlfHYs73Pa9Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjqEak+jxPZD7cDBlG9gU2J5qMVDsvH9BlHI8DfDqHcR1Mvc8
	BBX0cq/7w1U5zvkJxxc7lWdG1ElyO+fzh8lnOIp1tXfqFnoKy9YOD8BF
X-Gm-Gg: ATEYQzyHvBw3QlZ3iauC5Xxn9PqQbCWv97gehFInarIiZYdohvEdbNrTFIegTYQGGYn
	9GCGvyHizMZyFytZAJFb/mjiV74LjU/0jgsIAkaKDaHCd8rWctoppA9Gp7fdGvbQdZtwnDv7LDB
	K3BElf9nKNnE6hfyBCGoIc3kVfBg3vtkVtynqI24eHWHg9Fyqh3PtsDDs5zH3kI3XZctIIUSEKp
	u8fOGPeUfVeV28sSw2mTHhbBiv4mspeFq8CpuNqA54ZJuzBKEswjfgz+g/cVr7pdqBNu3cIS6RH
	TPUGdRVkwqO7IK0bC0iN1mnsIcp6tsyl0hknwa2+88LsFhFBhdWucLMzqs6QMNbbIR7R91NCqA4
	7MeVrtlG09PM5HxKhIFEob6oV02bznTr149P2RIel+WknqHIulbPsLV3oKpnRO1RWGnqX8gMaz5
	czH513xVtHISlUD67Jp7g4ZPKsOhyR9YXwXQbU09OOaQ==
X-Received: by 2002:a17:90b:4a:b0:354:c600:1a1 with SMTP id 98e67ed59e1d1-35965ccf1b9mr9811995a91.19.1772456813363;
        Mon, 02 Mar 2026 05:06:53 -0800 (PST)
Received: from debian.ari ([152.58.176.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b448e38sm7444585a91.5.2026.03.02.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:06:52 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 1/4] iio: adc: ad799x: make rx_buf static and DMA-safe
Date: Mon,  2 Mar 2026 18:36:29 +0530
Message-Id: <20260302130632.29144-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302130632.29144-1-architanant5@gmail.com>
References: <20260302130632.29144-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rx_buf is dynamically allocated using kmalloc() every time
ad799x_update_scan_mode() is called. This can lead to memory leaks if
the scan mask is updated multiple times.

Drop the dynamic allocation and replace it with a static, buffer at the
end of the state structure using IIO_DECLARE_DMA_BUFFER_WITH_TS().
This eliminates the allocation overhead, prevents leaks, and removes
the need for manual kfree() on driver removal.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..7775be874081 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -39,6 +39,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
+#define AD799X_MAX_CHANNELS			8
 
 /*
  * AD7991, AD7995 and AD7999 defines
@@ -133,8 +134,8 @@ struct ad799x_state {
 	unsigned int			id;
 	u16				config;
 
-	u8				*rx_buf;
 	unsigned int			transfer_size;
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -217,11 +218,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+			cmd, st->transfer_size, (u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf,
 			iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -234,11 +235,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -895,7 +891,6 @@ static void ad799x_remove(struct i2c_client *client)
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

