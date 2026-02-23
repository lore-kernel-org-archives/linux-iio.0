Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435B34404B
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818050; cv=none; b=FGbZntZ2vwABiOQHxp669XJG/StiVjPhPaFRgGQc8Vzha90m0ikbT0CbnY+9zzpRA1HD3n0auVTSOazfifnHr/B93E/X6qoclZPdthBsqB8007+nAnjZVjv6khPLqeeEtJEUqbBs1XpM8HGFmzA9+imZaPa4FFy+c3MTzwxvimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818050; c=relaxed/simple;
	bh=ojkJ6HR611cjx7257sMX31BsGcwTLb0wr5jxnZQGNKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeCOLfdEugHxuiJJBCKuznkbrEujGjxHIvybXb5aarEG4JHcViwHTUrnjuFlkRh+dQHnQbLYORk4Ou34HV793C426g0MZGk6I+Apj7iV0rQxI2cTFeVGBbELVpxP7ceQXRrw4i283PqxVViae/fqYiuPTSgDE/82rRGf4OX164I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6YsYNX4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6YsYNX4"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-797d36fdb96so60975417b3.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818048; x=1772422848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZddAUHyZfeURC2k1s53wLgt+CwTc0WLUD/YiA8Cx2cY=;
        b=W6YsYNX4yDQJIG8vKTciqbE0BJ14g7y7hwFES4PDXeblYzE9zZnmGARtrVQWVYCx/V
         ig+AIhLVFkJhhjv+8toIgEElsvmT0bC0AymWEzu/QE/+dlMtebDLGV5q+z7vOOBPzBJK
         XI/cQBbKRAjSVlqyKtXqL6PW/VV12df9LmwE3wPqO+ghNcYV/cZ026dKWLZsfDR6zs6Z
         4S8XXiFoWbxmVIvKN6I3sLr8DolF13fVdb4B7mXacWnoHYQCFp7BOma+vSB/g0lBgna4
         X5z7dwvVGI56JuM0ghgfR/0aYOfkfh7j0w3Bhk5SQDJG6NMHTruoj9iaIHitwVtGa2Vh
         Y7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818048; x=1772422848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZddAUHyZfeURC2k1s53wLgt+CwTc0WLUD/YiA8Cx2cY=;
        b=t/C9ITu1/V8FIIEWz0iKDd3ST5o9b37pHJ3VA2fri6jmC+Iya32g24tfwbcRoXFwVR
         lh4+0705rUqr+H8NDEzGoloecIr+/6uraI+WupoDyq3xND0O9Y93ACA30eT5vbuF/CJz
         3eYH0z0i4/RVNza2BI7zQoKBiVmD9Ej1u2M3lEcDUi7C8RWhQZabVcSNCkYhkN/V8bmL
         xqPO7MS+54cFp08MqmZAdg1DvFQKLlt3lHC6Qoo9E+PolmgXq245jnLWUxHedW1TYWcR
         B4LeCE8RCO23TVLmTYIN71mUeuzVh3wMkacZDYo/7vHqc95Iy2z+bKgNqTnlkd0553eW
         7jOw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIHWQOPQQ8jjhRImyYkFu4ZKa9cfsmHNy9vTTGyHwj65kjPJ4QmcLSeVuJLOFUco3ko1R9tQS1C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYpufiWnhP3Shi4iLhQAs+jtCp+Cpf2MupbRjHAbE7KXEMZX5
	iRcXwjgTieWT8aYE9lSs9RLTDBs/eZD6WjC5sOee2B3YyeoQfqry11LwJ6J/kjp/FlA=
X-Gm-Gg: ATEYQzxukuIzC1tEuSPB1ETKRb6IbFuqOHMrX0ZqHz8PF6E1us6oBsr3oXAfMmh5N8E
	ZzTPlpCPYn1YOr1LbOUVTcNvzLFXkg8WUWsOOg+InwZ0axJDY/vH2RpB68Jxl4Y0JYfw6gvu1wB
	i66mGApIWk3NkCI4AawGY+ZM88CZgOCDuFUiwGVdKfvRxcmDeC+siD1Ci6AI0nGy8CBO6OeqHtO
	N7V2iFRASoSgXbCI1M0KLGegv5+iI3DUhGbeckRucIzcHoU8qAWcn89gPs5B3CsnK/H4pnAumiQ
	a6DMK/kCv3nKdyhgEFQ8BzIVCSoioqq8lgGLkzjE/nathyCYWKsBKcPrTw/TnxpilTl61ppyMkp
	xgftmFwl8/oaAZEHWyrUxfgO7swQk8w8/ZAO8/J32elY2rx7gjr0F4BmCXvusQ3CU4ODJCNTedA
	jC/v1lSk3uiULSY86mE1jNRCaJyjj9KivmJSXD5wfgTHNsa4Cnuh64yhpoBELWyO+LBr8pOy8ux
	f0tExNnAL5VzbJI5WlxJ6rC
X-Received: by 2002:a05:690c:620a:b0:797:e635:697a with SMTP id 00721157ae682-7982b69aac8mr56754847b3.1.1771818048111;
        Sun, 22 Feb 2026 19:40:48 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 08/10] iio: light: gp2ap020a00f: Explicitly use string literal for driver name
Date: Sun, 22 Feb 2026 21:40:18 -0600
Message-ID: <20260223034020.27625-9-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The driver name should be easily greppable and clearly spelled.
Replace a level of indirection and explicitly use string literal.

While at it, remove useless blank lines before module_*() and
MODULE_*() macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 97630ce9ade0..0d7262e1c5c9 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -55,8 +55,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define GP2A_I2C_NAME "gp2ap020a00f"
-
 /* Registers */
 #define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
 #define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
@@ -1535,10 +1533,9 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ GP2A_I2C_NAME },
+	{ "gp2ap020a00f" },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
@@ -1549,14 +1546,13 @@ MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
 
 static struct i2c_driver gp2ap020a00f_driver = {
 	.driver = {
-		.name	= GP2A_I2C_NAME,
+		.name	= "gp2ap020a00f",
 		.of_match_table = gp2ap020a00f_of_match,
 	},
 	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
 	.id_table	= gp2ap020a00f_id,
 };
-
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-- 
2.53.0

