Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B933DEE6
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895746; cv=none; b=Ks3d8CPdEm4f7v+dfpmyQ2e7JfoY7OeThqUxdqkkCPZiU+PjdyCOFwPNGvoSaN/72kNYSSz3vpPhtc9urfH7rYe/HMsrjPxhslvlg2GEJgUikQF77JxHu0imOLtOQEmsTwAb+nFG0fognq7MXRe7bbELJurHQpuwjghZVEVqRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895746; c=relaxed/simple;
	bh=pNEWE+topqr1rhpsk0SHV4F0J9u5bipTgTSisRc3TTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uq5+wqb1xFdM5VH0MX1AVDcU/6CSUfw5rIp9THh7iYPNXca7hm7v0HaepTPHCVDlJksZQTZl32nFaRooTuP4sw/GG5u4TO88SOEBaH1bCm19GzJqpGT4/TpxZwD8euRdsEQfa3iYhxEkorbcQsv/wjwYtPohec/H0NwDkBkfAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqDrx1VZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqDrx1VZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso17200585e9.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789895743; x=1790500543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1cW/zqFKr4VTXcMiUtx8FkhmYjSXHe8PhD59Qq3qEY=;
        b=aqDrx1VZGfWBs3sStWEnlAHoZfvRe1XLEIcq2w7+rI7kMYBIldNLKc+qZoe42HQoA9
         6+CW0TCcLjcMancyDGRmax5WJjx+YvBS0KxVnO/5Fod0tZl5u59ptGNiOQxNwLgTqAIU
         P6JWXDiWUytAf9FstmUT4QHYBoj6+V5sLTdbTBn2iypfkXYXtm+WrEVcmdmkS9CkApfr
         GoiOAPajBtGqG/MPlo2COMGdvljK56fEaMxVeCqhgnFv4jI+qsV4v1Mg7xNTMp2ETnDF
         XWYaYHh/Yn23p54wD82ciSJS96jdHW6oioudYePxIXwbjOpykWqEbZAioGGfb6gAr2Fj
         f9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789895743; x=1790500543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1cW/zqFKr4VTXcMiUtx8FkhmYjSXHe8PhD59Qq3qEY=;
        b=gg30RFc0RG8dDQHjNvgMr5NLhDC2RISsLg/ePZCEanycWNqJs87Y+owv28qvq/psY4
         rnHWsIa2Q/Rvj5s3fLahgTDgtg2UvWU0C+LAXZRG1oolXDPw0dXPP82cu2Cn2KIbp0aj
         iOfnGSXZpj9P5C6v3n2TiNZC87IVBdhsRSnELXuNCTKoQXcetLC3dXD5K2aF0h3ZyBdW
         fgnf8NUPkYwMI0p7AUswypJZYHDM2zz2wiVmgvermDb+3PTMh5qnkmXpVww6Ouo55KuN
         xByPVyxcpDtFOAVQB0LaI9HcYFcp/EMuu6vtHnriWD0xe6koQxqKTLmjvlR5xE2MArF3
         +GOg==
X-Forwarded-Encrypted: i=1; AKwUvBy+R3+5GmrshtbM3tODs8gd1JR30h4aJsuERNGP938QKyF4jpgdDnojhe3PmXkbGVgeX5zSQ1htNpE=@vger.kernel.org
X-Gm-Message-State: AFuF++koy6aoMgWYU8zp3lxBVhRCxBpxh++X3FJ/hzPa5Y+zB1n12hx1
	VgJE8uvq1I8VA6h00zK+sTW5AwFJyaWLvxASqtrdEeQUK2obRsh8Hk0a6V+oRA==
X-Gm-Gg: AYBFou0b3O1ICTZ0w3Ke73+xOctSBeBI9gcr5HxU8UPlI0QRWzgSiXiXmtw6PSAsOEo
	YY9zxLixSN5SvPRmEyccsqOnqPKsADE3l6pYE/fH0PkqQPFqLJjtvj6hCzoxuHF+nlRz4qehBRM
	HIpCpKoRksLTVdzze6sICPojizR/BkwY8CV2fBT09a7nvAeJ5ryQNpJ1+9HUjpnA5f52cmDhePI
	KvgmsaDw1/FtwaimG5pAuigqoxLXxPUPXeFzlP3hu1hN6EHykWxhzCJgVu4nLmL1iLUx1/mfl5q
	Mk5wOf+4qeK7yYhbYkLs6wUYNl4c5hw7oV0R/iZlhV0t+3/Cksc8BJf+9jTV5MMC4FD1Q/oapk1
	/PFqkOCgCihc1leslkltKEKUSM2THg1KF5n6OOafCUPL66Mag3ymdDWL/9BKj/oBtYtMVMAwY+u
	BGGEATN748hLlXvLsAZ9cr48rGdB3sfHNz4wWKBKODuVbIJwdKz7KXChq7FpkYlnITEhCX/j0+x
	lUS9of8naBZNoo/8sSUaw==
X-Received: by 2002:a05:600c:3586:b0:49e:7d69:83b7 with SMTP id 5b1f17b1804b1-49fc56f7376mr130239775e9.13.1789895742442;
        Sun, 20 Sep 2026 02:15:42 -0700 (PDT)
Received: from fedora ([154.182.123.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0ece6esm185953065e9.2.2026.09.20.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 02:15:41 -0700 (PDT)
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
	error27@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes with mutex
Date: Sun, 20 Sep 2026 12:15:22 +0300
Message-ID: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs store functions (ad7816_store_mode and ad7816_store_channel)
modify the device state and toggle GPIO pins. If accessed concurrently
by userspace during an ongoing SPI transfer, this could corrupt the
SPI transaction.

Add the existing chip->lock guard to these functions to serialize
access and prevent race conditions.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v2:
- Added a blank line after guard(mutex) statements as requested by Joshua.
- Added Fixes tag as requested by Dan.
- Collected Reviewed-by tag from Joshua.

 drivers/staging/iio/adc/ad7816.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index f76f0215119a..2a15d7598abb 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -143,6 +143,8 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	guard(mutex)(&chip->lock);
+
 	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
@@ -207,6 +209,8 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&chip->lock);
+
 	chip->channel_id = data;
 
 	return len;
-- 
2.54.0

