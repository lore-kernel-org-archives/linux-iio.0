Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA62BE643
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877889; cv=none; b=s3D3xSt3EvSqw3El02b5gBQi92ifE1yr7/QR/omN2YqUp693apoqTvF5y6knCf8FqHQ2sGtxW5tr/Z1nA9tzRU8VmEq0MpNfPwkXS9zQ8hzeyzUdnlbbcMCL1pf4ikzPLlsKl1WUs74mrPc1F3Dcn7wOSZWIWRUpFNvhy2AIpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877889; c=relaxed/simple;
	bh=LvjRu9H6aYvcvN+agPz5TpvyB/4Y1E3sFD81yavDq00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDsSav9Ck0X9aMcgz0cPAY2wlvOP09RIwlLC0u74STMZKEBskvqgf0mYmiSW54LCyAZUAVMjKGTzaWQTyyXZrN4znu4fIWe+72LUwz0ADXqEelSHOJteflFX8v68noXQpFxqp/SpU/dAMIEQY0qbofDwDdC571S+v9i81JJxFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHF65xEQ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHF65xEQ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2baaaeeadebso36766eec.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 22:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770877886; x=1771482686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSLDuf812ujA58X4h0f+xwWxKwx6uBXZNn8+SI0hNGY=;
        b=VHF65xEQ535Jc+VGJTDKu2qMNAdFGdU0wK/xdeKKup+kypIQVFr92GeVa8GBfcwAVR
         YTcBSrVdrpYb1QzcSc4G5d0jp19/9N6S1GS4FmvmhBHoWpCpzTTqtzm8WID3JEyjJXd8
         1Bk3YlJqT/qEntMxyQm0ZFVRGeJpgq5reKkXWOUdP7vrivwdbdwAEkzHWCYyC28K4/0o
         g5Ep/pWws2d2VycYFZjrGqWEZwCjK/m5tydcNWXSH10el/fzdN/6DsEhAEHLh8pySelb
         YD3mRnFj/KxUYwrOT6ltiPhfHd1yJlWMLM3MzZ0cmb4Nf4I03sYD7lobKHFLSYx57XSj
         5V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877886; x=1771482686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSLDuf812ujA58X4h0f+xwWxKwx6uBXZNn8+SI0hNGY=;
        b=OraaYrKhkiu01/D4QEpUgJb1utjqlITdYq9OdA/lCyp79bTxd46jprHrqHAkc0gzsY
         PCntTa3gpVhaHkNh2PNV5appsr2O13UjM7QoLJ3VY+ZirEdplif60kaAwma8hTEdcO2t
         wB5QFODpbdqFH6o6DROuDw5U/pIuhbTr9RWlW3F0rPFz++LpYAQPzKRI6EaQ+pR0Aa/d
         5/w5NUmyJcmJ1UMaBm+YkjeSTanS8COBYkLVw8mRNfno4/OxZPX1m7hfVEZC70ZV37Cy
         BwkCzNvMtCjNOg7eglLmBfsCV9zXfZbjKNRr5Elix9gpQ3/cmmUZfihID5YAliGVlTt3
         xnTg==
X-Gm-Message-State: AOJu0Yy1Xr5p//Sfl2H2+fHxbsoHaGHTMh5/s9895fyaIjAccCacqPes
	u57z189pHMowp1DaUiV9S9J8isYzSY+oW0bKEHkFQbONQ0E6mSfhD1zK
X-Gm-Gg: AZuq6aLrS97iqjjvWaRE1GZA7EtmXY5v3VXe4SsQchNiFZ2fZogqevVV4B7CLwjL0TU
	FOR5BBJ2D1+Qx8MV9v71JtLYP0kifAr3jGCNyOuOiP3CJZUzDYVLzAIMf6Avxn8w7BYSvlnsAhJ
	6K8MTHoT5uOI/bULAMHk+piS7Q34yy7OhK0TscME1jmxwJdnMR2A3cbOG8dW6NUW8qSJDFP5boB
	g6CpBwS5jiyR9mP6aishtGuBWKFlSQR99LdsmyW0YWRup17W5EartVnH9ovCrBxvNqJ/L5N9jbJ
	S/pOa2DjEYWjgBQEURm5MkVOfDz1d2b7MkQCYLSVtD0UbMUHcnYNeJwFT0kz9vpTfa7Q+4+PsIv
	7wdKsBUjcxPPc4ibBXaS1XlnMbY7mLaWnmVcNcAwGLJiK0ymsKlp0Qbb0a6UZ7rQDxdo07vH0qz
	RgiMF7Qt1lNBnJbimYnQSfIaaTcZfNqnO7x1plVPyeBFJrk3qdI9QNmoI=
X-Received: by 2002:a05:7022:f102:b0:124:af80:9d0c with SMTP id a92af1059eb24-1272f69953dmr417178c88.0.1770877886231;
        Wed, 11 Feb 2026 22:31:26 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f29dasm4313870c88.12.2026.02.11.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:31:25 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 12 Feb 2026 14:26:55 +0800
Subject: [PATCH v2 4/4] iio: proximity: hx9023s: support firmware-name
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-upstream-20260219-v2-4-2b28fce5d09e@gmail.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
In-Reply-To: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=LvjRu9H6aYvcvN+agPz5TpvyB/4Y1E3sFD81yavDq00=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJm9xcuOyho8sWh98m25+tXUiz5VN7+t2Bbp4aedlxMcX
 m87U+VYRykLgyAHg6yYIsuZ129Y81Uf7gn+7ZoBM4eVCWQIAxenAExkExMjw4Ilc3Wvp2e8LTmt
 cP356+zn9jJTK7bxPL+2Y7XY6X1/V3xiZHiyIWCz6BPnozs22/x3fKvBzzbvlr+m9hHO1W2TJVn
 sL5QBAA==
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Add an optional firmware-name property to specify the firmware file.
If not provided, the driver falls back to the default firmware name.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index e714fe00a44e..b2cd0759fec2 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1089,6 +1089,7 @@ static int hx9023s_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct hx9023s_data *data;
+	const char *fw_name;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -1126,7 +1127,9 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
-	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin", dev,
+	fw_name = "hx9023s.bin";
+	device_property_read_string(dev, "firmware-name", &fw_name);
+	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, dev,
 				      GFP_KERNEL, data, hx9023s_cfg_update);
 	if (ret)
 		return dev_err_probe(dev, ret, "reg config failed\n");

-- 
2.43.0

