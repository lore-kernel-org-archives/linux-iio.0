Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C312D0C64
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202396; cv=none; b=MvX0DwgCrFwgYocMAVcF0rMalcnWgoyGEYIdisbfFiB11xxIB75OGXN83Ftulds4VsOHoyoUikywDRsXqMe2nw7LbJWA760KGJOlCAWjzxYJK7KvOK0dmR33U4ZyveaP8eq4dGBhsAKCKjmPmBQq2CVAw35gR7If/h1T3Uk7RVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202396; c=relaxed/simple;
	bh=8UtX3Dd8gyBxCOoHOjGxAb9XHakiWDFR2Z/SXhpSidA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVIYCCIkL3799qElpIBfu67XTOTM/b4cG9jH0EdBjT71t/D8wmwtKufG/nbBJU9LGt8wD3S6KgGW6JzkoZmNSMOs+F0CTjmR0j7EDp+D840EyFEP8yjimtCJF/n+3aPSy+RIY1UcStGhqFD6O8bzcXYarxQiBlvmhOjOdef/AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2bFhZen; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2bFhZen"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so13281595ad.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787202394; x=1787807194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdg5mjbxDlejn+rt1v5VsfqyiYFBYbUL8d5FdoHC6sE=;
        b=J2bFhZenrcmN/NvS3CLmPCaQbDZuecpFdZr6q4kZVGq8vGPrNijfayw0EGZAkowCeF
         znNZP6b6NLV88zgZhwC1U8UZ6PknFOF6IFXVPSkv6Sk+kNx5BTtlV5nF0K+HRFn/xEG5
         KKyrKMKZZxhNZsoyyKnQHp9+Gy0bQpl6KgJ1Jy3txDkDFydu9lASh50IgTVkUcXk9lNx
         W3EihkL+raXv/4xFw1p8H4iF4MDSQ1EGdO90tYSKJICcAxWHnoF0C+G8A1pEs0QlEjNl
         mrpFNoYxlsYfObV2syMM9lPeYXd+GOiDUArdyGrS/HM2kx3/PghUdyHyM2WNDMv0oxJb
         Q3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202394; x=1787807194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdg5mjbxDlejn+rt1v5VsfqyiYFBYbUL8d5FdoHC6sE=;
        b=aAdfFxNwmJBvPOEbJXg1p3Y1uy2tHHFo2TYOTaUU9vn2nYeNeNbcX5rT1m7DulDo9q
         GjBrUapmSMNfSOnhOR3M3nNZZgXOJucZFB7s4UC8Bcv3Xm7z4MIciFE8pKwrSqy6r6Ha
         ZkACOeYpymUi/nc4VFu5K0SQPptjP6hBxQXmgt7+UiONbwb8GDpq3SZFt7cUqW+ZgrMt
         jkdduzlL/CJ32Fi7R6eTShYA9DldnfRcDvcDEamXOUsqfbpKygK024vshXYbxjKOF/U6
         eHf2SozjFtq7aZbjz9IbWsY5rFFyhLjs9+RTuOwi+2K4K7T2g8tgkNAQF7uHFRolX5Iz
         6jCw==
X-Forwarded-Encrypted: i=1; AHgh+Rp38cqWDyIqXXcrgI3eqiWAj01biQiBNlA/4jaBuP9orGUq8XWaeqIwTjPwjb1S1TNYjj5cbJs4+6k=@vger.kernel.org
X-Gm-Message-State: AFuF++nUIJ6hC6vKHFqpzoIuvvCf7peLp627tgmvhgh5zJi/h+HDM/C/
	Fs4tIeJZEqfXBj3XqESW5zBexo//Gal3Y6MJK8Tz81oAidCMO85JzZ00
X-Gm-Gg: AR+sD12h0wHKTeRYzYuD7wPjvPVoeQiOf5fgrjyMvM0bEGwhqY2N7UqZBIuRoHU6LNh
	k9MFRRkHXRNRZ5rQeuYLwx7+4vZHPRd0/tH6LQ+mS9/xy6LJjKY1XgIIMCiDvXvS01h21NA/eGd
	T7Q73hYuUu4lcHBNMa+mey3HwVDVV3D8Uz+bm4fpx+SCIVekuSBQN5dWUGIpNyo/aCE78zduUuE
	hZVt4Ngtiqp3kDA2Bb4Osq/s4kEN4/Fl0b7dxXec8z3zEQcfHltWW2K6tJx0IrQopp5xNaFtJJD
	X6wudz5f/n1jByQkl942tl1M9bWDHX8b0qZ7rhDcXXiWrSQLVXfLekF+Jsplx8yvkFTvBiPW24x
	vZfv4hvFM/CV5dJtLjFaSk8y+KDI6SgtD7XQurAm2eQhf/EU0lvnKywgZPFS7NXhdPh2nuzY7LV
	IuY91DSrke/i4vx33YaLLvf0fAeam3AEB3qS6wsSdN7XIOv/EKlQMqcZbjFyfmT5AHiMa4ELeXF
	KWrmjjBXcLAJrCjvny4cpSIkjUdldzjPopr8kML5QqOYVw3hwjFdmu/TTPzyCjPJ0W8giYHp3xB
X-Received: by 2002:a17:902:cecc:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d601a8ef08mr165271975ad.12.1787202394458;
        Wed, 19 Aug 2026 22:06:34 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a82dsm2040685ad.18.2026.08.19.22.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:06:33 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	grondon@gmail.com,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v8 0/5] iio: add Open Sensor Fusion IIO driver
