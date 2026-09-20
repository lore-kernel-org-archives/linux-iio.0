Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157F442135
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922895; cv=none; b=e9bNm0JBedC1BpGUN4yQJTi/HfVNdTLZrpu/+zm/67hH/eUyy5fz+rEXxQFAT9hu8nl7qdpzCcif9srkNsu/B2cx4LcZ/OJIfWdvyf+Dkmt0V7GC7kQ3j8MoUWxJIkE9uCzMLQI0Enfh0b/SDp2zoPtffnw8o94x9su3FwPI3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922895; c=relaxed/simple;
	bh=9QJrrxtGQhh3xQEosUS94vv9iCIDf0t/zjzc1PzaY6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=OpVIBATfsX9YdtXk82de3s3T/EA1hI7ZUZUPDIlGVpW9r8VzYL0vLNUF/Egcudk8ULl0wKiyWV+15adxn2y6dZ+wEYNEdQpDts+BbC8Z1ll9pPdQKgnlIy0y5pnG1Hq4vBfMPCR51jCLXNaswHWCa/1DlyJEsFD4/A1nSDHgAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gpylOQkl; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gpylOQkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922891; bh=KAVstJCjksBawbsJtdfNivZ5o0/shvjTW+0lXrSdCLU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=gpylOQklwMlY5x5PNyf9jjaUq7T6szcAdPC2z9EZ6R2NJQ3oyD0pJc8gfURHbRl3/DFHzfQdhF4rY7ouo5q9qBmTZM0MIcmE1XV2sd2MWNQ7OC/LwYgmgVx9n+zsUFfjj2b7q2xafGhvVkLW8axVZlQsW7r3iL11m7PieHIOnFNxXv4POCt1+K2YM7HpfZSgAXtnew6hIYXRS9IfWS32ghvRx6jI/9wjoSUu0Zb8FYF5Nuo5i7nF26XzYcA0GlAat/Iq641l6vPTrAsz3f0Tdqf6QqkTFGiIi6wBdglRMg+fL8FzwYVuJDb0+2pCkwIp3LW2L4H8HeNTrFpWSkdf4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922891; bh=GDTAVITRBcgtxnU/sLdj8XVZjKi4tIGy4bY0/77UyMh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DYJLsppK0x0pOrwSU1rbb/wgq6L35d8AM5k93Iaq7Zr44/L+DY5gzlD0GWaZSiIYqpSw7cELjpj8RAwwZ5n2r0fBsCdhUAvLy4s7GeqO/oJWt42ZwHEX+Q1PeYm1Dd7rgGtv108IEba54UwrcglWWHaJz3H1+cX1LfpJb00It41kuolEeflRQYY9UIU1nTftrsPW8gMqNm8+d2Lmh3G4w7EYagc8gj84SJvZTAfd0I8vDVzutBuIw0UA80ACgHqdGeLE/fMc4j6sCZbEPFh1F3rbT152iv0PpQlAentDpk+EgPmTnlvTEIJs0qUU9mpALkuMTE4zUSYpPx3quAat+g==
