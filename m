Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599945;
	b=IwzWrdaTCtCw4+QnvxYn4K81f7d5qEnSyfySiphFIVNmv/loGPoB45UF3PnzsGQpUAMS
	 q6XzcAWiT4dkjvzHB6uEzsqin83E+KRR3mYExZAMbwB0YYUwWREoi2Tuny57gpT3EBnfw
	 RlbIO29N45ykpgl5EPLQqHnT6Ckqt76+hRVTmA1N7+Lvkbdtyi38YgF2mtsA46Uua7cid
	 s8s9dqZ/3492eDehiO3aB8/NLRaEuqKNXU6/EDyVKR5wB7ejbPBtjfKaw8fJARq6TVYzO
	 Qs/L4CbTacsgoVzBT/BAwfqWiCYEetl+xQxdI+dCpsQMc353PyWf6kpLeasYR3fGpIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599945;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=cj8Yp2Pkv4lftN834Q0nDahZTn/3z1ZOLgpNfJbIzI4=;
	b=sgSd9SJjgsiiqoCWafQ2qsCaBbWRAfNRMaw1Pfar4nBVKF1UK7S/St8C5OxlZAq0BoBG
	 lCUNxJjUKiqN5CeLQTb9OMv5LXGGsXgMz/g7mxEpm28OC9VCCRb3pYYjIEqsV2LmrDdgH
	 Cys2wbbo/KZQr+xvTNAgQ8SS+W68nqySAiUzVUYj6Z8veuhfoMP9FqM4z2PcczIfNCaGP
	 XFm3/NsS9iHD6G+oQEzroVIWqJLxAcprhs8tZwKjweMHtFQIZN/Um4SDogsc91j7ib210
	 bXgbRFQgDuWhYmnBaUIdBnqmjTiTB7yIj/bDtcvOq+y0UM9Au1CPvp5A5PCvGj7xlAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgzBv7Dx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79967606C94C;
	Fri, 13 Nov 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgzBv7Dx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794599945;
	b=zg5RxQ9Y/jerWtLbhy+8uyP/UVEGOBchzOVI3Biys4gLk0gpJm7iHBwEJQSyN/OSQr7s
	 9b9/pxPa/PM58AIDG9p1bsJ2cX2hq0bnU09zEY1yFohzvzv9zrzCvDdAZdP0n7poZCzYz
	 oHiLTc7quNLdEnNa39BrKgALTL+j2wE0sqmgccm1JZGJNGr13vbCIvRvO4hpPH5qDRnS/
	 +bFa3/1O3GIfbbMpeL7oCa8rSB1oPf0K0Zt130QJ03y3QKMzxpkzr+d+mqskfFAgmy2lN
	 wfYcroakBhSYxMNGOs2gTuroQwyMJ/Tu8UZPVXYpMd9c49wehgNmiLY1CPIxcA/43iA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599945;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=cj8Yp2Pkv4lftN834Q0nDahZTn/3z1ZOLgpNfJbIzI4=;
	b=bZrPu4SA+a8Du2PmB+kPhA/QkQIla7MoxAVatQnStsx8pNMQqs1Jrh7ZQQqDjlNh1kEf
	 QBpqM3dQisk+Q/WlrxMF1UufNE24ccF7SThVd0H/ZivN8KlzJVWmNKPAsvyq2oGmD5oAr
	 sI+Oo3RDmrSz4kBjU4Gx3o1kOLkBUCQewVqyEJs4Gyjk7wdEhjnLwn2FJLPV0rjuKjLQr
	 jPfpIoSR8wRetUA1ad5q+xuWBo2NjA3xsi+m+fhxK1UXxIly1DQcLuZxELGboGKf+9m4i
	 NwuAiPijObttlcuCsQPA4n1FRgcJnDrBz/EfYK5iyshUS5kX1QGAe9peViL77z7ZRJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DFB421F000C4;
	Fri, 13 Nov 2026 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599945;
	bh=cj8Yp2Pkv4lftN834Q0nDahZTn/3z1ZOLgpNfJbIzI4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=mgzBv7Dx2LkHaAoG3vxb/pSsleATa/XFSPmT1wZS43Nh3keaIY1cL7DCYIVgmcZfl
	 +3Fss1tlSMP+cfEI9vmEZErJceT6oiCf/QMSWfOv78VuikCNG2vK6PqiEd1PZUX/6V
	 BfZRMdRq2YxlCKZOCUxghD76i0osjexgaXFPNwBIJCqYJHFaBAfuzoFs5wMQ15wSVe
	 sN/5F4VKi2zrzcx9FX1r8kxVjmjrdWG5So4Fj94lwTKY/w37e81T49Twg6pomwftbl
	 2YAuc6ToN5B5M7L5r0heeOKBHSF8Eqh7HwnexlDi9DG5dYMkzwE/lOSrKBuWQuMWxT
	 WWbOcP16b2tFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7133749AA7;
	Fri, 13 Nov 2026 19:59:03 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH v3 0/2] iio: light: Add Capella CM3217 ambient light sensor
Date: Fri, 13 Nov 2026 20:58:58 +0100
Message-Id: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OzQ6CMBAGX4X07Bq2/DR48j2Mh9IuUiNC2tJoC
 O9uixcPxOMk387swhxZQ46dsoVZCsaZ8RmhOGRM9fJ5IzA6MuM5rxFzhHly3pIcwJgR1FBwFEB
 Fh6UqRZ1TxeLlZKkzr816uX7Zze2dlE+qtOiN86N9b9mAafe/EBByqAgFL5Uk0YqzdwGcl/0D0
 v/yqImlVOC/snpfxqNMN0JqTQ0KVLuydV0/s5PBVx4BAAA=
