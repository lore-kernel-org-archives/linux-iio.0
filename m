Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849930F80C
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833755; cv=none; b=RqfG8hhIXFc1acQ3XFgN7cXADroBqpKrcTryPMCcLtg6bWYTYj7MlTxNeD943J9VsQ7RRH1jgu/oP9zvD0X9Ck2biqQ/CXyhHeJJQAToqttBzFmJLxlzTgJpjLAz5t7zIsliQfBrzMzjkE4RY4B/AG13heTjYX3Z2lN2TyD67pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833755; c=relaxed/simple;
	bh=l9SAqYDh99uRa+5idqLGpztcDnLC9lmCSlUiuvYK5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EedaWtsK3UAE6mL4hS8y1/b08HOfsk+jbhgWRnxZGcAjMfD69r4wVxj/1/Ys1Uefb9r1SILzBpHk19A3MslPliP8V2/bmvLX//RqsIO0yC4eTocwDT/uPCUebPqWczt/3U7ihQ2MJ92xGH2Rlp+x+KuLOgMHj4DB4fUxaW0B6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ER9nQ6el; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ER9nQ6el"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b68b4643so10381995e9.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782833752; x=1783438552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DF9O/32twL/C04Tje39llm96lgQatakM3itV7nl0gYE=;
        b=ER9nQ6elt3rOr7sMnvZ/lIyhtOBdZUwCvPMFNuSMjczoof2SRG1dPnV4w4fUTQTt0C
         QnqeZw6b0WX07MQiwyj1nw/tfhrBwsxQvMDVzW1WUJerpVe1KC5sqCZyf1VSDyFPq8Z6
         WctycZorZYXZfuw+mLo89VVlvjd2bYb4MbVJ6eo/uugsKAB6EDAwm3lx6ka/yzQ7QsNZ
         Ilfn3kVv6QOQQz3o/HUGh9QOSWZDS9x+9Mm2U6MyiiOABG+UUguP39MM86VSXVouFYKV
         D9Kcfj0ygLyr3kDOm0Iq/cFs3U1ECnmK8xoLfv5SDyxvXeeQwpWShtxcQb4k4YfB5+Z+
         QN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833752; x=1783438552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF9O/32twL/C04Tje39llm96lgQatakM3itV7nl0gYE=;
        b=cc3zX4lAonEy0dmnifHbqUD0lm5LvR05BfibsvlkR6YYUZ8N/PyHmiu8xWHZnPwykC
         z/81ZxT7MyAuhQvE4NQl+4pPW2JHI1jMD0uM5OykU60nrLfmJDBJFpfUB6hVpkDojK7W
         bFAESyzO0QZTKl8VBwQCfa45nNBAQeODNpngsZQrJb8pir+/faulsCcsa9O91gh4KhR0
         tq/Zi0yBMj8R9HEOWW7AGzRiah9ZwcfIJqZNyNxV+Xzy7kUER2p6I1g+lxzSK5s6y+j0
         iRMkfWHPNRiRY9/RsOgnNyVj9xTEZn9Vgcc2lKQC7nctffRNY6yulDwGLyezkw+zaO05
         rmHg==
X-Forwarded-Encrypted: i=1; AFNElJ8kOcYLOCqS4D2DSotd98HuVRq0zSyvg68md9aJCySfap7KbcDjCYAzMpGdSYXLJwaYZHCCd8bCR6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzu28hiGHORFgruNxvPSracJtZFkLky2FWOJqO/EiZ0e7mjjn
	jocx9vdayjAda2s1DCvVr2Cm/TtA0bV5ekpldFDZ9PWU3oVy5nihRxpinlRB3xfQDwY=
