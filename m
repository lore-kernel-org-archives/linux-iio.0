Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209F30E84D
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844448; cv=none; b=LwdX02feM4jG0N5d6Q9mwpycOCmzNoQo5a7q3rJtkKzhg1rwvj4YZrEe7L4plCJGAujrj8thLzvrHtDajciLMe/fHfkFAOQKs4gbbB7sTcW9xeISCts6Jl60s1JjGlSbLIl/v9IVrkAEt98z948mf4Drw+88yTb4efaI4P/lY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844448; c=relaxed/simple;
	bh=Xssq7EyQ9mQf6Rb1eUad+lTaKyrhD63PbIsPDuRZlbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=db1JyraOXH826eDJ8gdYhSVMo/59Wb+twk3Acidh+L04W8dyD3K9FkSc+vrYh5D+pj/P066x5O/DHyITm4Fflozii1/UHFi8+5Gd4oAeSqqdmx7xuEwgcLk4jf0SwVRFJAR3GCJYjpGOAOHQs4XphL/TEUqpkNcUV3MxaIw4Jb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX8K2OUV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX8K2OUV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954aff6088so9861315e9.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844445; x=1785449245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98mv/f34DmMLxvtgZAJf8Ex1jdizcbjPKXCeZSrCyok=;
        b=nX8K2OUVCmJxy7pgL4x6K0G2s2nKpQzxl4yJ7IM53BQSj2Mikix9KoFeItZKGyuP9a
         XmQcKRJLQaX06eLYURs1sIqEshyLk+VLCKHtPXafo7tHD9T6cwwqR363lHOspcrVx25o
         ApXT1A+8WrhoSaAAx6JR0j9XxKcAM2Ts83E51polA/dh3WonxDN5ptQPNIh/9DsiIUKX
         UFZayDlqKyPPeNk0aZNT9GENcY9TY+iEsGCBX0fiNEChZw3gkKdq2AY92y2QIT9J9XVc
         zNiFwptB8VMmXCmzw0Atv5m15tN8dJGzIFeqo7UuYch+fm6cWAe4R8Hzn3wqe6bSe+gP
         Kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844445; x=1785449245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mv/f34DmMLxvtgZAJf8Ex1jdizcbjPKXCeZSrCyok=;
        b=HA09npCuiNyvyGOk2zgNlzdX8h5Qa+ao32ozZloiTzxR8LMYTNqI4tw3nfpmaPCJit
         sG5q24UXaaaYQ77BWsbk9xK1LbcTjTbdPVxhbFflvHi3YE5Hg1AjPrE/oaPyDqfA0nSd
         itPyBUmDhaUJ1WQNl0s179z6ATdwXGb0TtrCp8zYMSxcbnSNx6y7LyS6GDMtC9QTTaVs
         /m3pTl/0Cg+AsuXRMdvBuRm3vXb48tw5ot9vctIy+dI15bGck2kbhbjA2vIzWXpctdm3
         UHM7chDwU/3X0dYrdAgYlWLUU/A16U0ZPNN2ctxN9ASfR+531lA8W89bcyeXBVOOukIM
         tCRw==
X-Gm-Message-State: AOJu0Ywjv3uWWVDOwecKe3bH7mjt41nurBJiq2Q26wppiFf+vXWnD9H7
	jY6P/wQ1WMCIg3lp2ZQwzGRUmD0U57q8Njn5lp8FcPtzywEOP+K+s9iQ
X-Gm-Gg: AR+sD12vqoF42yk8/0TRN5Go8Ck0epLCoArL2KWJZ9GQphRWUVsofjMUAycWh0bCAaR
	uu5VJPnX3zHULazmeePt+trcjoFx4QjCdiOFkwoRkXJR7eI7oGaG62yugdT9XKJGfK1qp6AQBNE
	DLhP5cyIVdwTgKACt6G18eFNYmHTaXDpX2+hRe2KbD6ytuSS9N1nCgJTCmjAZQcb6inCcrJSdpf
	o2rM+oXPDYA6Zx3vq6OkRDDKsfnguahlGPWvabgqTewiiVuBLFUY4IuUWqz+cNT8DqGS/cTUQIc
	PGFrF7GfAxV1KjZq25AQmpXgUxn2hG9qP6roYPMGgh5ZSxj16X50Hit/FZZkDno+nZRiYv2m+mX
	XeonaEtW4gNasi8umfNbpQGbUybKm73MMjkmCm6uD0FlfruXY4FojYzcIHrtzGa/FKpC1M6Ndr6
	91np5p52I5Kib/jPVHeEYWTQHK9AKzBi3z+gzLK66ZtxFlE8DaCsMxwoeQIgK/0WjTvjnorQm/s
	zR+V0P7Ozkb3vvCWB2Trpk+l4yCAUtHRIh46Q5g554KUmALbzQVnPz/r0ttV4wDEnj82KRik3Z/
	21KqNLsnKICo6rNSgyN3nqLs0tjNiwifkea+swGVnJ5IfkVEza6Fi3lCHfH/2UmsIWTy+4rycJs
	Et751RLEBUYUgZMztXK1pVKT6Ag==
X-Received: by 2002:a05:600c:3107:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-49573ca9945mr48107595e9.16.1784844444989;
        Thu, 23 Jul 2026 15:07:24 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe3687sm6935985e9.3.2026.07.23.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:07:24 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Jul 2026 00:07:08 +0200
Subject: [PATCH 1/2] iio: light: veml3328: remove unused
 i2c_set_clientdata()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-veml3328-cleanup-v1-1-240ecf3e5097@gmail.com>
References: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
In-Reply-To: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784844443; l=720;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Xssq7EyQ9mQf6Rb1eUad+lTaKyrhD63PbIsPDuRZlbo=;
 b=CJw8HzZnjgsNUqqNDlOlrh8H/RzvV5EbDW2/LHR6CUnNcyWFeKYqjCLDzCyT7+C/RX8ReFPrD
 SArisdF2W/0A81L6GwTKlgo6UgapfCrT9mTPNN/XrvXvJczqEmJ+VNT
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The I2C client data is set but never used. Remove the unnecessary
function call.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/veml3328.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index 7ff1753925c4..a65748466116 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -318,7 +318,6 @@ static int veml3328_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 
 	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
 	if (IS_ERR(data->regmap))

-- 
2.55.0

