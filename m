Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44B373BF2
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471259; cv=none; b=JobRi2GpBQZjh/Ey1UOLQr098x7OM8EdOmqOzWwDV5DLqQVvLDsRvOsnphhxnZyJCAUQmkEGhhKroBbSKsggzwvdvkNoxc6dRUo9mzfJXXvQcP1RqpohUX2c8elhRijkXHb1XZJmbDE0QBANBj1FBC+DWDdeUxuGqxdNrhYwunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471259; c=relaxed/simple;
	bh=0Rpn29yJr7uo0YCxP79RgwAGaRqtgWqWXtfRX+nEb20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=axZm8P1SYFMvJa2beBP+bs6mFO3uFBmAOEAGYf09OJC9Es/6BOyVj+Oo41RTL8XntM3o7ftayA2mfAD+krG3JHHbZjqbkf5IAHkfQFFj2ODoACVd+RGCGBpaoO7qrM49OMG8I3CJwIXGAJBtk5OJuEBfCB/9epHnBsspJBthjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPIjKUiJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPIjKUiJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e72d7a4d7so2893412a12.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772471255; x=1773076055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jKDCrBgBWW4jJmi8o0KTAi+mWVQzaT0im4mj4cYCJc=;
        b=jPIjKUiJU7FC7L/oagijHhIosZOQMJKOodxBZK4Fg+Fvixj6HccBEaXGT9v6IPfU/8
         YLyNPSygC36bgbKuvtMj5pPuQBucQyv/pjvxQjRXd7IMV8z9kUEddUCGmHfftFaRrpEU
         S9Gfd8utjaOE7wOZBXuV0lDuh/gl4E+FaF6bh3M60QcOsAYOtWek1+7LrTd3izppGpBG
         m1Z336h4cfv0IWsNqaOziYSYo7UPM9OlU0ABDcQ5k4qUKc2xQNmtVr9IZmUj61Td53PM
         hkb7BRjJMXrTqbpNRGxI4CQdIASiGv6hTGphty9bO7UtjRDactr/pn4FS+nHUh2391BG
         aAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471255; x=1773076055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jKDCrBgBWW4jJmi8o0KTAi+mWVQzaT0im4mj4cYCJc=;
        b=i2cK3KTHQ5ZMiYS57jRe9cAiBqZOuHNQruz6pi4nMBFVu8qQZf9gAeD39wJwcBtRXP
         uZRFNcLSzymfUd3rUm1oZc45kAUNNqW8xKWuDChAZZWpraO1cnaBXSiJoVv2Rl25g0fn
         7DwW5D0sZML1BhIc88BuLjGg6hkRiemTJFkb6uXN2jUmvEfMeCHyGE7lmBFPayXZch3s
         UORsarwxxjaH3XI7qDAW0xuxWME7ywvSvEnrSJeUVMkY+WLm1oTnynAEqcsdwIixg+87
         TYUH8USUQdlig2YBErVM0i8UzqSRkfCW5YAQ1vahCargLostHCW+ymX7tBhN5TV+CrpO
         u5oQ==
X-Gm-Message-State: AOJu0YxSEt2irJ2YvDcmdeOMfGZOIO5aUg0G2MaaLZk0wrvTmQiS3pEW
	9K/jghn72h0Sn3zpEAVrUc1Vazp+gBVl9e+NFsGLegLBWrcJnZRESZx1
X-Gm-Gg: ATEYQzxd12BNcYVuw39SH2TpwaC7HMwpSogMyD9K64YBtD1TqbkemsHtAYN/aWcu8Xm
	h7fGXLHPcTAAQMwUwosXCedJCpTCOM5pKA1no+Q2NRXuEs1s7ZHcOdPkMAzbkLbllu5GbQc09n/
	aqhXbhZHZcIeLp8sXs/1hkluFmEUYqxN57wEt6A44XFQGUX6+6mKhBCUWtlFsAiNtzn3drp2Y0V
	JzuhFq/7jRcyvtaosPXBlCJH0iBd7XsunWuML3Qm+X0cC9QVlrYz1gki6xxXVjFYxUkJrO/peeA
	YlUbl1A6xmVQzYnHoN7FjcuGYwMjjLokpXftqRBsx8OJOOd1yxRRvS4EY/Msd6VeZao43eMo7RE
	rK4M4QUMPLSIXUD/moOZWC0rhBiQeQpZfoEwmBxM6LnubIF8N1qFS/uaTbTkExTEXPh67w+ppef
	hXhCKBzi9IoYM0z1K/mfmsFSM0tulibqy2gQqQ
X-Received: by 2002:a17:90b:584e:b0:356:282e:7eb7 with SMTP id 98e67ed59e1d1-35965c2d0bamr10260279a91.12.1772471255326;
        Mon, 02 Mar 2026 09:07:35 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4c92:fc5c:54e5:712e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35980729af8sm6998309a91.4.2026.03.02.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:07:34 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Mar 2026 01:07:29 +0800
Subject: [PATCH] iio: adc: ti-ads1119: Drop redundant error message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
X-B4-Tracking: v=1; b=H4sIANDDpWkC/x3MMQqAMAxA0atIZgNNKha9ijgUm2oWlVZEKN7d4
 viG/wtkSSoZxqZAkluzHnsFtQ0sm99XQQ3VwIZ7Y43FS9GHTEQDMjrLQxcXJvIOanImifr8u2l
 +3w8DhJaKXgAAAA==
X-Change-ID: 20260303-ti-ads1119-2-73294fc211a7
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772471250; l=993;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=0Rpn29yJr7uo0YCxP79RgwAGaRqtgWqWXtfRX+nEb20=;
 b=DRj/GnMivLanOgBWJHOajuS4VNFrLzdJ9oWVywXtmdEaWfRCeMxTmdeinuGpPYKKaHHMtlDEj
 l5JYLmaOLWDCviTFv4FzDjkFSekhfjWHOG7Qjp/mk4CM3R99+s/m+hH
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

devm_request_threaded_irq already prints an error message when failure,
so the error message is redundant, drop it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..1157e606bc64 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -740,8 +740,7 @@ static int ads1119_probe(struct i2c_client *client)
 						NULL, IRQF_ONESHOT,
 						"ads1119", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to allocate irq\n");
+			return ret;
 
 		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						  indio_dev->name,

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260303-ti-ads1119-2-73294fc211a7

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

