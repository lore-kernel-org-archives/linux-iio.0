Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3A1C695
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618518; cv=none; b=rVlk7NwrJEcP7o4jsYpqeqjnt+Ss/1bKRq0mqz7WMXYZe59gVy/KsnYzXwQX9XltyW1jVoLZLnO+iyk1RdnvadRkvFMd1I8RkCVbnb6+/9AJYLBlFwZWtiu0Bfe7RKB5Wjg0IcU+G+p8XoumQo5EcOKvLlInHiEUFpiPxwJBUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618518; c=relaxed/simple;
	bh=gOQIGEZOf7WGe5DA1rW84iRLmYd0ol8jSAiWlCXFmf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBOgLA6j1wL88Kmi/x3iwmUR2fanAjBjsHbykiToR8zo2jMqSe9MH9bbVGwhfDZASnI5jrBpLea22GVanXqrzNaigApwZImmSxy8WrqI4+P0dgABXBavni/z5OQLWzB61Mmv08p5I9+UgsXt/a2KmAuhTTTZ3sIcTBbbkQINph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=m47hMZXP; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="m47hMZXP"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139aaba3522so1475938c88.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 20:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782618517; x=1783223317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRIZLVQ+n04iCxlctyw6NGK2ak4+DiOwKPN3FvKaTl8=;
        b=m47hMZXPffi2Km02qLqHcKnR6HtgrQ7i+bXbCvVYQjpoguxvgFmEBgdMBe1Wg86Rpu
         C7FNMPlGb4xwSk8ZOTxhaubDiQMBZTVgOF4Wc48dkYOb5d4MrA0KDqGHJtQHOZDJ6X4/
         wDNnnyChCjXfzXuSIjUq2LzLW/K7Cp3CHYQVOZgBSDUPZS6Vtc4sf0yEcGCFLiE6cmGu
         cP/vnxfoRtc/oXaQeY8qFhAC+8pMVA7/QHrBPuwbUfa1eiiCFpPcvJRxo5lkRHE2ci5U
         JBKcwF97juBtd8umRsnkhrIX+arDBXJWPngX8UyHDu1SQVS3Zcf/MwIuLPJiMdox74GP
         zLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782618517; x=1783223317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRIZLVQ+n04iCxlctyw6NGK2ak4+DiOwKPN3FvKaTl8=;
        b=NdeKopMKkA+fYA1EKcMLHalVAQOGIoD4wjrGV6gA3FKj6YyM8vqK/b72JO0+KAH664
         IdV7cxm+mgs1e9YMKy+Qaw40Zo42+B+cHxtiu7j2RDIsNZgVenIDEikHKp+l+jOR/0sB
         Hwz6Xn9uR534cCziBBFgY5/IxE/8r0XpUZWxPm7tewd0f10udXmmzVF1GSAXzH4w13Cn
         /Hx+Cno7BCvoXi/4RkbJKBYaBcpzsPjfp1bptPLWPrtY+8wqR3j94El0RkOrdSUqlb77
         6M873OStee5hicxnh6n6zc3xtKBHOiotaYrpROGi7hdCf+BZARbjjKcfPo+oecafgA2o
         8U4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9JDOhAmSxDCp6ZlqHYriTbKTs9/IEGhyXAdxBc1cnp23frlbxs8TbsQbPNATxSkzJD83Kkg4N9ibU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFyzJJSuPWxBHsM0lncdfAYFgPmMpvixoUEMo9xITr9+UlurC
	aRg/K5H5/SuTfPimqCysk2ZmA5td+62ukIosjVO7Mq0swqj8E3xN+Zc5/5GBNFn7XhE=
X-Gm-Gg: AfdE7clHsyG0JG3SjZ0ABz1ggcAtlfjJ9G1+RayXGBUth/SFSaNZ0MMFxmUxJsg5pXm
	WB4MP1AR+VuOwOHfMkaAwl6dV/CKOX19S40ijx8609M8reYPW4zUIvzGWY567+pdn2YlHqoZJ6Y
	tej+QPQ2OgTV1gkKCZi+Ow48SLh67N763oJaTASCCH0fdZBnXizTVMMr6dRBJOIA+r82/QeTdXs
	jQjwmbKbqNCcUarBYqW4r313+e9wu/9fys+jwlO6DpfwqKycD4ywE02WRToYnm/IDRyIfyItZaX
	HnW8qzEB8qXVPx4ZVEIO0r/WN0LgsO/lV3v2aaTrfUajv9hOom9HGThZiBadc/nkpNQoy0wkkBG
	Z4nHfZF1D2eBExI9JOW7sg0N7Jk56yWvLUppsApyu8cC2stbSW8ikj1LmknTo7Su7pHYXZN8DkZ
	EcjgBMiJO2IVYIk6snARa6N+p4uJizrWWLSmyM9A==
X-Received: by 2002:a05:7022:f404:b0:138:4021:b20a with SMTP id a92af1059eb24-139c3c123f5mr18968314c88.3.1782618516603;
        Sat, 27 Jun 2026 20:48:36 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30c7cab28fasm35839384eec.30.2026.06.27.20.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 20:48:35 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v5 3/3] iio: dac: m62332: Use guard(mutex) for locking
Date: Sun, 28 Jun 2026 00:48:11 -0300
Message-ID: <20260628034811.152946-4-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope. Also simplify the i2c_master_send() error handling by
using sequential early returns instead of a combined condition.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index ee8fd3a71315..3cde38ff5f65 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -47,33 +48,26 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	outbuf[0] = channel;
 	outbuf[1] = val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (val) {
 		res = regulator_enable(data->vcc);
 		if (res)
-			goto out;
+			return res;
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
-	if (res >= 0 && res != ARRAY_SIZE(outbuf))
-		res = -EIO;
 	if (res < 0)
-		goto out;
+		return res;
+	if (res != ARRAY_SIZE(outbuf))
+		return -EIO;
 
 	data->raw[channel] = val;
 
 	if (!val)
 		regulator_disable(data->vcc);
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
-
-out:
-	mutex_unlock(&data->mutex);
-
-	return res;
 }
 
 static int m62332_read_raw(struct iio_dev *indio_dev,
-- 
2.51.0

