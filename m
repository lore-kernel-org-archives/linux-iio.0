Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240521;
	b=VN5w8PlyrOgfqfA6I18sfiaMgSGhrHmc5dCdcl75pC8LZvXEmGS3Ysxci2BAocjhMRBJ
	 OkCMRTUsNtJfQ6KrsjcoUvEcj9qtfQOnirHHNxen+Z7IHyMS3RLPp4UaK0cNNIRQxA+g7
	 ySWANZMxIzyij+HhvMwfaUBVPn95f5qg/zdMXWQmOmlsDUffByaVeFlkMj8ow2p2PNAMu
	 0GMOKQ6i/7G6JsKyQoKNNGwLckZNGL2UPbkHsVdh/Hj6i30l604cIngfni0ZA5mZX4pzP
	 KBVRqaxRYAucqed/iLuPjYbeg4azCO0MevDNiOp9TjjGWKWz/GjPBzVMBR46C1yMTBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VRkzVDCu4h7OOw62wkfxEZaIQL0l0jarNYsHxjBjg4s=;
	b=Wq6vVdIuiYO04YTQ2I9oCsBe/RqZxd07XRWd6zgQKLaqPTXGBpTLgew7y/gmXF0P7xlv
	 rAyBaZ7TyrNMjFlsn3EdAtZiEm/Rli79uDfU11tOIkBIc6lB2FCW6+rHH4cFjsyfNHd9K
	 9F5Mq+KEgsGp7VE5huaauFpKwrHHNTBDBSozKvCdldBqFqB7axYbwg5DTu+uE8Z9EBqUP
	 yltUoR9Etlo4k1AbzsUKdURzau5LWnrTRi2XWDReNrPtLnt9pNmD8ic32DLerGlPhQurm
	 dSubv6IG9NtwjE4CJyp4fyxDRfryI193ATVcBLYXbH4LqyVLZKYMmRPjVzJHP7RAyUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3UW+XKk;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED24606A697
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 05:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED24606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3UW+XKk
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-382f4710a17so2689406eec.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 21:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240519; x=1795845319; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VRkzVDCu4h7OOw62wkfxEZaIQL0l0jarNYsHxjBjg4s=;
        b=o3UW+XKk9Ru8xXN6/wgel/cgId1/iPY/5oSeQ6xcb7HJ7ifn3GBm2KCQGnOufJ5yBy
         d5cFcM8H0KgyLPrf3Gta+p+VnJ5TJf30/nn3oC1HlLgNCvnOsZHKf8/NUl04WIuG12ci
         pCOiBfP4/Pd/jX4DxDfDFY79qmvBO7VCm4941fWAU4eAfxb8drp5e2fDlQu4rtnCYvco
         Es9CZ5VqbInjKmjsACH5dlrbB5u24Zx1Fsl+FWlRMKaW7D0M4WJgry8S4hz/bB+IHElb
         bUA5MdfvvDwkZRUHhOk9wxo8klI5KW3DWiaPjwVHB5Wwoi5Ek36i9k6Y8TNDeMvZY971
         xmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240519; x=1795845319;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VRkzVDCu4h7OOw62wkfxEZaIQL0l0jarNYsHxjBjg4s=;
        b=Z1Me1aH3fZ+B1baxC8LISlICFD3UaKBzmOrZRonJnnDDWWNCIrSB7T+tgDfj5sHz5G
         2w+pFUT4mVftw6m0AQVpXx4fZwIWX9ikL4DwjRdfuF4PnyCgnhdoW5UNE5yXdg90v4nh
         RLUE7/8W2iAbnXTKVvjKO4wy6OcHpK66oXh12o2mZNbpPWVK6AX9RrGnZwzVO493WSG/
         B5BQzogvbckFckLdNFw6SlMMgtVQZYRygj3fU5Fq2DBeixO/pAI7aMGlAHu17T9/efMy
         lLxevLSXijQuBCQiftp2AHZZyExyY8BKeNdAd+LVnx0hxow+omTsiBdmTWXymgyLCT0P
         HEyQ==
X-Forwarded-Encrypted: i=1; AL+hErHmRXDIWTw00+hXs3DOUKMqF4cknZZuyCBV3hNfdO89SvUx68mjbg0D4A7/LuiR4VHRNEqdSeckxW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mAiWaD6WGsBEqav/VLNkIjRqDUADaU1hVJhlsSvEi7Dkts0m+
	PQI6A2UftW2PeXWF9Y010TiqQAvGdi/ftCUDln2/c4Rvw6MEIW98kRMo
X-Gm-Gg: AZFdTZd/8XVYuceXEFW7EfIqMdWGQl5IPMlfSjLHnUA0YL17nGuqWzw5ONelEgSSHcR
	TW90JA6wyWnLx1oU3G7aPimbJUMao6uKN3/abhaCmyHfOCjbeJJZH+V+KlDvkbsNVUJDxitDD8c
	5Li8wr7sN4dxwj0O7BKbpkrhi4awY/u3Gcv7igxTYqSsnrj5CVix8/poT/EXQXpC6zGV8KpaOCy
	jLqSR7APbZjKaiLwrcon5B++00DS/+b99MVY48yyeqtcLbgJyIpYXXEm+hS8qkNAW7zF7uFCY5J
	kH+63Hi+kS49aBatOH/+dWDjrUTVeV1mfObqiaGKWzKEdKbUdr/+1315JYhVKfHJQmA8O9KFhD6
	cj/7z+rXw8GivYMSBtJexAPwHJ3nJM64wGa23AnSbfcqXZColHDuE0IFR+iVeyEZw6Sv+SQ6uSY
	UQEtIFRrn3Io/exzxJNH9kylKqwG5+0t8b7zMSxKRlWWxLkKjXgnsohBBjiqarNdzuog4wO3gUH
	ZsamlJW1hic0/uE4KwZL9Y/J/kQsU4arit4DvA7voS2Xgh48VvUMlSLQ5HlqsIjXW14wlt3FW2I
	NPo/9fQwoeknf/ob5+VQ7SJstQ6DSIA=
