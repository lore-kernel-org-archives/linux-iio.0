Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FA313546
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405349; cv=none; b=cVzJITpnUe5qRrV+n+QEeCuFtmxpbhgrD8Wc39YHw4sIrwx27+s0FaDK5DPGhoAewQ2YVBSz4jj8tVM7xz++XvanlGM3tWJweRhVK2y2F18WsCrwxYZu+KcBKScbEqLU0rRtjo7fmT6n0O0clcSrzE2xhIHliAvFtwZwNm/iw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405349; c=relaxed/simple;
	bh=v9TErxDPpsIRkhNKYWP4xtO27wbtpwBXPJW0u87VpDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYEkw0ZiYjvucxphdjpe1565lTya3poqbmI2Nz2ej2+Xrqk3yhAHPyFkWRI+aN1zqKoevRbNFtaRuOnwrJ7DWVqt8orAMda0KHujVGqQsYsVPzbwqX9da1VN94fDr7/CnJaz2rYeKfu6UQUJr3Slv2jk17G6XOX+DHAHcAHu6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQGPfP7V; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQGPfP7V"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c280322e0so385894866b.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405341; x=1776010141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VovxD7yoVP0rJaxD5qPxYVv5hPsMXk0JFRDMJJBecv8=;
        b=rQGPfP7V6c+fdv4j56Gkks+qoqdpMkBuy76G0AcAqDPCUqsgg8QCisK21BSvdJfJCn
         IRVA9dDjhF/oIj2Ewys15AngS83YQmv8pUMrUxvFEoWxZoxTNhcoZDkQs1lK+s5kutjQ
         2tPgqQnYJr7GNE4uJlYhUs57Aideqb8gIlnA31UEGkTOckBaWIHX26BAyEt8Y518G5pl
         XWBNbFuWdAgUROShYgUPs/d+q3Y0vAkD902YGE2XV9TqGKvD9B0YDozxUG6ptIoTPvf+
         JIz6kOCmrqV1gluPefy2fBiyRxm8m2w5f86L9xvOwnSuIBBU7xHrVxLoLvUbWJiY84Cv
         li1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405341; x=1776010141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VovxD7yoVP0rJaxD5qPxYVv5hPsMXk0JFRDMJJBecv8=;
        b=Wwb/4EiC9FuCV4OydKoECm3gy33izzfy7KhNJHOmCe//q0hhQNLkaFD73G69Zoqgmm
         nY5mPcUwj0YpuPN4f6gtsMQXRYhVPkrVemBPVncY0Eu7DqrpqzTcTMjRgMQvdVtsGtjp
         M8MXQjrTuLlh7yextFTrf30ILBFJzt/f0l4lo2VZrMFKgPglCEwMppX0PiQMFkTLHrPC
         Uf2zPTihbReX7D4+8JfDfs/qlhNfb8QOnNmesa2iB4i/uPtbQJhLXkh0tFkXp7oIILfT
         vcuN/loE2h4j4OT7TPriT7F4hBoMeNvdnfQ20C2uPSbNK2ab77ynuopdSk6cBjv4neME
         egTg==
X-Gm-Message-State: AOJu0Ywdnpt3CGBun8Klofj734DuEN/CcdFtAw40RE1pIiQn15UouriC
	cYxdkwbQM25/orYD7Yt5ngb2/XAC+Crwg2DdndFM50nf9+EO2SJud/AEvnMMRSBc
X-Gm-Gg: AeBDietSkW+9IO7UoB2YoGVwk8JYfB8zwM8K3wqLK62IMUtnRRImv+P5I2v/XjzLol5
	029rjTo/nmJBChvpvIwMnFv0oicDakvH9ZKxdYXCoahtyOGaAgmXfcWjSUedFHq51aPT63kFz/5
	3HWqDtvF6u+9zAg/bYXekzEdOX+UgYDEgPDYkG3Fdx66hvVhlB70et2p7worxKRNz736ojSOZ6R
	hU+r72YFGaDthX64kfMS+s78oYaBXxJBjW3OhrkOyviq3yz2Kg/efquQvi+yqnyCtcZHRNT9ZuE
	wv1f8oO3o8Hrs5JiNnnNmGi+AgDGHMfLI9OHnRF9zXDTEpoUCQ9GpycIDqurQts0rLaZ93Ss0B/
	yZTgRIXh2mmqPKVYVu4+BiNA2BD6Bt2O55g3bSiuIdPDvraE92ltt8GGumgx+TZ5zeyvRklqq1S
	m43jt3oTfHR02TMXoVjHgxc4SjMg==
X-Received: by 2002:a17:907:3e0d:b0:b9c:7f55:cc6d with SMTP id a640c23a62f3a-b9c7f55cf7bmr327776766b.46.1775405341075;
        Sun, 05 Apr 2026 09:09:01 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:09:00 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:43 +0300
Subject: [PATCH v2 6/6] iio: light: vcnl4000: register an IIO device with a
 device-managed function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-6-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Use a device-managed counterpart of iio_device_register() and remove the
redundant iio_device_unregister() call in driver remove function,
allowing us to remove vcnl4000_remove() function altogether.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 556dc9afa82c..0813639b5ac1 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2062,11 +2062,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
@@ -2082,13 +2078,6 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
 
-static void vcnl4000_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-}
-
 static int vcnl4000_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -2128,7 +2117,6 @@ static struct i2c_driver vcnl4000_driver = {
 	},
 	.probe = vcnl4000_probe,
 	.id_table = vcnl4000_id,
-	.remove	= vcnl4000_remove,
 };
 
 module_i2c_driver(vcnl4000_driver);

-- 
2.53.0