X-Change-ID: 20261101-upstream-iio-cm3217-e3f14c4760e5
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794599942; l=5952;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=H766bnLZqaMN3JCJBas9Mw+8eKz2MNL20nTTCG220MA=;
 b=zTefsdHToVk0ITfLysKAtjIFeRwaS+uzqYVSrIlcu+Adyu3PnOtYRLF2P4U4pFrc3xHCgEweW
 9Pdr5xNNzROCmjpcIiy46IGPCnTSenyAIaSO0eyS/j867mA7hT8oUUr
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

The Capella CM3217 is a small ambient light sensor without registers.
NVIDIA used it in the Tegra Note 7 and the Shield Tablet. Mainline has
no driver for it: cm32181 and cm3232 expect registers and an ID, the
CM3217 has neither.

Patch 1 adds the binding, patch 2 the driver with raw value, scale and
integration time. The datasheet is not public, so the bit fields come
from NVIDIA's downstream drivers and the scale from Capella's published
detection range. Patch 2 explains both.

Tested on a Tegra Note 7 (P1640) with v7.3 and the driver built as a
module, the device created through new_device. In room light all 32
combinations of integration time and scale gave the same illuminance
within the count resolution (6.0 to 7.3 lux), and the first read after
each change matched the second one. The raw counts scale linearly with
both fields. Svyatoslav Ryhel also tried it on the P1988 variant of the
Tegra Note 7.

Probing through the device tree works with the real supply (vdd_dev,
Palmas LDO6), and unloading and reloading the module twice brought the
device back each time. Next to a phone light sensor the readings were
about 7 to 20 times lower. NVIDIA's Android HAL for this tablet
multiplies the count by 2.1505 at the same 2 T/100 ms setting, which is
7.2 times the scale here, so most of that is the dark cover window. With
that factor the tablet was within 15 % of the phone in bright light but
a factor of three lower in dim room light; I could not tell whether that
was my setup.

v3 was run again on the P1640, through the device tree with both
addresses in reg and through new_device without a device tree node: in
both cases the driver binds to 0x10 and claims 0x11, and all 32
settings give the same scale and integration time values as v2. With
the device tree, unloading and reloading the module twice freed and
claimed the second address again. Suspend/resume was not tested.

There is no MAINTAINERS entry: drivers/iio/light/cm* is covered by the
Capella entry and the binding by IIO. I am happy to add one if you
prefer.

The device tree node for the Tegra Note 7 will follow with Svyatoslav's
tegratab series.

Tool use (see Documentation/process/generated-content.rst): this series
was prepared with an LLM coding assistant (Claude Code). It read the
NVIDIA downstream drivers and Capella's product data, wrote the driver,
the binding and the texts from my instructions, and ran the build and
binding checks. I reviewed the code and ran the tests on the device.

---
Changes in v3:
- Binding: list both I2C addresses in reg, one description each
  (Conor).
- Driver: take the second address from the second reg entry, with 0x11
  as fallback when there is no firmware node (new_device). Svyatoslav,
  I kept your Tested-by as a device tree with only the first address
  still works through the fallback, but a quick retest would be
  welcome.
- Driver: write the resolution constant as 0.01875 lux times 800 ms in
  nanolux * ms, so that NANO is no longer part of it (Andy).
- Driver: split the scale into its integer and nano parts with a named
  helper macro (Andy).
- Driver: static_assert() on one line, the conversion margin added to
  conv_ms with a comment, FIELD_MODIFY() for IT_T, and the error return
  in probe inside scoped_guard() (Andy).
- No functional change: the scale and integration time tables in the
  object file are identical to v2. struct cm3217_data was checked with
  pahole: one 2-byte hole on 32-bit ARM, and no field order makes it
  smaller as ktime_t needs 8-byte alignment, so the order stays (Andy).
- Tested again on the device, see above.
- Link to v2: https://patch.msgid.link/20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de

Changes in v2:
- Binding: describe the two I2C addresses under reg, including what each
  one is used for (Jonathan).
- Driver: replace the scale list that was recomputed on every change of
  the integration time by a const table built at compile time;
  read_avail() returns the row for the current integration time, so no
  table is rewritten while a caller may hold a pointer to it (Jonathan,
  Sashiko).
- Driver: write the resolution constant with NANO and explain its unit
  (Jonathan).
- Driver: add cm3217_power_down() for the shutdown write used in three
  places (Jonathan), and a helper for the table lookups in write_raw()
  so the loop counter can live in the for statement (Jonathan).
- Driver: take the conversion time from the integration time table and
  drop the separate table in milliseconds.
- Pick up Svyatoslav's Tested-by on patch 2 (given on v1).
- Commit messages: name the downstream trees, note that the 4 T field
  value differs from the vendor header, drop "driver" from the binding
  text.
- Rebase onto the current iio togreg branch (based on v7.4-rc1).
- No functional change intended. The 32 scale values match the v1
  computation. Run again on the Tegra Note 7 (P1640) as a module: each
  integration time lists the same scales as with v1, all 32 settings are
  accepted and read back, invalid values are rejected, and the sensor is
  shut down when the device is removed.
- Link to v1: https://patch.msgid.link/20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de

---
Patrick Fischer (2):
      dt-bindings: iio: light: Add Capella CM3217
      iio: light: Add Capella CM3217 ambient light sensor driver

 .../bindings/iio/light/capella,cm3217.yaml         |  50 +++
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm3217.c                         | 419 +++++++++++++++++++++
 4 files changed, 480 insertions(+)
---
base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
change-id: 20261101-upstream-iio-cm3217-e3f14c4760e5

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


