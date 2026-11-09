Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243512;
	b=YSEQ29hI5fcWQAkO78r6Am/SLwRzg6ezaN6CGOTuHz80BAHzl9OioB8cK0qkXfPZsIns
	 vM0tT18v4NeV2cwMHpP7MZbloIrV263/fR0Haj9SZdDRaCkrFT5BNxG/4YegPN5QSYz5i
	 JhDOqqjrb8JaVMmdcnBTNIp9PyrM2xSy4+7hQRQpJAwpB6DGK+BZIU84dJ72ZiuNqF4jf
	 Nl3ZY1A3joCLL0ig9JioYC33em9YhvwuQvIe+/DKjt6G3B6aysZTgq010X7m0f0J3HeAY
	 GT3zACfuRccB39O3l+gnqku4ciVl8beYPtljQa48BdNMjb7E5Cm0xrlHvPP6Nh4UqFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uSv5FaWike0kmhQ2+P3ysE2aCmLM2123k0sFqlEhOLY=;
	b=FcR9SedxX23Tx1zGjbgxudBPnQhCDF6/outc9nbUVmgigr5USMqFmnSbgwNyhlUPZ4Pq
	 ReuLX1GBff5QfbKyeaA8dAuQvt+qf+eYZxfQCgkUbSPn9ctyGaJQeTv6TGcmVMOckYfDI
	 kxGCaX86qr92f/A84BzM2GQiWK6Zh1MC/3hdvRc9Y7/X90J/eroFaBbmzODkNv+493Rbr
	 wtvM9rPc2Ujgh3/H/0zm8gFqPcGubaZwC9UMzVtK9XZ+NKYoNNHnCTcCGUsnjSC1yVUf8
	 rkFNRqfd30McfOCVOiBVFeedEl10vBG0mZGKpAfaXIrYDqR2vNiSmGdI+RbAb80Txvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDB0kSfQ;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B54606EE9D
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B54606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDB0kSfQ
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0a2a44a0cso694250a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243511; x=1794848311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSv5FaWike0kmhQ2+P3ysE2aCmLM2123k0sFqlEhOLY=;
        b=ZDB0kSfQ4Rb8KMSTfuDH8rxKIm/OX6PjsF5lAxXuJxzywjAAPP1hcK9zA6JZPn3bHC
         F++r7/GuWwCYIOZAtqpDWeO7YU+0iNomAfVTq9H76mywaYXz+2JQdlrcc9I3J8wS8tU5
         MJkWdhWuBAKDHqNlcrfpT89Tw3KX3Yyq4Y+4bn/Ne6e/2Ab+fXFVPZT1IX0SAeP3zbtS
         YQL9hCELIk8t1yzz3zn6Imd6OW50VRdZQvZtw61iV5DwTpQn9pV5gxbPqLEPws4U07Vd
         4VCm1y3fgMnxyhWa5VZQNP6wCIyEtPyRtRnm7Q4ejy0S1uf6PcuPT29/vH+KK7T5YLhL
         bSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243511; x=1794848311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSv5FaWike0kmhQ2+P3ysE2aCmLM2123k0sFqlEhOLY=;
        b=H4XYUUPsuMgBi0g42O1vOf4SpWarntudP3aZzJUJh8OmDtJJyK97pRWBa91n7DEnFZ
         ANnibryAJ8PC6G79oIlR+horMPvCxV9ogzqx+7sX9e43/to5jfrb0Z4n5Nbz96Ed+eco
         4CvmMOzGnjIXqH2g+DQ1o6XWZyvVH4BWE3w7GkEP4sigpDDQjUkXnzkoxOT9hJdyYm/Q
         X+elt0Mmz/YT2JQvEcCgxYUDS9f7kpgz4HhRNxJ1rpne4fthwNnfwc3BrqJoMOVCQ88E
         B4YszgM+zDuf5l8sy4PQke+48WYQGE+mbScnQhyWdYgXXeLmZSA3mYAwWPsvCpsY0eYu
         COJQ==
X-Forwarded-Encrypted: i=1; AL+hErGI93tl1KURM88xAKdLrFDU7NWlDWw/fJSnyFvAYbMnxngEqCl4AjIX/BB8YZ4XFOUUr+JXmeODYZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MTJ1tkU10BdNB3eeEgxKlkSn6w/6VBJcmjcfEI+rIwIsnK1tU
	pn55NNykzhagZv4XfbwvUmGkDxrRw+ekvbtGOfHZ92bJyriXBau0o/bsDNISI9dv
X-Gm-Gg: AYBFou2ZE0pBupZfXMrsjIr9Hq0lAZqbkJh75W1Sx5nM0CJ2eOqDPLHDWdAu2rtnueD
	gJKXJ3aN1x8wD1yxhdf8aijceKQGrr3DNd30iK3+Lb1F2VZKDK4nVQuftlLaL4Ym+FEto7ZTvnt
	GCAv74ronm4In+robtFTrfV/Fn42IvPMKuA5sVn31d8jBdu7yhuk+CobwPp0Ua7eM37aiviClgn
	k2wTWjqC7clWGMT7MoGrtkkhCNKtEKNIbPsW8jq+cVtCWAke0xtwRzSmY0W112vmbwlG0MZDcTt
	x/4M3ngMl9XLLFpMXFpmxe1Y9BT7yEP99Zks52uzJD5pE/5gwZLWHo1CaEvMYEj+BFMPWs+gom2
	4ENy5Hzx/Fyu+Nra+IkL+lsujW+HB8uXz1iaZRlbKzUMlpLSWq8W19JxdNhrqkWIEyn9Z3TY9BG
	HdS19g41pLguAE5eG+T6bnm8ktygjnjz0tMDY0LqXhpEU2lJ1astiaED6dEbFwTA6cYU/d1xQ90
	3eqoZJ0D56gNi8zcKt1RiLpzliMe02k4SdzRNvrsiBooDCtPTFtTkuPqqq3eRdo8jG318/lHb+E
	yHAPvlgVP35hGjYTuQvRdE1pBdmGQP/nmvqYVAmud+/Bi0xSlWmWTPwVtn75kbEraWltp5MDAwB
	4YvUW
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id 98e67ed59e1d1-3b166cd4924mr207833a91.19.1794243511464;
        Mon, 09 Nov 2026 08:58:31 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:30 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: [PATCH v6 08/11] iio: adc: ti-ads1015: use devm_mutex_init()
Date: Mon,  9 Nov 2026 22:28:02 +0530
Message-Id: <20261109165805.31160-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165805.31160-1-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
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

Convert mutex_init() to devm_mutex_init(). This ensures that the
mutex is automatically destroyed when the device is unbound, and
simplifies error handling.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 1924c1b2abeea..a65da3742bec2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -970,7 +970,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5

