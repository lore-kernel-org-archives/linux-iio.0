Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332A3BA23A
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104431; cv=none; b=t/ZouDCPYWZ9jh5GOZLCb67PCvotFSJdHzbO3Gdzk/pq62D58c67AJJKdRGPYwQK+GJSkk6sUZeK7+xlBLoR7o9mebzVrwAZrXBz7geXI/AEBhW3JC9L6GLO03A3Y+i/pc/+YeXHZVXXAdtAO92vW0Is4Fyk4O6pzsaqsUcgP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104431; c=relaxed/simple;
	bh=ZywlfbF41j2Nded7OQmsl0r2Xwazx+xj+hhYFdpigSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQcWYgMresGIwC9KgCcP5QtE6BE4Tf/H0Qhl8iCxYFIOLSfWjTudQY8GcLOKrAqw+ELOSSG5JZUeAKWA3ihopFjwz88AgF4FGkQnT4g1VLFZjKnyvZ3NJJ8X+HoEgQlZCDDmzrui6tGRtdX5AheMyDNlSrP2uTWqSal39JJptbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdrfmLXd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdrfmLXd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c857fba35cfso3430497a12.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104429; x=1781709229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2WYk0Xb543ogGLjaeUCwmB6Ei9KYDO2yTRMSZaVpY=;
        b=fdrfmLXdLBBmNFgpj9WWZcpjiv2zJ4H4C9+UzMHGJcfN+ItNolsWGwwYzaHjYRH7Ee
         HlSLYKpRFqjupt70WkgSATJiOIn8GTyvD8W5l+AflrxX5cx6ULpCmlZbjPoRamF6fpZ8
         4uxzy15VhwDngIyZKUgNoFDjza/5EzTyAKBckGzeiINSFinAbNoV1GdzTlir6hlBqojj
         yifKHid4vhlffYStiQzMmqOeJdkdQjvzYYO1/tX0WGstUblvTnuNpcrpYbMxxpEDiQ4I
         ByVGft2oIgZTBT8DSYC8KwMRT/eb1cRwRprpAOYQ2wa2TvGd5tnuTR/VQ5ZPp53a18eT
         5kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104429; x=1781709229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN2WYk0Xb543ogGLjaeUCwmB6Ei9KYDO2yTRMSZaVpY=;
        b=IWSaatYsueC/Yk9FgbkwArNPCgJMx/JIakR1hf1z9bbOufcpwzl/J9VoLFvrupYePN
         C8Wryk2j54OVWWseZaegQloNG+WkXOF/UMdlf6izPON6T9cBBLgwncDWlhjIL+vWQ9dK
         JYrJM/HXltVcmeEexqjU9fdkjfH9BIuqjaJyQxAsOCQhUvmvp7Lqp3sYMhs5YxY6fRnc
         C2cbVi/2hGohFTv9Wd/Ncomu39S7Ixam1JSJbNPzUJTroBZ3h6y+xES4jKIllwaO2+rM
         moVcN9dkH1UfDUHswoEwf/Wa8n0czSKrXPmY3ldr9V8OXbKlgJwgqSyinfSFiaQ4CB/e
         zppg==
X-Gm-Message-State: AOJu0YwxChH6EzkhL6UT3L2ivw7wDUhDmJxL1XtRkvtDhhwPzp09ykHI
	ItbarHLdqXkWLyFZx+10+CTmX8z9z6J1RKC/jrwXPugr7mHgnXWa6H5q
X-Gm-Gg: Acq92OHnYJim8LjktjjkjI6BLv6nDBlVMdEonddlLpC1DM+k96qHn+EmNl1FlyXoxCw
	I03a0OIIBZ4GgrPnd1yirFCP+6m1jO2V19YdS+KnLEj+2dKDj+7KQoD/PRBjZqWiAlENXTFMmOi
	Xc33Z7kqKmsB9VV8kQJB/oxGyFuJX2Qk0Mp/X7D/5rt1uoc4vYore/NZ8Hkj1RmQmaLh47rkZra
	jFl+VH565i68s33anZLuhs4MsxLpmGuy0PHWin7tm1xhIHz/bzXdcz3c8JPKlr05iWoZID0QPLo
	qS9H7CHrVPWVNsMNPLiJDLoLT534+zAHm91sJ4nsTEeN3f/Wpes8P90mZhFAPKVb58OeFJGDejh
	3TMvsxknj+KQHH1aL4uvUHaftzL+Wfaxpdm1kKo4dHNXEWebdhxqYgN1ebjye4QFAiYaJq9BAf8
	3jweikqmqNSgIPYZB1Nb+yS1Y=
X-Received: by 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr281161125ad.32.1781104429228;
        Wed, 10 Jun 2026 08:13:49 -0700 (PDT)
Received: from ltu.. ([171.245.6.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm254066195ad.80.2026.06.10.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:13:48 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	zizuzacker@gmail.com
Subject: [PATCH 0/2] iio: adc: Add Texas Instruments ADS1220 ADC
Date: Wed, 10 Jun 2026 22:13:40 +0700
Message-Id: <20260610151342.44274-1-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Texas Instruments ADS1220, a 24-bit,
2-kSPS, 4-channel delta-sigma ADC with an SPI (mode 1) interface, a
programmable gain amplifier (1 to 128), an internal 2.048V reference and
a dedicated DRDY data-ready output.

The driver supports:
 - single-ended and differential voltage channels described as
   device-tree child nodes;
 - per-channel programmable gain (via _scale) and data rate (via
   _sampling_frequency), with the matching *_available attributes;
 - the internal 2.048V reference, an external reference on REFP0/REFN0
   via a regulator, or the analog supply (AVDD) as a ratiometric
   reference for single-supply measurements;
 - single-shot conversions gated on the DRDY interrupt, or on a
   data-rate-derived delay when no interrupt is wired;
 - a DRDY-interrupt-driven triggered buffer for streaming;
 - runtime PM (power-down between conversions).

I tested this on a Lichee Pi Nano (Allwinner F1C100s) running Linux 7.0:
with a potentiometer on AIN0 (single-ended against AVSS, AVDD as the
reference), in_voltage0_raw tracks the wiper linearly across the full
0..3.3V range (0 to 0x7fffff). Nothing in the driver is board-specific -
it only uses the SPI and IIO frameworks - so it should work on any SPI
host.

This is my first kernel contribution. I modelled the driver on the
existing TI ADS-family IIO drivers - ti-ads1119 for the structure and
ti-ads124s08 for the SPI side - so I'd welcome any feedback on things
I've missed.

Nguyen Minh Tien (2):
  dt-bindings: iio: adc: Add TI ADS1220
  iio: adc: Add TI ADS1220 driver

 .../bindings/iio/adc/ti,ads1220.yaml          | 146 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1220.c                  | 835 ++++++++++++++++++
 5 files changed, 1001 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
 create mode 100644 drivers/iio/adc/ti-ads1220.c


base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
-- 
2.34.1

