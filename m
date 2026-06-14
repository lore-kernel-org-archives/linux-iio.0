Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA0E571
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443149; cv=none; b=VwuiDETSiC+W31wjJFpxv0lkfo6C2ZCWlJt8lLWDDOtNzFJ064ab4N7f5V+RC+KIyrCEkeWJ9r1T2gxVoNq+7COOTh0eSi+Xkdz3WG9y4UXEbmsyCJRStRtJaD0V4MFmCO5GTrSgs1qEygv4eUs58L9P4Ggv7Dudmt0zwdk1zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443149; c=relaxed/simple;
	bh=VPE1N0CcVBqslo2XPjxC64Yibn0ybQG+k6RsuywdWac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmHOdFzoiZxMZzlHv2XcZ9VTgoyXUXEaC0Q9IZdGb2AwhgFKz7atZ3XoF7TG2cT5UuPm6EzzdGzNVfRRw9esr4Fy1QS54FzYMUjW1GsNk64sK5CAYZDAQt7JQPAqGZIFd2lGUodIMfyh+bG5QsnnwLzFm07IT2kFBkEBSHSENGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3JlzQVf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3JlzQVf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so9013875e9.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443147; x=1782047947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4j0TI1un02xuJRUmwkXAF6i5ZkGtnqZivF2Rw6pdJ8=;
        b=T3JlzQVf5fpGoLSWAot6bjX5p3owO2HJY9Es/VV4i/lR+54uKMM8AIKN1p1zshNr6K
         A3oIe/1ANeycT2NYjzwmHYVVjxKRdoDHPkHBKmp2BJrYwvAZAzKnPqcO9PXVURA3uCW/
         RynPTCkfGycovIwtLyCJ9MpWCZl4j1qt8VpiyhiJznu7QaDQKBXAh9aCn+WvoirOnWTF
         DkjddgzvWo6iCxkygb91tdU0finTmZiwm33oM+aegfr9OHgzCsf8ew0weVEgZC7Ezyjv
         jEn1PFC0BFtW4pGRtUUpvuFRiSuW21FPf8Qmu3obiCDjVo1/2M6STW0xGhRQ1NM5k4tJ
         uTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443147; x=1782047947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4j0TI1un02xuJRUmwkXAF6i5ZkGtnqZivF2Rw6pdJ8=;
        b=dRVpjpY65hpXpxlZVZyFOea46yVbXKUtu9+bOZR8rt8Lkdx8cKc7dVRWPCBzm4NQAO
         QkVtjoPVAl/X4YNEejrxEbLYQF2f9sBZ6KPepT5L5eqZQXMVkyvIDBYbd9GuQyKEmWJE
         sO4GFBsJl55w1aEDSenikWEGy3i6l5M9c0eBX5s9Pgv4VJu506jih23/fB3dNCgd5x4A
         hXAIjciq79nFqTAoQARx/3fnmtlhQnol3XYX8Bqoj2Ot8z2kB0Jy1uuEYXzomBLO+LM9
         FO7bcCRue+VpPMKGUzOLC2qxEc8xq0fEycRNGXelzY05G8gMEcYjDLk67uNZqIaxQXav
         ZTxQ==
X-Gm-Message-State: AOJu0YztYDoUD42fD0fBstfNRdl3xoMvpPYrM0wPNrBZ+acKcQFOK/jQ
	XzPuvtSIUWPHxUVjBy59xVLN/o/UxeydgvLUKseZ5+h+lj260oGi+DWq
X-Gm-Gg: Acq92OFcqc6nR9qY7AtaOkjbw0xMEtuzNX3BlY+rg0OYlwkdpxskT5f7YFaSy6fnv8B
	wOypgcDoy6cwyQK6C8a0rlT4GxC5f+B9xhfucaOFlmzqdR2vwMxWubI2OuV8W1wwj6RV/3uw7Xm
	wDMgW78OWa7Lkw6xrhXBH6OvLxRlgrAw+mqo0zMd3X1AMPLrSwA7fSSJMOPgEinmTHqDbnK/0c9
	X7JPufgO1XTpvp6OqUR/4zy1mngFJnso+K1c0P18k/OQBPjA/H5UNc2BJaxZFZ9pMPPgetzKBDE
	IKfNQup/u9eA350RHgffvoi3D6uEoFvgGhXBbLC0mZtSDEZIGGGnYUgzM+YCkJqiCoU3gc0M8vh
	FPXLzOtUQtp3YaiCgeYgA77djwSYcD/OlsK2LMFFqN0TMj7uuIjcTuTVgJzMGJCl8t0HqGr3YaA
	rgl+Ntd1tzxSdtL54IbE/OWhZo6zt+e1MwC5uYcPNjBwViXzavSJgBMdAzdTiZAj3LUSGVmJ4vA
	nErIPx6dhx6ugwe5LlrTi7yoL9DixGPWylc+k4rv7ibwYPp/i51Y6+nrdmaQJrNNM7CoG8i1VZz
	79EjVKRjoSIDGEkz/O7l3K3vmULBVkorXOCbXbhO
X-Received: by 2002:a05:600c:528c:b0:490:bbc1:d508 with SMTP id 5b1f17b1804b1-4922005e290mr82574285e9.1.1781443146595;
        Sun, 14 Jun 2026 06:19:06 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:06 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:03 +0200
Subject: [PATCH v6 1/8] iio: light: opt3001: move device registration to
 end of probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-1-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=1802;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=VPE1N0CcVBqslo2XPjxC64Yibn0ybQG+k6RsuywdWac=;
 b=jpCpfdc+XLGvMWNElOyXJqpVEwtxNjlHgAcBbHCtjofcK1575zBPOhBdC0Cxw3aAPZwvskOzz
 GzR3xF1kRHvDD0+eEYiAsK8eO+hknlCNdfSk1TObJ0DsdylNqAt2Ay8
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move IIO device registration to the end of the probe() function to
follow standard driver teardown/setup ordering and improve driver
logic. Additionally, switch devm_iio_device_register() to its
unmanaged counterpart as current driver implementation mixes managed
and unmanaged resources, causing potential resource leaks.

Also, add iio_device_unregister() to remove() function to correctly
handle teardown.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 03c7a87b4a8e..6a39f116f931 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
-	ret = devm_iio_device_register(dev, iio);
-	if (ret) {
-		dev_err(dev, "failed to register IIO device\n");
-		return ret;
-	}
-
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
@@ -894,7 +888,17 @@ static int opt3001_probe(struct i2c_client *client)
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
 	}
 
+	ret = iio_device_register(iio);
+	if (ret)
+		goto free_irq;
+
 	return 0;
+
+free_irq:
+	if (irq > 0)
+		free_irq(irq, iio);
+
+	return ret;
 }
 
 static void opt3001_remove(struct i2c_client *client)
@@ -904,6 +908,8 @@ static void opt3001_remove(struct i2c_client *client)
 	int ret;
 	u16 reg;
 
+	iio_device_unregister(iio);
+
 	if (opt->use_irq)
 		free_irq(client->irq, iio);
 

-- 
2.54.0

