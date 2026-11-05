Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894039;
	b=BD6dvSDACpuYDfO1OVIHL7Jeaip1DOVzSoZk5lcm4KEd0lqd4838oKU7IvCWLl94ao1+
	 69nyBicseZGjMSYxev+K8PQOE5r2rnb+qscdbefDdJk4Qi6F/vdiLSakuMbkWDRyY489E
	 1QMyvMPEx3CqK8tMLyLHoSXKDvqWXw9MT4JpBL1COgC3GQRpklgauw5DXTpwmSOzD3Ukh
	 uSkcFnppMJ8Oib0QPtLSFad86jqk080GyrNI9DhfGLNDdUMd7rJQcouImSsCKe0l0QLBo
	 IRbM3oaCSUyLlwmOVbXNpPwwO12IIeUiXKuwTLzgsZWd5RG57Gkmw2+RnX76rRFI77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dbmOJwNiA9U5ZN5yfEB01wzVScVRVlQu8hg29XoBtHc=;
	b=XcxKk1c+Gh5nz0cpGXGnajE8BLV4t2hnfcqYEe1MArwZ3cnqZGjVuRFfmmrY0igYJ5y2
	 d7ZX2nntMozBxOr0mnLR+fum+NmmI6Mxy7Gcx6wFoqzkqnYHq505ook4zD+VpwGEDS4/U
	 chzFtto34TB2stNvIrsC73huT75WRYQjFg6yDLwyQYfQb2jZ8QUKK5WT/tk8t/06vXTsR
	 5NnJQkInGRq9Wclh+JlIdJ/e3EP1stv2edwzrdT3PJQT+j1SPQwIDYaW7/Hir/QhZSIns
	 KuDTPSfsciz2ivbuzw7WdlS1XHs452W5YGlfnSvK7GkVMchhytDsuT+hLWSVwCWDdrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3qaJxCB;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C03606A60B
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 15:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C03606A60B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3qaJxCB
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1370306a91.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894038; x=1794498838; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dbmOJwNiA9U5ZN5yfEB01wzVScVRVlQu8hg29XoBtHc=;
        b=S3qaJxCBghpm3j1A57D8YpLSxqVSsD3JGGGJz+hQ57er/RdEFj+gaQJ52OfaeWEA+y
         qc07bAhrgwTVTZddzIj0eHLJVchNtzuEOiuEMsSJX1SDw94OUJ2nKCcPSLClMxLifSvE
         5577Uc6pjDGiEh/Nc/PjATY7RPlXNTeOr4lHk0/EOF/qnBZ210kBa8sQWno+GzY/ETtF
         ViSZSiY+swk1puOo9d4JMt05B4gcdDSPw6a0/QmoRed9V+rVKS/voR2oVjSzFJsUJXb1
         5UD6mSZNPQh9rUOjK3PFc8sXxCxRqknDHDRtuJ4MoikRPvC4ndcqUxLmtqI8T4/QbcoA
         YObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894038; x=1794498838;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dbmOJwNiA9U5ZN5yfEB01wzVScVRVlQu8hg29XoBtHc=;
        b=TuoywjTKnNSe80o0LZn8dpegsWlpgrxbV6nn5/jOG0LXyI/rlISgLQKyU5iHtEBSFn
         nicx8pg7Kqb/0NC2HsdDDlhb1pWeT99v1xf+IUetUMhmx8mQ6CjcZzz1R0UnJFJ5fHiH
         P9XdUb1NrX4Acadd1RNt5TGgLXFq0FVqXwg9vVx5K7jPhRxBjShY2SZYGuhHB9xOowR7
         15UoLHZ5I72a6Tb0+I+VtYbEiIUnu740HDqzYnxUM+awo7RbkyhabOm5wMwju1SYOsFp
         RZbO5KixuoUX/2fo/pIXX5EtpiGgFPsYMSl2pjvxihm6mCQdzeYv4duLGLf4gBas/VlE
         t28A==
