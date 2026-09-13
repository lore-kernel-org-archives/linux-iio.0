Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974A390239
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289641; cv=none; b=OZYMgvvGRmC40ATahl6tzWLEwDQjg4Ro90rIVSDKc5497pj8JUzDIxk9zvoNldtpm05z9DSdqG4TEQH3+Up2rIp+8h6b4zkm0LyTziIPMrun9g8itBDkM9ztczOf7jvNYO4VYD/4mF+ZAf85XJIa82bmxvv4AtxUb4MY9cJMK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289641; c=relaxed/simple;
	bh=envbLuQDbQDDEWH3XcYF5G304K0mIQCtaASdr8Op0dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoHnmwpLVQoCYOSRbItQ4J3dLXmKGmZWbazQWN94eE6gMKfNnwCMF8THbMI4oRJV9cTsVPup1tCsNi7MxiwoIVkQpEndV433fUrp0PcAHkQapfngu7Up+IkZ02RnU5emTcKjQoZiX52NJH4Akj7yuQ7wHd23IeXGct+wKf/X6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCXOjZ9i; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCXOjZ9i"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso484506f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289637; x=1789894437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDLkgYBNbtyZoarKCnkrYArqCb7j8Bh77/axESvjCE0=;
        b=DCXOjZ9ijXzDxYixge4RPYSgc5mABw3Rhal/7gdgkFzXagRkIFnJYpX+XZ0oHll947
         qrAdVpZZnHr7uN4i9XAFs2QZD9cngEabnU17kkJ6bg5525r1wi3yu/C+Ip85kc6lM22F
         7p1kpyeursYavGWlsnOOxUSfO4NbNzbnJkmybAp62i2FxZ+5rLb9Rsq+2T/uQpWzG3ac
         ltQHeo8C6dp8zVz12mVhSDPC8CQpgSyG0fQhzrUTgx/w75rD7KjCnfWTL48Hs6X/YcYA
         zg6pQzx5QMFuiCdFKVaQZj3mZYJvC3ZBupO1/i0YnOttp4rWdfUElQXTeCDgNYA3iyEz
         oyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289637; x=1789894437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDLkgYBNbtyZoarKCnkrYArqCb7j8Bh77/axESvjCE0=;
        b=QgwVPvlbdT3RG9qyWVdiKJkq8HG/3DkJtcBTp96LqQnY/DCvZR/EcTCIQs6tCNKd/f
         X9Nq/GOBP2Uww015lQI76zwelT5goKLomp9yalrx/96dNiFfm1/OuILQbJLfbzV5PKTf
         vx4jHhWSb5oLc3QNR9uSpiA8ROMjhL5+gC5yEumf5i7NeA2YqbjkGHs0LaYE8x7RzDUm
         Ce5DNCd4h9t3bBlhs5kpQ+YCg78IrQIkF9TrHUcToYiiarRz154UUMxvMH18a2ODUR9I
         rJQCimD+JXCPs8lv8twLYGi/xvKwl97Lm+O2XesAeJcLSzJVZ+WDDOoj/9OldHN9l6h7
         rIow==
X-Forwarded-Encrypted: i=1; AKwUvBxcXg576ZwsqDbOzHUbU9CH4SE6IFb7bY96PI3ezUOEQdulEZZvF1lGv+r6Auy30Av4J15sSyvQ8vY=@vger.kernel.org
X-Gm-Message-State: AFuF++lToHhf6Nx3MPdatGA87sdQ3//Eo81cBWKJModU6SR3U+3uexpX
	GX3uNDmA8Axmk37Af1h91EfvvK0x1cHc6xcyjmLSpwlUKMD4ib8Ypb5t
X-Gm-Gg: AYBFou2mXKQWwGxZBgT9jIyzBnrbR9lZfqlZ8PYaL0phx7iYVFsucblD2D/vdSrTN0P
	MQcrVTGIf0XbkNuB8z2VKHBfR2L1UGJjVe5qZMApBpPoneRAfzIc7E1o/PGHpGh0RzCT5SYZMOw
	R4hgtPkQWr1Kxp/erd/jdScAZGffzycwj4tpYE3YI3D+eVfvW2jyThHxI0OIYbaqH67x3kLU14x
	VTuBDgSwhY2VR8HxULsbWxOhE5LuV2PUb6VaNzsUEfg2I2832LpBMnvBbhEoaAHrWb0chHbuf2M
	DpZmY+ugCQD2yk3rJ45C0ZvA6NNUbTuvYFeIHAReA8hS9jnqiQi099nH15cb895ELGNXEM0DlCh
	0DXlcggyKs0wMdAMpNcle6Zlmz3H4Jhko3zbxz5PayCMt8ixxUwxopu27gceRcsCM+BI6slAlbL
	1Lq4KOgx/p0ep44lvrXNvFSKozVcqJBmEp5NkPIDGgyZmIkwg5NfInqLU2N2rvlLv2HeymxEkbe
	RyKrYUJ7CkUKT7vADc=
X-Received: by 2002:a5d:6f17:0:b0:486:fcc8:aaf with SMTP id ffacd0b85a97d-486fcc80b06mr1476198f8f.26.1789289637449;
        Sun, 13 Sep 2026 01:53:57 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:53:57 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v2 2/6] iio: accel: adis16201: add OF device ID table
Date: Sun, 13 Sep 2026 13:53:03 +0500
Message-ID: <20260913085307.13846-3-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913085307.13846-1-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add of_device_id table for adis16201 and register it with
MODULE_DEVICE_TABLE() to enable device tree based matching.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 1e76a3560..2ce5c409b 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -288,6 +288,13 @@ static int adis16201_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id adis16201_of_match[] = {
+	{ .compatible = "adi,adis16201" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adis16201_of_match);
+
 static const struct spi_device_id adis16201_ids[] = {
 	{ .name = "adis16201", 0 },
 	{ },
@@ -298,6 +305,7 @@ MODULE_DEVICE_TABLE(spi, adis16201_ids);
 static struct spi_driver adis16201_driver = {
 	.driver = {
 		.name = "adis16201",
+		.of_match_table = adis16201_of_match,
 	},
 	.probe = adis16201_probe,
 	.id_table = adis16201_ids,
-- 
2.43.0

