Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6F3988F3
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738523; cv=none; b=mP4SlyQV6PD44zKi96MPftTp5yVtAdKBF2R98Zk1ljuoLRUIJpU0rPTam71MT6Azl/vcsYyVU6QMWpPmcSdf5jqn6QW1POrY2/sBFgqQ/qPVKOodg9LlG75/W3UILF40tf5D+1NXvPgTgF+yK93sdhLDPOu3v1/0NMKDT0Momoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738523; c=relaxed/simple;
	bh=XVUWmg8j3ejye14jr+R8v/V5hJcLtfFCwO0Xfv6pPUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+7iEsoR2NAz4j8PlLtAgsLNPeMeKUVOQkxq0ab6Izt3c1dOQ4xfwNkxeDpls2gC9YfM0gQo5UJaCTc4qrv+/hv9FtB6I57L8vxguZt1Orhlh28NzSDBErtZDXFoGuqZTmgOVYuaP7Srqxy/ZfARUDJ4QKuCPtkJkVdILgLLss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K33Bjgkm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K33Bjgkm"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be0711f493so1828715eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738521; x=1773343321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5/kB0ndwJkYYZGbdBM/LgcKSk2jku2aKtlMXuF9DS4=;
        b=K33BjgkmHwlt+3gQJh3O/5EfoWOE0wPnzCnopROpyOzffVD7tzA/pKb1csMHdP8wrf
         8fppCxfacXKW9GgDBosKsmKn+XxJeSeQB7iPHGjqut5YhGaaVixcF+nLDfC2fze+m48w
         Wigfc5t042aRoX6X9dzxMZhEVluTdssjrfHFamWPtR6Bep/ctAEnQh0VhmmP9Zn+QQPs
         rmqgK+BJNoNFtuAMssQepPYt16IEPT7ponGKsJWW3THL5lXucsgKLsSHzLiFLmvEb5TA
         5f8rjHhPcScuSYkWZB+iZNrr0eOPsyaoFYrvmFCcacU/ZmqLVroy6gMJv8BQcIbrFQJN
         a/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738521; x=1773343321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5/kB0ndwJkYYZGbdBM/LgcKSk2jku2aKtlMXuF9DS4=;
        b=VnrRRDkT4dsPjhFr7VjohThi1QYPcAyl9R3VJmWAJ0zSJKRyr9N3N/9+JCetzgdRO3
         faiDxiosa93FTX8aBIwTKhdHcoNyKLGyaFjfVuKo10uKpIt4FrDrjF8ZIQY6v+raQ7ap
         rWK2/fk8BfhY7vJaDf3//Wnj6pDTsAdQh+fe+fmHeSqirxHJ53Bb1wjifc1cWdjRWQMN
         0aXyn/I+5sJ3XKG4jCIY32+2RDINBGHBIvv0j0Z5k0NESraRQ/1bBcemtiqHANHd0rHr
         aoUj0XghKqMYuEwgSgSMyCPYYiE75GLHF7Yq4oew5ZxkZNTIvai5mCxo1tPXVBWxofUa
         jdGw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+lYrtBfjK1pZhlUgXTZ8LIBkmJ3FXlLnrVSEFem4YD6X4yFn+rj9nNETZ367A+Ob/hix0BuZDAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuvg/UZ585FTByDZdg2XHIWPkVjMR3928QZ9SGJduQ5MA6WOwF
	0Ch7DbaG2sM7ut27KmygkuiT0pFJrYJj31SNDDssq+rF0jMwKMN2O0X0
X-Gm-Gg: ATEYQzyZgXiF82GGY1n1btrcNqFI2ggxbyFbJ8TUPbbVTjTZCX2tqz/Ep6tp9HMt4e5
	7TleIqk/ZqhmngfhRKWWlrnQz3c7sX428abP9ScvWrIlZs8lfnswcz9zd0UX7Bcld6nz//jPbSf
	wec3yKo8b9AcSW8tp5AsXO2gN/uAA8pjYqV8KTkSZqfz9dv6BawDNxZlwnn9RT8yUA6hzXFB8Vm
	6fLoZMCWBHcq+gXKRLXuZBcIr+NQw17h9eNEFvu81YDr/q1B2e4XgpcNKbmZ4OIJldFp8DBMJn9
	KhGj6yWubV/MuUt5e/ADTklKfaAtOEVdP8YeBM0rkXhQz3klxfGdzAhxskH4815BF3ecCvY/l6t
	r6x8NhO4UttNyTOSgXbBC93qkzN6BsRTNjmhWfSmbxe05i16BNqF/7xM4pcEbOPK7dExPBpv5fg
	tvmFDgw/mcC1wb/bsGQSWDdFUnwJm4u2osliqlVRVOlshPv2C4cZ2KIBVIvbN0ROlcphhvP8cG+
	f1101jgm3iaZ2XuQlsTZYYgsQ==
X-Received: by 2002:a05:7300:724f:b0:2be:fe8:8af6 with SMTP id 5a478bee46e88-2be3e62136emr1287405eec.17.1772738520860;
        Thu, 05 Mar 2026 11:22:00 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:22:00 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 05 Mar 2026 11:21:55 -0800
Subject: [PATCH v3 4/6] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ti-ads7950-facelift-v3-4-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-94184

spi_setup() specifies that it returns 0 on success or negative error on
failure. Therefore we can simply check for the return code being 0 or
not.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 1515089dd759..273c35e03185 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -527,7 +527,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi->bits_per_word = 16;
 	spi->mode |= SPI_CS_WORD;
 	ret = spi_setup(spi);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&spi->dev, "Error in spi setup\n");
 		return ret;
 	}

-- 
2.53.0.473.g4a7958ca14-goog

