Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04723394E91
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377822; cv=none; b=eHXImNLDZEXNtdRcd7YYjdQk9SdWsD2WBhC1P5EMufrTkDPA+kERrI6JM/d1qPhJnV6tijz9pMfKzAky6KRwF5qmYprnRO+ZecTFU4rKuZlAh5ugIhxqohHbfDdUDlylxoj+cDIldk1npnUC3VcnyPgkIlNl5dRrNlW1uh5QUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377822; c=relaxed/simple;
	bh=IarGWq0h4k7YgRYkX36nCoK+3Jt6gr7vdYY/leCwb9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKwpemeohtgESeDA69KYvntSgE+rEhD1GRLAcNgl/rkQ48t6S/SeHN3paPGJrEITzE/CY5T2P2RGX5D8IBhmt2vQ5CF3NOcY00uCVkbmMpNDIZqOXpQdoHzAYFmWamWKxooTPo5odKcV4GkIWfcXo5KNAYLQNiysR5Zmx7ynjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YENmbA6k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YENmbA6k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6919f40a0c8so3718343a12.0
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377818; x=1781982618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=463x8kT/wzRlmQHGudSYziOyf/LSV3/qWwdmBIWyYR0=;
        b=YENmbA6kPGE6vQhr4skKsJnq+te3NSsKplGNts63Qs+b5s+NNjLTDe5fx+MtEgdW7T
         iB/VVCuO76MKSvBpoTZwmgwEWZymCOOMjqvDDzCh8Z5Gg8B03dAFIUJ9NzfXoLTW+IK4
         Ww3/+J0W7FUgoBCh6A5cx6wnsYLPYuTQIk7e2CCFx+g8qLHo/2r1a1L5GDRXnQmD6aVt
         bS5JPXNltIJL57AN2xNjuBp8RUFhmb6SbkJuQGLfURAOk0zLsz3NcffFpBid00T/yoes
         wWjZq+xXGMhrq/WM3wujSlViEZk0I/oRxh/QQM3WBmIjSavgeAzS/1jt577mw0lcCPsN
         teXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377818; x=1781982618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=463x8kT/wzRlmQHGudSYziOyf/LSV3/qWwdmBIWyYR0=;
        b=VlrtunmQ6N2tM2k4YPXNIWsOvnIjTvtaVNnohl6PtiCmZXJ90ED+bOudMCkZGX13zb
         Rde2j50dKH6BTgTzKuXcC5O2h1G34KAGRDdobnHfZQvvWkHnnQsfwLhv/l4tu5dOtIdv
         ayaB78T/wpcoFx6Ym2F5RVLnoXhUi6QD7PwxzSN/Vy3E/j7jh6BhrttBibMVJ2gozQul
         JD4PCfLUPD76hx+2SOIKblVcelGwMdPbSwfqzEGorPWY6PJx7q97Sg6S1XT7Uilnu0zC
         n9r5rgTRyEHgJ3vc+LhmOK0bmtUHQWQqbRcTwpj3z7XTQy5GDkKVw4qQ+sIUVg9+8wZU
         whoA==
X-Gm-Message-State: AOJu0YzDDf6vQPVA+VxgwT+1YPi6Pxe14FdNdJxEiTTreSZ4NvEIHsrj
	v+2Ue/KKAtNWFMulTFbVMNLte7tQG7q442taQ03dde+F1ISoW4iXGJfby09GHV28
X-Gm-Gg: Acq92OGyYkoop/f7YOdqwIOgrcfNAMqnmPvweRocd9uss7Ug3J3/JZB97zdp0juoNPN
	eFIYxvk9uimBRWWVxI/aQPKfCaBKGD13pvpccfcfZf/9NyRV0bFqquOu6PQkp0SvYfIiv5Asw+g
	ZFQ4pzC+YtUaPadaKKZyG6Z2otLlUkKu2ZaJ4wZrn07EbZ0aWpF/T9utlZCOduYCMnWoHday8/2
	qcorK2Ly8Dqz8UtlmyVvzeP0iS619zE/4FoO9yqZs65gSqBELOEasUE67f2Lj83QAiPODddcOIn
	5P8fOmLT411FYi6Es3Vap8In759T6lhZSlJdPTObnQFaICvIzuK64Q7Jk9Oprm1DeMSCTRZrnX5
	fbZMNPU1wqu7/MOnh8SJ2oEv2w2taD8QhlesgL+NKq9/bOI2wCI2ngQTPMMtv23UzFfoXo/mty0
	3ilpAJGUlJc7bIHsaTksSf4Pl7wP0Nd/6ra1YYjaiBS4XqQuwz/MpE9Dl9fw==
X-Received: by 2002:a17:907:7f86:b0:bec:894d:dd45 with SMTP id a640c23a62f3a-bff4cdd5123mr180433266b.38.1781377818222;
        Sat, 13 Jun 2026 12:10:18 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9790:7740:8855:4d8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b2276fsm237193366b.17.2026.06.13.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 12:10:16 -0700 (PDT)
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
	krzk+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	joshua.crofts1@gmail.com,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v3 0/3] iio: adc: Add support for TI ADS1110 to  ti-ads1100 driver
Date: Sat, 13 Jun 2026 21:09:54 +0200
Message-ID: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
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
V2 -> V3:
- clean patch from unreleated changes
- divide adding support for ads1110 into separate patch
- add missing changelog
- Link to v2: https://lore.kernel.org/linux-iio/20260607183542.368184-1-jakubszczudlo40@gmail.com/

V1 -> V2:
- go from creating new driver to extending ADS1100 driver to support ADS1110
- Link to v1: https://lore.kernel.org/linux-iio/20260527164312.355729-1-jakubszczudlo40@gmail.com/

Jakub Szczudlo (3):
  dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
  iio: adc: Add ti-ads1110 support to ti-ads1100 driver
  iio: adc: Fix incorrect reading when datarate changed in single mode

 .../bindings/iio/adc/ti,ads1100.yaml          |  10 +-
 drivers/iio/adc/Kconfig                       |   6 +-
 drivers/iio/adc/ti-ads1100.c                  | 136 +++++++++++++++---
 3 files changed, 123 insertions(+), 29 deletions(-)

-- 
2.47.3

