Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA36379960
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504405; cv=none; b=n0Y4iP37jlKKICPImL8kTy7B2+UMHx8QfguT9pathfhfrG8wqY2Jmgmr+rP1mG97njyAwRi4RQZkuaTrKI5zo3PHjYZITb59A3ivFlYXPSSK7QoPj6E+1EOEXPBZ4kVdtzIpNkT3C5Ci0blPcjOmhjXIHY/1+9MD+B9qsT/bR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504405; c=relaxed/simple;
	bh=j6qWWe6QEp4AZVAT6HIO6TViQIm6aoaS6Zal4S7e85c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdXKM3ws+WhuxaLOPV0xfxfVa//025gLJbPcpBAG5G2tjfboUzxKKxNL65zRqvHlP9tfEDDKTmH7ORz98gec4HRh05BOUW3ec/lXS0wGCn+Dj14e/Zyf/fT6e1OM+jvNDMgrlvGNzK6QLhBoX2lrGGe0vmJBnEgfMT9jZ6TDD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwhUlJB4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwhUlJB4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358dd7f79so508737466b.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504402; x=1774109202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgQ8nZvVLHmAMjTgF6dNW3MLBAIvM4glDSXsOvEDdCg=;
        b=YwhUlJB445tKoZ1CRAnYSeqWBXS+3hEiTngSSs/xWTb3T7+c68p1aulsxcX9mPdXyR
         ctxFO6wv/0+7kx4/I2XnLsONDbwb2sfT95VsaRN2Du9JTfEEnx9jiJ7ZQug4hzxihLYx
         f/grZjcT8kh1qcWDn1wcC+JSzbLTLI+xj36RKbalY//glNcz2yQDDWRF4Z4kQV4bKE15
         ULyciwpr3nokbwnPEQvWngxpZ6gBnWmOJ4/6+cM0kjfSDDg4qPoBNIfEeNJ2V/wgD44Q
         2Nx9UFeeXmiF1dHWNXY3R7uHeYUTJwLuWtwnZmBCYRY+R7OiGLvFeIZIW3AwajUuaAJn
         kaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504402; x=1774109202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgQ8nZvVLHmAMjTgF6dNW3MLBAIvM4glDSXsOvEDdCg=;
        b=WR76hPNDo9zIcLnuwJCuW2AvNb1OIgsI2bn7UDHW6665itUTlTLc81YSv9j9gM5WKl
         XIUa8ap+sDcxLojQR7hxpirilVSOayuHW3RBb82k1Bln4vuyjjuXWxYv35IEr7+96hCc
         jt1onMyTjnsrX4zNBWl6epu5+S7eIjCEys+UqylSjkAcRTRN4+WNIfeLQD8BIECXPNkS
         +aWRGKxp4uH/oKhHmAEBGLVIekxKFhAp5MsEonoM75tvkcfMzkGmCSA4LVA9/Oz8Cumc
         g0mo3jjtgXLSK1wpJhrEumVmLEYyd2zVMAtCBem8lgSsc9wHeNF0LPw3c1Id0eYIQmt1
         lUvQ==
X-Gm-Message-State: AOJu0YwnGgm82ka/FA3r90kkcfNKW13+G4WK1EFCm2TY39irkXUfgOCQ
	qihzOj2139Icf8/sUFQtF8A54+E2GJlILseIEekkkEDSVhIRUNoDWZgX
X-Gm-Gg: ATEYQzzLYQX/5dtZdZN+brW7/0ww8GetM1Nzy2dRAqqR6by2qRCY1ndFURxGeRMniv4
	zNQJ1IO/40k751z3ZTL7/pSyFvtxtXHZMRYVzsCOq7XivV7wqQ+G5KiqhtLIU3LCU/VzXk3oeoS
	oQ87SePudg+iHKVwLgblJ6SBHE0hAFPpQtjHY+E04yhMAnc6vVgYZTAxzJHUTek5YO5veSuTsEl
	YtaPU7oh/CdIWhehcjZK2TF6v4BMioQUYn6u00+H14bbsP4gvm6XrDAJbR1taoRqENFEnj+GRSe
	DgcJjcxWo8udO/TKFQy547b4fIGiTVuK5HkaF6lMvmsXyfbLqJIUiXWVuHYO1libxpNMxRFWhkk
	0fj8uyVM7NbimgcJuT7DUTufVnqDIeXseXfb0dK5SO3qiCtf4nb6xp5AxW/eVIZuTQ6F18lOQ49
	p36BtPJ3CO3aLIwDHU3223h+EucA==
X-Received: by 2002:a17:906:e96:b0:b8f:7aa8:d9a4 with SMTP id a640c23a62f3a-b9764fc9c3dmr278758466b.20.1773504401926;
        Sat, 14 Mar 2026 09:06:41 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:41 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:33 +0200
Subject: [PATCH v3 4/6] iio: light: vcnl4000: add support for regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-4-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

Add supply, I2C and cathode voltage regulators to the sensor and enable
them. This keeps the sensor powered on even after its only supply shared
by another device shuts down.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 drivers/iio/light/vcnl4000.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0ee307fc5ab7..e501db7249d7 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1991,6 +1992,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char * const regulator_names[] = { "vdd", "vddio", "vled" };
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
 	struct device *dev = &client->dev;
@@ -2006,6 +2008,12 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	ret = devm_regulator_bulk_get_enable(dev,
+				      ARRAY_SIZE(regulator_names),
+				      regulator_names);
+	if (ret < 0)
+		return ret;
+
 	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
 	if (ret < 0)
 		return ret;

-- 
2.53.0

