Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795822765;
	b=jq55obnwXD6QJvMqVuyriAz1GGYeCmYugZU027eNcpvwTPDswTUm2EBuCg+NL6xOShlw
	 4dgHkcBv7cwwXGKK66QjILZOhwyta/ilZSyijcm/JLA7rPdLsFiZW5pyYdAR8oRC3IYnJ
	 Ire4jB9JzV8mRR+8pY2vOwvEMPkBEap7UfyyEgwFuClj+ZRkwQNnIugeo2WVRqYEgkNYg
	 vJXPTFNo6ut5uAALQAPC/UtZipp+ugXfxUMHgdqiZekgiy4iWEL18OlrsYdKhLB98kXlO
	 ne+WhKUCK/+OtHmnkiufWcuWG3LlfY1W4r0qXqo+8orkecMZgkJ0O2Zb47fZQFPWz7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822765;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=KGXANK/USdDKEVmRF29J9+HlJg7S2JxOvqaweYy8bXI=;
	b=xxqyziF/HrOunHb/PuHZAiizSaZX1btFf8WeVbn7iZBM6+weqJvo0qzcwqL4YmBzM0Wy
	 G7tsMewexYcmYR5t5cRmqJ+H5yDYky29cZCjGn52A9chvBdlm3jGMzXHFOLfhiQmCOeO8
	 MIobZfmiVGcaTMz5jW0x1C1kyEAPV3p07zqPWoBgFhnY+fSDTtpa1QpiWo72E5hpdzNku
	 eY28iQ8YSmnOeYsIGGZAPEUwGzO4ZkU2B//YUyqwNtvcpRPJaO0aU45QgwhZ+3P1IxeYy
	 +Y3BfBAf2GQfPtElrYbKZ7Z0h1dKHvoNvW9PKBIK3u424JxNn4Gek3Qo0lQPnxQSs0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEf+DcoP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B06606A323;
	Fri, 27 Nov 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEf+DcoP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795822764;
	b=jIZyKz56PZcycNH5Qkjyvol2ttI73djw6tk5U41XtcJY0O7kcfnkB40D1jC774GHcL50
	 vpi5A3HwCULBp5bjrg4fAiSmSX0l4qMkyVE1OLWwA2f3r58EfLJ9QoAqFQt96SEVHXshp
	 mb1+Peiku5qiTbehOFiNPl6jAj8RhY04BtXRHLEfHDyhzQXFCZ7Fd/yUFLAgU2iSDut8o
	 zExH1c/GMK34scDg2IBuw45mgP9ZqxzEOYChOahTy7zEtdogfISvHHvN1AKBQ60650hrw
	 4d8V553rnbFqnhSME3ajxpykEywj6hfVv+uEYpuvNqcBb4YkdovDQtPPVYEbyRKHXDg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795822764;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=KGXANK/USdDKEVmRF29J9+HlJg7S2JxOvqaweYy8bXI=;
	b=CsbtM3M4Qi2wO96dUo4mPuFRfXmDqP1ohv+PkeJIO8db8B/oSr5cBsygQpTll3IZ1dkQ
	 FhefgihuDPCChotdleBQfkUyBp77xXvyoBYBTsEX8MnfxaGTeDEhHAExNx5o/vGyol3HY
	 ZfmkDAoU8IOFoCMiK40sKhB0AbFfUDG4Ic41PPy/RadFhpsYMQ7TxtaFx9YMSdO9qEofS
	 57roabETqh8shFG3o1L1Qmg9m3l/SnuyFAph7BhqcYYCv/SKtjR7MA7MbvPhvOYrjX3CR
	 JURDPJ8eHTNQho5HiW5sj6jT0Kxve1fUntn34rjXSou+WaCSHtf32fEGKkwjrq3OExw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 556861F000C1;
	Fri, 27 Nov 2026 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822764;
	bh=KGXANK/USdDKEVmRF29J9+HlJg7S2JxOvqaweYy8bXI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=VEf+DcoPbKYVQyd+v8swKMA05wOdp1cg4xNfK57h3+jRGWZgCXpcI/yhLm5OE9kgl
	 kjEOTRSiHLJSmEdZL81CjSCcRleH/hfpwVVcUlxb9ewx1RNPgBI82GzRdlyD/q7Oqm
	 S6NcqmzB9S1ke6hAZ4OxKzaK2mVYJZEvK33orytogxWTU45PZqg26u090mZXKCMYun
	 PWaRG/AOZwhHkgg8gpxPXJOV77waipcJS1sgCpmoi2yx8NBbUba4gfbG87iV3nWrtU
	 ZBXDwHlvGcE3C8PI3rVa2jym2KgbRWlKou7Rr7wEq45u62TpTvdlfYF7Jsc7Fwp0ro
	 iaQZywhJ3MbZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF1444DE8A;
	Fri, 27 Nov 2026 23:39:15 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH v4 0/2] iio: light: Add Capella CM3217 ambient light sensor
