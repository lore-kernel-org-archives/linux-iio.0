Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294132;
	b=vbx3/vyE5XUv6a08Kp44IIxvwBZG80qFQ/AzZ0b3tDxR6vUOl/kHhh9bGxhmpSS4AdQb
	 EEwH2Hla7KjqCHfuqalzW09KXF/aLEcCV7bYPJIaasn/AOdpFY8jUz/YIlWK4gZgLCRUW
	 M/v7QYKM4BolHhgHvj/+z6g/DkKy8QDlW+3v4K7nRmlzADXyHfKKB38BDqZxzoZpGGggg
	 W9bQwlevVUsLnTn+e7G6rjc1NhG5GMpYV9KxlhOcouGupYD4ePQwekhWjbaKwcRuQGdXe
	 W/uDcbTY+JlJwTaUbuCo5IoqMM33x/pDSaf33C5GAVweUg4lmBflgNOdRToRwoC4Hdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294132;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jTHiZ4jJN/E8yIGpxapjAZs2O+sKVcXlYf7ss7FEZYQ=;
	b=lTif4V/SRFwi0WBXcvlTT7Y+SXTmHnLhOhVrWOT1lqqObCRUmWvRly/F37B2NmrfQMEA
	 tnxkEa31MWYJ6tlhvx0bZW5U2gkqnhbKRWWYcWFueQC5WdlCTzTdTOkirlDK7BrJO24/0
	 J5fbvFjRVNwdYpJvS6fDLXFWnU+z61KwBhkbOgAEQ4ryPgfleI0qSXiLbXm/FZuwj2pqf
	 n7WsV2CPnutxKF5epntf2w4PpzxHNbYP7SGREF21HqaKTAxvFzJIyBU8bVzxuAtzjDiTb
	 xdL7qrJeWsMmVEfde4qpDFRVfigrBsvYUd1uQAqtTN4SEze8AF8ywXjBedSLvgGGJWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B7TXg070;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF5606A31C;
	Tue, 10 Nov 2026 07:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B7TXg070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=B7TXg070/gXUzm5z54hkm/3Xpi2NMmsBhkTy3TMMflpNysvYQ66QByshODi7gfNjBSgBKrL+eOpUD
	 1ers/voTH5kRVvm4219Kv0NbtjqyJxYBTdXYQHDdVTjfkl8vX4/Ssu8iJNF+iDb1mArqX/ZDTU84sS
	 rH4d3BdCJSj8gRrU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af2c1720a4-d137e;
	Tue, 10 Nov 2026 15:02:10 +0800 (CST)
X-RM-TRANSID:2ee96af2c1720a4-d137e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af2c16f620-aa48e;
	Tue, 10 Nov 2026 15:02:09 +0800 (CST)
X-RM-TRANSID:2ee36af2c16f620-aa48e
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] iio: accel: mc3230: Leave chip in standby on mount matrix probe failure
Date: Tue, 10 Nov 2026 15:02:06 +0800
Message-ID: <20261110070206.1452-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mc3230_probe() switches the chip to WAKE mode before reading the
mount matrix from firmware, but when the mount matrix cannot be read
it returns directly and leaves the chip in WAKE mode.  The
iio_device_register() failure path, in contrast, correctly puts the
chip back into STANDBY, so the mount matrix error path is clearly
missing the same cleanup.

The mount matrix is read from firmware only and does not need the
chip at all, so move it before the WAKE transition.  That way the
chip is only woken up once the remaining steps cannot fail anymore.

Fixes: e59c6acfd5fa ("iio: accel: mc3230: add mount matrix support")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/iio/accel/mc3230.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index b45897210..9ee71da7e 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -183,14 +183,14 @@ static int mc3230_probe(struct i2c_client *client)
 	indio_dev->channels = mc3230_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
 
-	ret = mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
-	if (ret < 0)
-		return ret;
-
 	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
 	if (ret)
 		return ret;
 
+	ret = mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
+	if (ret < 0)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");


