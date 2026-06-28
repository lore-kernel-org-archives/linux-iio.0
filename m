Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454630F95F
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674058; cv=none; b=VLNXczE7KugDGUow6K5c85W4XWUfzzeibTGDK9bojIK/QFWKzVg5HEoSMjgHONJnxwoTitjDWq+yDnojqJqzBiNoqVvSTd0zML+RUcqJkdK1EU5OSDqi7pbZ0Qbjij7W6DrgCoEMgFtAIG2YQXKX/Q8vpc7PF2Fi3ZOKySoFiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674058; c=relaxed/simple;
	bh=ZzTYGVCy8fODFj0xEVGqVe1G0+adzKhYacNbiy+2CXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvZdWz50ZIjhfGzh1FniGtBMAk0RIpomwqzfnxZ7NCTfasoUpHWPkM1x/JfktNkp6zeTI8dXu2zZc8OQOHqQmytXIYLYExL24xWy7OhJZ5lUGmRY8g/ACMmWv6Z2l/4dtDRZXJTyVFjSX2vxo3v3yJVvzDunnxwQlVmfUUYPjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY1VIDwS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY1VIDwS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso630723a91.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782674056; x=1783278856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjPPl2WZyg0oAL3UMriRRxZrSS5zvLZMLEmgTiAO/eA=;
        b=HY1VIDwSjptksZ/Q+8klUFfIXQOk5AS5Z0CuTiBgZI/YJe2a3rTv0ZENA+j316SZWj
         Sk8soowC4mlVldPIy9xWWrNrTGtb7nB2ZkjuOUK2lT6CJK6uxvD3p4w7xVUMo6cTaa3S
         ZGrPreJBxBGg79oh3i5u1m0M7rDXcCD94YiV14LY/OG5RENOq8ey0Y0AdjVyWf4qfCbc
         FlhpH0sUKAPU9/NXQtTb93QhELN8VRlcjEwylUAIpRqqxYYvQAkJHtRX2uaX+YyooxOR
         MgT03nhBicGGdkYr0zC+iX5PEc9fY1ERq4WmydYUhiu4WAWqDIJdlaFXL7POSWqBvxcK
         FSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674056; x=1783278856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjPPl2WZyg0oAL3UMriRRxZrSS5zvLZMLEmgTiAO/eA=;
        b=qYyUJZb8EhMD2t6QVd90bfP64TDrjd3rkTftDLtOddt0O6MTpXZpCMx0YkYbdf4Owg
         pBo25Vi0QM7DTMCpaH9V9ydF065q7+oSQSEFWfOvcZqMEDGYLzMpfd60tocl3LXacWoh
         4erQ+2KHdvfUEMRXc6hQ5MKek7b44haO92bAGb70bPn8yi80svpO+lBVUiuO9UuvENpO
         6NDp/s89psJh+jqxRB+zflRGSdgdtdZiPqllfthZ9X81hS4Nal0lad8wg3tnbRnmo9Nw
         7lM1aTFUhHPCgspMgd29A+yluMrXYSpIVF1oESeJAee9fRp7W71WBmcq/30EUIJ+UH+W
         YjqA==
X-Forwarded-Encrypted: i=1; AHgh+RrX6KsvErtKCFZVI/1WAfM6mECbzI7IHs8ESPiwsgFG6ZgIpytiCOFg+qbR/drjcUVhQePlfQl0gOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ9BTuZEP/BS9YG56Y0Skd/GcPphzeChcax2LJyK4duj/kAvaK
	ol1p51Pep2VV0tp9sOTPXMZEnzEJYQwX7CsbTgi6Q6rrljbHfDwmelji
