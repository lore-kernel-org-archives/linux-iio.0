Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323E3BFACC
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764650; cv=none; b=LgA/OGNr/VlFG70wJEqt8rJVW94MnpfhgWOUeoZaBoRDHSn5XJaxlSFPx4lnQYJaufLmqcPd3vnntIXbZgcebUOVFc0ozBsT45EOY8M+eI78W7qY/eEr0/hqsdLNRRcNAVw5F/iahhw9d1bewGHpwMlpw82DTcDisAsEmWO7odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764650; c=relaxed/simple;
	bh=YM8dfmlqxShxjvZGqRGiSNpTyF4I8DQHGxMXfAniN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/HkW6tAi/ZfupNB4b8TLnSxzzsa0a2I5ZldOQiro7cuVaANgTmtQIuVF0Mqx3MhxEKadonqtCGCE+NTH1dbE/qqU4Ti88yqDz1HYn9trr4Yy7+9Vp0Rx7nUxJIs9TV+aNaBlMh/Kr6eXssW4mTs0frYonLDdwn3IWR7HwgCGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k63liqe2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k63liqe2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fdb6f7d72so723005f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764645; x=1786369445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDNUtFHnwjFHImwGnadLZYX2nGq1XShrI3jQKtCkmMY=;
        b=k63liqe26Fl8IPI3al0/6RKdWIV3N+CUBv5PvQQ1u8xlHB5hFfnW02YYzaQS6yX0v1
         F7sQbslg0bM7DPqAaVedo3cKXtAf+trRfJz7xOfvb3ww731k77R794XbLoZedyaZ5vzt
         Lfi3tfM2PyZ6BzrClhYe4FbfhMa17pZWoFy7Vz4ENpi+PNUsnTvq1ah8cazYICd61zQD
         oN4q5dAeLH7pCdtvILvqY4t0oTMuFWIev2Dt9QmDnso1mwKyw9EmEO/I0ODsmlmovHtC
         pn5mPm0YK2s0+b2kquLA2EDhGesfgghh4+bzvkMqUi/UgLP33Jvtvuz3e2grp2eeFtIe
         Xj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764645; x=1786369445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDNUtFHnwjFHImwGnadLZYX2nGq1XShrI3jQKtCkmMY=;
        b=n88Bp3kFP1PG0mDNeoWFiSaGnxGssyfjMhI7XI2M0H55d7maYFBbK18sQEPT6/HFtH
         5TzYl1mZMphJa5zS4sPSyas8Sis3HRRnR45uc3IxZuihSHCm0Vbo29Pnnt6R7ECPXtBt
         FtYz3RfovjTsozpJH94Og1uqul+Ml8KJ1fcyzHaOYeNfAsrO8JRZlm8+Yz+55ImSzRbi
         JF/kz8fvJse8F6kXGt8Z2o2hpfBmsgdZ/fBIxsU4qpGa6BAqqeOcLH18AT1Zg6QwkxCt
         /IXTPpUMnh2WN9dAUKB7WhqdLkKMxyWlivj/PSMZMWwz+n/61aUieVqZOQK3ukYkDqfH
         JChA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2DqV3/qz8x8XDzcBO9PpTVNfBW+ay6C3mxO59z/7Yla2E8feyZq3p10Y44ZpXhPEU7DmirmInpJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZB5064Ih3Dt0VPG5ATH0JS9xXJeVV2LtFP2Ni/5NBu5KqBXk
	oOuvyx4XEyawQRvcSW8kFB/1lPxiryilkmrysm9rEY0P65Ip4iIgZlwO
X-Gm-Gg: AR+sD12O6PjGTgN0i2pa27ld7I2WA4tR5Zn84Pgw1aRWadvbbkyQzrYUKeFczX1vXtM
	pogltNDFovHAU/YolMZIxJu9wMPGBZ8q/g/TAlBFb0kzHufVxuHqZLsdEY83LouVjxg/vUHUyP/
	u/rF+0FZWEjwYnoIDNqokddsUsviLVAU2iCcM32AVhxh6QspYYzwUp4ha40LpAAg6NHoeTKsLdn
	v39vdyVIFPqVYlyJghdMbyOVYV/6cxnPNPhSQYyYTWwgZihuFYxOTiALqQBtfl0i01fS2e16fVX
	ZcyK4x8OXKIeB0EAeBbKFka/GuMX+85rwT06xa5e+chH3AOrIZ39czY6NxKRBZN0bTAJQRZdlqm
	TD+tTRFIAWf2ZP7S/AerLRzsri9/egrrO6imNUVzNRpQb0Vu8QdbfYJjI9vxNFvuiNrqRxMEadi
	9/LqnuTGGY6RzdfioQSNtuAJ2lH6uypLaWGjycIqSa48JNx+xE3cgaXSwt4kTjztXwZWnT3Hh8P
	TsGZrWYSw==
X-Received: by 2002:a05:6000:2087:b0:47d:ea8a:d211 with SMTP id ffacd0b85a97d-47fd9f93ed8mr23273896f8f.29.1785764645563;
        Mon, 03 Aug 2026 06:44:05 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm34328908f8f.0.2026.08.03.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:44:05 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3 1/2] staging: iio: ad7816: serialize ad7816_spi_read() with a mutex
Date: Mon,  3 Aug 2026 16:43:44 +0300
Message-ID: <20260803134346.6733-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
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

