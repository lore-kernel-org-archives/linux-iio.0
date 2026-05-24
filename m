Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB510F2
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612820; cv=none; b=bt9Rovjxh8NulR3Hrd3nprujVj9KTEW/DYSeXNq7GxQZzVz10fncWJnZtrQ1HK+mrpSiGHsXNXtKn7QfCjoPK+qUTD/Wsh+WfsqfNBA4jtHx/g4G5cPpEGViDwDQ5Qb4Ci4ut4PlUxObeJpdupDCSt3NKB+jRzKo7JUjTjp5rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612820; c=relaxed/simple;
	bh=c6CmS2PsElbd14byoasEvR7Kwc0TKu6y36ZmXrs+kBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzV/bgvGu8jHyDmdbGGBO9LNsITUcdzdYSYYXYF3wJx/9JE4Ja0qOFrKgUQyyCW4Hd2SR+9PXIIbQmj5HJ/tAZ/j/dMeD0hynvyhLmkC9gxlAX792bsC7u9aMMObXWkhDoNl5YH4xI3aNQcAnLZ3r4WD7f3+kv13R/M9iz31HFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqcZ4VzN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqcZ4VzN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82faf871346so6772048b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612817; x=1780217617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLgoBL/zLcvxr6bj3saZaEcREqHREuQoofVTcPdITuo=;
        b=pqcZ4VzNEgajWghYCVMf2nQ7fzuQIPZW7zkgIimyU5gfpsKWm3okoeLzCgmu1iBDr0
         HKKGcMOucpzgxLUnNz2sV/p6FLI0XCBmN7sImcjLKIqIfEPBfSs//bI6BHgKjLVaCqBb
         YJfb00+94BIozZOu5COL0bMLJgwOoVhlBMzyJgdzVW1hCJkbxrtA4aOxRaL9BWmLVvB3
         g0pOkpkKJ0avRB+4eKWrwgKIkOHY437YZiGPi4Bky4xzkWGtCfcVoLBPD4z8f/9YDY5I
         Bo2UqOh5mB4w/aWyp3VeAU6gOSsGt42IduQ0WaD4EiP3CUb9f1CPnel3AOYQDx3LveOl
         ja0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612817; x=1780217617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLgoBL/zLcvxr6bj3saZaEcREqHREuQoofVTcPdITuo=;
        b=rGI9dv4XssPHW+JtDXBD/3AKyLJR367nMIMMuSMjh/PWwvsvfxVoMNnmzCl6Q2ku4f
         OSTnwpMvMf0kiQKm3m2KicKG0KSDQkWaY6+XfcL9tBGgKwGoIVpadya0d9z1ywbLlROW
         XElmvBNRLv61BXxu7SbTgfxtlsrmYMysYXwRcywkvaJWuuLpavdfNBL/kA0wPRGwNsxI
         QHVN80y1/7SIk0tF0uqp4KunmL+7lmdF2IvNC7YcJXNKdDktZ7N+QLIccSlxAkpT8PcW
         /IIOcK6Zk4RtEsbpK/jYxpcPK2I/dpmdQ0ZvTLvclWMwtuEYumynhZ4UE7FFwLzE15Mv
         VjBw==
X-Forwarded-Encrypted: i=1; AFNElJ/d6Act1idUkp/TGPH53gVyHGk8bRm34CZJs4zQVeD7mcgOBmD1OcIH/6iH8efg5YzXkcT02GaHEYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeauwVBpCZmZm0g/PO0nbWZ7vQqaFVCFj5jZ+OxKaFskZ096iB
	LMlsuS5yuY4TWs8M+fjKjTlQOJuPXAIlfEjIA6FTVqGUZKNTQQ1iHqVoj3UaiQE4MJY=
X-Gm-Gg: Acq92OGYJZxiZboIdv3aAYMll5JLobMsAwqxTQ82iPZxr7SEjHDqPDBfAeBQiznZJ9I
	X4PXkv5hd3UBiN8k3zyObYwJWCjm3YtMZZsiKOjGZeHHxD/j8pdzoPGoHGW8yyHLJByRvuObg+C
	7hEEkSwTEInt6YTrz08RFac7xyDJjwMCsJtsfaeP9kQmEwWUGnu9mHYcoT2OGKQi5v6THpG1+gb
	pOxgzxlCy5dD3x1A90YVE7Si6vrsYWbVtSe6XdkRuzo83tWgPX1/f7Q//RtVxhuu05YVom+xfwG
	GzVj2TdYi78GF+neMUEksNGBevRU1QbgEP1ijdIy2VZZ8xvv/UbG0OFhNuGU6iCsSy0XNApl9km
	DQnqD3aHmGJVxCEKfIcsf+ZUN5oEQ8b0cZhJoYQdU4ZSTDbR9V+lfM48Avv+WDoJmvAd+Cb5j2q
	kOzqL8xcJmfY/z7D4xD9Gz7YpxrqUUeM5gV60yTnDnqz2LAmserMY44ZjV1PhIlpForEtiAEXaS
	GqIWDZg9s4EKRXStnr7N7dZgocVyLO+PdeShg==
X-Received: by 2002:a05:6a00:3003:b0:82c:d986:e917 with SMTP id d2e1a72fcca58-8415f56374bmr9672521b3a.22.1779612817004;
        Sun, 24 May 2026 01:53:37 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:53:36 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: [PATCH RFC v2 0/7] iio: add Open Sensor Fusion UART driver
Date: Sun, 24 May 2026 17:53:05 +0900
Message-ID: <20260524085312.15369-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an IIO driver for a UART-attached sensor aggregation
device. The device sends OSF0 binary frames over serdev UART. The driver
uses capability reports to register IIO devices for supported sensors.

v2 preparation changes:

- split the previous RFC driver patch into smaller patches
- add a Device Tree binding
- add an OSF0 protocol reference
- use get_unaligned_le16/32/64() for wire fields
- use IIO timestamp handling for buffered samples
- push decoded samples directly to registered IIO devices

Tested path:

- STM32F405 OSF0 UART stream
- Raspberry Pi 4 serdev
- kernel 6.12.75+rpt-rpi-v8
- IIO devices: osf-accel, osf-gyro, osf-magn, osf-temp
- raw reads from accel, gyro, magn, and temp
- buffer reads from accel, gyro, magn, and temp

No OSF oops, panic, or call trace was observed in the Raspberry Pi
runtime smoke.

Jinseob Kim (7):
  dt-bindings: iio: add Open Sensor Fusion UART device
  Documentation: iio: add Open Sensor Fusion protocol v0 reference
  iio: osf: add protocol v0 decoding
  iio: osf: add stream parser
  iio: osf: add UART serdev transport
  iio: osf: register IIO devices from capabilities
  MAINTAINERS: add Open Sensor Fusion IIO driver

 .../iio/imu/opensensorfusion,osf-uart.yaml    |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../iio/open-sensor-fusion-protocol-v0.rst    | 267 +++++++++++++++
 MAINTAINERS                                   |   9 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  15 +
 drivers/iio/opensensorfusion/Makefile         |   6 +
 drivers/iio/opensensorfusion/osf_core.c       | 311 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  67 ++++
 drivers/iio/opensensorfusion/osf_iio.c        | 288 ++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  22 ++
 drivers/iio/opensensorfusion/osf_protocol.c   | 220 +++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h   | 100 ++++++
 drivers/iio/opensensorfusion/osf_serdev.c     | 111 +++++++
 drivers/iio/opensensorfusion/osf_stream.c     | 207 ++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  31 ++
 17 files changed, 1691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
 create mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

-- 
2.43.0

