Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260153;
	b=u9a2Xp8W7rL+bK/djld+XOriTImie24Uh4gWdbOGqgvOuf3dnV/9ruthpl1NwP5lXjr2
	 kd96HpK4dEhFGSgSF+1ryNx5DNMcJ5HuFzdVsBmsFI2a0w1INYXB82ToQgtBCXJ/7Ozvb
	 dh24BP7YAMbx9xqDPBsZSOPiLhtra0UQ038h6ON3OWr9nlcz637+osllc/S+47GEnHcSL
	 KYegfe48VZqs5Kanz5mWwJ+CLoOAvZz9MgPLPAyBOn1lS1DmAKBjCUWW08+4sRcBPziE6
	 Lxl6jbA9WWug0AXJFGPFVwbuwgELD/5/P4H2PQNyjULt4ZE0QagmzHXZSdurN4AhfgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wjBhfqfNAu/i5gAOXlQoqv+CdHzgKo3BKhh2OjwT3ic=;
	b=fnoYrZ7QNXImxTUO/N3IoExvgv15KgDlujz4APeG+d/bPNFeXANRhBgcKDUi46j2Mnwf
	 VlFeLxmhxWt2fv8vR/s87Q4mw6eOjOfVnDssx6zKZedEzJPuS+6cdFpfPYkFEo3aiZenb
	 R29CJ9r1Hki9FDuhnfrqZstNfkIycHLomHmkR3TqMi/m6SPFWhOu0uqLQ/T/bdubvP+wn
	 t/TvwkQfiDoLihr+SoQcOK8qvB+X5sm17ebwXaEI+ZWTcG5sc1Dtrx0v5Vs7u8jKjq2NK
	 d3mHf0A9Wa/qJlTfFp4F8TD3KlsbvC9Ka1XnGzBojY3lK5e82cHA+W0OW9qB/Ujo1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dzhPO/fQ";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE1606A327
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 07:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCE1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dzhPO/fQ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so2453130c88.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793260151; x=1793864951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wjBhfqfNAu/i5gAOXlQoqv+CdHzgKo3BKhh2OjwT3ic=;
        b=dzhPO/fQ+cjkXDXTba4hzk3aU4lQNEW609vZ0j9AIO5xatasgpNEIaRGNf35MYcmjq
         578l6fGt7d6VcSXf01SaSR3jDoKd1GnWkojLuuzeDghqGZicrIC2ZduBi/0daspyL8bV
         Ejrqfs9puzM2EqfBCQ2IEct9DJRZ+MPEszMIb9ofj/DGxAfpaQhPidkAK2BY5/Wt0NfD
         b/rb4E81rK1vyPqFoECL8ARH88Pm1HJe6ywpzP3ZNIU/op7Bh9/onO0PnQcyOiEZCtiY
         /Y30AxR1UxyR20z0yNy4S2EdZpAzV1LNNOdZvkzOis9TXbTuVwlOHIxlu2CgiJFZf+20
         ovOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260151; x=1793864951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjBhfqfNAu/i5gAOXlQoqv+CdHzgKo3BKhh2OjwT3ic=;
        b=AYE1DHqI8pjl4Rb59+TClnMzZm7BSMVGmtXlx5RsCeU7hBi0QjIu/jn5aULfsTcCj7
         qAdBVOMjpMg+LpgVntJlnbQTVR8dEmHDkHhxYwhmTnGR5Jvjbi+9Ju/j4O1RrPDXwynz
         eUEOS0jTsrriMkxvWinqIP3qaXjjQwv7in1luWTKZXIJ14Bnj702dKMbsQhpuo/HfNpK
         HCSs0MFcphdX03HFUS/Njr4ezKsE4RSkqo/OakBzOCk5aeijeM34vWkvMlckb9wE0e1/
         snNxvyYaeaxqNapulf2hKy9ASwOXVmBJ3MhYE3QZKmgFZ7HHOvWfq6GgJ9kDCgEpptgk
         xcow==
X-Forwarded-Encrypted: i=1; AKwUvBy+aGVaLgH0RJR7pi33jQS3YprfceEInAiOR6hfuaDDdS3AVQSBzaRrVsl6FX5WrNAm1+EXdQ9aNwo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1hu10JNdKCTf9MO14CVG79J0oEdtljqmGljJzOarHvYABu9SG
	GrDe3bFTkkFpR5OOa9Cb6S2n/AXJaU+nhztL4Q4WtYEmzvnpd7KF6gbA