X-Gm-Gg: AfdE7cloSTJa0pnc4AKVX+r4Ix+3jpqXcHgciHdkR0st/KJf0KSaV2IbS7LrH3+UJL8
	Bs6mvTRiYBJOk5xnGcAc1JtzNrR+HGIgBXG4LM68LsgkiNM4B4AIcRHerSYHA+PNGgT4YUrwmVk
	tw1TrOrqrpKIbT9I3Tz5h81R7j6rM1UKT+YKgkYVJyzfn8o9lxpWI/AUohGQrgPIf0i78mB8cuo
	qEWqak/H3pMlhU5KSamQqadNQPd28r6zdYBVf0nkWnIJZ7YraNmlGy1jEd3ODAWaN55vRuR4c2v
	WxWe7axf1ZXB+ypHHsLCmRESOqStDAD7AZUm2hd7+exuyuz46+1wzWOXOtTLb6goL0CPGmeRpSq
	waEylHYV4QVN5WGOGgWx2hCevM6pAZZlDMrBASNHgGyc6rXo8+RV26jcxkqeGH70RvWnBtOo+M/
	tUA1beVrzvMKosut8u9QWh+cCTTzOCf2tz/XriSHiVf+TxtZyOSk5oZnBtGZHmnVpddDF6VqF2N
	VeR
X-Received: by 2002:a05:600c:6216:b0:493:bc4a:c6b5 with SMTP id 5b1f17b1804b1-493bc4ac7dcmr32220755e9.39.1782833751793;
        Tue, 30 Jun 2026 08:35:51 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47563d195a7sm8360563f8f.7.2026.06.30.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:35:50 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 0/3] iio: Use named initializers for device_id structures
Date: Tue, 30 Jun 2026 17:35:33 +0200
Message-ID: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=l9SAqYDh99uRa+5idqLGpztcDnLC9lmCSlUiuvYK5DU=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGpD4kWiNHg8m91o/D7fofJy/CQiuQNUDcGvmceC+UOR3Lvg9 okBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqQ+JFAAoJEI+A+1h9Ev5Oc6wH/jwD 5s8COzfqYhNohwbiX43TalZQTsYnqjC/vuPkNCIXJEx/SKHSR3bAENRyM1Dqw11g/StkODiIuvH kwT7CBkjgLy05N1F9AXSKoS81D0/JIlLjMQh8d0DpQz6+sSz0RQjsZKA0BwEz8/l9hKx+euZ5eB d+nRrb4dDD9t/B0EGs1jFOPL9M4eNkJp1upoqDKeLUYFq2HIVBS74TT3ZAIH/4xs0luFmoFp2F7 skvM+HlqBNI+A+Q7ohJ7WLK2BOPjqWjwntZOmSkSGNzXEVHNxurizIXw/89vqzNwmubus6MZ0so nhKzHQt5WvL9sF08DFoQre+OZiXkVU8hrQ17xyA=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

v1 of this series can be found at
https://lore.kernel.org/linux-iio/cover.1781883685.git.u.kleine-koenig@baylibre.com
.

Jonathan already applied most of the v1 series, so here come only the
remaining bits with the following changes:

 - Squash the ti-tsc2046 changes together and simplify some more 
 - Apply the same simplification to the adis16550 driver. Jonathan
   asked the ADI people if they have a driver extention in the queue to
   actually make use of the device abstraction that is thrown away here.
   There was no reply yet, so I thought I'll implement this
   simplifictions such that it's clear what we're discussing.

Patch 3 was already part of v1 and Jonathan claimed to have applied it,
but it's not in his testing branch, so I included it here again.


Uwe Kleine-König (The Capable Hub) (3):
  iio: adc: ti-tsc2046: Simplify device handling
  iio: imu: adis16550: Simplify device abstraction
  staging: iio: Initialize spi_device_id arrays using member names

 drivers/iio/adc/ti-tsc2046.c           | 25 ++------
 drivers/iio/imu/adis16550.c            | 89 ++++++++------------------
 drivers/staging/iio/adc/ad7816.c       |  6 +-
 drivers/staging/iio/frequency/ad9834.c |  8 +--
 4 files changed, 37 insertions(+), 91 deletions(-)


base-commit: 76b8de6371463f29189d4df52f464c3fd6f3328e
-- 
2.47.3

