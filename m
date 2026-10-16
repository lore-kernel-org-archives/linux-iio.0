Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DB37EFE3
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164941; cv=none; b=kZrSR3KQ9W6/xk66GiSgMCLYIEa7MbUuVXNw1LS2qxGtTwQUOLDkm0dRaWs9P7gNxY7d3rRBF/Yh1ATXZtYAVkTDP0idRbyU1Z74hi/RpIk1uuUeb2N/EFcF/PQ2bOA396CrzHOtH4jDg2lykmoQGE2wbXwfFNN+TE31mGBVYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164941; c=relaxed/simple;
	bh=obZwl1YfpAcsg19PeU/FGyCCEMFs7N3QvJbg18vd9RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ojf7vFSXtcQdS5RdX8aIlP7xOIUL3AhVgqw2MV7oRj1PQc/+hFBT/nMhN/d/sBcy1OyyZQlA948vCCLiX26PE3HEzyyFgSlRBRUxKC1gVoK361mvdhME8WInnL+NlqtBvSVPvA4owvm934VVrndFiQmKHw5zQTMgxuvMjtEpVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAWr3Fli; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAWr3Fli"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso8450356a12.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164938; x=1792769738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=byHreUpdXpkgVnzr1n+T2qNDhsXwcMUXXAuC2SDWEuE=;
        b=GAWr3FlimvsbIAvBEDHpGCAdW7ugg4S13R7XIlbM7O+FB2W+7as+JC2xHU5tgyVBu/
         OM0VHJn+JuGyb5493xHRVGdwdVaM/6kL5gm7pwQ1RbyIzNDo7baIgmHQ7tpgFooGIkM1
         wC28xHmZwe9cNeVjtmY/qCDPBUr4ZiWp6j2+hsGKxsZvwZ4Y6fDgYyprH/zet1TXAv8e
         UTKlf2/rGYvTRKjjBtUWJKTVuTTtA5KH3VHsdGnJGxaOtTYAr4ZGIz3suggQ7i7lZdYi
         N/0942QMKxsYfmdA6UmyJBdWj3PqB7G+bOIYx1G7GxNHILg06itxYW57BRGrk7EWW8kw
         LOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164938; x=1792769738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=byHreUpdXpkgVnzr1n+T2qNDhsXwcMUXXAuC2SDWEuE=;
        b=IwnqiaTSp9vlV2PTLotWEh1By8iHQvzZX5DW/DW2RAsQ3ud685IQVU0kGkDjRlI9ki
         9a1CHv9yMmnjXaSNL0+FbY5WwjDRRExSjOK95JIHPJ2wBbWfJgGyP12c8n/0rkg4bbA6
         DvMNHgjs/n4h9tRnDi8EgRQ8RvKQzyvKH7FfI49V269HSJN1N8vTpS2HKgGJ4ZDjaTEo
         J3Vg4ttFzvR5xpiP9UCNK3SWxsz1ybSlYF++zR9qcyJTt0SaZYokbid6weIZHZnXBIpT
         ZnAwR/sgq4b7/cLDoxX3xvql04ad74C5qgqdevqgB+zBLjl5npwWPTeD9FjwnSalAY2E
         RZ2w==
X-Forwarded-Encrypted: i=1; AKwUvBy+Y4VkyNoAPMszEFVZ0ftN9RfEE6ydRze/lo6FDWnSyZWd01X6U1CywVfr2mwWjshxr6iy+fmsGXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3dTRh874P9q4Xm1wqy59nE5f5M0IB9Fp+ghppBZAffNk0vgDV
	z4jBn+qVZNqcAWwAaiG/8PVud48///Ykn6FN75VCJ8Jo9ry+uTkcAMlS
X-Gm-Gg: AYBFou1mhErZ1Lp5c2CtEJ/CA+fa9wfVBC4whcFEyNm6eIE6GNr+QmE/EJ4GqBcQdzx
	Q0uth1mfuTy1r/1A9Vf7z2ClzoyRMDrls0bnAreoJYt/m6ffBJJIAC3aE2O3O2ZRZUZX895/KlQ
	ZTuhe5TP/iFXI5jLhOzg6w7CxFlKW+C/Fb7zbnA/10QY5CXrQYtm/ekrdW/JzEgNuL/IpVyNvlv
	kCjHh3Y4bug7bSsBVTKflG0RDUOw7NWs5toNF5slfOkjHoxfEUOT8V85QmIY4GfrI5W+6VuE/Zz
	dlW4U9Z1bQZpdFCApt+5ccfhv6Dg4ExU/xS/Mx8BWZW5cgFXpm798ETSOKEafwRihkgW62kfV5t
	mVZ0IKXwAO4R/s8MNEemug44uBBKiYYShQ4x0m9DRcYsrRagMods4Clj9zunfeP9AICp/xVfII2
	KvIPbHnUZRW2hakB+WSa6mEe7Z5UlOk3nqLNTCm+CIyU3wT1lphE97dDAfZ9CLboimSjPjT59xH
	0K5pAX3eVIno+ztW67fP6dHLfLZYIdxCwuLSfYyqKk/zzQWbJ8qIbGviSsVUwbUzxyTwUgpE4lf
	j8M9DFGZBusM7M27O4o6oWI0QlM=
