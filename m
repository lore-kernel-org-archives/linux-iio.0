Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940452188C
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755926; cv=none; b=F3AqF5uuMgbYP9lPCNTVJFP70QzCHR4XWtoIUx8VhsAI3o5QC7BedLxg0Oif9s8ndb58L5bWs2I4LzBK3wPm6mvWifvTBZs4/g21AJSUtoDAzJ0cnGaTjVFAldbD/lctSy4dtGU0i3OJtH59QLrbzkAlXK4sBo18vW3uZhlsRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755926; c=relaxed/simple;
	bh=ul0rys5upXfFQ1pgUywuQQ+5Z1mTk6pcDtvaCiiHLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jqhj0GE921kF2tbwdFGsSGWf7k7da2CfaOdnv+r6VyWsBVKM4O+1werpoadDpogt+e1hmABtbtREFzXzplqAXM4qBDZbBeZcj1Tnwt28gV3IlQME+/bEOyVT5lXskOghwIXtfYXVYD7Sh1QGJxzbRJctyzL/ff3g4fcf9+0jPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrU+zwrI; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrU+zwrI"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eefae4so3183275ad.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755924; x=1790360724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MQhldycE9aUQavgxyDeXbivCGtgn7Aq1X27dPA9Ny0=;
        b=GrU+zwrIavlODt1WdeILKPKGc3gcT8FnJGE/0O2nnfC504xIPCEM4kw9Zy5ozoGZ/a
         DFU3rOm5I++Y6CaDhaTutF72MaAmljlx9ASb12axy8/oaTTI+u9/WHvEMptjiDVKfeyg
         XKh+90+PTygWV2SucUezI7wd0+0jnXYfktaIR7cqEn/UTBOfNa8PPSChRK82f6fHHorR
         B9UbANBpA7zs+euT5je5ALvqLP+BuNa6t8E4CtYUqBDj8/6LOX+sxqCpOKf0BJFVGKC6
         d/fvnPkHOJUlHXXN8vk4V7MWlUJju4G/BPb2EhyuDtYr0UfJajNP8DAAK0uTKW3SidHr
         Nd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755924; x=1790360724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MQhldycE9aUQavgxyDeXbivCGtgn7Aq1X27dPA9Ny0=;
        b=Dr+9+XGaPqeElv6gYA30RlF4UzA8fOesuqmPqAknv1FFDXTdBtSgpH98sSXdi6NXQm
         IGs61DenI1m004jAp6Axmhbodv23anwfPHJtxghbaP5msxD30o3NiXwUO0G6RwUZlrLw
         gCxUZ+nvbqGeLXk2DNJJtyKPmYZxnyt7lX3AsMwg/pL90xfEF7/j3xMpZxzpr9E/zA1Y
         TH8Wk6TOOZ2vASNiRx1kOmLA/IdQpcu0vMli2/H95gmctHHEhJ6x/pfPDR3WdwMyWkBU
         Dbq24svPyRUZWApSHzppJePAT72i0ozOOB8a8yA/s09MZtjkugYRpAe8LfXKbMOzxHrH
         Yy5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzI61XoTROI3ywxvt0RfOWo1ep3MEpLNATmKMurNwoEpE0tMmkyLMvuFf+Q1RKDfUa+yKAMlv8EFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lKgBQQnZCeuG2lD3fTECZATtlJ9PkVK3Lqtrxx+teOqWpdVdIm
	5lHAogo0odjC0IBFMzoPTskNPAXG6vH6SCsU7o08kV4C6g3ESM27XhPv
X-Gm-Gg: AYBFou3PqrUgVU/lMhJ4BgUbc0dkMCXNSQAv1uWcWuK5oMAcYFl8RKRUg9KSW8pfTu2
	sbQArZu36XcXwRxtRr8Z+i4pJgTtoZiMjSM0VImpLf3SjTYQ5+bnnw+3i11763nFqZQqqdUDW+n
	rLW6r6ubVFxDOcfus4UT6aDQX4zu5Wn3NHnkjhK8LPqzr0g45gKkIo+6PrYA1xzt8hN0cmm5NGs
	Lj3PD10m5XRYwyQs+cj/ieBie7hbskmPzu/nsVV36kgf0AC3wqhTr8pGHYynAKUeaD2FCu73SBv
	ENpUKJJ4yP1UQVObJcBq9P/Rc8WUd4P34mFGejT1a8UpuVkblP/FwLXSu1OaRJUJJDYKSQa3TmH
	j+eysyboNkuRYhaowrKEr3UMhjStDM1jGY7Q/I7I+NL6b9qlYMrbLbMgYrN/nTEAgb6N3nAq3DF
	oVzMSorIx1VkKRYRTTG8yvgjnfBgarEy9MDPnHdKlquP+YeQUs15CHVB0wb/9lfT5uPWPL7WrBw
	rMd3TLRea2mtO/KghsMHns6lein2z8vPrxegm5t3AY0D5Zal6gPlvQ653J3SJadhX1GUucFcIlS
	eCscpOWG