Date: Sat, 28 Nov 2026 00:38:55 +0100
Message-Id: <20261128-upstream-iio-cm3217-v4-0-fdab04f40bbc@tsv-stahl-riesa.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OQQ7CIBAF0KsY1o7pAC3qynsYFxSmFqOtASQa0
 7sLunFRXf7kz/vzZIG8o8C2iyfzlFxw45CDXC6Y6fVwJHA2Z8Yr3iBWCLdriJ70BZwbwVwERwU
 kOpRGqqaimuXLq6fO3d/q/vDJ4daeyMRClUbvQhz94z2bsPT+LySECmpCxaXRpFq1iyFBiLo/Q
 /lfryyxMpX4N9bMYzxjdqO0tbRBheYnJr4wFPOYyJiRtm65XNe262axaZpegl8QDmsBAAA=
X-Change-ID: 20261101-upstream-iio-cm3217-e3f14c4760e5
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795822755; l=7256;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=Ny6vyllDTSVrESnJILjBNKDu5yers3ghxEQhKJ3JD+I=;
 b=k/qag+BOSFpvM61YZl7TFc+M+2n7lZsiZiMbSxm7RAPTKcgcxLvSfWQzEUenjzJlwUyTvj5pg
 qO0JuJIya9/BfN1HrXiEykgpcUJw5TreCnlNZCIIwRYn10Psix9Dx6y
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
Changes in v4:
- Binding: drop "without registers or interrupt line" from the
  description (Jonathan). Kept Krzysztof's Reviewed-by on patch 1, as
  this is the only change to the binding since his review.
- Driver: don't read the second address from firmware at all, it is
  always the device address plus one (Jonathan). This also removes the
  fallback for new_device and with it the question of how to detect a
  missing firmware node (Jonathan, Andy).
- Driver: one lookup helper each for the scale and the integration time
  instead of cm3217_find_avail() with a length parameter (Andy).
- Driver: reversed xmas tree order in cm3217_read_count() and probe()
  (Andy).
- Driver: devm_i2c_new_dummy_device() call on one line (Andy).
- Driver: include mod_devicetable.h for the device ID tables.
- Commit messages: patch 2 describes the new address handling; both
  patches now say what the coding assistant did, in addition to the
  "Tool use" paragraph above.
- Rebase onto the current iio togreg branch.
- No functional change on the Tegra Note 7: the scale and integration
  time tables in the object file are identical to v3, and the second
  address is still 0x11.
- Link to v3: https://patch.msgid.link/20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de

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

 .../bindings/iio/light/capella,cm3217.yaml         |  49 +++
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm3217.c                         | 420 +++++++++++++++++++++
 4 files changed, 480 insertions(+)
---
base-commit: 92c9d64c0cf749c8369403a32630562f0e855a6c
change-id: 20261101-upstream-iio-cm3217-e3f14c4760e5

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


