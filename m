Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC637C929
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192471; cv=none; b=Pm+auMbjzIot+i0WFwKc2RRnnFhDt74RhTDCN+SRHFxnlojuzYVoL38myp1dtKbdw2lPovULfuOXHClgKtH3df4Cyud6YScJcf3eR0K0dcD6rLrCuwR7eB4SBFmeozIhXHVfu3fZwW2wzT7gEWPmydlviL2L2NG1o6BCPIPTBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192471; c=relaxed/simple;
	bh=RPmaQk94XVkHjUWvCHnUNh/oP6dEj3BeRyO7pRtRAQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkTNyjMZ4QmhL6vPSaXpfeZ9iymnhEfrw9mx5f7QsRg34vjcAf4jexIl8F7Bm48h979uq1ME73OAzzUS6+aL9OSu36IbxII9SSyrrzABZ5w22ZXkBiXQPj5vkDO6Ct5DUPXI8AznEQYqqAN9V8VoPQASiqVbO3GBPAQE1bq8hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWL9kDZ3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWL9kDZ3"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa65a184f2so8615429e87.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192468; x=1781797268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GKrlwR5PMGqe4clCpmusoR6L/gapT+56WN//GZADUM=;
        b=nWL9kDZ3NWkqMttXrVtBV3cjsBclaBT+YT0mXsxSAMyQAFrs1ThSPrsDqlaoJiUyY5
         PU04+goNeE1BCRxhlPCJZOQYHA2mzv8ngDEYPltrnrVQrvdd3f2gwUOoBChXOYRl4tZa
         uqRggtUQm2RpB16zqJJ49hXXCcMLW9A5hg2g2VzdO37iGccgYJRBzT+r4FJCYr3nxvET
         MvvlRRZm1yLIstlOx9pRXggJa+NrVDTbPW6hOeXN/WD+o+If8iuq3g/zdGRy9GDbI8P2
         Z0q+IrgGVnP4KjSiXoCBESO9LVnwA5WDu1j2/n9sm11kn/VAT7jsyxMyHrRFiHwPCTZ7
         M7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192468; x=1781797268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GKrlwR5PMGqe4clCpmusoR6L/gapT+56WN//GZADUM=;
        b=KdfrKqtQGdCBs0RfeWgddktMlRa05BMIj4ZIGVrKOjZtzq19BiXbd80HD2cZrOMKrM
         z2oAnAg3NWERpDCaNRP+lgTeKdlSEv9BII3owEMFJ9RAoEigeATN3hyYSiOm8lfz25Dj
         khpK0UGMLfqQvY7SRbbja8T/Gofr1F5zmKaykfoPeB8+albzOHzBIP8Rbb2Wy8mgfyZO
         7sphx7GvJ3HFm9lrpNZouXaCIJEKHUHhQI1QrTF/zJUvsYtvPI9UrAcQj5mcB3+ZUOdb
         wRsK8fQVt/gK+GhV4bNnqQ13GEeDR9JJa8uJVeWJ6hR5elHEYYC62xVN2xQdj6g2szxk
         CZ5A==
X-Gm-Message-State: AOJu0YyH/Rb3OTyqCcBlzYQcCOcsUMuSbDH5Wf76VlodNzRLqckgzP8p
	a5eVg91rKJQS1vGjYf3sMhwubv38t90hwvG6x09wIMz16tRHHJJMHaQgqQ9YlODCm8s=
X-Gm-Gg: Acq92OGOo5+3GJ+G+pWZY22UwBDVZVypqJHhrV1ifvRSYOmKXnsaBdYTQ/vXQcsWOTj
	cgpHwySuVLT9sSfHiHv+6CelJrGVevxMzyJq25DNmRbQ/zZoQyCTwgcBzCFg2IX8WnDTaNK6yi8
	Agl2dStwGZ9Me3FvYlG3x0exkAfUphQH9Aj/Ma4hhEhF4I/+yL9MvloXhJHCGeluFrhlBqWmpn3
	QAOZ8RN3gnLGulM/px+asrAP5q9H9vN/erseNFgP8Qs+NAkvYg3e6rsALF6GV8ILA574mOz7JeC
	/t+c8UFU4JHxZ63/tNGbGmPsS4l3eUiPJEGfakFwOI5/GQU+CIN6B5fVikyPIHNaR+2NCLDDXC3
	X0eiDWIkq9ixA2EAM+12LHkLh95rIKP3Wez7kTrpfCb05XW11s77ZUHFK4eURP9lKf3UrA/+S8N
	Foh34xcG6LTV0swsQqSWnqln9hMqefc9ccqrIRIHXg3Sk+dsmhbacStkqE+2RzNbgxk3M=
X-Received: by 2002:a05:6512:1090:b0:5aa:6a2b:d449 with SMTP id 2adb3069b0e04-5ad27aba631mr1088964e87.21.1781192467393;
        Thu, 11 Jun 2026 08:41:07 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ac81488sm5994641fa.1.2026.06.11.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:41:07 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 0/3] lis302dl/lis3lv02d: fix click thresholds and add legacy YAML binding
Date: Thu, 11 Jun 2026 18:41:02 +0300
Message-ID: <20260611154105.3727-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses the review feedback on v1 of the lis302 binding
conversion.

During the audit of upstream board DTS files I found 11 ARM boards
referencing st,lis302dl or st,lis3lv02d. This led to two additional
findings that the v1 patch missed:

1. A longstanding driver bug: the driver reads st,click-threshold-x/y/z
   but 5 upstream boards use st,click-thresh-x/y/z (the name from the
   old .txt documentation). Those boards have had silent click detection
   failures for years because the driver ignores the misspelled property.
   Patch 1 fixes this by setting a sensible default of 10 in the driver.

2. Three different compatible strings are used as the primary binding
   for different boards: st,lis302dl (Nokia N900), st,lis3lv02d (Nokia
   N950/N9, AM335x Pepper), and st,lis302dl-spi (PXA300 Raumfeld).
   The v1 patch only included st,lis302dl-spi and st,lis3lv02d.

Changes from v1:
- New patch 1: fix driver click threshold defaults
- New patch 2: remove st,lis302dl-spi and st,lis3lv02d from the
  deprecated section of st,st-sensors.yaml (duplicate resolution)
- Patch 3 (binding, formerly the only patch):
  - Add prominent WARNING at top of description
  - Add st,lis302dl compatible (Nokia N900)
  - Document both supply naming conventions (Vdd-supply/Vdd_IO-supply
    and vdd-supply/vddio-supply used by N900)
  - Add mount-matrix (Nokia N900)
  - Mark all click/irq/wakeup/filter properties as deprecated=true
  - Add st,click-thresh-x/y/z as deprecated with a note explaining
    the misspelling situation
  - Remove Jonathan Cameron as maintainer (declined); use Linus Walleij
  - Remove driver path reference from description
  - Add schema range constraints for axis remapping properties
  - Update example to use Nokia N900 (minimal, modern node)

Md Shofiqul Islam (3):
  misc: lis3lv02d: set default click detection thresholds
  dt-bindings: iio: st,st-sensors: remove lis302dl and lis3lv02d from
    deprecated list
  dt-bindings: iio: accel: convert lis302 binding to YAML schema (v2)

 .../devicetree/bindings/iio/accel/lis302.txt  | 119 -------
 .../bindings/iio/accel/st,lis302dl.yaml       | 320 ++++++++++++++++++
 .../bindings/iio/st,st-sensors.yaml           |   6 -
 drivers/misc/lis3lv02d/lis3lv02d.c            |   8 +
 4 files changed, 328 insertions(+), 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/lis302.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml

--
2.51.1

