Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD557C9F
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166573; cv=none; b=fwItfTGXdqpuoaQItGl98NxlObttgf1cML0h4VrMoMW/h3yWHMFuOS4CA8s3l1We2Z1uu/kSjWnkFxkvZF70VxyW1vWYiax1ghlVZ7tqepS7IhDQ8BPYItutFFfRt8z1ABC8APBYY7sU4ot2f2F9rhjbfkyDEm9O3ha91xHLfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166573; c=relaxed/simple;
	bh=8ofovIchq8LhZfbkDIA+PMJXPYWidRkJzVPPzStsXGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPaYA8HwXUxOtDpu15q0tKS9ScI8iHI6CgROmg+oJJzt3glGgYRu1L/C3mEVpmrZG5wVjbbwiMUoyc6surrEgAzY7kW4IIesY/+dg0YwU0EO9fDERx2jIWZpcLZ/hTXq+HT7SSQSzJBKvZw/JvGWD/iJn0AAy7tX3wlWUXxmPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3PfTfbZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3PfTfbZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-462342ac290so5415693f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782166571; x=1782771371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/5Vow282wNBoHiNek7VDSfC4rzQpZ0v0yruM2P1GnM=;
        b=p3PfTfbZOYqpnmHKk6r4BxLa5uB4dJmX8rr7joOwZ4C7N8N8gJsvOeYJkPFUfJ7DIr
         OsuCBhu4AXjEZYmc1nChleylBRbtyZZfvfzCy1jKtdHAzVu10nn4KCYtGPMRZDpyEiXL
         jQOhnpSGpkFSWObzaPyd0cB+GTbWkAqsaCv4BRVd56QoQhz18tRy2MExlEOeMfgYawzf
         2nxtIWL/b6XQhipEo/UtGiBTfK2RWMGvCnrpMyA1fmNZtNGnTzPGcy8fW8dCeeMIQS+f
         vc+LaAI9MDkWY6bX1kjjrGU1kOkZoRXYTOmOMC0+HDQdrtP9Uk11OlJ2cs83dyCtCsFa
         2Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166571; x=1782771371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/5Vow282wNBoHiNek7VDSfC4rzQpZ0v0yruM2P1GnM=;
        b=VdC2x18PDbXSeDRgu+IerwPnOaGkd9iaudJfHbFk/ciZGaDxLh6JbPygmMCgWELTXW
         nlVVf+XNWWrleOLRTNYaMXLNyNTv0Rr6E05TYcnJzg74g/gvkl9PgxVVw8i41NjYBkYB
         qeqnPY/RBGJ6dqcDPz5S4lSK9fGbZIhuTMyiydGCo5VCDjWMksrNCyG+nzK1ocY3O+Ds
         CmqCZVj+XfOwjwzUPBtJy3kv1ie60AGoYZH/blyIAmtpuG57Q8H3gGiCb3RpP4hi4ZMH
         UZDhv/m0Vh++FA55AYzJ2h7pLbH8vakYrg+ZbAyAR4so9pEQvgA4avr6c7oNl3olXSvZ
         v+sw==
X-Gm-Message-State: AOJu0YwQpfDMK6qYfMp3BPArYPT7Jw+ZWBAPXHBqEjmd6sdLa2gOMCpV
	cwP8XiPv9igCEtD2XV7gcCqaFvNAFNEKs7AUlMxHf+ZEDQs0LiqyY6XEsOv+2TAl
X-Gm-Gg: AfdE7cmucAQ47OJBadpLG+CZZJYuzb4IQVkehhfdQAsd432Tf0KHHCNZMMlPB0lVtkT
	coMZ8JGk10iLlrJwOGsMj0BWiA+s/UdPpqeKkEphHH9Io0s7nvP/VzNpjWoXmQN6sewm+to7eaL
	DVYDABCLTFXrwG0GcZBTQjyVfHwP8qqUGds4F4yUt0J+ZgAxWxtNFWGfk+/SY9I1nr5Mzx8mwas
	8ANIgs6gXUcjQQLQ3FhYa7fs6xTpRpyNyprkMMBW+kx07nj8q2j0IllMvlKAZbtDN1aa1bwOny1
	LsiNKR5g30nexGoipthXraA45d3Z01rLus6oWGo6W0SzWWNKyjyN7KCpEkeGlARooIVRQRXlxT4
	EIaEwtXTfim03RFHbmvdsDbksTo8zBJyo04JIY5YfphhOcNOHy3Hpcd6TVM3R4ArkSNDtkpaeZK
	rChFoPQ42kSKlVlKIWL1/3se2E6Zq1OEZJ/PDgnG0=
X-Received: by 2002:a05:6000:2004:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-46adb0b697emr83476f8f.35.1782166570380;
        Mon, 22 Jun 2026 15:16:10 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c53fdsm31319845f8f.10.2026.06.22.15.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:16:09 -0700 (PDT)
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
Subject: [PATCH v4 0/3] iio: adc: Add support for TI ADS1110 to  ti-ads1100 driver
Date: Tue, 23 Jun 2026 00:15:47 +0200
Message-ID: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/Kconfig                       |   6 +-
 drivers/iio/adc/ti-ads1100.c                  | 153 +++++++++++++++---
 3 files changed, 140 insertions(+), 29 deletions(-)

-- 
2.47.3

