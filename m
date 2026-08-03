Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D58403156
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759362; cv=none; b=i78IpkP2Sf+1fvEyRR1RQCwdkpo1nGmVICwRlD74AY2uk59Y5EQDg8XZzBmMtL3mBXnK7ilHsdVG42UpP5C8ipHqNXcdL3o5W1gLLunjHrlwhqV4oBp1aXql5CG+ilsJWiQiQf43/Q32Db+q96Y9zFlj6kd7eIoxeOmb26VxEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759362; c=relaxed/simple;
	bh=YM8dfmlqxShxjvZGqRGiSNpTyF4I8DQHGxMXfAniN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1r51MMPEfYt4cBLwIi2IVgkxuMh+BRGZifJwp671Eo3aMm9X2OFY44pIGA+jIkeDe31z9wYNEwpmInIZTe+upYNMo9bv+Qcm1f0QgMfHcbY84WEyv+zFbXtnxj26t/vsInOcrd+Xje2Lf9RMI7XBHbVEhM7Sac2kHfk/WwpYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS6978ZK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS6978ZK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso5843602a12.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759358; x=1786364158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDNUtFHnwjFHImwGnadLZYX2nGq1XShrI3jQKtCkmMY=;
        b=JS6978ZKztqR1vfVlEFeKvPCkbf1NMAN4/jSAUX0KpSh2U9v3aSJ2s5VfrcrzWjCUI
         ybIznLiZ4EnQ4lic8tnm0EOJB611cIvELsYGp/8RdZsw10cUqS0vbeJFUY18vwzNddgU
         vrDn4j4cqe3MFaxHijRor8v+gSP9vFWMGwo+T+bG1jxS7YlYA2OI+up1W+PqCDC+drQb
         28yNsOgBGgsAhOGvxoIbEAzJ82iM3mXNWyeJ0JLIQ69T+wTThVm2dvGn7eH5TuGLm7z9
         lo1Rp8USPCZbxWg+FTqZKGDZKbPvIw1D5G5SeaxRhQaJjKoqRG3S4mZQE6PfTXxqdUgj
         2ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759358; x=1786364158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDNUtFHnwjFHImwGnadLZYX2nGq1XShrI3jQKtCkmMY=;
        b=YT7+nztNt2qfYatK/+MyQIPtqIf3xr+y+A61F75dl14zHpPP39J59QOg0cI3ZEdI7Y
         fNUmsPfH9yl0sqINl1GJOHi2mK4wN2SrsrX1IJOU2SWiR3WRJRyWJWiy2dTKT2NNKYO1
         mHQbISQqes3SOCukkJ+5GMJ4X4BsmhJgmgxOOQvshhouUKIobPEuby3DYoL/nNOiS+OY
         r9yo1YUyIACPSDBLvWmDMImHC+2/KcBO/I04q+pfjQK7WRL3Y17Un8WGabrV2vGwzhLL
         iT+fF40lntSkKuten+oJ4n78VsCZMZEA6URDXTSTMhLIBUdNyy46OjNMS5wwlKvW6Fy4
         Usxw==
X-Forwarded-Encrypted: i=1; AHgh+Rovb+YR3p5igtNrTvPn0fBAzoY7Qdrvl/5r5Ze9wqKHO4qVi+HZlo1ythHYSEmhuRnlTVmrYIMCJFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztP9ilXXRq0RueEmk71FISkotk9LoX2vQGfw9B0eUoIz59nZuA
	0i/L70Sg/iLHyqDtinDzgIlFhikTrxOOBWYTO8REYJp+ERYX6sJZxePub6gl5g==
X-Gm-Gg: AR+sD13YwohSincKkCpXP7bhxLPoIyX9HqVsyZTQnkTK2CPFXxcgvy1AjJOvWff1EAq
	qLExeOmhhGAyE+JlUqujI+9+1jm/XPpSa8VDQHdxXJeATO9EmqT885mJdmOHm+dnMnVAYC4M8/f
	xWwE5t94VZ8XSJJyiyrgyXDrw8c4pHeFEQjLBdN0NbwJsZabf33KBmIIFrZxgK7xliwutG7sOZ1
	2r4zTtvlEYX52o6JBgXyHLZfewNyqLBpNTQP/B6q5/u13TWe5a1S0WSUUSB32yaC5qWnoMLwa43
	ikyioVV5kTYjwZKx7U0aUXHKCtSlwP0/xJD5xXYmyG4zQm1QHGuooV3J2idW7sk5VFy/XwvIm0O
	mGRO5UmvtHauHEIzfbqD+M+N7jCu4hamJvTPKAxmRPzzH96j0YFI4VWrc3tACD+U2admrCnnboI
	4KZx/4yLBHOqnKUrm4I0PLttzukpxAkehmR2WvDf6JmmQcD0c0LItOUWK74TY/dOnwEJt/JULb5
	8XUVJAlHg==
X-Received: by 2002:a05:6402:569b:b0:695:4916:b97c with SMTP id 4fb4d7f45d1cf-6a09ae1328dmr6235483a12.8.1785759357696;
        Mon, 03 Aug 2026 05:15:57 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c655626sm6175963a12.22.2026.08.03.05.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:15:57 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 1/2] staging: iio: ad7816: serialize ad7816_spi_read() with a mutex
Date: Mon,  3 Aug 2026 15:15:19 +0300
Message-ID: <20260803121520.6274-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
 <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816_spi_read() path performs a sequence of SPI transfers and GPIO
state changes that must not be interleaved with another read operation.

Without serialization, concurrent callers can interfere with each other,
leading to inconsistent device state and incorrect data being returned.

Add a mutex to struct ad7816_chip_info and hold it across the entire read
sequence to ensure exclusive access to the device.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..b5a0c2871e00 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -50,6 +50,7 @@ struct ad7816_chip_info {
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
+	struct mutex lock; /* protect device state during SPI transfers */
 };
 
 enum ad7816_type {
@@ -67,11 +68,14 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret;
 	__be16 buf;
 
+	mutex_lock(&chip->lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI channel setting error\n");
+		mutex_unlock(&chip->lock);
 		return ret;
 	}
 	gpiod_set_value(chip->rdwr_pin, 1);
@@ -94,11 +98,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	ret = spi_read(spi_dev, &buf, sizeof(*data));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
+		mutex_unlock(&chip->lock);
+
 		return ret;
 	}
 
 	*data = be16_to_cpu(buf);
-
+	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -359,7 +365,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (!indio_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
-
+	mutex_init(&chip->lock);
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-- 
2.54.0

