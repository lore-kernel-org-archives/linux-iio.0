Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FC56B87A
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966240; cv=pass; b=ZBqYwtHP/HHW59FjE4pkJ7a8S78ne/u1qnAqXRI9z6GUxK0764dTgAGcouKf2+YYYRof3wTbXvAZP3xHmHMj6lZdjWoMWOVZwesco9PleY3vM2KI+dL25MXvMR2YZskQfxliVs/3kLKj0/yXiMX/iBsg1oqskmJUiYHnGE7/Nrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966240; c=relaxed/simple;
	bh=hkSfepIkuaA1BR2vdYKe9EUPh+zODoi/S7ln8yQ7GIQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qEkkSEmsYFGEw9Ry5OFKSLspCbCb+YvMQATt5iRCIXRbd8OyjUWygLuiKt3K1qD9W863rTHGHRSn/i7dEBZAEAV4JeuHIPIVBlJ5BjjO5s4nxvApy2Q+PPUJ+8d2K4a/IDj8ocv5lH55xuc105QfdpvJapV5Py/dGNpkYy2UAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAQwsDJC; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQwsDJC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso5206120a91.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966238; cv=none;
        d=google.com; s=arc-20260327;
        b=sGZQxneqe82fuZeuvM6KvDwrhkEBbNdzi8+3LVd+e1Hti8tUogES/zt86UTRdEyo1I
         FFE4HhmBSRTcT4skxTntdTSet3dW+QiMpxb8E032S5EH1PTzPmnGgcuWyw9KZrBCS9eA
         iGNxWPKwxjpjjs9mO41yZ3CXvYZ24vIV4zOzQZq8vLxHbpmssgveCZF2JrP3qaRzXKuj
         K8YDbsKgUuseLFT6fBYjapKctPVgxKUe5f6/p+T4kr3zbPAwdtCK1gSSkcq6wJIp82UJ
         4+jBQqTycUhENXpHBXT2km2ORiO6CiPjFUi+0x1tg1W+hNI8Mjir7Gba1zqjp8ipjvNE
         6daA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n/Z72raft7zwuNUvkj5sjKkqDryaZ+r6PhkLnJpg59s=;
        fh=fiq40myiuH+4pQemNlG7eWGQNDzEKP1LoA2fdeIfEAM=;
        b=DwbDE6YQtzmy9Dy1d+ILPCSF35MAIz1wZyfAQpDEjKSMbf6xTjA5xSq/s7GDNLixNN
         Iyzn/mTohNAqzSD2dWYSHqV4kD3deO1oQQwO9KBj4qGvPLCSpNIbS72HsJcxldARR1Ri
         5AZKuEGth1fu9HGPvgFdZLKMDCorHHS+2qbPSZ6TJ/cE829UB02Kk2dxL9aJ6re9MZ/+
         ujiu4e/5fyORGIolpr2dOUlAn+zbFEC7nwIvCZSaPhxJn6gIMrV/gkyFddLKOr5EJltr
         AUp9TVmdHtAz57cKiVjW37pcUgL94BCHqALIpIjQREaLeLWhBUGsd6ctF+kT+H7MGU0w
         x1Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966238; x=1789571038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/Z72raft7zwuNUvkj5sjKkqDryaZ+r6PhkLnJpg59s=;
        b=AAQwsDJC5kaAu4gV+jxSL3wLXkLgM5buuPdjIroWylnehqtK4j27HHGqHoZrS6DeWd
         PIMS2eviEFZxyG1nB9yrglBe90SpK9LyLBKSx+NUWS3azeQumDYp3wN3x+iZGMl3KXYG
         fhS6mBWi3s2O8YVh33aJzSO2IBSWvNH4soaiLAwI4kKM7dZ0lPhEgDSYZDUDSBuVhsmR
         n0EvhpWxfBKEYsjnKTcOzC7S6YlVXcCcz1A8niz6xgtgR6VRtNWwN+kpV3jW7EbRIJmp
         VDsuNCJERTyYjxROWoDnA0GQ61FBqHoJyxjkGBYIC8I+NFLb3XISxTYWMrEwsfIM3PUh
         NRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966238; x=1789571038;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n/Z72raft7zwuNUvkj5sjKkqDryaZ+r6PhkLnJpg59s=;
        b=iyqn/x0hJMr82upB4BcStt3o+NClTpsrIOZP67tM+1glKDAY+GhM5KjyJgtasrA3tW
         KMrm4dGIP2SgTRWddG4uxzOY8Sld4Z23KC6rc0IIF2PdRTeXvfSIljLJ6R8abrHak7IY
         JVFTItPikYZLx7YCkWdb7fYoCCUFF5QooVLJau5FLvgR3W1hiadKtPV0icCZgFsxKZRD
         yyi68aNdDLDVSmOeEtoDTavwKHDFsnPPn/5l9q1sWQzzI6ww6PJTIJGsp2DxAf2UAmEF
         cuQ8hyk9wuYGnMi6oA1XqXvWbXHmby3UD0L7QVpM9RXInbMq2RJbHhksjgvIS1jDZbOM
         r8Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxyrA2cmcOR8ZW/zv5PK0t8mWFgvqGZxssCgr/qMckaYBFQKOuNiSBw+2Nn8EKq02e3QqF5+vQ/RQo=@vger.kernel.org
