Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8F423167
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467213; cv=none; b=nC9yEOWCfNFXmuZ9yBQ+V/0jqII/4cpD7viu3jmwJ+P3Hzn9c9u2eZ6hYcYKs07E2Rr3W2Njf/7f/MuT3+Jnzi8sJX/wsvyExuWKLYwk1NX2Q6MSJncQlV2ORaQW31BRJhL9e9D4QdHdsK8leSa/+YZhTDLWzYZImDoh/AtU38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467213; c=relaxed/simple;
	bh=h5rzvGi1/G+Ful3OWovrvuW1iNjNYNlflYV6uCBBpRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ojIwf+W4iL7f0JIv2chqxvsPb9KgeF96/wPqJFGbgpxB3AFxS26IDz5ag9YVKiJrRTZRfQjg1QnVZqUJjKzSuFqXyvY/X90CYarwMvXlvhw0RgCOgBSC13AL1ibDVyBpUSA+7N/GfIHRCX5u36crav6QnCU0LUO2HbLoCzFhgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKc9CHCO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKc9CHCO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82747396358so2196080b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467212; x=1773072012; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdygrmGqM363HHpCS5E1KS1vjEdVqeuh/EoK/GPYeQs=;
        b=IKc9CHCOkG3Ug2Wy2zN/LVjRAfi5Ov1cjErp4ycs6EQPk3VhL3wB/8UaQkgAfigmNF
         AsSTp9Dq4Y0cqE+rrC+TDXoyogGxVVeUrEUArvfv3Tq96RusUJ3Jmmj4FL3ecJlmGnNK
         4r4IWX8CEp3S1WqiOk4sT23aevM/0k5iFP33dM2zN7ELt8rCw3nmYzw1CP89vY5VJaep
         Z2hwJI3S+zaHLfuDqLQ0e4+mhVExUYK84piYS11sKW2QXh7Wk27ub6kBUeIi7zdueLIt
         NzO0b7IsPxzrhWKBsO/ZfUIWJTsJSE5vzRRcq3E5ceupKiMewzM9wgqlMHzTdBuWIVsg
         Wz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467212; x=1773072012;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdygrmGqM363HHpCS5E1KS1vjEdVqeuh/EoK/GPYeQs=;
        b=u4LJppS2rhj3RXJ66vfygBFYd4RrTGENEnEYdZAXyHaifkV9XAfpJJZyPWvNYX8J6s
         UCVNFmNbJye3AthQAmghVKH7cvXYnn1V8Dm8Ez+KkK85CO1NUPyur7dLPgtTx0EMzLdF
         /zV/d/Rs2OuNRpQrQgJ/dBFngKbuiJJJRzjgc6QuxVstjGH4cA9LyHXURwcqlvXlE5my
         KVkcjJpokjweyEKqZV7Fe8o+Ib7OSAAobTQCPfw/+zc+6PKL5ZvzYqFm0Yk5Enct4S6w
         WVTn0SO7FZtaHc8X4P5C29j2gvpuX9Rlgc5iAiQK/xptaRa27ZnsxdR/WR91QdmzdQkH
         T2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhfOlZjq+HpAvAbqMEWjRg6SxHVflo/qv2Utox1SEwfMNcimcOqYPvWudQbAShyZYdTVETAEvxbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgg09Yx3PAjGhn7QM1l9hG8NPWGimiLU2ekV+kNPlXbFqRMt1
	gEekMMyuZwM5Pw9214UD6LPUg9R8oPWscVGX4RBr9f6+n3PXtWt1J0qe
X-Gm-Gg: ATEYQzwkaF8mqkIE8aGkWitU/T36JkBhUcBTOyJUlDP+UJDaIo88diajsNmuIgpT2od
	Bpv5loaIxaHBm1W3c/v3PJ0dIxhWWYXlM76f2tPBiyOPAEbPPcC0LMl3kAEYDbuNjef143i3kyA
	A0AKgi4NPEGNt61WQ5/pNIncfLD26ojm8j78QhFAHi/cSaLKHVlNZwQV9UTSIwbOKn6O3apzPgo
	R3ObCZR6SBXot5kd1p+RENMC04FJmCnpJeiEbayf6xdhhve6ZBD8aKAiIkZnJQJYWiAiEoSrnbH
	TtSdSSDJ6T8YysFHHOR1RySCjkLYDETzqCj15o09Ltc/jCC/f2TFCR9OVy/zV077LgdSu5eQY/w
	BQkbInRqAVGb4VG40YtW0oorNoGWc3qvlWWOXtZ+wwLLj31t5bZjsWTjJPdA3IdJwdXkyLmOZS+
	KlpB//DdaMPbPTP7VtyZno05p8YebjtCU0m7SC
X-Received: by 2002:a05:6a21:9cca:b0:38e:90ca:5a1d with SMTP id adf61e73a8af0-395c39f7babmr11920653637.11.1772467210523;
        Mon, 02 Mar 2026 08:00:10 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4c92:fc5c:54e5:712e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4e10csm13982076b3a.1.2026.03.02.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:00:10 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Mar 2026 00:00:04 +0800
Subject: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAO0pWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3ZJM3cSUYkNDQ0tdS+NkUyMTAwPjFOM0JaCGgqLUtMwKsGHRsbW
 1AIy0w0lcAAAA
X-Change-ID: 20260302-ti-ads1119-93c524003d3f
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772467206; l=1419;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=h5rzvGi1/G+Ful3OWovrvuW1iNjNYNlflYV6uCBBpRQ=;
 b=+TOwVyloagu5tEDdmm63Uw7Sxd0CsVjXe2wZaIl3BA74PH/sbaSKX9d6kVI5BHE91yTftbBXK
 4K+CtF7XkytCzXL7l2uDUWmLviqefON936ODM4nSAS1UyPI4XNgv4rV
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

Since there is no threaded handler, replace devm_request_threaded_irq
with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..d92a20945b80 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -735,10 +735,8 @@ static int ads1119_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "Failed to setup IIO buffer\n");
 
 	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						ads1119_irq_handler,
-						NULL, IRQF_ONESHOT,
-						"ads1119", indio_dev);
+		ret = devm_request_irq(dev, client->irq, ads1119_irq_handler,
+				       IRQF_NO_THREAD, "ads1119", indio_dev);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to allocate irq\n");

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260302-ti-ads1119-93c524003d3f

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

