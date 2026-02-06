Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864B3D4101
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398949; cv=none; b=ZKFDXcBUIdf4KWQVrStnxSuG5LHFX2W9dO6RaFrEmUTHJH3E1efC3/v+VyTQRMo57DmU979vr3zZH+TUPldbnh+QZZWzt9WWIBSJqf1NFY4qMx4z5SG/gGTZUxIsRiSBcvPOZnfGGMbYCiL1/+Sb4quhSjGc1bwviSmBt62MmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398949; c=relaxed/simple;
	bh=DMFf8IatqPgPC4SuwdNqD6eGuSOXIaGvf5N2KhUlJU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6tGg/q05Z7seU0yGAedcWZZeSysmKfmhNwa8+AGQWH2/Gg63uPMZYj2LOgs3LyDIhiG6J7IrCx87Q/ryXGC5NEApWVE/FUqqyojMqt892Ax0FW/dxcJoD5WFvOYPZeVjW82uWk2VCkYC9s6diT9qeEUOYr9Ovtxg8TgbDn5ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMJqig8R; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMJqig8R"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso506574f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398948; x=1771003748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh4BgGzIqnS2YSFnGO3bkqStjslK7T/mmxxxgCr3KOk=;
        b=BMJqig8RAQuaF6pjM+zHc6hkfNZU9rwaBeF9HWG4Dvi+DPHKv4YmQ67Pnzh+tEjdCX
         e5SiaSRpTHNSA1hKL+P0wQ/YOZuzcb+nsaaemzYKpzIacmHipVgXsuBIsLsy7SNVFLfJ
         muJckl4mGi6xGWyf8fPXeHVLqFrVM3M07am108W8GWSet7DK240Fu5/Nv44ZXapyqLUh
         goh66DjKhzTuB8N8dDAecSZmUUjQPYLdBPW19pwiC3mNNPfx9nZoKOLdhXJw4KzzswWr
         Q0PPYytLxv9DL+6GMbvWyJV/Mk7ahUfZqZlIO3os5ROH5HP3NFsgxtrrBD2ED+EfLe6O
         HhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398948; x=1771003748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh4BgGzIqnS2YSFnGO3bkqStjslK7T/mmxxxgCr3KOk=;
        b=SCIkhBmk2mMiuAwLpnZ08ucTvDgEtyZcEsRX1V5Xzky++Z3mOuChR//WzcgD7LtFj0
         F0N/XRdv9e7hVrYA3gWJeBUifdysYn4eAvc0pZZNa8KyeNNLG7tLTVmx6n8O+Dz5qUD0
         u74X8h0IYWQKZBr2sDkDlqA3f+XIxiqtNtOz0z5OvCWj9xTnhC8oKHNbjX0ejBEc+xap
         4LTBnZ62k2HheRav0Z6ybBeQKe7h1NROtHrle9vmzZVzKqEY72L4Wj+xcs1zlIjfhGq4
         jFrjVW2x4SuJZ5zfrfTht9cRV54pVcz0WATppgGkG3DX6hWvzAXBGFH5gv1HnnvmTDpD
         VB+A==
X-Gm-Message-State: AOJu0YxivmZmh/GKUdqSrX4equXhOCo0sFMwg02kWskcGfHp4V8Oy5Ma
	/lYVnk8j/TpXB9/Dm2SqNnJOens0o2x/GAL3oJVe9WIgATof6vlCrPD+
X-Gm-Gg: AZuq6aLfcSOztE/FQC/7k2VYR/YC24aVDiSe5ykwDyyFRA66FEHk6O/RUARVOcc2d2J
	r85c36OUBWxJC3URSsUogOtkea3hK0754GcDkF9DsFnBQksZEvfCCSK53QTsYcvm0fiN6OdAuC+
	8EobmIpv/83bIPEiEVv2pv/nhOauA/jnANTxtkHni2TS/lgQ3g+4/48agBJDIuHPex/UgYdUqTV
	YuO7QlUYXDUEXABMcn3cPn7oJLZhnBO4gIiH1VBD7luTF+QWI6/fPQ615XuMR3fOL1KquhiOeF1
	/kYO9Wb5N1A6IR23iVxhRvI/gRmWWPfFOY3zrWwU8ko/7fmkqz6en7cLCZljCyrTFY1riq1jhA3
	SPJISjRD4REwxZs/6tFSn0ff0Y26xMNkiBof4PSzs6p0XGhWYtmzDiWXl0SSCMOMiFV9HQ0TJaf
	HhadGPY55gCuE=
X-Received: by 2002:a5d:588d:0:b0:435:94f8:e7c6 with SMTP id ffacd0b85a97d-4362933ac28mr4655822f8f.9.1770398947401;
        Fri, 06 Feb 2026 09:29:07 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 00/11] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Fri,  6 Feb 2026 19:28:34 +0200
Message-ID: <20260206172845.145407-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial goal was only to add support for the CPCAP used in the Mot
Tegra20 board; however, since the documentation was already partially
converted, I decided to complete the conversion to schema too.

The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
from TXT to YAML while preserving the original structure. Mot board
compatibility was added to the regulator and core schema. Since these
were one-line patches, they were not separated into dedicated commits;
however, the commit message notes this for both cases.

Finally, the CPCAP MFD was slightly refactored to improve support for
multiple subcell compositions.

---
Changes in v2:
- fixed code style
- rtc conversion was picked, so patch dropped
- added audio ports description into mfd schema
- splitted schema conversion and compatible addition
- minor style improvements and typo fixes
---

Svyatoslav Ryhel (11):
  dt-bindings: regulator: cpcap-regulator: convert to DT schema
  dt-bindings: regulator: cpcap-regulator: document Mot regulator
  regulator: cpcap-regulator: add support for Mot regulators
  dt-bindings: iio: adc: cpcap-adc: document Mot ADC
  iio: adc: cpcap-adc: add support for Mot ADC
  dt-bindings: leds: leds-cpcap: convert to DT schema
  dt-bindings: input: cpcap-pwrbutton: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
  mfd: motorola-cpcap: diverge configuration per-board
  mfd: motorola-cpcap: add support for Mot CPCAP composition

 .../bindings/iio/adc/motorola,cpcap-adc.yaml  |   1 +
 .../bindings/input/cpcap-pwrbutton.txt        |  20 -
 .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
 .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
 .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
 .../bindings/mfd/motorola,cpcap.yaml          | 413 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 .../bindings/regulator/cpcap-regulator.txt    |  35 --
 .../regulator/motorola,cpcap-regulator.yaml   |  51 +++
 drivers/iio/adc/cpcap-adc.c                   |  15 +
 drivers/mfd/motorola-cpcap.c                  | 139 +++++-
 drivers/regulator/cpcap-regulator.c           | 105 +++++
 12 files changed, 787 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml

-- 
2.51.0

