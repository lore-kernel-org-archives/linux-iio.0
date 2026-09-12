Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24847D449
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219573; cv=none; b=ZrnOHZBjdQf0IbH6xAxaGog8jeKFNKqoZMyXhXL4pu+pOEGA1LXHaJy3Y0vddGmRWNcMQN9QjHLthGxeIN12BOdaCyOE8mrmYOh1ICMbA9pR6fcOM8MPOz7epp7LPfWYHsijA75OEE769cNEb6kU+uUJ8dhRDlXeWIFvFZzBd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219573; c=relaxed/simple;
	bh=7CE8YwlilBd1VM+J4eCukboYD8vi5XXt1Ru2qxPspMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cglg0Vja7kVhaVvZJPPhYwGg74XGVKz+9CUS4FOUI+skXp17+F0pqhiG8+r1BaYTN4w+WSj2RuJGAZAm/EM/Q3ABQmqYbvqtaea9E+GespRoYX8qy2kpFfixqPWEzzbe9l4FpmWNcR41OCGvkA3SPbvjmRM+sSUnTJNTaNzIS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsSPNRXH; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsSPNRXH"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so583286f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219569; x=1789824369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gF6cpu2FDuNRXYtVifufQ0jbLZ5i7EeoWxGFjWtrGA4=;
        b=QsSPNRXHO3sNcUQcvzjcsDydz/thwet6ipyU+WsKG9HetIrkV1U+5XXooO5xyRSl+G
         6H5WJG65U39D84va9vfQ7BvzDkLft3gvSQLGE6yqzk0R096L7s1xWcFmKEUYkKS+7ySM
         fhfnknkzC0+ZU3bka8d4cI7m9De9YA8m1iSYcNjlW+xf+95+4wB5tuT4Lyebw+E6CwEg
         W2Ru7o7tVVH0hOlRh2C4QD/cvamqWZGqwj95EItZjW739xlL1Em+6Zzx1KJbxhLs7HwI
         lsgLXZUc5ggpdmJ5sQz/AtAhg1lGOExmw9rduRa5eEwhv9CFrSvl9CPuU3TJrQlfB06t
         tiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219569; x=1789824369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gF6cpu2FDuNRXYtVifufQ0jbLZ5i7EeoWxGFjWtrGA4=;
        b=nhqvXgSWYRAhDLJceBj6DudRMFI1vGYEPFuMIDfE55KA1jE7rhqIUMJQQHBWJN0b46
         qCPixc2h12ghUuut27c3lcHG1JZB81HI1mG4e+XIGUmGF63oc7A/ATtWIgxNLuLhY1Ix
         8NOqvVIeRWLdW9RDQbTxRCw/5J0hwKWbVdMLyUQPZIlk6pXjDh2KmnrsB8VmXO40VHCq
         2umkwLrlGOy8zdqwAGiTYX1jD0MtFfvnxsVdGFvtwbqIhoIACb6oJ7V/FfExdVyAe/7A
         jhzXrxk5WfF5liP3dcukx3T/obMn++HPaDslGKeRayqhfbAMjAV9MRUItTqfs85LTvVY
         YLJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtvl5nVaoIeFIQBouqcES+TUqoI+AWmvDY9D3Vknpdm7/0mU+b/GKu8xWoLpvFYUZF5r4+sXoZ3LY=@vger.kernel.org
X-Gm-Message-State: AFuF++m5z692DIVic6fn9Pil9WX+nHxIjrRKYpJwuoKR/9PR1aRrfc8u
	5bByWtGjRkiPi4KhtuMWyMjgtPpHAbk9etu4+OGdn3iscFlbFx3diJw0
X-Gm-Gg: AYBFou3auJ4ki6BJ4cioTv9VSXUVyGUYS0p0I6hGSPhAkNkVV0lzDuSvxYcE0ufHLFM
	FYiNJPRgtJAHFs7lBQIyyQFxIoYNNpSPS5dqcnoIlvQv4a5WQ6JwkkDQsnOnybs1IuzmQyfF/4k
	zGhJA9UujCdPIn5KeVBsz6kR23oG5hU9/d5L7BtgCZb0YxhtpvvNnHXSFLPldXjoBciVsXu2XiG
	OhXMJaIiWyV4XLV5mvy0LpMoETVmTL7FxzsOQcG2pT1SQh9pASjO3XHJ1sfIeZTnHLeeUsYoXOb
	d+tPiSDtGyQ7rMQM2eeDFfsYkg5Tqsu9Aq8TK8zy1VNGCnLvlYDf4PQ0ObXWI2kVvaOUYjxQ/uu
	RWZ3iBRsuIMfkTHh9PbjyAgF/oHD4NF2W6JxwoloR4TCAQbgqWRFxGQiA5nsSDtVyFvcySE4tYB
	wZntIrAYA/I1eAmu4Lk4mGY0vyrkDyclZfM/a/Gv7om14QVKjsUX43naZYqS+Ton67kPUipI4jv
	bKb7TDyg0/QwOKT8aUturlDSoKr
X-Received: by 2002:adf:f9d2:0:b0:486:e6a2:2d7c with SMTP id ffacd0b85a97d-486eb31b1ccmr15058844f8f.15.1789219568859;
        Sat, 12 Sep 2026 06:26:08 -0700 (PDT)
Received: from fedora ([154.182.88.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm12684503f8f.15.2026.09.12.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:26:08 -0700 (PDT)
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
Subject: [PATCH v6 3/3] staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read
Date: Sat, 12 Sep 2026 16:25:17 +0300
Message-ID: <20260912132517.55686-4-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stack buffers are unsafe for DMA with VMAP_STACK enabled because
they are not physically contiguous and can share cache lines. This
causes data corruption.

Fix this by using a dedicated rx_buf aligned with IIO_DMA_MINALIGN
in the device state structure to ensure cache coherency. This also
corrects the size argument in spi_read() to match the new buffer.

Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index acf26c5a267a..2fd2d6796603 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -53,6 +53,7 @@ struct ad7816_chip_info {
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
 	struct mutex lock; /* protect device state during SPI transfers */
+	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
 };
 
 enum ad7816_type {
@@ -68,7 +69,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
-	__be16 buf;
 
 	guard(mutex)(&chip->lock);
 
@@ -96,13 +96,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(*data));
+	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		return ret;
 	}
 
-	*data = be16_to_cpu(buf);
+	*data = be16_to_cpu(chip->rx_buf);
 
 	return ret;
 }
-- 
2.54.0