X-Gm-Gg: AYBFou12sLqn6RonEk2D0UbvMn+c63uIUpyO1NVpdjVSc0tGTMj+dWCUUOkqw1ybEfB
	jSAQf5kFChRJzQGeT0s9egfOmktv9MstKG1QNW74357GbKvWkeZ119IM0aa7TOkqsfYQp2vmU/u
	A7UttUjvWUCGRd0wIfneBCzRaQOF4tlQjdBaanSkbk2oATCIM/84JpZA+ggHa+Il371DSwI3dCE
	gp8oE/oUFpXnHfd0s84FTeKsUwGpYVFuH0fgjHyR7rwmxhvDWI5MYT+3YDAXdIhjWfXT+3QXn6B
	jdGGKrigUyHJsdMKHRFT+d/yyg685RdihvyxpilpWSvuU9dHMT4SkAtqptty2J+AwmSpqVeIN8E
	oim1VUYsAWgYf7cr0/DqeDiZMYoaIi4dOQk5uJmaHpDz21bmQHQVnQ08GciC8DTsFDtE70xfs7V
	xpE//5ED/zGc0kk4HdAFyAEaFVi0YpCTfAotDk63DFnl5VbOJRtCDKx872GdaZNz/ZhmABRFmjH
	uWvyL5Jsq6WfKZh8OqUPlx73svxG5/NtvpxJ9aiKgBpKQet3UIzpkCMGpkEXDJbqB+cQE4U+Z5G
	gAIgh8WKZLqt7MdBJgkF6orZhBq6
X-Received: by 2002:a05:7022:b04e:b0:1a9:f3d2:6262 with SMTP id a92af1059eb24-1a9f3d262b8mr1402604c88.36.1793260151194;
        Thu, 29 Oct 2026 00:49:11 -0700 (PDT)
Received: from localhost ([149.28.89.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76037e2b5sm18486398c88.21.2026.10.29.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:49:10 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Add support for AS7343 multi-spectral sensor
Date: Thu, 29 Oct 2026 15:48:49 +0800
Message-ID: <20261029074851.216029-1-marcus.yu.56@gmail.com>
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

This series adds initial support for the AMS AS7343 14-channel
multi-spectral sensor.

The sensor has 14 optical channels (11 visible + NIR + clear +
flicker) in total. This initial driver supports reading raw counts
from all 12 spectral channels (11 visible + NIR) via sysfs and basic
power management.

Not yet supported:
- Configurable integration time and gain
- Interrupt support
- Clear (VIS) channel and flicker detection

Patch 1 adds device tree bindings.
Patch 2 adds the driver.

Testing was performed on a Raspberry Pi 4.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

Changes in v7:
  - Specify reg as a const.
  - Move additionalProperties after allOf block.
  - Clear/set PON during suspend/resume.
  - Check for digital saturation before reading spectral data.

Changes in v6:
  - Add a ref to leds/common.yaml for the LDR pin in dt bindings.
  - Convert ATIME and ASTEP range checks to runtime checks.
  - Check for digital saturation before reading spectral data.

Changes in v5:
  - Remove the GPIO pin from dt bindings.
  - Add autosuspend.
  - Start measurements before setting up runtime PM.

Changes in v4:
  - Fix led-max-microamp property in dt bindings.
  - Use REGCACHE_MAPLE and add volatile table.
  - Use PM_RUNTIME_ACQUIRE* when resuming.

Changes in v3:
  - Fix gpio description and example in dt.
  - Only start measurements after suspend action has been registered.
  - Add a mutex and pm_runtime_resume_and_get before reading measurements.

Changes in v2:
  - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
  - Adjust the default gain to x256 and integration time to 50.1ms as
  recommended by the datasheet.
  - Use read_label instead of .extend
  - Remove all unused scan_index related constants.

Chang Yu (2):
  dt-bindings: iio: light: add as7343
  iio: light: add AS7343 multi-spectral sensor driver

 .../bindings/iio/light/ams,as7343.yaml        |  64 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 491 ++++++++++++++++++
 5 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.56.0