X-Gm-Message-State: APuU4Z+KVi6oPkqTmtmSybjXJjZhovoHI9k41yNVYmckgSUECUDE5/Jc
	UpO8nL+m2f/PJ/6/o0+bXynasloDxfZIwp5YGZrXtM0gU1ZUCnCyidIk
X-Gm-Gg: AYBFou0pwrXgJJrMsYkX3ZN7ibozPGjSiXo6ixlH6kcvRZmwOe/KJ6hx/soFXEhipD9
	Auwts/eEzqo+I9QQiGQAQWDrxte0+COi0BKiP3PHOTDGFzpYdscBemxAfEE+uFDsRafpOA2HTL5
	mwjwFu21DW2kJtMUe1KJnvWAmKhGNDJMupYT2oxkVJkIoBL8S3mVEj3+iqVPyaCfEC95cyNqaCq
	TaCjcB8XVE7xAzYsZ6gQO5d4N2JkFe/mKheT1sqyLBX8P3i9mMO9wHHoJlu75mFlsp6nHIW7OI7
	8p+gz1lJaMq/PefAww6fjuzuvMplr1y875yn3m6+3m/8ZJwrp5y+3Pjc9zXq0oozwjmOO7YK92y
	cBuaoO6Q7X85EPqK6aXFQ8KhnC0icRofSG6aBW+FOhZFjD+xkfGxben4TtPczZSJZN1aBn53JoR
	JNQ2j5xX2c5rfNE98cbAR/neokf5oRYUUL9ys6Wg3w4pPSRgYs1GExo7JFIQjxw9FzV8WgbofDH
	lZis0Nzb/WMEGqfmhXbMqhdRZLSghojn8RjRUEbCTYJB6ZZFSn3Eshd02X+prZPbxoW2IAolnsq
	WKJRe4WTPfiCp0xo1f9e+JI+pLLwmPK0
X-Received: by 2002:a17:90b:2e4e:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3ae895a5673mr16536437a91.9.1793894038354;
        Thu, 05 Nov 2026 07:53:58 -0800 (PST)
Received: from [127.0.1.1] ([2405:201:201e:816f:e3c3:bcdb:ef3c:2956])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b2cf80c9sm4518780a91.0.2026.11.05.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:53:57 -0800 (PST)
From: Viral Patel <viral8854@gmail.com>
Subject: [PATCH 0/2] iio: magnetometer: add Infineon TLE493D-W2B6 support
Date: Thu, 05 Nov 2026 21:23:46 +0530
Message-Id: <20261105-tle493d-v1-0-3246e91e6394@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIum7GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3ZKcVBNL4xRdQ5NkY4s0o6QUI3NjJaDqgqLUtMwKsEnRsbW1AFL
 N4cZZAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793894033; l=5107;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=E5ABrNVOOLIPXc1azjaTAT+AtKnHce0xIEtXnuYn4Dk=;
 b=v3SnX26XMaaHHllG3roFdxbI5vmzdNDOgpk/dcq9v2qkisFxyrt5NOTOE3VPDJ3p2vNm2cqgs
 GRInWGmFFCmA2Sl1F+YOkLK/5peAKIrNSt6dHowzNWC/ydFxW7eqqx1
X-Developer-Key: i=viral8854@gmail.com; a=ed25519;
 pk=UC+UDB53t70pTK4wncXf3tfh0hsYMCqpxYnTaKX3MYA=

This series adds support for the Infineon TLE493D-W2B6, a 3D
Hall-effect sensor with an I2C interface, 12-bit X/Y/Z data and an
integrated temperature sensor. It was tested with the TLE493D-W2B6
Shield2Go board (variant A0, I2C address 0x35) on a Raspberry Pi 5.

