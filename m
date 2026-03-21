Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5F258CCC
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774093866; cv=none; b=ecuWEZ5MNNkBOldktHPdb+L+XMf54e7M+k/4KBg6lzwWWwEwqOFmu/mAX2MqnpHbwemOczyYT3u9krME9ZVXwJ4DdCmoB8k5uCLCcz4H4OYip+HhFibc8LV2A0NXI4iXojbXtjaO2kPUndKKXYw5Mv2JrZFPAf/DyFI9ZvRdLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774093866; c=relaxed/simple;
	bh=h4qxELH8HIyH7OrDx+tL7RRRw3iHnOriCeQy8hf5fUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9dQmpDr6wAcdVeQpfdACeYU8TObs3P1X92aAD0m2/4C17sjCTFJlnHXSTmMJz/C7Zr+ZKuGAv5mRWFeHgd9QIZWp9+XWYLyAgBYyolWqFb0tcae8tAWGTZ4bArTskncnidM14GaigNI+x1wokP3HQQsYyaNQVKHN8wmDv+eqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyNpaWBm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyNpaWBm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adbfab4501so6118595ad.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774093864; x=1774698664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maTaTS9K/SD3x2mZpLCZOJxjIoNIamWWMcZCBzHQFHc=;
        b=fyNpaWBmXEZv4qgtO6+aTXaBv7RWp6m+Wx/tfP72Gjd9cBgMQXm5t3ohlNb+ABUegI
         lsxxtiOfPPbbNiMW1kPTRWwkl2jbSEJbeZxbAUzlTwfJld9kAV+hphUhHPeZX2Fxcd/R
         TwSVCX2NuW48eiocTMnsF6mg8+whbPIprbfYm9NCUC23MVJyL7cQ4bEoIKD3A6LoErxt
         7Vfd1uwtRtz2SslrniQJY2hunVTvLZ6hic1Klp2DTfbSy0eTbcIFISF2tdkCK2GX6pWb
         pxGfxWnKZyCN5xrPETow79bRR+zggfgBvI/kRHu5IIcmscIfCAL9BTMtC+bur6cB96jK
         lYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774093864; x=1774698664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maTaTS9K/SD3x2mZpLCZOJxjIoNIamWWMcZCBzHQFHc=;
        b=rj4MUuvIH0fBVOYze9jJXYQSVoWdDfO5NiaZHd4BaHEr1lfVQU44AADd/k6pRQHWxa
         a1eIOAbxdhnULMOPlu9NWhc6d+y8tux+hPS63VrR84Y4+XXk98Crfnh3QOCj9wKCl6m7
         OkqA+e396QYRC/fLgPuBvIh5BLIKkzN42FE3gYRqYNVquizLMamEi8jHBeUIe6MziaTs
         ot6hugnrenCYNaxg1/cxVjnSH2N8CBaECx4ft1wiyIARgA/zOoaPAOIYafdiELg4nWPu
         5X1hj0sKrvLH0AhHGm6GPUMoMJcmXb8thDtyUFoBw3Xf7MM8RHIse3hVrT7tvu0+EFas
         CDCg==
X-Forwarded-Encrypted: i=1; AJvYcCXk618K469i7gb4+9ZxINj4n5D+LBH5pTctQq4NPNcYJR5Yj8B4KeICp6yEscfxjpCO7zBuMz4MqW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMH1fT54jN7WS+384h4cmBWqlO8CnVaPZQKf6gDM+TWxzl5q0
	0bqZoiYXCOd65ByAOsYy+oEHB+rP3WQ/SszLTRqttoLdAlhTMHbsJal7
X-Gm-Gg: ATEYQzxnHz9fBb0GOWG2w+7P2jMD9g7jmK+yMgtk9igyUgeULOv7SjLd1dY1qQbczbs
	IiTzZDm6H4EC2yaZkr2gq2IHQEqrZWuKTB8eIk77OQdCsMyXXxW3sVLL/3S6TFyI0szXZZ0bcp1
	e3gDJoPG+vynwlCFb8N1Jifup/KUM1tyZ8fG8WcfS7L1EThFkYgPtA30AGK0JwAKVi/d+pJegkE
	e69R3XHG0PXo98gjy99VGEI0iALefUxVFdWJaMCUNRlUxVRI1wIH35UZurD1A30MnD5lIg6Q7AZ
	XCulk5aDKGTqDNYQjfFZ9SZWBGKuS+U4T/ShLR0IEcsAqczuLMIuNKNK4n+6a6fMzbSaDJqQDzB
	BvmkQCyr5vy3gH5wZdxvdBKpYmtEzF128j/xaZZH7J+ZXTKNO0+ipzoCfDALR4vyovXugav67Om
	uqfRkzUDPFaKywVqim0Wr+6/BK0iUlUQ==
X-Received: by 2002:a17:902:cece:b0:2ae:c816:ec5d with SMTP id d9443c01a7336-2b0827a76b6mr65044715ad.32.1774093863877;
        Sat, 21 Mar 2026 04:51:03 -0700 (PDT)
Received: from fedora ([122.173.30.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083688ca4sm66288375ad.67.2026.03.21.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 04:51:03 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] iio: accel: bma180: use devm_iio_triggered_buffer_setup()
Date: Sat, 21 Mar 2026 17:18:48 +0530
Message-ID: <20260321114848.159973-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_iio_triggered_buffer_setup() instead of
iio_triggered_buffer_setup(). This removes the need for manual cleanup in
both probe and remove callbacks, simplifying resource management.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/accel/bma180.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 7bc6761f5135..429d5a5c7672 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1004,7 +1004,7 @@ static int bma180_probe(struct i2c_client *client)
		indio_dev->trig = iio_trigger_get(data->trig);
	}

-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
			bma180_trigger_handler, NULL);
	if (ret < 0) {
		dev_err(dev, "unable to setup iio triggered buffer\n");
@@ -1014,13 +1014,11 @@ static int bma180_probe(struct i2c_client *client)
	ret = iio_device_register(indio_dev);
	if (ret < 0) {
		dev_err(dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_trigger_unregister;
	}

	return 0;

-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
	if (data->trig)
		iio_trigger_unregister(data->trig);
@@ -1041,7 +1039,6 @@ static void bma180_remove(struct i2c_client *client)
	struct bma180_data *data = iio_priv(indio_dev);

	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
	if (data->trig) {
		iio_trigger_unregister(data->trig);
		iio_trigger_free(data->trig);
--
2.53.0
