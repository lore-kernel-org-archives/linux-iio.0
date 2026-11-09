Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243212;
	b=bfd7+1KMrjczANy7NX+FgvQamdztJ9GEGp9GwpDPDbO3BLyxKEchVcJEvA4NO5YjTwbj
	 i8YMN2jYcRjTJaPMKMpdYBGAq4d0KLgl50HR8yqPRDl9tlZLA/zQW5CCfLjTGsM/teuYj
	 rFpmkgTqCC2sZAf6EPJB3C+yD8/DSLlBGswkxtVuqA4pue7RzuZLmhJSyBM5vCMX0KyZo
	 0vnD8TFMm+cW3yEsoX56GHPgMf0z35BbXnmird2ciD2rN0l0RgJwcwLSAZt8rG70+IOmw
	 zLrJ5g6SHg5XLmCJWOWVjz5nV/FH6Lx0mzRUyi9dL7IsZB30scP4DAMFlCmWmTXCWMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n/o+KdlAQOdJoFsrUVk4Pwcg9WiRwxYqGqB2UYDqVSg=;
	b=yn84P2Kvi2dB+hTwJQHOss6sBdqtsdY3dXPueHUxMUbpzMm9wlgkBvtPKggu9iNtlm59
	 xm6ttGm95IQMXteKQVV/uc2RBINbZpaRbxmpYptxNxtRcYOq9OOtLbrGqrRKVOh3h8m/f
	 lNpKZc8SV8QJXRNj4I+AqNVo4nGRt+z/XwKWKSvRl5f3YathqnCpwIFuzaQMVEVdMowtC
	 Q492p/4haVoyGAel1pcGooH9lZuX8RzSClr172H8bC27WXWT+gDF+bVKx26RQfrW37ONM
	 s0xZOpiMlHyWh5TDFPlv1ZP4khQWNP4mEBoa5+jK/5wTHq7Wf0ZIfut6lg+lOJ9CfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZyuxNP8;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE611606EEA5
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE611606EEA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZyuxNP8
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb9f760337so527011a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243211; x=1794848011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/o+KdlAQOdJoFsrUVk4Pwcg9WiRwxYqGqB2UYDqVSg=;
        b=cZyuxNP8L3fSZDzQFMRV88CjDipkL4TLG7usKIljDDTCMMhj5bbbCZc6nNe67iSjcV
         qtzF/4NoXCejqWlHjSJvSvzWzVYiEN2l8Fn+qiGGx0b2Ata+ypjaVrihNTp2WwUVrMVa
         TkNomnzlOAWzpeaOeAtxQHliE0o6hWVKhN2tZESrmAOCN81kF1qK40EkJBTtSBKysmux
         wbR47QtuFg8ZVQ/r81PxQTwyzHnyKBjoy04F86cshlMh/Yy66aQ5uVAC8p8w4DFvb157
         F3qhxi4Zf1BUCvsFmvpbyGq/4bV6P2b3PnR5qY54zZscPN7oKZEky6glBx6EDqKCZCjB
         qqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243211; x=1794848011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/o+KdlAQOdJoFsrUVk4Pwcg9WiRwxYqGqB2UYDqVSg=;
        b=AX8+qxRA9oKukqsKFTxZYMZDs1ktgolkqaY6DyrWe26UZpkU87tBDDqr+6676p+Cxx
         3NC8CP3nS/nIicS2Qwalav6UAho8xIprBVghLvWWFMXbziqF6slbMXVySuc3dhm05PkB
         1ntcT1WWmk2fjqbSrrX6U6uM4cJM6b+vA0XoMwL9dwtTnBhTG6yc37MZDDvSORFmCzP3
         sDChdJ77JNf1iEZIXlMTM2YjBJXOD5K14XOzCWcsdT9GVgWnueoblEDYThO4Fyr2aDuX
         SBpDAeWp5OMfBzw4YwQ8cjWi457jY1Bg/OYg0kaK1FsvY+OGqCyDs56vnaaPMG3mxgTj
         qGKg==
X-Forwarded-Encrypted: i=1; AL+hErHt1K2vgclbqZ1c+YEAKk4traSOWCuc/ZSMHJewvrTvLYeBj6ZkJZqvyh9WAEAAw7fvuBUUdSpXbH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uARJNARYMT9WJozpgjsDcVaEBshQWlnGuDWaIhpUFXO5OX9z+
	EbFBpnGYUm8Pt1d2mZqaU+mpiVX7QN8cE+Pa4XF0IjJr6Kp+haebYOcf
X-Gm-Gg: AYBFou0JWAZT/go2o4HnLNdL+uoWzv3HCbkip+3avPFaLM/3bc7BTcg/DTwjwHGI6XC
	Ld7ql9GsQlLvj2T+/BytpWLYv70z/vQ+rVkjbCTH9XXzzNFZPsL16/4k1476cUU7b0m0Rk9MIea
	JqmqE5t/LhDjC3ayAzZ3uqBKwQ/TMSlcdz8iUlgmyLItALInNlmJDsXlOJA4rKcXdei2fZqHxxK
	GiSB75NqNdGf0rtmUq05KEgpz4WGEMtar7z1eg0PAjoPzeSlvVzTip3ghFMC2Yrvwq0zEykRywe
	l+GnMmM9ZzJorHW+FXoDRK7MK3WnU0s9gdKomrBk2YbhyZ2DkwV+pIc1mWnXAornrsBNHAIWD67
	C1RIDyP+bjmPrqTALY4+GWAqFY/mkhX+mq7KA5c62kn56ZdTayA8yFYRKD0J909pn6Kb4N5LtB9
	C0xFlZkfyzLAyzZt4NAhA9NIErcjPZzl/BRjLk3nvYDOLn3jTZ3l5nUz5T7KBfZW/tY8Gx8WaVC
	Pm/4aQ334jg8jBgpXQgu13ke3nlMco6Q2P+LCT1m8Eh02HykMiSyC4q41v/HUSTy/sGaDnRpK7n
	5cjxPOvAI61xFIp5+89BvPzchf0Kh1VS53ay5sjPQqELvOum6o8NzW2MN2ifUxk1LeXneSnAZPR
	9gK9D
X-Received: by 2002:a17:90b:5688:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3b167a2c765mr50121a91.39.1794243210983;
        Mon, 09 Nov 2026 08:53:30 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:29 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 04/11] iio: adc: ti-ads1015: return -ENODATA when match data is missing
Date: Mon,  9 Nov 2026 22:21:32 +0530
Message-Id: <20261109165139.30803-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165139.30803-1-architanant5@gmail.com>
References: <20261109165139.30803-1-architanant5@gmail.com>
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

When i2c_get_match_data() returns NULL, it indicates that driver match
data is absent rather than an invalid argument being provided.

Return -ENODATA instead of -EINVAL to more accurately reflect the failure.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index af3ba6b75c410..d18a2ac1205ff 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -974,7 +974,7 @@ static int ads1015_probe(struct i2c_client *client)
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+		return dev_err_probe(dev, -ENODATA, "Unknown chip\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.39.5