Why a new driver
================
The TLE493D-W2B6 is a second-generation sibling of the TLV493D-A1B6
(drivers/iio/magnetometer/tlv493d.c). Only the X/Y/Z bit packing is
shared; everything else differs, so this adds a new driver rather than
extending tlv493d.c, as agreed with Andy in the RFC [1]:

 - Writes: the byte after the I2C address is a register address that
   also carries ADC trigger bits; tlv493d writes a raw stream starting
   at write register 0.
 - Reads after reset: the sensor starts in a 2-byte read protocol that
   Linux cannot drive, so the first access must be a write that sets
   the PR bit to switch to plain reads starting at 0x00.
 - Register map: a single unified map, 0x00-0x16.
 - Mandatory odd parity bits (FP, CP). A wrong FP makes the sensor
   release the bus until it is reset, so FP is recomputed on every
   mode register write.
 - Data validity: a Diag register (PD0/PD3, frame counter, bus parity)
   instead of the channel bits tlv493d polls in register 3.
 - Temperature: 10-bit, with a different encoding and scale/offset.
 - Different power modes and update rates, and a selectable short
   range (X2); the A1B6 has a single range.
 - A dedicated I2C reset sequence.

The other Hall-effect drivers in drivers/iio/magnetometer (tmag5273,
als31300, si7210) were also checked; none share the register map, the
write format or the parity scheme.

Scope
=====
v1 supports master-controlled single-shot measurements of X/Y/Z and
temperature at full range, via sysfs and a triggered buffer with a
soft timestamp.

The temperature has 10 bits of resolution. It is reported as the
12-bit aligned register value, so in_temp_raw moves in steps of 4 and
the scale and offset follow the datasheet's 12-bit LSB.

Not supported yet (possible follow-ups): wake-up thresholds, the
built-in self-tests, low-power and fast modes, sampling-frequency
control, and the short range.

Testing
=======
The series is based on iio.git togreg and build-tested there. Hardware
testing was done on a Raspberry Pi 5 running the downstream
rpi-6.18.y kernel (6.18.59), with both patches applied unchanged apart
from a Makefile context fix-up.

 - Probe: the module autoloads from the DT compatible and the Version
   and ID registers match the A0 variant. With the sensor disconnected,
   probe fails cleanly with -EREMOTEIO.
 - Raw reads via sysfs: with no magnet nearby, X/Y/Z read within
   +/-3 LSB of zero; temperature reads 31.7-32.7 degC at room
   temperature, matching a userspace bring-up tool.
 - Triggered buffer with an hrtimer trigger at 10, 100 and 500 Hz: no
   missed samples (200/200 at 100 and 500 Hz), mean period 10.000 ms
   and 2.000 ms with at most 3 us jitter. sysfs reads while streaming
   work.
 - 10 rmmod/modprobe cycles and unbind/bind: no errors.
 - W=1, sparse, checkpatch --strict and dt_binding_check are clean
   apart from the Datasheet: tag line-length/link warnings.

Known limitation
================
After a sensor power-on reset while the driver is bound, reads return
-ETIMEDOUT until the driver is rebound. The reset clears PR, so the
sensor is back in its 2-byte read protocol, plain reads return 0xff,
the frame counter never changes and the driver times out waiting for
a new frame. Recovery is planned as a follow-up.

Use of AI tools
===============
Claude (Anthropic), used through Claude Code, assisted with this
series. I gave it a specification of the hardware (register map, parity
rules, I2C protocol, conversion constants and test vectors) based on the
User Manual, together with the v1 scope and IIO style requirements. From
that it produced the initial drafts of the driver, the binding and a
userspace bring-up tool, and it reviewed my later changes. I did the
hardware bring-up and all of the testing above on the Pi 5, including the
device tree overlay and boot setup, analysed the power-loss behaviour, and
fixed up and reviewed every patch. I take responsibility for all of it.

[1] https://lore.kernel.org/linux-iio/atyPf0msZ85z2m19@ashevche-desk.local/

Signed-off-by: Viral Patel <viral8854@gmail.com>
---
Viral Patel (2):
      dt-bindings: iio: magnetometer: add Infineon TLE493D-W2B6
      iio: magnetometer: add Infineon TLE493D-W2B6 driver

 .../iio/magnetometer/infineon,tle493d-w2b6.yaml    |  48 ++
 MAINTAINERS                                        |   7 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/tle493d.c                 | 552 +++++++++++++++++++++
 5 files changed, 621 insertions(+)
---
base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
change-id: 20261028-tle493d-14c38f2bd273

Best regards,
-- 
Viral Patel <viral8854@gmail.com>