X-Gm-Message-State: AFuF++lG3HCx2fLixc264kjy6jbCOORcejfFN/T7+rb9TrJgynVI4hTc
	z8R6/XEPYFcZ6PgPiyHPmSrLR9jk3q8Z5HU97Rg1qQ3dEAcTSq+QRvGA9fk6SW2HoBfhdRwvGjV
	Espar+xieReXMHUt9xCrEqOfnLkTLovM=
X-Gm-Gg: AYBFou2CoDV2bDA1G9H1JT3oAbK554t9h0iQSG9wNnGHptGqX+9vRW82GPBBZgCLKAl
	j/n8pLwPZuiS5bNUmxY9i9vwGlQM+Es2myqDNMFJmakkZMaid/5eoxWd0CIPtOc6CbtypImNynt
	0tcfecj5ZHt1e5WMQrQnqkhC7sD4231TpJhMkydmwIHKLsFTf4pJFfEFzwcSTUygcDjVL/pV9qd
	iRgy4+mNs2awpx/uGM1XSPo8iN4dj07VBaaIRhIOraEIShozx5XEYKn+NYu+Hd0cuRyWEnU0elj
	Mfv/70+6W1YD0NRag/pLs40Db1EUXl+/Vpah5gaQ8VhGHEQH3FmZvJsWWkYxHAm3PVFJfGrKc7M
	w4TBtntlQBZVU5f+24mMXh1x8uMcdGwSW6VxKTg==
X-Received: by 2002:a17:90b:2e52:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-39b260dd3efmr48184331a91.1.1788966219133; Wed, 09 Sep 2026
 08:03:39 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:03:37 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:03:37 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinseob Kim <kimjinseob88@gmail.com>
Date: Wed, 9 Sep 2026 08:03:37 -0700
X-Gm-Features: AcwNN1W19s7315aGlu8LliS1GT-z2uNC5wYBGWEEN5ram-BzdPYUuwtrZLJmSEE
Message-ID: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
Subject: [PATCH v9 0/5] iio: add Open Sensor Fusion UART support
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org, joshua.crofts1@gmail.com, 
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds the Open Sensor Fusion UART receive path and IIO
devices discovered from capability reports. It exposes accelerometer,
gyroscope, magnetometer and temperature samples through the standard
direct-read and software-buffer interfaces.

Changes since v8:
- Configure UART at 115200 baud with flow control disabled before enabling
  vcc. Acquire the regulator before opening UART, retain decoded early
  capabilities, and publish IIO children only after fallible probe setup.
  Close UART and drain receive work before releasing receive-side state.
