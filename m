Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAD3F8805
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042677; cv=none; b=JbCOtJLEsmsL7wrkqpEfP3xM7hSk7nepnclv5X/si/CYnH97Moc5r/Fv1YNwQAIvxEeB05mVWJeJLwlm2g0rmeRTLtQpavt52FtcgC5LqjWkBrQ6u3SH3oHhU7PJI38m8Sv8jLgMed5FGNuQ+t4glEiinE8/lrK8lqg7Qax0mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042677; c=relaxed/simple;
	bh=DCwQWaryllpQ35h6aXgQVuYEVeoi0YU18dXkg7HwF90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMAiw9zxHULaw7e2C2BD0hEqG0oDnb2IUE46AzJ2dDrqnTbb8uqvJqjRfmX5G9mPyE3QuegrgtO5vRGjAIXQI1/SkCkbxu74yueaih2PRftOpCf7Mpb/9TCR4FdrcwmodqY3Bisn4TGrJEnjzcrKcvWheIreSKOSdPf/Gf5DU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjdSZbqG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjdSZbqG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fb14227cso89672705e9.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775042675; x=1775647475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spMqMvC+vqOgCsB+Pnf3A9bt/ejBlLn3vXgY9ADZL+U=;
        b=SjdSZbqGtaPWmNhzk2L256g2deAtn4PEnylMn0UbBZw30ShMxo/fFSx5HkEQEOl9FQ
         4J+fYCGAKKzHSPX+5G9lPle6g2bwYF44+sVTqEgm/E0flkGJP1shHAuFiFkSrM/vdR5D
         hRQefW3OEktTuhPrNp82IOvJ1yjORf08UysbwjpukqK+5AuAznSCAYUGUM9NDuPGIyts
         mvknzSKlxcFH5YRVaSQKKne0CxfrjpznxKolunG8tlsV5GDBxcZ6ZAKg+935U6XYtrYv
         woR3+guCKFGC8jvKrMTezC4JP5CyW+LGiHmFYGR/QK/IF/PHfnIBJAij8NmFyc4LB9Rf
         8ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042675; x=1775647475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spMqMvC+vqOgCsB+Pnf3A9bt/ejBlLn3vXgY9ADZL+U=;
        b=nVV778n6rkNBrSx+HE+SnZWouQW4fGMWIkAxLzzS23KOrHmkLw38FF/fItswUMBKFl
         jvQSdrJSuk1EKouIY8FSCpAyCaqDAAxvm3CiFimy7rvQifjkXWevNfJq4DPRY5p/gku+
         M68nH1eSX+GJPLhcmxzPkshiXN4QRIYHpwjKeoVu3iXSoZfamTxw/po85L6uOb8LPOyK
         wyHIBosPLRA1sVy0ctkadk+TWRW/uq9EDm+Pp7AGr6sKD8pp30IoiTQ8bwUz/0P6Z2Dg
         gV9KBtqT5/SQEuwyrOUnZEDFgmLXN83k85M/5PgJtoN2+Y3OeqjjOyiqiWKAplBGxrn5
         Ivkg==
X-Gm-Message-State: AOJu0Yz1sj5MZ8i15yCV88DTqvaWquRusqcCePUj47oHR1TPgqcFZPaP
	DxGXIpbiYQRhtgcdgzuF/qaJ+lEQfinqcr0PhsZwyG0XcH6USHp8J/Ua
X-Gm-Gg: ATEYQzwJ827tMs+3aexPfDVpWpn+MrP7fceGQsFmc3qEzYr7wnlL8UacrexPQmJqGDl
	jmsu4UDkF1kSrPbp6IFIhQcpq5A1yls9VP3Flh71wXuPqO0DpYIsd9tRPpGYRx3EZGBAN/NfihU
	LbP6PI/uZrRR0gTm8ZskZhDJ9RxOHcG4hIWgr7GZMhiQP8zIZbTFJT8eMbY1UJ2q3uoZCha4Axe
	wd5PuQQweZh8PZWnOK5j9a8P+bgE64ruscmN3srLx96zj2fcPJIR5YcelTso+50FfQndc6l+NcK
	RzJHFEmb4WBPs0MplDIQngZ9mEYXPbHMgQFwqqTibeYcfKBN/PJeCE6CSz+9dW8VIYs2QuJSg0s
	2cGc8snEb/OQAc/LdeAY54dYNITz5k2njTA6ZuCjYB/eq2UTZ84yCjoJevbJ8ggsyjppHBVEilG
	62Dx02aAaZcjWsDvCrE3xMIA==
X-Received: by 2002:a05:600c:4744:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-48883569e74mr50033785e9.1.1775042674749;
        Wed, 01 Apr 2026 04:24:34 -0700 (PDT)
Received: from [127.0.0.1] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb99csm43450165e9.1.2026.04.01.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:24:34 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Wed, 01 Apr 2026 14:22:38 +0300
Subject: [PATCH 3/3] iio: light: vcnl4000: register an IIO device with a
 device-managed function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-vcnl4000-drop-enum-v1-3-ffd201f0c848@gmail.com>
References: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
In-Reply-To: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Use a device-managed counterpart of iio_device_register() and remove the
redundant iio_device_unregister() call in driver remove function.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cbe0a9e056ec..4ba91dac1f55 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2043,7 +2043,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto fail_poweroff;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0)
 		goto fail_poweroff;
 
@@ -2099,7 +2099,6 @@ static void vcnl4000_remove(struct i2c_client *client)
 
 	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
-	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
 
 	ret = data->chip_spec->set_power_state(data, false);

-- 
2.52.0

