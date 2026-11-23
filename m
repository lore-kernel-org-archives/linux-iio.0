Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417766;
	b=OUdOMRD3pNR2c8dz1r8A9+zsVY1dXxi/FhOIBsv/gml9rHlvh1VhFxwoSe4ST+Zy9JBL
	 lw8I13cI5aKqOT9MhYwGBjb+z6nwYd8mFZBFVZelRHtjt2WQy5cMia2d+Wao+MpCVai8w
	 R/LaDN1G5KdFeo5MEI4af6WfUbX2jHPHnY60XV2gIsrDI75A7EOsmlmNBMrQKvz6esToF
	 mIrqGIFL4DCNJYyYYbttGnv97IGXAVITroVgHAZ8HJlKhqOa1DxpGQxT430QmTuHP7UbQ
	 9qfkdfpzBIyH8jobND0Cp3HLqlXHIZvGFbR4ZlNC1w8WmGoRswKErC/zIqBV33O38nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8MAzL+L3Rrw/YnY+ybY9g7R6arsB3n6cfIMTszHVd5s=;
	b=WLSUvIxgF0PT/mlart2Ns9klLljRf43EwaE59x0/8INxBUb17MIA9iBB3DOPBG2g1HE6
	 0eIZZjXratmENWoTKjpkMqzoSFm4/z3PRaQqph2fsN/u6IxLgZF0roD3kgySiIXqnx9jg
	 gRFQWA2eKF/iWQbgpaLVs2b2b8wj/uZ61p2o22K2ZcllQUf4oKjdOwBV6LuDAZqgUC2w9
	 iMG3dK2np9Du49a2HnsEVUEci4bvkVCM0gt496UZ+pjbDY57C1YLNZz4IFImquXwb3XfT
	 1ULazhGy3iJ5wrw84KqdwwLVycZxbc6cq5pWZQGpDz/+NN0NYEFt0tuQuQ9my4x1OPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dzWwWfRt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC66606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dzWwWfRt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38564b4b017so3183743eec.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417765; x=1796022565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MAzL+L3Rrw/YnY+ybY9g7R6arsB3n6cfIMTszHVd5s=;
        b=dzWwWfRtCJCV6K2tsWlErxLqWoyDYqItarkhqjExd2Uojc7eaKjkRnh7w/LDXSR0Ts
         QxoBK681yTDYfMzYqkvGRBNEiu+ejh6zsPTaeVWiwSOt4qa73WTzHheXUqdzbPiRujzY
         +YKO+OwrV4cH5DBfGA8BqVYVqTEzZzig2solna+GsW1jrKkdiZ6evcgRLqYEsF2f27Ek
         WeRWvQtzj1djMX390IoUE6xCwyGBdRRNKCLaHFq8CCMR+sPrXq5ReDVaaxmEPEH7/3oK
         2LfhxU8VrRbjlonae4/Oc89XvLu2o7RDACS2bgV02BB1SfFUgnfJQi9Rd/CpFjbIXY79
         Saaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417765; x=1796022565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MAzL+L3Rrw/YnY+ybY9g7R6arsB3n6cfIMTszHVd5s=;
        b=ACmHhgOtNqNxRPxFnv3ZvRQ2WyR65ISTZPtjo6fxMfbyITTpBIs74iKU4AWNdtqpja
         MewufgaIL1Do0Odfs2WWJGRpgVdTIYUZNO4Y+NCRLiaHQYY1KpgfBoOuir9jY9X1bp1E
         WKu1N3o8UORFoUULlkQSOyM+U9Og5ia2Vm0xk0D8XZO/LQm4yqcCGUeBQFB7lzjwEEJ/
         VzLS9aPmXW0BNzBdzBBt0Q5+XnevkrMOAjRH9Asc8xfXC7qDzuLzRAQhmrDGSkzP5P8W
         GivBdnRrxNE/B2HEoinatxO/zunRGhDRAqFoXYxtwEiE9RoMls83q5Su4diAgwkBfanN
         I3dQ==
X-Forwarded-Encrypted: i=1; AL+hErE+5v85oB7vvoNucK26NxaXKXTddBtIVSVW/sLVhz7WFAySxC93FbAI98RNk0MT2jZnToWCMjp6db0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UUCH1V8Do/bzjOCikf/5T32wtLRSEvjof3hjVu4rWi1uV8K/H
	9nv5cz/Adz+CxnXKK1yAX9mt7Eh0XtaTcFkKdN2RMUxvNGExBKaZJXP3
X-Gm-Gg: AZFdTZfT+wCAGl08XERmstOGLZcaWil3+272Te1CjY28drskU7/oW5OkPNjym0+AkRV
	Xf8yktuwxwvqAZ2COE2ncOGCL0sK2R+No92NVes6KwAf5RwOBt+1m4dfVfQIGFhxxDB13+vVty6
	dN67bSH6XcB0rLAeVm8eV7ezouIeBHvhq9X9K5TPZrY7WILGrSmmF3xPiYNf3V9qr82BYoGcJSy
	smEY+8sdx50439I2zEC17jBearLNP/xeRGSt1cgPVxh7yq22mkBKOJgV+uK7KbuEVI6UswSHBTN
	SvePDHtkip03GVKQESRQUsaGh/NTX8hom6mLr3cOF/ZQpGtUrP42OtaVQRLpgO2Qw2+vJ2hnTgA
	aMiuFcEMfIlQG3ItHXL5fk1tAqYK+FBvgPtZJJp3Ws4/iIAINfscWsthQNkauE7WSKl4qVCFmzr
	ePs5QO3zuOqn+SwrjCIZK/msXbr8Yo2LG+FGapX+k6oOuXq4WOiAf6TO0idF8+o4x0E98LOfV+q
	LUVtVMUD4YYhUhUqyKsfxmHAx5G3/dM38AM85hvt0t1AvbtWScA5uFW82q1IGZAZamt16rCHLs4
	y/edPZjIB98s/L6mViRSgMbT00ztrZVL
