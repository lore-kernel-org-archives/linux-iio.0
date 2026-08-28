Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCD410D19
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914888; cv=none; b=uJsqeuzuWyHhw9xdKG3Nhhm/fwGjGsFbEM0TfUKKnT/KFZ1RAPP4Fs245Ct2EVIW6f7Z+mdqzKKhy1l/vlKyl7UtqVLJ6WwxKWUKszbdSESLcfE5uyIDWGj9KJaB3emWh3gIdRMD4/u6OB/Jgc4l1I8Idim+5YZIrPHBjqzX7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914888; c=relaxed/simple;
	bh=Pryg5xS+n+g+Fn2cHf2KW4X9OGMWP1v3ShHt73nesCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wi/HBKZfUFM9qsKbFJaVBy983PwyTuIbHzRDKCBufQjb9Gs1hLAzlsxk3BKDKYZjXbdxDXgercA4NJs11HmmAoiCJbJa6CLQCo02rIIgQkULJeeAfoJc2rclidSm37z574HcvEnEL4K7bSUe8i6Wz/ut5CntKvvN4pbvK2H+t0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOpknzKX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOpknzKX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e347638adso816647a91.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787914884; x=1788519684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MTWa+djf47koqumolK6H+Xu1UaXk+Fum2BNO6AlYd3U=;
        b=ZOpknzKXjsiH8ZA23mYJnzkXyDz43bsqmSmuThTI9d/LeIuZ9pbYZSdNXQGAGrugzr
         i4Yxf7uGSxsof5v5H4divtOq1TTH8N7AMK+OflkBk6A2PiB9eYbIfkrzk+TEGCiTdPwe
         UlLih0tlB1VntMIAS6FwZufyp5dQy0BDHtZeX/SRHakXRllmPXLzBCvVabC9nqW2Pz+q
         /kgfwq374hThdY2vNKTIxvOFqeMqFndXc1OqCzvaOkBAgepWh82xi1wN9UL9U3tBuGHQ
         Ftyv7UMRpqe8RwrusS9ohok9loYAkNPBHcZFoLjxOpdDyQVKbhuDuXlpP1cVMSZdQYGf
         2r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787914884; x=1788519684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTWa+djf47koqumolK6H+Xu1UaXk+Fum2BNO6AlYd3U=;
        b=r/YTqGthttQJOapxAGgx7Kyy5Ru3MLIAdNZwhvsgXCWlnp8IPiACvXrlZbZfZFeRKg
         jqtWwGfhGAeMCccFKbUTF+9Y1qwthJ1r7lwFV4vvVILl1FnVsifZ3S4zLLSI+5PXXTAj
         r7WZb+l14jbgqy0i59voe+qxCuPyjZPXjLvk0JuRNcFV3qqKSyIYXBL7npvN/E4xi25K
         yGMFJ0u0REx9hkE2YKMRrqNES65tsB0h++7kwcRbigsHTUkYLhwbrs3+JaVGGt8RQbEz
         NkgZJNQXG/9kshEz39k8ru1w3bHJ53IxVgbHbzKKtdjREwCXj8LT7E4gvkkjDpkNQGAc
         Gs/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoHlU2pZWKejBhBBQQcRTZx1Tqc+v6UGRLtJ7Ce7+7bLXW2Kv+bwBloEr3t+ARwbUPisf8EH1w/yMw=@vger.kernel.org
X-Gm-Message-State: AFuF++k42ztd7eEqYcvtwCJcZPqOYXrBoooOY3lu4LSTgD79Spl+YrXC
	JCBxWSJKwdi29P5WXTFwZZNGOLN87Dtl/SQ15T9/GsS7QgvrcwyOIdTJ
X-Gm-Gg: AR+sD11m+6c96sxdpohEV3zzz15URwjhqZBY7d+W5uLKjIcKrHIcBN3auunxPbeZ4dA
	4V51FJMQIQuGnnGTCz7CQsMknQvsZznWY1Iu9yXCUWBOVZlH3trugCQsOT7m5kHFm5oJPYFOcUp
	FeDbCsGD6R/9CWIM9MibR2lVRw+us5xySJ7jWjfU5Hd6ttxCp27rJcNOGTl260MaXPBtQKv1GMT
	lTlU/hKuU2SuSKwqByA6+nopqAAd15dYrvYDqOxKxCL93wDIPJySG+6rUactmYhRhCzcO/4CrxM
	ENGHXWN3AYu2kpveA2BlJ+PxbKsdh231GlZdaSeGxhiWqQeRmqUOVFuvhPq6MmHxOBo1L2BR7KI
	2UAhaTnMWtHRanD0TB5oKUwTizUbmHzBxDkMGX0uJe97TC7Jl66pb0K73j1yrkEeoBmW7Jx3cid
	v0bzr7Im3bk94B9mFTxk9AvyQUVHSra6v1z0OjBaBwFbQVreb3wbWSo6YeXYnSQPst0ezber1Jp
	A==
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-396d0ff519cmr12801662a91.14.1787914883610;
        Fri, 28 Aug 2026 04:01:23 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([42.116.29.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58f3dsm2075669a91.16.2026.08.28.04.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:01:23 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>
Subject: [PATCH] iio: proximity: pulsedlight: fix iio_device left registered on PM setup failure
Date: Fri, 28 Aug 2026 17:59:09 +0700
Message-Id: <20260828105909.2425439-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_set_active() failing in probe() jumps to error_unreg_buffer,
which only calls iio_triggered_buffer_cleanup() -- it does not undo the
iio_device_register() that already succeeded a few lines above. probe()
then returns the error, the devm-managed indio_dev is freed, but the
iio core still has it registered: the sysfs/chardev nodes stay live and
point at freed memory.

Add an error_unreg_dev label that unregisters the iio device before
falling through to the existing buffer cleanup, mirroring the teardown
order already used in lidar_remove().

Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 400477b4c740..8a9ee21f2bf6 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -294,12 +294,14 @@ static int lidar_probe(struct i2c_client *client)
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto error_unreg_buffer;
+		goto error_unreg_dev;
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
 	return 0;
 
+error_unreg_dev:
+	iio_device_unregister(indio_dev);
 error_unreg_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-- 
2.25.1