X-Received: by 2002:a17:902:e886:b0:2ce:b3cd:7539 with SMTP id d9443c01a7336-2ddb212b570mr42351775ad.6.1789755923336;
        Fri, 18 Sep 2026 11:25:23 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:25:22 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 0/8] iio: add Open Sensor Fusion UART support
Date: Sat, 19 Sep 2026 03:24:38 +0900
Message-ID: <cover.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specification status: OSF-D2H 0.0 spec-1 has completed project technical
stability review, has been adopted by the project owner, and is published
as a fixed specification.

Canonical specification:
https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md

Errata process:
https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/errata/README.md

Current adoption/publication record:
https://github.com/opensensorfusion/opensensorfusion-protocol/blob/0cabccf63ac01d0eb82dd9882739ff58eed4a76c/reviews/publication-record-20260918.md

The specification was frozen before adoption/publication, so its embedded
status snapshot is intentionally historical. The dated publication record
above establishes the current adopted/public state. This is project review
and adoption, not an external maintainer approval.

This series adds the Open Sensor Fusion UART receive path and IIO devices
discovered from capability reports. It exposes accelerometer, gyroscope,
magnetometer and temperature data through RAW/SCALE and buffered scans.
Device Tree describes the sensor hub; its individual streams are discovered
at runtime.

The receiver validates supported descriptors and sample scales, keeps
discovery open after empty or unsupported initial inventories, and checks
repeated inventories before allowing new data to use registered metadata.
A supported descriptor changing meaning faults the session until an
explicit teardown and rebind. Existing v9 cache, scan-layout and buffer
lifetime fixes are retained.

Based on Jonathan Cameron's IIO testing branch:
69fa76f0af3414cc189c3b0b807cb59e327ecc00

Changes since v9:
- Publish and reference the reviewed/adopted OSF-D2H 0.0 specification,
  errata process and dated publication evidence.
- Tolerate reserved padding, validate descriptor/sample scales, keep
  discovery open after empty/unsupported reports, and compare repeated
  capability reports.
- Fail closed on changed descriptor meaning instead of publishing data
  with stale metadata.
- Add focused KUnit coverage for these lifecycle and validation cases.
- Use managed UART/IIO/power teardown and dev_warn_probe() for the
  controller baud-rate warning, addressing Andy's probe-path feedback.
- Split the former combined UART/core/IIO driver patch into transport/core,
  IIO registration, core KUnit, and IIO KUnit patches following review.
- Use validated/unvalidated terminology for framing/CRC results throughout
  the stream/core/transport code, tests and diagnostics. CRC detects
  accidental corruption; it does not provide cryptographic authentication.

Prior validation on the identical source tree:
identical source tree evidence reused; no builds rerun for DCO packaging.
- All eight intermediate apply/config/relevant builds.
- Independent transport/core and IIO module link/MODPOST.
- GCC/Clang W=1 vmlinux and modules.
- GCC and Clang KUnit: core 16 + IIO 2, all 18 pass in each run.
- Core-only intermediate KUnit: all 16 pass.
- ARM64 Image, selected OSF module and Pi4 DTB.
- Targeted DT binding/style and IIO documentation.

The terminology-only diff was verified mechanically. Wire semantics and
data-path behavior are unchanged; the receive diagnostic key is validated=.
Hardware testing was not repeated for this terminology revision or this
post-DCO packaging audit; previous hardware evidence remains historical.

Human DCO is complete. No email has been sent.

Jinseob Kim (8):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add validated stream parser
  iio: osf: add UART transport and core receive path
  iio: osf: add IIO devices from capability reports
  iio: osf: add core KUnit tests
  iio: osf: add IIO KUnit tests

 .../bindings/iio/opensensorfusion,osf.yaml    |   52 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 Documentation/iio/index.rst                   |    1 +
 Documentation/iio/open-sensor-fusion.rst      |   77 ++
 MAINTAINERS                                   |    8 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/opensensorfusion/Kconfig          |   27 +
 drivers/iio/opensensorfusion/Makefile         |    7 +
 drivers/iio/opensensorfusion/osf_core.c       |  465 ++++++++
 drivers/iio/opensensorfusion/osf_core.h       |   75 ++
 drivers/iio/opensensorfusion/osf_core_test.c  | 1046 +++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.c        |  338 ++++++
 drivers/iio/opensensorfusion/osf_iio.h        |   22 +
 drivers/iio/opensensorfusion/osf_iio_test.c   |  325 +++++
 drivers/iio/opensensorfusion/osf_protocol.c   |  215 ++++
 drivers/iio/opensensorfusion/osf_protocol.h   |  101 ++
 drivers/iio/opensensorfusion/osf_serdev.c     |  148 +++
 drivers/iio/opensensorfusion/osf_stream.c     |  231 ++++
 drivers/iio/opensensorfusion/osf_stream.h     |   53 +
 20 files changed, 3195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
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


base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00
-- 
2.43.0

