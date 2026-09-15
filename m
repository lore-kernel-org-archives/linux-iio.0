Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A639A062
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459238; cv=none; b=PsnxIOVu4YxLvtYlU41nS/4rdrZriZC4dTtzVrYy2itQnWEO1HKjVlODCNgAe0Ea1KerDRPCAIpZpcO7VY85zVk0HoDjg2RsLhlyH3U4iCfpBhWgmQkyX2dG51Y0zXcmT/Be4AU9W17OzIZ3dQMt9Ea0Dj18CaumEjhj5mzmY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459238; c=relaxed/simple;
	bh=KTgZMvg4dulJZHvYNEIoy011mnzTSGSayGEdve6hAJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr5tbdfIrKE4qrOwnqVhAH3hXt3bXKFFTDPEJbG9I2sUaXQ9lHl69pdaklBu+JtLbXXtZSbQGmx9aJFbKtC0gLOZmaT2r33ZtIcm8CE8Ld59bsE8ypNy59fhkXhSYK19Kzt5y4Lsx14iBWL/OI190f1Wl3e0ifrwJL8ODNexcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JriyahEV; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JriyahEV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so12064865e9.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459235; x=1790064035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xfw0WXqsQI2eC5dBxcA9xLNGEmKqYt2MXCmmX8Bocyo=;
        b=JriyahEVpvTNIUd8dxGwWAYMl9p1779MrkC+C3b84PTvy6gEu0x+QfabI6tTdUSudC
         2YVRg4q3rB/0S9AgXsxcl+tZ2hnCNzCkRvUcvM24PtVv0tdG+uG8W+9b8HV3ok8jCUJn
         mh8jcvFFSIxVRr+DLp1nWu0rp2Ld0/ecU3n7mMMG3L4VZXm8Xv31t83xP9sptb0+dCW9
         cxb8EjSS842a+soqravQNOAOlTwUvVm50RYXwetCg4eEU5wVHy5cWSeJ1mz/CpTQam89
         ds5Shp2hDdnNRsZnEDiNhctaXOTDzSQ1My3KL20NQaI7UYFXeo3WLsz9MUZGKV4QQW2e
         gcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459235; x=1790064035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xfw0WXqsQI2eC5dBxcA9xLNGEmKqYt2MXCmmX8Bocyo=;
        b=GSF6onkjo0szR93Aoav223YxMo1jbBbdf57ricY6WEfJgkt4IEYzwcVJp/4xt/y3nx
         qnBnfP/Bj3EHcgoe8U9jpAz/TICr9wpyhc6jgNJJKEUsTGyOrXjr58+615IKV72nZa+4
         mFLs4xDUlNqc7HcZdQmnghjTLaHGvwTseb7bcLfGhYY3+A++uy7Ei1nyKSComEM6qTT9
         aG3/OAhmFUQaCWA3C+3H/uhRS6ncbkBABWDC9IL8rzugK3E3GWA2wnFjjK+vx7X9e6Us
         HRh2PNXBHCqbfglXp+tOKcn79ZO8HUnVX7dbU1corb4LMMg+lykNZhEoax0+aXtW1gVR
         rbCw==
X-Forwarded-Encrypted: i=1; AKwUvBzcc5gpaTbkkJnVKMjnckM8ur92TICsSqc1/xpHU4lYhVstkCkycS9+LBZS0iVVAV3x9dOMVfOzRRE=@vger.kernel.org
X-Gm-Message-State: AFuF++lMJlgftfHzg8SjBb1zKZToSfSRmVnKwB0FPHdMP1rLbECyi/Wp
	ydaWEMmA/w5SOBTQtDJeFZkX/V3yT77ygDZVyc9SnRSFd3yM4fSRk3ZJ
X-Gm-Gg: AYBFou2CD1+nkK1zbXao90DOkNz00MJmMCoXJYhkVx3Nj03Mv1ZTNbomO4hl3C//J0h
	HZtNtG3laWWANph6lZ5OWKw58638IDmzGVBFTbx7SEqxM30ns0i2qctq1Y9fy0ovgHEoYM2ejx7
	FFHLXxcU25HSOhpQGysClf/d7ll5WvlAJHtYWL0GJGuIn7cFkJnxjtxy1YB/mP15MLVYmNZoEh8
	I/a9Bccv/UQMCDfJbUajfUTaPYq6Mnyy+jAPLri+EonH3DFrwPnQrwa3h054R9vWmK04za5sEQj
	o2NL+m3NdS7acrZ+NzGThTXK1eeLKb7keoozbY/SGp7BAE3HDZhsIbONPB+ieUBM8U0ui1oD7ON
	g76a1lFEq3baweMG3vTagckhSfO/amK9wqywYW7zu87uEM4a/hqS4ZzfHptsju0MFAL4P/qICeI
	IABeOUpVX2qaFCgqo+Xv+fV6Uea23uOw4f0h8UgHOVwnLhgRGWjkZQ2TXq7vTM5XkbfGl47bkJf
	ieVRTCmTsDCbpC4hYA=
X-Received: by 2002:a05:600c:c8a:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49e7a6386d4mr71308795e9.2.1789459230005;
        Tue, 15 Sep 2026 01:00:30 -0700 (PDT)
Received: from fedora ([154.182.99.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6bf4desm64112155e9.15.2026.09.15.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:00:29 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v7 3/3] staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers
Date: Tue, 15 Sep 2026 10:59:39 +0300
Message-ID: <20260915075939.18180-4-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI operations in this driver are not DMA safe:
1. spi_read() uses a stack-allocated buffer.
2. spi_write() in ad7816_spi_read() uses a struct member that shares a
   cacheline with other variables.
3. spi_write() in ad7816_spi_write() passes a stack parameter by
   reference.

Fix these violations by replacing all spi_read() and spi_write() calls
with spi_write_then_read(). This safely handles DMA by internally
allocating a bounce buffer for the transfers, avoiding cacheline
sharing issues without needing dedicated aligned buffers.
This implicitly corrects the size argument in read to sizeof(buf).

Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index c18093ca8a82..f76f0215119a 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -74,7 +74,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
-	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
+	ret = spi_write_then_read(spi_dev, &chip->channel_id, sizeof(chip->channel_id), NULL, 0);
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI channel setting error\n");
 		return ret;
@@ -96,7 +96,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(*data));
+	ret = spi_write_then_read(spi_dev, NULL, 0, &buf, sizeof(buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		return ret;
@@ -116,7 +116,7 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
-	ret = spi_write(spi_dev, &data, sizeof(data));
+	ret = spi_write_then_read(spi_dev, &data, sizeof(data), NULL, 0);
 	if (ret < 0)
 		dev_err(&spi_dev->dev, "SPI oti data write error\n");
 
-- 
2.54.0

