Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11C35E95E
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782675840; cv=none; b=VsKlZRCPsc+ioMSkT9yupwUu79mastLuri53VnJqJFwpj+YB4X1k3ftWPT2QnujDwd82OZdzx3HPWLmgwVIRNZxsRYUZaNa597UugOF4ObISk5t8+K8YYfr/dQ8a2EiisPK7olNn7U/3RYRfesyzQGZSLw5PuojOyWV9TsMXc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782675840; c=relaxed/simple;
	bh=/2v/eleMETJ5MMngbaBtVItA94CLZWZGq3DWicz25Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tdwr4LnnRQAmhSMQct8TF4RSM+i3OZ48uvRcAmMqUtr5yu/DY8tvQK9Hpj7z3b0+5yTLejhVDNZqRPex1g5SUAdgclLXEEPfTmly2MpmNDcGsDmO1uMCJP7UxLWGkPExbonKyGFyvk+898KcqJoAgNwUNDE5JpD8vxGOLD3I8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLRbY+Dl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLRbY+Dl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so656695e87.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782675838; x=1783280638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kotxqLQJciyAG8N1ibRZ2pd/bNhJkmkzGP8nqTKaV3M=;
        b=GLRbY+DlN7kP+o+cq/DLmNqoasuuO93xKn2cZ0XezndlbApvpREk5rTiRKeBzlz9WS
         NfbfHjKeY1XDKTzZhWhdkERoyTgOqgtFuTnTN1jUHbC9MfMIVjw1LhdWUikRpy1p/kfv
         33OI4zeHCBswUb2c79ur09AzVa6JmI803GN1NAm3ZoZnlf4Iue9XCl1O/UjFJy7E0Ecl
         6KX1PqvoG7Qh6us1TkRJHg23zdgXrQOta/J+1R2of76+DP7Dv7Z3dzqqB1zyUoqvNlPl
         p5Sqh8dEK+P0KArEwEV+jj/j4Cm6scBE9t4sVOJ96YBO2PzCtyLwkLb0JTEy96HYc/Sm
         IQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782675838; x=1783280638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kotxqLQJciyAG8N1ibRZ2pd/bNhJkmkzGP8nqTKaV3M=;
        b=IBOKMVTOMvuHLnHFRI3YihEWfdR3p22gSl4ksmjzRbehUhM56HhaXC3qj8bBdGUTrW
         LElirGBKLvV9eJh+QldOgUwWxpNPfw20FmSpLOUKgzxxT6znycqokLTzYUw7ZaJLX4F2
         1HP76Q3TGWSwxAGzK8+nE123m8U/KibKCai5dfSN+hVndf+sKiyEAdctfnSYHNtA6huk
         Y6k6Y3ZUtS+AXZV4fdMLZZ0mIOp+Wn9Qo/ASGNbeaABgHNZeMFmYazNQyZ11gogamn6P
         /RUPE//lAEOUkGmnxiaHZJWKrrbJe7NnWEfWQiDvqQKFIltUPJZZuB5EIdI9QQnAo3YZ
         WhOQ==
X-Gm-Message-State: AOJu0Yways1LgGqltEAeKN3fluBSwch5aR84pSd575nF0JVdXYJeGRYw
	BWfl3tb07VZ85wLFEmV0XNn8FmyUZWrnddl3y7j3yJ3CIJUXXDmNRJFqJmiDpreX
X-Gm-Gg: AfdE7cmjBtCw/FtNw2HPFkszwhmNvFef0Z8JPEBxnIxAZLkCDcmnmTcNt8Rg7o38h3/
	5WbG751D8YA/mmegjL963YhgCVqkQVlbXcA0twr3mBv7/ACceNOlWx6VqhNEdA74uYNqKsZix4e
	Ahe4QEqWwj80Fn6lYIbVFbfg3h4ZLCqqma7fD55qM3Ald246zCmEviXXtFpnhkLMJHVNBfjfGOK
	SKuvInl0LuVYcCbyyQCK8kcSr8d3kvXNYna11gJj5jbQs7Khb9gFojNJl+VC62QCPdeo+vPdHmf
	OYG/KC40RUBttm9EKMnwjhxqvy8rXi5F/9stm0ITUDUekGDcZ7q+Yc33Fig49vlK+glAkemabm4
	Vc0LL/6KjK3H0W3KbbGyEEajfsEydNV9PnFmPsDqm6Xb5QR5pvuw3OmOFc4tkz2eHA+i86hd0PQ
	drcovqno0dm6nOhmobbcWIACc1pO2A
X-Received: by 2002:a05:6512:3c92:b0:5aa:6fff:c3e3 with SMTP id 2adb3069b0e04-5aea1f4cdf3mr4002256e87.33.1782675837789;
        Sun, 28 Jun 2026 12:43:57 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551002sm5221688e87.24.2026.06.28.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:43:55 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com,
	joshua.crofts1@gmail.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	jakubszczudlo40@gmail.com,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v5 0/3] iio: adc: Add support for TI ADS1110 to  ti-ads1100 driver
Date: Sun, 28 Jun 2026 21:43:38 +0200
Message-ID: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the TI ADS1110 to the existing ADS1100 ADC IIO driver.
The ADS1110 is pin-to-pin compatible with the ADS1100 while providing
higher resolution and an internal voltage reference. This patch series
extends driver support for ADS1110, updates device tree bindings and
Kconfig text, and improves the overall hardware description for the
TI ADS1100 family.

Tested on: Raspberry pi 3b+ with 7.0 stable kernel

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>

---
V4 -> V5:
- Correct pm macros to be more generic
- fix variables ordering in new functions
- delete unnecessary casts
- Link to v4: https://lore.kernel.org/linux-iio/20260622221550.374235-1-jakubszczudlo40@gmail.com/

V3 -> V4:
- make fixes patch the first change in the series
- correct error handling when short read
- use ACQUIRE macros from pm_runtime.h in new functions
- Link to v3: https://lore.kernel.org/linux-iio/20260613190957.654798-1-jakubszczudlo40@gmail.com/

V2 -> V3:
- clean patch from unreleated changes
- divide adding support for ads1110 into separate patch
- add missing changelog
- Link to v2: https://lore.kernel.org/linux-iio/20260607183542.368184-1-jakubszczudlo40@gmail.com/

V1 -> V2:
- go from creating new driver to extending ADS1100 driver to support ADS1110
- Link to v1: https://lore.kernel.org/linux-iio/20260527164312.355729-1-jakubszczudlo40@gmail.com/

Jakub Szczudlo (3):
  iio: adc: Fix incorrect reading when datarate changed in single mode
  dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
  iio: adc: Add ti-ads1110 support to ti-ads1100 driver

 .../bindings/iio/adc/ti,ads1100.yaml          |  10 +-
 drivers/iio/adc/Kconfig                       |   9 +-
 drivers/iio/adc/ti-ads1100.c                  | 145 +++++++++++++++---
 3 files changed, 135 insertions(+), 29 deletions(-)

-- 
2.47.3