X-Received: by 2002:a05:6402:1e8c:b0:6aa:7ff:4ebf with SMTP id 4fb4d7f45d1cf-6b1e40c6dc4mr10129099a12.15.1792164938017;
        Fri, 16 Oct 2026 08:35:38 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm999067a12.10.2026.10.16.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:35:37 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v4 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Date: Fri, 16 Oct 2026 18:35:28 +0300
Message-ID: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zilltek ZTS8032 is a register compatible DPS310 with two more
pressure calibration coefficients (c31, c40) and a different TMP_CFG
layout.

1-2: Vendor prefix and the zilltek,zts8032 compatible.
3: Per-chip data in the I2C and ACPI match data, no functional change.
4: OF match table.
5: ZTS8032 chip data: the coefficient count, the TMP_CFG startup value,
   and a Horner step each for c40 and c31.

Based on iio/testing, on top of a22dc7ebb21a ("iio: pressure: dps310:
fix overflow in pressure compensation").

There is no public ZTS8032 datasheet.

Testing: ZTS8032 on an arm64 (MT7987) board, the series and a22dc7ebb21a
backported to 6.12. in_pressure_input matches the datasheet formula
evaluated from the raw and coefficient registers to within 1 Pa at every
oversampling rate from 1 to 128, and TMP_CFG reads 0x00 after probe.
Every patch builds without warnings with W=1 on x86_64 and i386,
dt_binding_check passes. I have no DPS310, so patches 3-4 are untested
on one. v4 only renames a macro; dps310.o code and data are identical
to v3.

An LLM coding assistant (Claude Code) was used for this series: it
ported the ZTS8032 support from the vendor driver, wrote the code and
changelogs and the hardware test scripts, under my direction. I
reviewed and tested the result.

Changes in v4:
- Rename DPS310_MAX_COEF_LEN to MAX_COEF_LEN, separated from the
  per-chip lengths by a blank line (Andy)
- Add Andy's and Joshua's Reviewed-by tags
- Link to v3: https://lore.kernel.org/r/20261015104945.2687162-1-paulius.zaleckas@gmail.com

Changes in v3:
- Drop v2 1/6, superseded by a22dc7ebb21a in iio/testing; rebase onto
  it and add c40 and c31 as Horner steps. This also covers the Sashiko
  overflow report on v2 1/6.
- C99 initializers for the ACPI ID (Andy, Uwe)
- Add DPS310_MAX_COEF_LEN in patch 3 and bump it in patch 5 (Andy)
- Parse c31/c40 based on a chip flag, not the coefficient count (Andy)
- List the supported sensors one per line in Kconfig (Andy)
- Link to v2: https://lore.kernel.org/r/20261013112124.1878296-1-paulius.zaleckas@gmail.com

Changes in v2:
- Split the driver patch into per-chip data, OF match table and
  ZTS8032 support (Andy)
- Drop the linux/mod_devicetable.h include (Andy, Uwe)
- Return -ENODATA when there is no match data (Andy)
- Add Conor's Acked-by to the bindings
- Link to v1: https://lore.kernel.org/r/20261012114550.1680054-1-paulius.zaleckas@ui.com

Paulius Zaleckas (5):
  dt-bindings: vendor-prefixes: Add ZillTek Technology
  dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
  iio: pressure: dps310: add per-chip data
  iio: pressure: dps310: add an OF match table
  iio: pressure: dps310: add Zilltek ZTS8032 support

 .../iio/pressure/infineon,dps310.yaml         |  4 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/iio/pressure/Kconfig                  |  6 +-
 drivers/iio/pressure/dps310.c                 | 74 ++++++++++++++++---
 4 files changed, 73 insertions(+), 13 deletions(-)


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
-- 
2.55.0