Date: Thu, 20 Aug 2026 14:06:03 +0900
Message-ID: <20260820050608.5440-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open Sensor Fusion (OSF) is a physical sensor board that reports
measurements over UART.  Add a serdev driver using the generic
"opensensorfusion,osf" compatible.

The compatible is intentionally independent of a board model or firmware
revision.  A fixed wire header carries the protocol version, while a
capability report discovers the available sensors and channels at runtime.
Supported capabilities are exposed as four IIO devices: accelerometer,
gyroscope, magnetometer, and temperature.

Changes since v7:

  - Separate wire decoding from support policy.  Validate the protocol
    major and reserved header bytes after frame authentication, and ignore
    unsupported capability entries without discarding supported entries.
  - Harden resynchronization: unauthenticated candidates discard one head
    byte, while authenticated frames consume the complete frame for every
    handled, ignored, or rejected outcome.
  - Retain split one-, two-, and three-byte magic prefixes across UART
    callbacks, and use an opaque callback so the stream parser does not
    depend on the driver added by patch 5.
  - Zero-initialize explicitly aligned IIO scans, use
    iio_push_to_buffers_with_ts(), and simplify the buffered fast path and
    one-axis versus three-axis handling.
  - Commit a sensor sample to the direct-read cache only after the
    registered IIO channel and buffer path accepts it.  A rejected
    CRC-valid sample therefore cannot change direct RAW state or the last
    accepted sequence.
  - Add focused KUnit coverage for accepted, ignored, rejected, and
    malformed sample paths and protection against invalid-sample cache-slot
    exhaustion.  Run the same suite against pre-fix ordering as a negative
    control.
  - Consolidate MAINTAINERS coverage under
    F: drivers/iio/opensensorfusion/.

Static and build validation completed for the corrected source includes
git diff --check, scripts/checkpatch.pl --strict with no errors or warnings
on all five patches, four passing focused KUnit cases, the expected two
failures when the same tests are run against the pre-fix core, the targeted
DT binding check with dtschema 2026.6, the IIO documentation build with no
OSF-specific warnings, clean W=1 GCC and Clang module builds, per-patch
build checks, and clean-base application with an identical final tree.

Pre-audit v8 hardware validation used a Raspberry Pi 4 over UART with a
physical OSF board.  It covered serdev probe and bind, capability
discovery, direct raw reads, a 66.5-second simultaneous buffered capture of all four IIO
devices, and unload and reload.  The capture delivered 919 accelerometer
samples and 918 samples from each of the gyroscope, magnetometer, and
temperature devices, without a kernel warning, OOPS, or IIO overrun.

A focused post-audit Raspberry Pi regression then exercised the corrected
ARM64 module in a one-shot tryboot without installing it or changing boot
artifacts.  Both the first load and reload registered four IIO devices and
passed direct raw reads.  A 12.0005-second simultaneous buffered capture
delivered 165 accelerometer, 165 gyroscope, 166 magnetometer, and 166
temperature records, with no read errors, timestamp regressions, or
critical dmesg findings.  Unload, reload, and final cleanup passed, and one
normal reboot restored the stock kernel with the OSF module and devices
absent.

A validation-only debug build from the pre-audit v8 development source was
used solely to observe internal parser and DEVICE_STATUS counters.
All parser error counters stayed at zero, and all 94 DEVICE_STATUS reports had a zero
dropped-frame count.  The submitted source exposes no debug counter ABI.

This series is based on the IIO testing branch at
a9fa85254feee2b52b2bb4fbb4920ece47dfd6f8.

Previous revisions:

v1: https://lore.kernel.org/r/20260520072843.3593-1-kimjinseob88@gmail.com
v2: https://lore.kernel.org/r/20260524085312.15369-1-kimjinseob88@gmail.com
v3: https://lore.kernel.org/r/20260529121005.1470-1-kimjinseob88@gmail.com
v4: https://lore.kernel.org/r/20260607234343.22109-1-kimjinseob88@gmail.com
v5: https://lore.kernel.org/r/20260616072242.3942-1-kimjinseob88@gmail.com
v6: https://lore.kernel.org/r/20260628191337.937-1-kimjinseob88@gmail.com
v7: https://lore.kernel.org/r/20260707014525.1015-1-kimjinseob88@gmail.com

Jinseob Kim (5):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add authenticated stream parser
  iio: osf: add UART IIO driver

 .../bindings/iio/opensensorfusion,osf.yaml    |  52 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/iio/index.rst                   |   1 +
 Documentation/iio/open-sensor-fusion.rst      |  72 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  27 +
 drivers/iio/opensensorfusion/Makefile         |   7 +
 drivers/iio/opensensorfusion/osf_core.c       | 393 ++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  70 +++
 drivers/iio/opensensorfusion/osf_core_test.c  | 493 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.c        | 304 +++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  22 +
 drivers/iio/opensensorfusion/osf_protocol.c   | 224 ++++++++
 drivers/iio/opensensorfusion/osf_protocol.h   | 101 ++++
 drivers/iio/opensensorfusion/osf_serdev.c     | 124 +++++
 drivers/iio/opensensorfusion/osf_stream.c     | 231 ++++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  53 ++
 19 files changed, 2186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 create mode 100644 Documentation/iio/open-sensor-fusion.rst
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_core_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

-- 
2.43.0