X-Received: by 2002:a05:693c:20c8:20b0:381:53ed:1c4b with SMTP id 5a478bee46e88-38571518db2mr5440311eec.34.1795240518911;
        Fri, 20 Nov 2026 21:55:18 -0800 (PST)
Received: from [127.0.1.1] ([2405:201:201e:8863:a72d:7d80:d674:e22b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm14423662eec.21.2026.11.20.21.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:55:18 -0800 (PST)
From: Viral Patel <viral8854@gmail.com>
Subject: [PATCH v2 0/2] iio: magnetometer: add Infineon TLE493D-W2B6
 support
Date: Sat, 21 Nov 2026 11:25:09 +0530
Message-Id: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAD0yAWsC/z3Myw6CMBCF4Vchs7amM61IXfkehgXCAJNwS0saD
 eHdrZi4/E9Ovg0Ce+EAt2wDz1GCzFMKOmVQ99XUsZImNZCmHDUVah3YOtMotLUpWno2dDWQ3ov
 nVl6H9ChT9xLW2b8POOJ3/RmoL38jotLKkM3ZIefG2Xs3VjKc63mEct/3D2YzTYmeAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795240513; l=6963;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=MzBc98Zhhkw57lEqQQOcbrGAiY+LY9quSwYv0/7I6Lo=;
 b=R3gSSlYhITz002ctFfK4fCNua+wTP/43nqOmJwcU81rGA+YxNxN8UZ/8msebgErAA4NnonkJ+
 ZsLoJzsoV90DZupZAyu2k128jG7xFwNkV7VY+kouACszroaUan7DYyT
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
The driver supports master-controlled single-shot measurements of
X/Y/Z and temperature at full range, via sysfs and a triggered buffer
with a soft timestamp.

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
rpi-6.18.y kernel (6.18.59). For v1 both patches were applied there
unchanged apart from a Makefile context fix-up; for v2 the driver from
this series was built as a module against that kernel and re-tested.

 - Probe: the module autoloads from the DT compatible and the Version
   and ID registers match the A0 variant. With the sensor disconnected,
   probe fails cleanly with -EREMOTEIO (v1).
 - Reset: the Pi's DesignWare adapter advertises I2C_FUNC_SMBUS_QUICK.
   An i2c/smbus trace of probe shows two Quick reads from 0x7f and two
   Quick writes to 0x00, each NACKed as expected, followed by the MOD1
   write to 0x35.
 - Raw reads via sysfs: with no magnet nearby, X/Y/Z read within
   +/-3 LSB of zero; temperature reads about 30-33 degC at room
   temperature, matching a userspace bring-up tool.
 - Triggered buffer with an hrtimer trigger at 10, 100 and 500 Hz: no
   missed samples (20/20, 200/200 and 1000/1000 over 2 s). In v1 the
   mean period at 100 and 500 Hz was 10.000 ms and 2.000 ms with at
   most 3 us jitter.
 - sysfs reads from four processes in parallel, and sysfs reads while
   streaming, work.
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
hardware bring-up and the v1 testing on the Pi 5, including the device
tree overlay and boot setup, analysed the power-loss behaviour, and
fixed up and reviewed every patch.

For v2 I went through the review with Jonathan and Victor and decided
how to address each point, including checking the TLV493D datasheet to
confirm that its /INT also shares the SCL pin, which is what allows the
binding to be merged. Claude then made the code changes and ran the
re-test above on my Pi 5 setup. I reviewed every change and the
results, and re-tested v2 on the Pi 5 myself: probe, and the triggered
buffer at 100 Hz (200/200 samples, 10.000 ms period). I take
responsibility for all of it.

[1] https://lore.kernel.org/linux-iio/atyPf0msZ85z2m19@ashevche-desk.local/

Signed-off-by: Viral Patel <viral8854@gmail.com>
---
Changes in v2:
- Rebased onto current togreg
- dt-bindings: add the compatible to infineon,tlv493d-a1b6.yaml instead
  of a new file. interrupts is allowed as for the TLV493D, since both
  parts have /INT on SCL and Infineon recommends wiring it up (Jonathan)
- Use FIELD_GET() for the single-bit Diag flags (Jonathan)
- Comment on why Diag is cached before the error checks (Jonathan)
- Use guard() in read_raw() and mutex_lock()/mutex_unlock() in the
  trigger handler (Jonathan)
- Send the reset as SMBus Quick commands and skip it if the adapter
  lacks I2C_FUNC_SMBUS_QUICK (Jonathan)
- Declare the reset loop counter in the for statement (Jonathan)
- Comment on IICadr and on the 7-bit vs 8-bit addresses (Jonathan, Victor)
- Link the user manual in the driver commit message (Victor)
- Link to v1: https://lore.kernel.org/r/20261105-tle493d-v1-0-3246e91e6394@gmail.com

---
Viral Patel (2):
      dt-bindings: iio: magnetometer: infineon,tlv493d-a1b6: add TLE493D-W2B6
      iio: magnetometer: add Infineon TLE493D-W2B6 driver

 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    |  14 +-
 MAINTAINERS                                        |   7 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/tle493d.c                 | 572 +++++++++++++++++++++
 5 files changed, 605 insertions(+), 2 deletions(-)
---
base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
change-id: 20261028-tle493d-14c38f2bd273

Best regards,
-- 
Viral Patel <viral8854@gmail.com>