X-Gm-Gg: AfdE7cmSrnB+uK2CqTkeocNxwXXHkz1UDaJ0J3XIUsNkh28Q2eWIvuAFMXL2zyUYuzG
	aWdyR/gy10Djxj8l5C+2DaeXZxE8iSDReimHdd3YCDfoJDHjVQf+/O/0eIBliTp2GIvDtsw2BJS
	tCzSB9Z9b9PLcSWPhBHPPdIDhfxKPHjhb8XRPvnKo9indTXJvcpVKx4O4hVlVT+q4dlqfTZvpyv
	wKhoi1H8Sus8Pn9LSIwgFk3LKHkV39/93+TwWRbluJtsSwBkEQlEl4/4iZ+2wB2ZtsQ2MWNzafm
	WyWdA1pby9Lko+8ZwCaUwELriVZW8oU49wbuAduISbzcUdwvOPu5EnZrcn0yGy/IY7idH0gUJck
	oz1/vLE59ZAu9jS+5yesWKbvpFwKRlskhidDWvNUqJVMrSXYTU43ekC4MBt9cv0fx1OwS8T+nj5
	IPzty9d4ckQbjAEK27zkpG9zq3m74/slHuBHYz3YtVGDBR0m2xXPhlqffem4QbhkKt8QbeoR/Ay
	k28PmAYHkdkrgjjzWFdiJUiQ+knf0a4+bXq4Aw=
X-Received: by 2002:a17:903:13c6:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2c81c051932mr95767075ad.19.1782674056502;
        Sun, 28 Jun 2026 12:14:16 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm1354385ad.2.2026.06.28.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:14:16 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v6 0/5] iio: add Open Sensor Fusion IIO driver
Date: Mon, 29 Jun 2026 04:13:32 +0900
Message-ID: <20260628191337.937-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open Sensor Fusion (OSF) devices expose a UART/serdev host interface
for a sensor aggregation hub.  This RFC adds a Linux IIO driver that
parses OSF frames and creates IIO devices at runtime from capability
reports provided by the device firmware.

When the corresponding capabilities are reported, the driver exposes
accelerometer, gyroscope, magnetometer, and temperature data as IIO
devices named osf-accel, osf-gyro, osf-magn, and osf-temp.

This remains RFC while the binding, protocol subset, runtime discovery
model, and driver-facing ABI are reviewed.

Changes in v6:
- Reworked the series as a 5-patch standalone RFC.
- Folded the previous transport and IIO registration split into one
  final driver patch to avoid Kconfig and Makefile churn.
- Addressed binding feedback with generic host interface wording,
  mandatory capability reporting, runtime discovery wording, no
  Linux-specific binding language, and no fixed regulator provider in
  the example.
- Added progressive MAINTAINERS coverage as files are introduced.
- Removed patch-split wording from Kconfig and introduced Kconfig and
  Makefile entries in final form.
- Applied style cleanups including loop-local variables, unused include
  cleanup, and a probe-local device pointer.
- Used designated initializers and guard/scoped_guard where useful.
- Kept the stream parser from discarding unauthenticated frame_len on
  failed decode.
- Synchronized IIO buffer pushes with
  iio_device_try_claim_buffer_mode() and release.
- Replaced iio_push_to_buffers_with_ts_unaligned() with local zeroed
  scan storage and iio_push_to_buffers_with_ts().

Validation summary:
- git diff --check: pass.
- checkpatch --strict: pass, 0 errors, 0 warnings, 0 checks.
- dt_binding_check: pass with dtschema 2026.4.
- make KBUILD_MODPOST_WARN=1 W=1 M=drivers/iio/opensensorfusion:
  pass, no compiler warnings.
- Local stream parser corruption/resync harness: pass.
- Static IIO scan layout and padding checks: pass.
- Raspberry Pi hardware/runtime smoke testing is pending for this v6
  candidate.

Jinseob Kim (5):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add authenticated stream parser
  iio: osf: add UART IIO driver

 .../bindings/iio/opensensorfusion,osf.yaml    |  54 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/iio/index.rst                   |   1 +
 Documentation/iio/open-sensor-fusion.rst      |  72 ++++
 MAINTAINERS                                   |  14 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  16 +
 drivers/iio/opensensorfusion/Makefile         |   6 +
 drivers/iio/opensensorfusion/osf_core.c       | 291 +++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  70 ++++
 drivers/iio/opensensorfusion/osf_iio.c        | 308 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  22 ++
 drivers/iio/opensensorfusion/osf_protocol.c   | 258 +++++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h   |  97 ++++++
 drivers/iio/opensensorfusion/osf_serdev.c     | 114 +++++++
 drivers/iio/opensensorfusion/osf_stream.c     | 189 +++++++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  31 ++
 18 files changed, 1547 insertions(+)


base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.43.0

