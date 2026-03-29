Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88D3128B8
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824436; cv=none; b=gr8KCcPO8Nugir/1gwtsRWSdFfkLK0UsRNLcrvqCZ6eqOsXLSXaSmZT1qBd/30FhdOatMrtR5soN68bLUWM9nrC5V9Z6kf55KjbJQ6MNd7fc4Le3SO2FO/nOieg05CK4XDdnSISu0sMZ42uXostcw/ELfk+jN633AJshGLPHyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824436; c=relaxed/simple;
	bh=fuZck8myQoX8k0WCv45I/UW0qdwIBbPx5XxBl9G6Pa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZInOYSh4nhizqr5GY+CKfd9R+1Pkhhvboq6EltEHnhAQgRwuVxFmzRuPEr0eZW82E6brsKTXNbx16R1WnwbXFQB4N5HKDePznmBvCfgkAYmvGrSC6kjOFQODASfOSgGivrWIuUdc4qi47sfTl9CeDrTKi1LbI7RkVaI0PZhN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8Ez01XZ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Ez01XZ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c15849aa2cso3956489eec.0
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774824435; x=1775429235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKnXDyPHxP+Y+5jS7Wois35p2rZi45QRMmQZExuHS7U=;
        b=c8Ez01XZ20lPhRSjFztQaSiOooyWOLC/zUH1IxSOM4gnDe35As2xPkWAdKr6RYqpRA
         6nMA5dWfws/sfvul0aeMfrqBhGirC/YsgoPA2w5nv7dqWe0RKUgg88sIjE/oxasMKqpq
         TFWu0FVaziDi37+Kd33tnJh2q7rtIzX2A/9OYQxUFRPF3AOppVSf/lJvoDEl5yMw64v4
         7yPIEjv/Z0sLa5OdivySGGnhIvYIhCki6PmK8xG5vLwsNJ5JroE5A00l5Os2QNbx5n3Z
         65Irthiq31dE+BWY2YEXVugOLsnp7idnvMFDewBVsvTNA3VYTqUyK/k4YeLCmwYnHzoj
         htqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774824435; x=1775429235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKnXDyPHxP+Y+5jS7Wois35p2rZi45QRMmQZExuHS7U=;
        b=V3hU+35ztO95LHp506kgmwGOQN9QmxuNXqwcAcSNrpj+RE7MfKSBi58Q7OuAIze9yn
         rIbSq/VVHlwSVK7EsZCabkSN+JrCKWGN2Nisb5G6qwW1KkuYCSLmG24wmng7NWSM+6cy
         sZ57IhLQMNtfXjJq/LUx8hN38qGgOE6JxFzFz6E0mS/f2BBn7GuXj7qu3oJkypltMXxN
         QIYlIXTwlMhOFkPYjhtA1khhW9Y3ft/Ib2CEhuvJeehhw7i1//ptn42qYJfE60XWCy7+
         pcbF0AS0yizmXSm+cKSFncwvnqyadj1JPPgw1A8RbJujZoLhrpp38iPU6V+zQ30Sle6t
         y4lg==
X-Forwarded-Encrypted: i=1; AJvYcCXulmadc+xzvV1KGIMLzUx99Y0ZV4sJQi+QshUQhU1hUu6O3EJw4lRTYevEld+jHcSIokpWMf+j9M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnmMmSW540G6Pl8r3+I9zyh1FCNo2YenDLOTKBIPf8hxg/5Li
	YgkyWTqY24fBHPIsHGH5gBc+/9XTt7XwV9x500bqm01U3zagsekm91kh
X-Gm-Gg: ATEYQzyJJTnJ1kpMAPkzivgbNDgIQ1BZQVNjnVoMB0x+BpoAzEwYZviH5l420we53p9
	f9IkNKm6NY5mr5nPKhcypLsSBLZNhtPckOwma8YI3ZU3dC4CNxD4XQrVjC2ngmbp4VVP7MA4/Uo
	4MIJgR0W0jSqW50m5sdXqm0uTkMqof0yuqinhQ8x5bvFRhrcR/dC75ERrFS+WC5TFBrjOfBbWgN
	xUqyUXun3n9dLrDs3wOV0sVVA1ff248ey+mZMu1iVElRX0Zr68+Pb4nMeyY3LBrBnu+Ia6Eubet
	InfBITEC3+M/EFW4ucWPfcr0ZeQ2A8V/sA6u+qlfPnmaUb+0fr2sBVicSGLj/CG0sq4UU2iS/Ib
	UjQwDLsgwrOesAurC/TgiT0KU88l8l31ZvDYF+AQeEZeIClyabF03xw7xLNiP1A3WxmA4iOqT4N
	6ril9hXjy4GgKHNlWL141XvowVuuaR+R87bDVuFnyQk00HUn94+4Aijx3YXFOeZjWpuXutvvRoN
	gy748LPGrKsyO4=
X-Received: by 2002:a05:7301:6781:b0:2c0:c9ba:1192 with SMTP id 5a478bee46e88-2c185e069eamr5267348eec.18.1774824434599;
        Sun, 29 Mar 2026 15:47:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm5840295eec.30.2026.03.29.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:47:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 15:47:07 -0700
Subject: [PATCH v4 2/4] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-ti-ads7950-facelift-v4-2-c568c508c49a@gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
In-Reply-To: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-a6826

spi_setup() specifies that it returns 0 on success or negative error on
failure. Therefore we can simply check for the return code being 0 or
not.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 6e9ea9cc33bf..c31c706c92a9 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -520,7 +520,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi->bits_per_word = 16;
 	spi->mode |= SPI_CS_WORD;
 	ret = spi_setup(spi);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&spi->dev, "Error in spi setup\n");
 		return ret;
 	}

-- 
2.53.0.1018.g2bb0e51243-goog

