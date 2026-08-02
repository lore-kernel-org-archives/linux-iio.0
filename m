Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D3AD506
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670768; cv=none; b=l9c7GVfS1Oh0H/wHVIo1ZRZwGQyzS3D3XNFK0fkTDLUL8qGDt7QsymUOdfX4/Jms0j9C5/8N9LqveL9bbT18BxzCUwanPT0Tdm2iWvv85Jibgev866vfcnxF/zUAd6tEbnBTjz+p4w4c7MbPUecTSJmD6kSBJ+XirybXFEvJHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670768; c=relaxed/simple;
	bh=T4R1HNsXMnCpyaFzZ4pXogBKQizbRCcSIqBkfGB4Lac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPwZ2K0czMZldJh6t4ChbjECyShbspzfxdF61iJwvP3Jh3A7XV0OLxcWRdJjj8xmMzeU6KCLv238YfHqFFyDJ+YxRmGG6Qm2D4t6iWHzvnFfbeMvxGDcPPPV6RaalNShvn9iTO7T0fS9xGEElO49aG2Oc6FtEGMcHUQ1mXHeROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCnNHWGt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCnNHWGt"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1f5208b38dso446383166b.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785670758; x=1786275558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7ecKSNcW7KFUMBHUns97kjKTa+UXCrK+tcT7T4tgGY=;
        b=iCnNHWGtrSdYWoEBdOmDjNBUEJOgfbbjVDv8uSrwaiqopZYE4g5MuVVY6cg9dsd09O
         GTKmA+dcxt7LtOnYj80xdf7FRcWk5CfxmOFYbxm9I1vCQHOy49tUQSvGnQumDqxmrmih
         R7R6G1y/foJvOc8xkccJTr4+VE4XPZT6Y/Q3F4xAKplZPrvFuQSpK0Z+Qt5vMfVTlSIc
         bMFvcLrbUUAYKm/jQjbGV1pjr0tB23e7FNKN5kOHxRU4GjmD5IJUxTrqrQG6JI0oQz7H
         al/5MU8V0SdZI5OLbU+YooroFaH7XMm07GXKCAUEy6faJRY8pi8SnmHhwbA7DkWb7RRA
         zC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785670758; x=1786275558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7ecKSNcW7KFUMBHUns97kjKTa+UXCrK+tcT7T4tgGY=;
        b=cmd8PuQY0WKCMUW9dNb2rx7TW25O32ErFJtMdCF1AAcM9rrOD+nqieVpzoa+qlet0H
         KhmIrRneya/f3b4T1jsiX9lk3LNjabBdE/4nTS1GHUi8MPe9EAxGrhagHI12+CoSQMu0
         MfnSLvND4m7TW61dMrqW9/ZhqGQQ3sq4/zfx8jnZVI3LnaTWcmP4MawuubDZicMdhqj0
         BEpEt2eZLrw8lkzdsbviGwlvv7ZpWbkv1JnJZPKiSQuecRtHEsn3IRiwkDpnJ1HscFdN
         Lw/qvoYnxVsgvfMeb8Ylzyb3ekvv8xWvO6sJ1ozBKuu8W93uWlfUfqxPY3sSL7Im/HFA
         SuCw==
X-Forwarded-Encrypted: i=1; AHgh+RqeagjV6FkH1hcIJ4XGDl6IKNhStr9oXGMLSOwyn6JuipTfdznu83gThw8lBMoZHTfRN7FYNY50RrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitwGvaBU39WSrjjvHPy+BgEvVaS6g396oRiPtDSlkKwn5GWXJ
	A18XNlJOTU245mF537UIKcIKZleNWWdWKZ/M0lOkW56xUee4x5qLxi5I
X-Gm-Gg: AR+sD13SNCjvpTwG3/OqeLf2oIGA/JMfg9bZOIMA8a7BhE2HGkmzxINInggInZN5mLp
	KBp0i+WgVcoI3C222LfmFcyphtNkcMvabwMrHC89TcO4MmWqaatn3zh3rVXr/8+U0XnLzCQ+9NA
	eN0Bf3CaIjoQu/IRJSEQiWv4zlCQc6MINZY2dOVH52fI6Zm+qMODYRNggIDndPOzWMkWB8Wws6U
	ZUlGueb2Rt+JGJaNzx8CZKevA+a7mHEgm5Mf+JeFchATmDdgaAZ1jzQ3e57PQ7i/t/iG64UdH06
	ZFvXbJbEySz88iKTEBdyqsw/dcKkiBsAcOvBL/tirAuXzKVnF9pfW0hDqp0dNKWB2zjAstoO9y5
	n1AmClOYojaEWMV2vVOJUVj8DpvMCKIOo+mv5R7TBes3+FbVkQRCDzyujN2XEkkslh6sc36bObK
	vd4iTp1AlEU8a2QcY/qhNaOPPfwBuJP92MwJ51wv918ety2Jf9wpuATlKJEri+G40zpYATEvgFR
	w3AFRNGyg==
X-Received: by 2002:a17:906:fe42:b0:c16:3074:657f with SMTP id a640c23a62f3a-c1fe7ecb6d3mr535636766b.9.1785670758004;
        Sun, 02 Aug 2026 04:39:18 -0700 (PDT)
Received: from fedora ([154.182.104.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4532e1esm407679966b.50.2026.08.02.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:39:16 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] staging: iio: ad7816: avoid DMA from stack in spi_read
Date: Sun,  2 Aug 2026 14:38:40 +0300
Message-ID: <20260802113840.17730-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI core may use DMA for transfers. Using a stack-allocated
buffer for DMA is unsafe and can trigger faults when VMAP_STACK is
enabled, since the stack is not guaranteed to be DMA-accessible.

Move the transfer buffer from the stack into the ad7816_chip_info
structure so it has a stable lifetime suitable for DMA transfers.
Mark the buffer with ____cacheline_aligned to ensure proper alignment
for DMA operations.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..fcaadebff0f4 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -50,6 +50,7 @@ struct ad7816_chip_info {
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
+	__be16 rx_buf ____cacheline_aligned;
 };
 
 enum ad7816_type {
@@ -65,7 +66,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
-	__be16 buf;
 
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
@@ -91,14 +91,12 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(*data));
+	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		return ret;
 	}
-
-	*data = be16_to_cpu(buf);
-
+	*data = be16_to_cpu(chip->rx_buf);
 	return ret;
 }
 
-- 
2.54.0

