Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8B38DC44
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602462; cv=none; b=psMDK3lExncDRmKq2zfq6h15jyqT59+lY0HstTLJa2JYSfaFC+yqO3Rtghlt4HWA2b2i+qyMh0+FV6j/TdERIM/a6/2AU03ieIjF9/giOsSO3KszjJMpkDAcUHTEfnpsSut71p5YBX5l0IkU7n5ZUKwVTUX2T+LLi/o6Obd1XOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602462; c=relaxed/simple;
	bh=n9Bht//Yk3scXsF8UPLRoojJO5J/1T0We2RgP49xtRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txqMppEIZTdCnxY81CoDfeyMExhhlWJZZIebwvOdWwOp6CMARz9Oxy7vpY5iaEy8j09d0LtyX12S+R/VNZ60ZKqlNnf3nqt3710luesFHX0TYmFR8dGlst4lPp2QruEKWtWuR2Foc/Vpkk7U6vW4M2n2Kvdc57Upa3JbPy3zvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skx4dy1w; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skx4dy1w"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aebd52488cso3731998e87.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602454; x=1788207254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSIPUen5mSK3/7kB5RAMGdblegdItDVxkIK2jwNz2kU=;
        b=skx4dy1wfxLk/AVRkSrcBo9+0Y0sEoRat4ynaeuasDkS3afSekgTNScn7uFe+BmgZ6
         2pw4WRcqYA+fkJgSsA6Rz2z5PghY6pIl8P3IVKgG76TRas43w0P+mjP6RT2YjQ3TOTn9
         m705wcbQE2TAm3OC//vxcpYh7DbrHPQLyMtl++6M7PWz2PZtieiFCjU6pPKiTlomZbwf
         OATj1QpdE9DFz+wwsR/MV2KzV9baM8ygJSo4STVAd13P1Gwe/J/FGdHptwGPfLJMwcWP
         wsflCJ8tT8lPZLhvrUk61aZ66SGySvEVV9DjmAe85ouJn1pFQwNat+DxhczFw++VaHXk
         yj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602454; x=1788207254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSIPUen5mSK3/7kB5RAMGdblegdItDVxkIK2jwNz2kU=;
        b=kMOqn4Y4gkJgcMOBMM7a3YXQ9BxY0BsIlIQiDMte4Qe/lQTB0G1CHfLOE7ibQSK3u2
         D3SNgmo6+pxqQrNqezUrJjiCwEU5hDUdbUzJr73z+iyOe6P5SLCLgOrPivcSXZgQW0tO
         aIOSckAmjsfjT6vkXP+xXsM08TXLy174xrUlQ5P9bwKVpf9H446QGW4Gd2wCqFLIeq+u
         cT1EzZXkJhbELPgWGWO7bnUXl7x8dUH46b+GQUBbATgESJTrxMeR+BRWMKR3fctWboWt
         WbJ4zjha2UbUAmQilYf19MEYx0iTT9k0GPq5S533bPtxCCt1Mg9W+YtmctBeMw+9P/Ws
         eB8A==
X-Gm-Message-State: AFuF++ksAGZ4yzTsbcpaus4t9Ke0rpx3Nz1+l+CSkPNK3BbWpb9lZ2U0
	27CADt4ybg/pICCrrgNajfIgd7MYFRytbLivyVii48NVVdYdxUOy6rQv
X-Gm-Gg: AR+sD10JGStQ2llUHkyY7l7oo5Y3yoT/wwqcVu+x4NvbxlvP5AxgmQ7PpXk0thGI4tW
	IwUGtGUQW5BB2cKuj6UnzHfrVOUoUnEktlb1d+xTFYqM2YySXLuv4n/L8bfv/uF1BqQLzqwbG98
	84GGuS+hYIO357gll7piFIdQ6sT+98734jEMR1Z8hCGnYIj1iM79D3/WI+m0xqB5icgjnblUNR0
	2a4YCH+Z8aOsUvI5tEhMpYg7r9dVnQfVrf1ru+7zEyAKtVJvs6SxsP7T7AC6YHXR60lsu+Qlqrp
	l5B2OHj/d1SHSmhAAjs+nP423NYBOlSFNie2rsAu2ipAs57fflntnHkSuK4gDiG5BS5Sf6bR3et
	zjwV019B09hYDh6Exi7wIRVZnrna0LZiecC2d7Ij5fUUWQiVVzFjzMt8Fjd4nPuatojKOw+cJdC
	2KRLFBzUhjA/6ruri93nneaHM5ipjJg4dJpFoYes6SabfNg7sIkCHoS/OjHVwJdF9sglSuNvZEe
	XY5mVafRMNZMQEt1KonC/Mw5yyiOFE0pDHTCpbnuDrNwFQgSeQU40Zva3E=
X-Received: by 2002:ac2:5688:0:b0:5b0:23cb:91ea with SMTP id 2adb3069b0e04-5b48b8a15e8mr5879737e87.22.1787602453887;
        Mon, 24 Aug 2026 13:14:13 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:13 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v6 2/6] iio: pressure: dps310: use a local device pointer in probe
Date: Mon, 24 Aug 2026 23:11:59 +0300
Message-ID: <20260824201203.396651-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824201203.396651-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

probe() spells out &client->dev for every devm call. Take it into a local
once instead, keeps lines short as more calls are added later in this
series.

No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 68382960382f..25d1c79876e6 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -846,11 +846,12 @@ static const struct iio_info dps310_info = {
 static int dps310_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
 	struct dps310_data *data;
 	struct iio_dev *iio;
 	int rc;
 
-	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!iio)
 		return -ENOMEM;
 
@@ -869,7 +870,7 @@ static int dps310_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 
 	/* Register to run the device reset when the device is removed */
-	rc = devm_add_action_or_reset(&client->dev, dps310_reset, data);
+	rc = devm_add_action_or_reset(dev, dps310_reset, data);
 	if (rc)
 		return rc;
 
@@ -877,7 +878,7 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
-	rc = devm_iio_device_register(&client->dev, iio);
+	rc = devm_iio_device_register(dev, iio);
 	if (rc)
 		return rc;
 
-- 
2.43.0

