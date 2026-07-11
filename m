Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E782F8EBF
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783795472; cv=none; b=GsXcyJPMy4qKRHHGFGgBi39Q6gu6WMyhVxItRTs9/xucuGFyovWGxRyCNDV0JKxpL/oAXiaPTFFh121PKcHCWylWulgOGr4kbnQBM783mFu3aKfYxN0ja3GUc978s1Dt7pVn9rgQhduUSqchJrspB0pidW1Ngk1RtEstruLXpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783795472; c=relaxed/simple;
	bh=lle7Rmg8FyTcC/Q7qALF1mUEHp6zQifQpVs5AdeIRxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5E9svl3X0OwdPIICP5VmEWOkqBinutvPf/py0VPXE6MxOK3h2Qmh7PZhLmHmL3MsyGv9IeE71Ni6h7dFSj1B8X32PzhMB64rCCzNxqy2zUCr91RiqLg84w6UiHPeKKAY7nymKF7D4gBgcb8HHNJ7QmpCnptGh8Tzh0tu2cj+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZD5Bcv5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZD5Bcv5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1910312f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783795468; x=1784400268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VV1uOthI82FI9Ppe5ViOKmESWKdCAT2lJ4bCDUnYmLI=;
        b=QZD5Bcv5VfWFa5KI3BNtp8BmC/MZ4hmCcpstj56OC1fRs3O0e2RVlTAZ0PM6AAviLg
         exXzY7OKayaF/IqiaSv5j28UTJSS8JHRdkBD+JdDwXxADZKasx2bd3jQdqy2vRYg2gGG
         F7FEWFefSZVKEtb9f0y1z0tjrGQOMHQvKIglVX3NFPCTtGh52ShZUoIqHJ6yANkqNIE8
         Qpd7uiK8rkc9m89SNXTEFh7SZTcTkk4ZSg+boBw6Fe01PerhRsW9QEy4qSSNRBeHZ5iy
         ViOK35IFbRM7OfxqSA7K/+f2GTL/ZFxot2HGkEthh0wSMi+2X55Fh/rTt4asYywcffuf
         kq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783795468; x=1784400268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VV1uOthI82FI9Ppe5ViOKmESWKdCAT2lJ4bCDUnYmLI=;
        b=o83kDyi6StuZZ8G5lZ6/j2Rr10G+zu0BALTLmpPOrvywEqZhpi742UVOUOSgKw/XPn
         eq0IYoFlXfvrPxKUE6IQtOCBMSRGtqjtua4PqlnsbHesZ1tUWpyYJSRb9V6TI4pQAPwL
         1WCFaec6NMo9fkcifgk6wfCbutq4vUa67bBuCVwNGk7ZbsMO7rgshY8IGur7PxPr7kKE
         CHGtfNiljcO0bTfEBASSk3bq/jtR0jxvjmuLQ6CS4i0vQPBc0p0GyLZnaH6loJEgVbdy
         Ep63IqiXVS4gJTLW+V+R0Fq5qSsoaBdqZWT4ccJSg9r0xJLuJf1yX48IXRBd9N089wKy
         MELg==
X-Gm-Message-State: AOJu0Yz83NLV2XAFq9o04mkTqrhAlfiCqANE04PUS/CoJm9DRSt3BwMV
	7K2oiM3HLXzsM777NnhRuGYsrPE1nsIiOaluwZcDXm79NBAugrqjYPT4U9uthY04
X-Gm-Gg: AfdE7ckZj9RD/m39VkuGwWV2Jkcj+iWoy9fYN8nDmUrzu+OPgbMPrjdeQfROhn51Soo
	oB5QXrxZZDgxdoQc2h/EjdBTdLnYtxnNHOm1Tk8Q4okdMZoOvIIaSe9ghpo0psGBAK+IX8hpb2U
	H0WyA89IE3gsuLquj+nWGOyohUV5kc8Fulss08lVs7H4mxzwF96ZFjR38o2ewvcBWxXH1Mow5vO
	PZHiJ5rxrEIfMVSIWBJeNYlCSfS1dznduA+CjB5d/UWBx+t1HEvAy0spda1niVyoj2iTJJHxYNI
	dQwCnpzLe/RP4/WUYiGCaGmCdDLUArULVD8XVSWSoLleWBxAiDkuqMFtffkZttaQwMSAHqUv8Ee
	hG1iOhImYXZ1yQQMPi1deBsLoEHCe2ra2SdDMkXXGKbGcOqF6j0xzL1ecXpSgVNnhKopvUwrW+T
	WoMRyYhWcIdbJXC3s0yU9EmUrEM69ESlwOn/LJEwE7r+BI738=
X-Received: by 2002:a05:6000:2510:b0:475:f0c2:75ac with SMTP id ffacd0b85a97d-47f2dd0fca7mr3711208f8f.61.1783795467710;
        Sat, 11 Jul 2026 11:44:27 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:e6c9:27be:161c:632d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm70825745f8f.11.2026.07.11.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:44:27 -0700 (PDT)
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
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v6 0/3 ] iio: adc: Add support for TI ADS1110 to  ti-ads1100 driver
Date: Sat, 11 Jul 2026 20:44:11 +0200
Message-ID: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
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
V5 -> V6:
- correct for loop so it will be more readible and return error when iterator matches array size
- fix SI unit letter size
- correct using available_data_rate_hz array when using ads1110
- bring cast to char* back
- Link to v5: https://lore.kernel.org/linux-iio/20260628194341.66752-1-jakubszczudlo40@gmail.com/

V4 -> V5:
- Correct pm macros to be more generic
- fix variables ordering in new functions
- delete unnecessary casts
- add unit to variable names
- change array name so it will sound as array not variable
- correct get_vref_milivolts so it will check if not negative value returned
- delete unnecessary short read check in i2c receive
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
 drivers/iio/adc/ti-ads1100.c                  | 147 +++++++++++++++---
 3 files changed, 137 insertions(+), 29 deletions(-)

-- 
2.47.3