X-YMail-OSG: Yi1NNJgVM1kWuGeu8E3Amb.4amu3FxL3OjF56RqWmhd1LaPCDHlXW95jvmZVU0G
 EFF7Fy8EpOnrNvVs2dXGs8GmDDabikS8G.QTGlr2j8kmwUD1iMDxn_oBc8j0qSOqkNCkwNoQhUAW
 2.16Ad2hCeRKv1O1UYZm.dZY39gl5Pz7zU7sRsLg0BYdZvU96nF1zpWTRgRkA6VDQSXd_y04BuC3
 ZyOFzY0MchA26EUh1dsWmasWI7iY2jbVRbRpWKuUOrc9dTJLJ4R3HieB5j8KjOy1GXGJP4by47XU
 zGZFoztD1SkQ_vopdWd8IhNhnP8VFubKgJeuc.o.vadiOhbNfLpJsdJTFOZ0XRaBqvZtyx3Cu3ua
 o0kXcewN7g9bQeniwC3NSUrqNtp3TO_pu8sc.IUcQjN.7b5QC6moIQWphEqjfa7fGNKli0WbO._i
 UqcV5Oq6UTXdwt8T5P5.Sj.9LBAnAKwSnBnTUpsSvSzH7JfKc_h8M6JGOMJN0sxEtwi4uUR9nsMC
 nVqa56xU0JvHEUKWOx7pm7tCX7RiDdaS0qgpbHGyvTlueEw.Y9I6lGzNpbymPUGaZmSnMjb7kpFY
 p.EeBL9RU39PlG_MnPHv3MQR5cB4bAhmp80j0Q_CFbRMQxHf9eeXcnGoRoTTIFKt6wrxhmwOPPJu
 FdN1o4vaw8d6k2Zh7NxFJ3tlDWLixpBUpPzOC8McWFd0PFsulPaPuwbisyTP_qK9CDVFTlhbg5yu
 v2TBro9CNRQ5wKCqrXPHi2YifE9c96Xafldvc_AkQijq6414E6VkX_38z0bRlZXEkJiEclT3BF15
 9JL3YLmBRaBf_oMqDO0FTKx1u42yGH6HSDEImdASxHEGcmWY1ugh8wvl77hIPyR6sffRbKZ2r5Bz
 GGQj0UAsZONTc4Acb0GVOJboxN0yZ47VvPugsIcpAaTiwKB6aFc9emzo_rahsYU5u4ija3e5Hoq7
 7UNJQWDfHRaf0fd0Fyd3U79hBniAyHiUuZkAFeOGITxwt9VMPuWxSTV9An5uh6Piqvtu7DTzDVzG
 Uf5mSxKQYkyFHkmEco61KTsfL.OS02A7WHtVIy76PolXz9Ius2VCU0QAAlF3VxY4N6Ugc4fNluwm
 teLoGcDny0k_n2.OeaSh0TuvSlUhUcWdVjhuuFfDGrTf0ZQYyFY.HjOXBNO3Z4ecC0zXHT_PO567
 rT5kPG_pBnf7EG2cE9SkOaEPJlPeBIONKSpmmfZJJ3htFotWidpQSlN74HirVyCN85rmydttm9TC
 dbMV93PgkdDLlJPFaj8._GH973R6QErP81s38BfzJIGs8sV9uvSldPti0BRxyAGHz5ucewYq5aTx
 m5kaw5gXPHaUKsr3etjRE2EpqtYpeUtCaifsW9oop66MYBYUieSFcXdF8ofU8b1Cd8d4ZiLHL7N7
 RM.rGQSTe7.t1vwlOGxgzeoErhqI71tcj7fy6ODVoEoiKwAG8R51a3utRm_A7_8W2WeoBILdxgY.
 ocNrPDyKmgi0Duc7qM_NqXaD6ArlqirIMXz1.kU2dHrWmPxehOFaicM.UVMvkdjhbydOvKsoKKDC
 N1HCwQfsoY.KanDva1Ui4BfWOR.uUC7t5laqE9msz7olQ24QiN1VuwEOrQJSCpgo88RsZd5PWIYw
 kFVKKx7i6bVxS0YReT5KmH_9zrgeohljqKQ3tPiHA_X6jvWZZPVfkXtV.mnlVQgYyA4ZG5BVcFRk
 nf4RkTDOX7FfAatRnnPV5DV7nIZNL808UJnYPhnsuXZ2aANiMu_L2aj98E3LviGJTVMrF81KJR.g
 Vsv8w2iMjORcQpbvMWvBZLke82jD9jXlD6.5jMxvUSnOSvcXILJ1c0FMCWA8c.RWAzL3O2ZZ08py
 LgaHzqKJgeoicDDP1a8dXeDoD9YMUYRpMFlSl311Vd25O2MEpzcW3_SQORhvhuieewdVavwVGNjB
 2ZUBPGnkw_vM1EJToFcjGetroGREtrLLxFRyqV5qpBZiCfc.6KCSwSBIr.CF4Zwv0ic99OnEZh8K
 HgaVTYiH8.dMUrtuZwYZuWjyvoE3VkT7TZ2ibDowhplUgs_FayT3wSA--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: bbaf1a06-800f-4d9c-b6c0-50cc89294e09
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sun, 20 Sep 2026 16:48:11 +0000
Received: from dip55.lsn.bf1.yahoo.com ([67.195.177.64])
          by hello (SMTP) with SMTP ID 523daeaa0215dea57efbd4c0222e20e0;
          Sun, 20 Sep 2026 16:48:05 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Subject: [PATCH v2 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Sun, 20 Sep 2026 21:47:22 +0500
Message-ID: <20260920164724.32019-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260920164724.32019-1-m.abubakar365.ref@yahoo.com>

This series adds support for the Sensirion SDP31 differential pressure
sensor, an I2C device that also reports temperature.

The SDP31 uses a completely different I2C command protocol from the
already supported SDP500 (command-triggered measurements with a per-word
CRC-8), so extending the sdp500 driver does not make sense. No compatible
parts from other vendors were found.

Patch 1 adds the device tree binding.
Patch 2 adds the IIO driver, which exposes differential pressure and
temperature channels and validates each measurement using the sensor's
CRC-8 checksum.

The driver was developed and tested on an SDP31 wired to the I2C bus of
a Raspberry Pi 4.

Changes since v1:
- Explain in this cover letter why a new driver is added instead of
  extending the sdp500 driver.
- dt-bindings: make vdd-supply required, and enable the regulator in the
  driver using devm_regulator_get_enable().
- Move the MAINTAINERS entry into the dt-bindings patch; the driver patch
  only adds its own file.
- Populate the CRC-8 table with DO_ONCE() to avoid a race between
  concurrent probes.
- Use devm_mutex_init() and take the lock inside sdp31_measure() using
  guard(mutex).
- Build the command with __be16/cpu_to_be16() and parse the reply with
  get_unaligned_be16().
- Use a named initializer in the i2c_device_id table.
- Minor cleanups: local struct device *dev, single-line dev_err_probe(),
  and a comment on the mutex.

v1: https://lore.kernel.org/linux-iio/20260919223650.13396-1-m.abubakar365@yahoo.com/

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  41 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 209 ++++++++++++++++++
 5 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

