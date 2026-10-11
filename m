Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8483612FE
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760466; cv=none; b=m4/fJEaNk7alHfK7Pa2erlL2RqaZSIMVfRRafJaNUb5+KCuKsCOvuqoRitLqyjMtfi46bztHvlfZ76UXBcKIvxVn+2i6K2b9urn5B1AkTJis0LGMbt4v+67cIk4OpoG8N9pNIwqnuVoQAJnskIvESOG3gkqZ8pFs9n06K1Wo7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760466; c=relaxed/simple;
	bh=fFleWHNo/y1J4A2S1T5/VI79f4PAXSoaji4SutSut/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2uxJYDT0N5DScYJLC6SjGMp6LRBd+qEnaSgtuwvfcFO5XPfZcNQyZFH6ON8qeE+6n1MtcSuIJs+PTZAhnTgialO9mMvL2x08DLVOX0mnm948ZeP3qdrp4XyWVpjcz6CphxWRMLS2KHC9C1pmiozc/Kcz5QNTqIzjnNyU8o622A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjz4N6J0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjz4N6J0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8874539bccbso525932b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791760464; x=1792365264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kv44X2ypV4dj/vQWfiHinCIJAZ0imVPklyHLOa+kIIY=;
        b=Cjz4N6J0w3qwtPLIW1pDRxCJZEpY2T6c33/hqyTWr/tepaz4n8D94qW6F5GB8nBIGM
         sJuH2vGag3AbRmIA3XKGVIJjil/qcj1HPHJdDxtR9jLwvv6AxLfxh7xp524gl4Omnjq8
         FjdnYWd8L0aH/6QnkUidOyrbxYGxYsxEh8VpLlzGAaVddja7NApBaW1SoycawiS5GI1w
         irDiQqBm1uu5Wol3hYZGsijJ/qtCqps/GNKhAMyT7089Qo0zpKm2sNcjPM0wj7/L9z8j
         oBb+BOUG7vxk62AwuMqbh03teKvsJVvJVYwHo2KunSp1Mu8Zlyaqe8WGd5VpD7UjOSgn
         hakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760464; x=1792365264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kv44X2ypV4dj/vQWfiHinCIJAZ0imVPklyHLOa+kIIY=;
        b=HNt2qZ/IH2fCy5tkdfKc24kNnKOBTH6+JSTdAjPtVmMCB5YmJFSoD4Fm0XjPd8oxjd
         8H+O+OxrbPlCAy91+jFb5d+jxkIHQmHv1szVKULuJLoaOaMeU+PIUd9lM9DmgDozZi/h
         pdMTRNpg5V5f0Qk7G8xJ1I+5i9D9ViClKskqi6HB1qyg0zu54wbQSkJ2EIRaHLDMqSiH
         PlyUhXvz9HvSdrfi0qbx3rZIBO83BH3SsMjlzBdBuaFC3FcIXTxC1McoiBfOpScPUQvq
         uwP1V+fPHSAM72tRkiE0bru66e+mMGa2HLqVr6xbOZ3GX2Ce1GIctYeg93M9TjHEVHsv
         92PQ==
X-Forwarded-Encrypted: i=1; AKwUvBy34zt/wgV9sqLum2I90h9j1XlLqFZOLRTbfxwvZG9Gv7NlQwneQNI4va405TTpkHFSqsmF+Zg4OXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAoN1K2AIKRZ2g1MRLwb4GZj+fOx1ONd2TcW8XjM5IM9pNhWMB
	uRaiP8b2FVlgYKpyDqCimUvfHX2fmRsbqRhz9gtz0PTHa4690OOPJzFS
X-Gm-Gg: AYBFou3ObUaN0ivu4XhOkylmBvE1Lw6CItHSpr/oxd7tkZWZvHwARW7RszNfrU7UU/p
	DG71BX6DgNw9JduewAXpVLZ7KrDYGj+5OUAQ2ts+8PMMxDyT7RB3qEYU3OPKbcdHzVEUdIhucVu
	Tj4Siq4ex8gFX2hlOZ6g0luuyEaesrPVSM9jBDZiVZ/6RmsgRUTiN1FKRMlk66E/7+11RendRRK
	N2kbMHxOGgMKmiYAwHT5uMm/wIM7j60gtsfv3bjI8iSNCyVLiXekIGC592Q4swEQRbJ6L0pc6lP
	FbijWu3RfiOp9OQtPckPYig+PMrkonGpjrgEo+bwMqMc6LBr0c062+yPLvt6OaJLdi2J7qO+iTB
	NNxfZ/CzMOteIcWWOQpkcy8Y5ED3VxCw0QihKcZMmgqVBoV9K0uX/dFRS5gYd77a74hmgOxta7a
	dS3EPGcc8vTraQZ811lrqoEonLAZuY0EQ+IGGBZyMMBUqQyfRZmBKsEma/0GtofojQoHSBqgHT5
	LyTvDSJeIdBCN7l6thQFI6Pkn1+opmZBVa20XZpW84uPcyvD9CXiDC4VTOMxIZ+uV+Nm0koQC7D
	4CTsofg=