X-Received: by 2002:a05:7300:51d4:b0:384:fef7:5876 with SMTP id 5a478bee46e88-384fef75c78mr13119936eec.24.1795417765170;
        Sun, 22 Nov 2026 23:09:25 -0800 (PST)
Received: from omarchy ([14.139.177.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm5293460eec.27.2026.11.22.23.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:09:24 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: marius.cristea@microchip.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH] iio: adc: mcp3564: Use guard() and scoped_guard() to manage mutex
Date: Mon, 23 Nov 2026 12:38:02 +0530
Message-ID: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Adopting cleanup.h helper: Replaced mutex_lock() and mutex_unlock() calls with guard() and scoped_guard(). Ensures locks are automatically released, simplifying the code.

scoped_guard(){} was handled in mcp3564_read_raw switch statement (case: IIO_CHAN_INFO_SCALE)- giving it proper
scope.

No goto statements were present inside older mutex blocks - so it was a
1 to 1 substitution.

Tested:
- compiled with `make W=1` with zero warnings.
- Verified using Sparse (`make C=1`)
- Verified styling via 'scripts/checkpatch.pl --strict' (0 errors, 0 warnings)

Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
---
Q: If i have similar cleanups for other drivers/files in this directory. 
 Should I combine them into a single patch or submit a patch series?

 drivers/iio/adc/mcp3564.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 259ac4ebd..252c3886e 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -498,7 +499,7 @@ static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
 
 	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_BOOST_CURRENT_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_BOOST_CURRENT_MASK, mode));
 
@@ -507,7 +508,6 @@ static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
 	else
 		adc->current_boost_mode = mode;
 
-	mutex_unlock(&adc->lock);
 
 	return ret;
 }
@@ -561,7 +561,7 @@ static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_MUX_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_MUX_MASK, auto_zero));
 
@@ -570,7 +570,6 @@ static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,
 	else
 		adc->auto_zeroing_mux = auto_zero;
 
-	mutex_unlock(&adc->lock);
 
 	return ret ? ret : len;
 }
@@ -598,7 +597,7 @@ static ssize_t mcp3564_auto_zeroing_ref_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_AZ_REF_MASK,
 				   FIELD_PREP(MCP3564_CONFIG2_AZ_REF_MASK, auto_zero));
 
@@ -607,7 +606,6 @@ static ssize_t mcp3564_auto_zeroing_ref_store(struct device *dev,
 	else
 		adc->auto_zeroing_ref = auto_zero;
 
-	mutex_unlock(&adc->lock);
 
 	return ret ? ret : len;
 }
@@ -828,10 +826,9 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (channel->output) {
-			mutex_lock(&adc->lock);
+			guard(mutex)(&adc->lock);
 			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
 			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
-			mutex_unlock(&adc->lock);
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 
@@ -840,10 +837,10 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&adc->lock);
-		*val = adc->scale_tbls[adc->hwgain][0];
-		*val2 = adc->scale_tbls[adc->hwgain][1];
-		mutex_unlock(&adc->lock);
+			scoped_guard(mutex, &adc->lock) {
+				*val = adc->scale_tbls[adc->hwgain][0];
+				*val2 = adc->scale_tbls[adc->hwgain][1];
+			}
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = mcp3564_oversampling_avail[adc->oversampling];
@@ -903,7 +900,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (burnout == adc->burnout_mode)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG0_REG,
 					   MCP3564_CONFIG0_CS_SEL_MASK,
 					   FIELD_PREP(MCP3564_CONFIG0_CS_SEL_MASK, burnout));
@@ -912,17 +909,17 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 			dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
 		else
 			adc->burnout_mode = burnout;
-		mutex_unlock(&adc->lock);
+
 		return ret;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val < mcp3564_calib_bias[0] || val > mcp3564_calib_bias[2])
 			return -EINVAL;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
 		ret = mcp3564_write_24bits(adc, MCP3564_OFFSETCAL_REG, val);
 		if (!ret)
 			adc->calib_bias = val;
-		mutex_unlock(&adc->lock);
+
 		return ret;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		if (val < mcp3564_calib_scale[0] || val > mcp3564_calib_scale[2])
@@ -931,11 +928,10 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (adc->calib_scale == val)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
 		ret = mcp3564_write_24bits(adc, MCP3564_GAINCAL_REG, val);
 		if (!ret)
 			adc->calib_scale = val;
-		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val < 0)
@@ -947,14 +943,13 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (adc->oversampling == tmp)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG1_REG,
 					   MCP3564_CONFIG1_OVERSPL_RATIO_MASK,
 					   FIELD_PREP(MCP3564_CONFIG1_OVERSPL_RATIO_MASK,
 						      adc->oversampling));
 		if (!ret)
 			adc->oversampling = tmp;
-		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		for (hwgain = 0; hwgain < MCP3564_MAX_PGA; hwgain++)
@@ -968,14 +963,13 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		if (hwgain == adc->hwgain)
 			return ret;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
 		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG,
 					   MCP3564_CONFIG2_HARDWARE_GAIN_MASK,
 					   FIELD_PREP(MCP3564_CONFIG2_HARDWARE_GAIN_MASK, hwgain));
 		if (!ret)
 			adc->hwgain = hwgain;
 
-		mutex_unlock(&adc->lock);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.56.0

