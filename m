Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29D41DDF0
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151194; cv=none; b=bISoykhGclgqQUWBSn9nygkZxcyvTx2NCMMFo4D5tMp7xl9eK1JMAXvtqldIwW0/urq59RMw+ic2ZqXoCQZzp9v8lqz/uqXRYMX3goJ7vSDpanZyiANAieObFwZDytl7zcNw0BJTWUWKresn5JTTs0p7jgudIBNCLLE+XS0JpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151194; c=relaxed/simple;
	bh=Uvmmp2ZgCoQ3dwzThmBqUX6TSI/JKruY9bN8EY5j6vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COsZQEEF1kR8tqh23lcvP+StMmtGsZUmaL6CIZZmS69gTfQkx8qTDhSiUrWOMYnkzmcO+zee2I+fprqCMMmb1GAUVoBNXUNKlvwd8w4O8tN0kPDgeL8+Itm6aVto1pzvjRewxnWAXN3iiZh112EmL6r7p48MGLw1b7XwFN2MtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtSn21gi; arc=none smtp.client-ip=74.125.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtSn21gi"
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1848628eec.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151191; x=1792755991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWLAHlKO0hInXWoQXAgF9Kg+b4ACy1GGHEQwU1sBFAo=;
        b=WtSn21giVBkMemLGU1E2ueMXjxTqJPXwICISCy8jvXAFyTJh6nxE/ynvqODXrtgr/B
         0lq8YT40mB6phpaA9XC9I6tjXwn4lZYIT3d+tmKiATqubA59dzQcHtHic/AE0/tzT6bU
         Q+B0LD+e5AdmJXQ4GMD0Korg3ltVzZgVbqueN99QuYIxV0rrr3VPgJ9QsdUvkNCW9J0b
         CX19vzpD5V51CpKDYdADHa17a5MbFX6TdmMRK8MfTc7I4FP2mP0/bc8+AgZF+otC1vE9
         0A8t3l1puRMxUAlsXLMvakkrW1OMp8CrAonrgd9FgA6DnIeaeIwrjZ5B7JdOwUaJlNwi
         t2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151191; x=1792755991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SWLAHlKO0hInXWoQXAgF9Kg+b4ACy1GGHEQwU1sBFAo=;
        b=AX3UemfVzsOfA0KM3On8pPyrGRmOKcKDok05/Jk2b3mrv9+gD/6WAaI2ROaZJmrOXq
         CgckR5bPK38jX6JV2IBihHRAQcAUT3eRIYaTEWyW/DP+ph/CMn4zRI4GI5vsUXjyxww8
         9r/yAKy2d0CGwMH2afepd8RAiIqm+S82PC4pkdo2o4u8aRqcxsLYkwow+u72kUMpduLm
         ECb1Z+TpBIiyMnkeKRjLPE1ppK4hpDfp+b8NfAv+VNu/Fp7qNOHAkLMLV6ykimUFr62u
         447roS9cV/xTgEdMh39JSVlbl+PBZUe/et7ZEK9E++vgbg7idpc33Fi0xzp+1RdxhK9I
         27zA==
X-Forwarded-Encrypted: i=1; AKwUvBwsbkzZuNCYlhtEupwD/qJuwGbkHJV8VtKyssj011kHyd7h2LZih5BFX7oq5wFNs9qLJMBT1yeCg1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLygT8w7KaCB3P3FfpFT3mME2DW0fd11NgrU+OXYmXzfr2wBOoJ
	Pu41QViNOn18sQpDTlGQNR4uPgByNgRxM66jnRzwvYQdSRxLakukU2Fa
X-Gm-Gg: AYBFou1bYcHNkn3PMCMXnAtGcp2Uuno95yUfnM12TLkxG81CR81yVdi3dHLo1HwleYa
	DwQT8pRQp5gvJIppXCQ8X6DRK/Kd6YE+/yWRKlsi55Fb9IUhKg2E0YvrxsTHbZPdHxOMPdluBKX
	Eyd1wqAmkLSBvMG2cdWQZA05jvoMD53duOVMLmlhgx2oDLg5l4CmIm/KjdTyxFgzjYeIrU6H/FZ
	6H9lrmadhCqAtAWA87cC0o4QDeKKBd9sxwI949TolB8zpFZXg/lZThCneDTXBurWYciJwHU2zw6
	UWh85KZfM8xg7qPo6UHEpkxY8XWfHHbxVG2HL1+2xxq4dDzRg1Ee4v4LEwvLEAYqPcGbZpN9cgH
	gzI0mEcWZq1gHkoYLRHtd3UVDWfuH4fa731/+e3+94kvLLWOBeWULlMwdY2dbHkWDXYQmQIlb6s
	ziTHQFhAJSvfkiRLKSx12vRjiPZKBrpW7/d1QnDNMs53za5aYEOFci8F4OyhYJ3xRIPxgS
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3537df95584mr37998881eec.16.1792151190580;
        Fri, 16 Oct 2026 04:46:30 -0700 (PDT)
Received: from fedora ([117.134.210.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b63e1sm7330259eec.8.2026.10.16.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:46:30 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH 1/2] iio: accel: adis16209: add SPI device ID table
Date: Fri, 16 Oct 2026 16:45:26 +0500
Message-ID: <20261016114527.128364-2-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016114527.128364-1-shehryar.amd@gmail.com>
References: <20261016114527.128364-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi_device_id table for ADIS16209. Replace MODULE_ALIAS() with
MODULE_DEVICE_TABLE() which automatically generates the same module
alias.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16209.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 04e169f22..07a682d68 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -298,16 +298,22 @@ static int adis16209_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct spi_device_id adis16209_ids[] = {
+	{ .name = "adis16209" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16209_ids);
+
 static struct spi_driver adis16209_driver = {
 	.driver = {
 		.name = "adis16209",
 	},
 	.probe = adis16209_probe,
+	.id_table = adis16209_ids,
 };
 module_spi_driver(adis16209_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16209");
 MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.56.0