X-Received: by 2002:a05:6a21:3985:b0:3e0:c334:52a0 with SMTP id adf61e73a8af0-3e1a68ea93emr883941637.49.1791760463637;
        Sun, 11 Oct 2026 16:14:23 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c48945dcsm3188917b3a.54.2026.10.11.16.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:14:22 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: kimjinseob88@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v11 0/8] iio: add Open Sensor Fusion UART support
Date: Mon, 12 Oct 2026 08:13:32 +0900
Message-ID: <20261011231340.42885-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a UART/serdev receiver for the project's fixed OSF
Device-to-Host 0.0 protocol. Complete capability snapshots create IIO
accelerometer, gyroscope, magnetometer and temperature devices with RAW,
descriptor-derived SCALE and initialized buffered scans.

The receiver validates the fixed OSF0 envelope, CRC and exact known
message lengths. Equivalent capability reports are idempotent; changes
to a bound supported inventory fault the session until explicit rebind.
IIO samples use host timestamps.

Changes since v10:
- Move OSF under drivers/iio/sensorhubs/osf/ following review.
- Use the OSF GREEN compatible with the generic OSF fallback.
- Clarify complete capability-report snapshot semantics.
- Use designated decoded-frame initialization and drop decoded reserved
  fields while retaining reserved wire-byte tolerance.
- Reuse stream reset and simplify core/serdev locking and lifecycle.
- Use IIO buffer-mode claims instead of a private buffer lock.
- Simplify scan storage and channel declarations.
- Fix KUnit worker/device/mutex/resource/completion lifetimes.
  Generic IIO self-test extraction remains deferred.
- Synchronize KUnit fault observation and configuration completion with
  completions and thread joins instead of short polling/deadline windows.

The IIO buffer teardown serialization issue found during the v10 review
was fixed separately and is now in mainline as commit 84bb0fc46ccf
("iio: buffer: serialize buffer teardown with mode claims").

This series is based on the IIO testing snapshot fetched for this submission:
a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
Runtime validation used this testing base plus the eight OSF patches
and the exact mainline IIO core fix 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd.
The core fix is not included in this series and must be present when
running the series on this testing base.

Fresh validation of this source:
- GCC and Clang W=1 kernel builds; module builds.
- osf-core (16 tests) and osf-iio (2 tests), with KASAN, lockdep,
  DEBUG_MUTEXES, DEBUG_LOCK_ALLOC, DEBUG_OBJECTS and DEBUG_OBJECTS_FREE.
- 200 production module load/unload cycles and 200 test-enriched module
  load/unload cycles using identical driver/test C sources, exercising
  20,000 IIO buffer toggles, scan subsets, timestamps and unregister.
- DT binding/style/example/schema checks and IIO Sphinx build.
- Clean sequential application and relevant builds of all eight patches.
Physical board tests were not repeated for this revision.

Canonical specification (fixed revision):
https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md

The fixed public specification is maintained and adopted by the OSF
project. This does not imply Linux maintainer approval of the
specification or driver.

Jinseob Kim (8):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add validated stream parser
  iio: osf: add UART transport and core receive path
  iio: osf: add IIO devices from capability reports
  iio: osf: add core KUnit tests
  iio: osf: add IIO KUnit tests

 .../bindings/iio/opensensorfusion,osf.yaml    |   55 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 Documentation/iio/index.rst                   |    1 +
 Documentation/iio/open-sensor-fusion.rst      |   81 ++
 MAINTAINERS                                   |    8 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/sensorhubs/Kconfig                |    7 +
 drivers/iio/sensorhubs/Makefile               |    3 +
 drivers/iio/sensorhubs/osf/Kconfig            |   27 +
 drivers/iio/sensorhubs/osf/Makefile           |    7 +
 drivers/iio/sensorhubs/osf/osf_core.c         |  460 +++++++
 drivers/iio/sensorhubs/osf/osf_core.h         |   75 ++
 drivers/iio/sensorhubs/osf/osf_core_test.c    | 1056 +++++++++++++++++
 drivers/iio/sensorhubs/osf/osf_iio.c          |  288 +++++
 drivers/iio/sensorhubs/osf/osf_iio.h          |   22 +
 drivers/iio/sensorhubs/osf/osf_iio_test.c     |  386 ++++++
 drivers/iio/sensorhubs/osf/osf_protocol.c     |  215 ++++
 drivers/iio/sensorhubs/osf/osf_protocol.h     |   99 ++
 drivers/iio/sensorhubs/osf/osf_serdev.c       |  151 +++
 drivers/iio/sensorhubs/osf/osf_stream.c       |  230 ++++
 drivers/iio/sensorhubs/osf/osf_stream.h       |   53 +
 22 files changed, 3228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 create mode 100644 Documentation/iio/open-sensor-fusion.rst
 create mode 100644 drivers/iio/sensorhubs/Kconfig
 create mode 100644 drivers/iio/sensorhubs/Makefile
 create mode 100644 drivers/iio/sensorhubs/osf/Kconfig
 create mode 100644 drivers/iio/sensorhubs/osf/Makefile
 create mode 100644 drivers/iio/sensorhubs/osf/osf_core.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_core.h
 create mode 100644 drivers/iio/sensorhubs/osf/osf_core_test.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio.h
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_protocol.h
 create mode 100644 drivers/iio/sensorhubs/osf/osf_serdev.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.h


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
