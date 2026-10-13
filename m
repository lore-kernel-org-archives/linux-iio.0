Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D04F3EB0
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892618; cv=none; b=S0h4Hz49wDCFD42di9QMY5grhGKTr+SK0/aNEudI2jUI3CGsCzaKQk9hz8j+j8ly5mkw7mjkSfhL6gPvt5oYYWlB477g1OGPmnUhcJSUV+RB6MHkrx63AtTDHqmN6paoC5ElJrb1U7WShcVLanSxbHFApPhzpn0hP4YKeHt+7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892618; c=relaxed/simple;
	bh=B0xB5Wj2A0Iqf6C3s/PSU4/SthSDFPeFKdDmMAXGNOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5lEeCM9qf+11cbB6OPtDIZh5XXbAqmzQCIL2hDlRsEm8B5FjQ89GNxfYI8SQVunW8PpzG1vpKqbM0HEqlBKSV4lwfoq7h+ZX2+uVGhuZA77G88kKG2gKxwYYJ8cQmUhe+nyE37Hvia+E3ygKCdwyq114kFRxpVnJuGKAFsTOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzRVhwUG; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzRVhwUG"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15354aa70e8so342343c88.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892616; x=1792497416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUjsoBRlToylDAgZob373tu+/iyx0SwuuffxUT/RyX4=;
        b=PzRVhwUGi8yu3YNJed6Zc9JhUHFkPB82oiwLbi9XwNHBNbtX54nPBpyyGVnO7XpiYR
         Amr6RN8FLLBBn1JGA6Z/w5kAZQAvLyLApQ8wXUT6iIP3sliiaHGSMrgdHNtaMKa7QrYH
         bSb81ViAD0X73iT3O+0erpDNijsjxZpbBgC6B0SeNGPmXEOYXcDfzmdKJdd2zewEZD+E
         7kEaqYqGs1oS7yBNt2IvX/G3ITn4w1XJzkV3TowaplDc51CuTkszm3Rv/FMPh5YgT3xn
         cqzvIU/FQGdKFMdTWMe+OEaa+Y/2G7/Ez4rz3qCjm7/MFdNY9c0rAD3HCkWI4T/YJ2cN
         aKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892616; x=1792497416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUjsoBRlToylDAgZob373tu+/iyx0SwuuffxUT/RyX4=;
        b=VB881B9tJDbtvuRJtVyk/O/9z+ThnNsWYVaqC4O5H3H3vR18vH3wKvIf0q9hZrhMoe
         K8kqE7Yb4X5uA1aQEjB3EhDROvBCDXKV5n2l5LqsXOz4rJQA38Sh+tTcb+BrPmImuOU+
         9T6IrCa2MDUeeFqH1zM/0Mjev7JZ1xViFC1hEi3F3BOLFGCUIC4FGdejnpKqcnjfAMBf
         SOeARK1vPCwJv7+tzpoo7yWbDexRu8jAwzIcfq8O0xb+JurF46ZffToX0dLYD4yGkIlT
         Ofu0IcTmgINU7QD6v5NWdov5Yepi2lG7C3GiicbvXcHHYyRsYjDLWuM7CEDyvaRVJY1+
         acMA==
X-Forwarded-Encrypted: i=1; AKwUvBxUYmovoG94PdwZlUrEobV7TJBDNndOr3zUYllqXtwHuBUvHZUbv8uD3IWhoMNspybhojmaat+dMrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo7Jz22V18UZBIuWCohE+aDdSa1w3v+XZxD+nknXav7xT+bFPX
	T+qvFeVOgbG3lajNoKWFtBgkvOjQb7Z9MrKAzJIvabVd5iZNFALDfKRK
X-Gm-Gg: AYBFou3sHl5kiOXEu7dfd5HZixsXC1QuhFoFmK4KeprXo74LLGS+Fu3h8B5YJHKDdRF
	UiMrpA3IsGOgAWAZpDKw8HE40eVC0+oBRlJEA1sJgkqfv7PQiqKghvLfVO+Ad40bitiK3lbY6Ar
	vJZKqX54oNSlhXMb8GITXkA6lRy/fgWNNLgJabz5Vr4nyhpc8VM+nMsrRr+j30m7lIF+J0tLLRj
	Oucoe6ToViqUAKvVcG8G4Jm2AJTFCPn+LxJytTSPDPuSeN2qRxJGlHJMwuMk+QO+aMQni/wZ+Gx
	j27bI5+nVbV6N8H2p1M0x8cQ00mUN+8pRJpjsmgLyoB0gsTWBWLxoh3WYq0TXNTsG2+1J1PEraA
	gMzICUpf0y8jmy+qUS5BteNwqHZEFZmYCt4FI85oE97jBTV0hgmtZ/jQVGxBYSc0K+IAzHpZxTr
	LH5kkp50uop03jTsSbOTuJD0x3sU012jH7UoCwWIMKFXKoOD2Y/Ik0p/QLTvXGe0qknbQ5CAnp
X-Received: by 2002:a05:701b:4583:20b0:151:9af3:1beb with SMTP id a92af1059eb24-16a5dee12e2mr17214338c88.10.1791892615861;
        Tue, 13 Oct 2026 04:56:55 -0700 (PDT)
Received: from localhost ([104.156.230.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm18467858c88.13.2026.10.13.04.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:56:55 -0700 (PDT)
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
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Add support for AS7343 multi-spectral sensor
Date: Tue, 13 Oct 2026 19:56:37 +0800
Message-ID: <20261013115639.167433-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
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

Changes in v6:
  - Add a ref to leds/common.yaml for the LDR pin in dt bindings.
  - Convert ATIME and ASTEP range checks to runtime checks.

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

 .../bindings/iio/light/ams,as7343.yaml        |  66 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 464 ++++++++++++++++++
 5 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.56.0

