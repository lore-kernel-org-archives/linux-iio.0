Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497A1F30A4
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968266; cv=none; b=pEZxzBevDC3pCtEGpAHXKj+6KfiAeyG/w6RoNkpn9Il3og3qyDrUk6jMqFD/pZKgirm99uB0rkApPB5nChgccqKRFAK0rKxBfxW4tQmwkfFtnkp91/dtR6Ap9GbUxoTkDpk1kGVga+ESR9DzTY+irkl7VIjiHkhSQtboeQFEHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968266; c=relaxed/simple;
	bh=gT6XICHpMAC3xsYxIsUQVNDrHejCwTPOWCqbI0fjZRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eaLLNOhx2iylcA1WcgTp+CqW8HmUrJQUCT4o+Uod2AAjnj0zdegwUqOrCp2kIXvsMDlJCZUnfqMwGEF9VDFhsMkjbXNtKkI5AH1seH9CZKGSBRE+oDhEhhvVmbuoZeDI7fgcOaCFVwiScVDur+a+7C81SzceLMyB4bQdfVD4LA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZDHDei4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZDHDei4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso10101175e9.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778968264; x=1779573064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Ibvrh10uhcctZ5pFOGwQIOfOXYmHIfcNc9VVPAHmc=;
        b=hZDHDei4JpZmxe7bplmM7bwTB8bWjw9gJHdlfGN/Q6c57WS6khZxbN+0PcUN8RjWlT
         gKwcvSgS8kTc1beP6dunEWiQ6AkCHVzCCEkg9VWrOuieROmJDJxEghyXm22hTOJc0hrx
         rtTfvFXA1c3oQXpiqbVOyW9LfOv8YVkt6kzf6ChtGaV+/8kiEJmIBfJVYq6cIiPwnM2S
         dQ7UzTpoReCDtX/V10DxDJS3HqPdag7ruRTXfegQ7wAOOPKa5kvcPh+/au8JlyY/7ZNW
         FzcAjOmE1hkYLw4vqNTB6xkMNKA474H7EnjcHaw5loCCi/XNyC1S9D9OPDmEGwBxzaQi
         v97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778968264; x=1779573064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Ibvrh10uhcctZ5pFOGwQIOfOXYmHIfcNc9VVPAHmc=;
        b=WNXIo7Dsd6A6o5COWPkMwCDba4NDamTD7kK+FRBP2na/aMskhIrpQgB6dNgJ/GKIAY
         2csYgv3va22gRTzmgjm5WBmhvkNWAkALvUoNeeoMVT1g6kxX2asweGkySzTp/EoAtCIa
         9FIx3V8/IYT5bJzwPqJHHp56C1P5bUGAC3iGMLQ+w7qyXSWfP3sLd4XnWM7E+89krdRR
         r25RTq+BnhYuI2yIuLgl7xKVadmxT7OSpwNg9VsZtOTrM/D+qmgfSzzDO2lsac0KbXrK
         OSNJw3CJ66BD1xM5S5enZfcBwiXIsdVzTYyLh18ujcPYz6VO+kWoQMUovmOG1XnVjWbD
         DRkw==
X-Gm-Message-State: AOJu0YwKOzCh8N07+VQGLy3hjjppqS7+drg6p5pFzuHenoQwvNT2MaVQ
	g2/9Sz6W9U52PZnVE+vS4YlwqVQyxaF/+lTzK6VKXNrvm4ZRdHY9BLyQ
X-Gm-Gg: Acq92OFLyHrpbRGmQakYOK5U8sUpMH1BxH4HEv5JejhvdvlKN0o6v0esgFS7qqtT9Tt
	qU1jItzlSje6WyTaVXG9NTnAZhVIZCBbQM7f4Fj6MocjFuCa7T15qs6/BgtAeuY2XPbrTIdjCN/
	ww8kKp9+RzX1jitwb6+YyySh6k2jo9CwxuWRQcQuFDMzrlkuh1+YxKgj86mD4zwQYTEiFvlWSGi
	CIZGE6VVPjPuSUbVdc+Ys8vojgmlgajcrCEFllhXc0Vw4TfvNt3XpYmKlErZfk/6nLTp36RcNXI
	NCFiPuUXh6Ka/675efHPp5W8zPmEBXOJnTGfUM7LNIN/9eOHfTpR2A9ES5JFUU0Liz1d5NKee3T
	62yBOEaI4+lpkTXRTmS5jpalm8Asd3hCIWToJmhLt80QQXLOkoYOMlVJ+Wha6tXbRg1CRv4+M1l
	0evrCpy65UckpD5sWdDf75+DynDTNycCQF9yaSnTBYSRjW536KCb20VQfxPGPAgv8Avye0gpwKi
	GJ06dAZamj0CH1RDrbPINLNVNVc0eGfQKaqXbDTvn3O0JmSCNpnigzLHIwqurilEJepzqfiaytv
	Z/17pQ5e5MkWEI18MdfYphn9YoUUzHvDdDAK9rjiUjz8WHCv
X-Received: by 2002:a05:6000:2dc2:b0:45d:4c20:7285 with SMTP id ffacd0b85a97d-45e5c5bbe46mr13893624f8f.6.1778968263443;
        Sat, 16 May 2026 14:51:03 -0700 (PDT)
Received: from systembl0wer.localdomain ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm25819528f8f.35.2026.05.16.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:51:03 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: light: veml3328: add support for new sensor
Date: Sat, 16 May 2026 23:50:52 +0200
Message-Id: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzmCGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMz3bLU3BxjYyMLXdOkNEvjNAtTQ0uLVCWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQA8PZSDbAAAAA==
X-Change-ID: 20260426-veml3328-5bf93f85198e
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778968262; l=1340;
 i=joshua.crofts1@gmail.com; s=20260516; h=from:subject:message-id;
 bh=gT6XICHpMAC3xsYxIsUQVNDrHejCwTPOWCqbI0fjZRw=;
 b=rNJZ9uDZG7S2Cm0fg+Cdo75lKl5vgAev7X77MLtkLSkHdYy32sEULWOkJjFgOSUv4o0x3EvJP
 6k/GmWCmuDOAg7xnoueIYRhyNH9+t2bAjxt1R+4v4kjvOou5mZxB/yE
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=d2X8EVKEB2uF4AaPPi3iSSI+IJF3/9kOoDYVVmc+G1o=

This patch series adds support for the Vishay VEML3328 RGBCIR light
sensor. The sensor communicates via I2C (SMBus compatible) and provides
5 types of 16-bit measurements: red, green, blue, clear and infrared.

Reasons for adding a new driver:
- Existing Vishay drivers in the kernel do not cover sensors that
  handle RGBC and IR simultaneously.
- The register map and configuration differ from other Vishay light
  sensors currently supported by IIO.

Testing:
- Tested on a Raspberry Pi 4 using a VEML3328 breakout board.

Datasheet:
https://www.vishay.com/docs/84968/veml3328.pdf

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (2):
      iio: light: veml3328: add devicetree binding for new sensor
      iio: light: veml3328: add support for new device

 .../bindings/iio/light/vishay,veml3328.yaml        |  45 +++
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml3328.c                       | 405 +++++++++++++++++++++
 5 files changed, 468 insertions(+)
---
base-commit: 74d173f29572951629d1e0b7456b424006e51b87
change-id: 20260426-veml3328-5bf93f85198e

Best regards,
--  
Joshua Crofts <joshua.crofts1@gmail.com>