- Give the aligned one-axis and three-axis scan structures explicit
  padding members so designated initialization also initializes the bytes
  between samples and timestamps.
- Pack selected channels into the active scan layout. Tests found that
  forcing an XYZ producer layout could give X/Y/XY consumers a value at
  the timestamp offset on the target IIO base. All nonempty masks remain
  supported.
- Quiesce pushes with a driver mutex in predisable and admit them after
  postenable. The same mutex covers the enabled check, layout access and
  complete push; it does not claim IIO buffer mode.
- Keep the latest-cache rejection rules and add KUnit tests for early
  capabilities, scan bytes/timestamps and buffer teardown.
- Tidy macro/call alignment, shorten the driver commit message, and
  document the actual receive-side compatibility constraints.

Protocol specification remains an open review question. The accessible
historical protocol-v0 drafts at OSF revision
11d11eb413e6a0e861e4d45fdccadc71c5f15c48 disagree on reserved fields,
trailing extensions and magnetometer units. They do not establish a
versioned normative specification for this implementation. The driver
requires exact known payload lengths and capability scales in IIO units,
including gauss for magnetometers. Documentation now makes those
constraints explicit. This does not establish protocol maturity or
resolve the request for a canonical compatibility specification; feedback
on that requirement is still needed before merge.

Validation:
- GCC and Clang W=1 kernel/module builds with automatic stack
  initialization disabled.
- Eight OSF KUnit cases, including all 44 sensor/mask/timestamp
  combinations, retained latest-cache regressions and controlled
  push/disable/unregister interleavings; Clang KASAN and lockdep.
- Before/after padding byte and generated-code checks, an auxiliary ASan
  demux race harness, and 16 modeled probe/unwind/retry scenarios.
- Strict checkpatch on all five patches; clean apply with matching
  intermediate/final trees and per-patch DT, documentation and code
  builds. GCC and Clang final links pass.
- Fresh ARM64 Image, modules and Pi 4 DTB built from the final tree.
- Raspberry Pi 4 with those artifacts: four IIO devices, direct RAW,
  12-second simultaneous capture, all 44 scan combinations, 400 buffer
  transitions, unload/reload and verified return to the stock kernel.

Conor's Reviewed-by is retained on the unchanged binding. Randy's earlier
documentation Tested-by is not carried forward because patch 2 changed.
LLM assistance was used for the documentation, driver fixes and tests.

Based on Jonathan's IIO testing commit
edb91bc566576f6664a3efbad6bd4205aa1d5259.

v8: https://lore.kernel.org/linux-iio/20260820050608.5440-1-kimjinseob88@gmail.com/

Jinseob Kim (5):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add authenticated stream parser
  iio: osf: add UART IIO driver

 .../bindings/iio/opensensorfusion,osf.yaml    |  52 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/iio/index.rst                   |   1 +
 Documentation/iio/open-sensor-fusion.rst      |  84 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  27 +
 drivers/iio/opensensorfusion/Makefile         |   7 +
 drivers/iio/opensensorfusion/osf_core.c       | 414 +++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  73 +++
 drivers/iio/opensensorfusion/osf_core_test.c  | 577 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.c        | 336 ++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  22 +
 drivers/iio/opensensorfusion/osf_iio_test.c   | 325 ++++++++++
 drivers/iio/opensensorfusion/osf_protocol.c   | 224 +++++++
 drivers/iio/opensensorfusion/osf_protocol.h   | 101 +++
 drivers/iio/opensensorfusion/osf_serdev.c     | 162 +++++
 drivers/iio/opensensorfusion/osf_stream.c     | 231 +++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  53 ++
 20 files changed, 2701 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 create mode 100644 Documentation/iio/open-sensor-fusion.rst
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_core_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h


base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259
-- 
2.43.0
