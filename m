Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663100;
	b=M6rGLemPL/XlWf3ifh3keZWbBlI5eErWih/2WvoEYT86sjd8DZnYEauIfmIUY2xXO/o6
	 EEFaI0KG92QaiZiryU1YlbHH69KGzFj0GR0xxXKhyiA0EHwkcPsMRkXbwbyM7JsAvBFEg
	 pEca+ZtwuVeMcRbAEakw4kZRSQczG2b62UHswV2Q4nmBiAUnhlbmxfRujSW7WwbjmqzJu
	 Xlog/cAexPF/r/LN37HEQ0scPj/fqGqtcJXE3lrsFtCE3p6v61VrzFKjHyHUfdRVJuIUH
	 ui4P8DrTIBUAoJKs/yATY1sV8BYZw/1jHkJmkqgGznvxe4iWtdMHc9koobdO1XwaxuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663100;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Go0h5nY9fq2j0Y9SisoBwCP3cqPnblsYuJNIq7sHBgg=;
	b=FqW+VMsA0rIq+CMRYiw62w+OBRKLV0nnAQtbjk3x5BIHEm7gtTXWryhKxgsatzg2YhtM
	 7d3ms/ndcL0D8M+px/4n83gYie47vgsArM8bJV9BPhQ30ZO2rvda5xMiMwGD7tesHai2A
	 9hROINJh95yhQgPvTvvxI3SsADG/14TgFVvyrhZpejTMY976fo6TPeRrVUj8AnDzImaLu
	 fBCqQTAv6EJ8ErVMRSlrGWOtPJuw+GzRh/6X0pbeVWlEIHUp/tvDhE09D7cQ5bAYYBveH
	 z4rKjgVUlZJ8j7aHLxgPn0BP/hBHdI7mCcW+bt6m099dOtC/Af7bBfOlGMfK3zly/tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQnkeeQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7D606A31B;
	Thu, 22 Oct 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQnkeeQo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792663100;
	b=D4xsRI50pA5hFaVsJZfpooOQtrwIy2AKYpPpitZM+uaaY2XHlxB9KQ63XNSVnvGe9m4J
	 2RzidPmsuETl6R+IM+wO3Eh8QeiI0+bBr5F/jN2okILcJyxb4Y09PDPsZFKGLKFwGkuaa
	 8Eyv3gCZneCzZj+dbnoUJ+OKp6jq+gF1FKlyNPgGnWIHVz+rfcRAEMBd2G5AauFGpiAnU
	 ZwFrF3z1u4SwfFshsYp+JCWDbE6ifX4/lEzkPjHXqU7VUS2KikNhCQdnwA8q8VFaLGh50
	 rX8PGOULKvA5Hx7pXU6O5HFpjOrO6ZHfTcmcYmF5JdVDYGD8BHo8FSO1ho6hcPCWQ9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792663100;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Go0h5nY9fq2j0Y9SisoBwCP3cqPnblsYuJNIq7sHBgg=;
	b=vum/JXGfcr5heiquMrtEYhjcGadKUZCY5G656RSOX1g14nF2BpNJMEavx6LcKKhZqyIG
	 hRcNSrVyE/mmLJ3xTicNfrYN3/7suiNyOksCNPvZjQ/pmgkJaFOvFOKyzvyoBkjI1vEdc
	 Cl0MLYyb99lpsIHv0GxLYTt1/AW6iR5oexjNwAGm0/9JhLezuta+aeyYK3mdSyIRv8bDf
	 W08gqMpfPUff5MagEkVLDvdhry11+CLM8RwoUvYaOUzhBWY4wCGR1iJ6KW/zX084OXe15
	 3aqgweNKttr/jMlQddIj3jQX2PsGtui6G20MMyZp+x9ymPMQWr2pdtAVl39oWpeeqog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D41D1F000C2;
	Thu, 22 Oct 2026 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663100;
	bh=Go0h5nY9fq2j0Y9SisoBwCP3cqPnblsYuJNIq7sHBgg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DQnkeeQo/f4BIjCs9WBwuGriO5kt9AkpeXGahR3D5NKccuz4XVifCCr0XBtmI0yKU
	 amuw7mfdqE7AzYvxndyZIVifLxGGF7Y0YJygezp0ukziAvMtmv6AK+hhjJsnUb8k/G
	 ITwmBw+q1KkJvAFrZw7x3ryc+hSZWaXdTq3fMxeyu4UKkViAAwn8+FLlxGTsB+8YTB
	 WtC0H63A//52ppZi8ssQ9bFE/KJIe5gB3/X+pmPyzrWXMwp4IWZkvm+8FeApO4hv2M
	 UdEfG0Z4HBJY/iR3bTQ/yhtMyhy/vRVvfG2yU0uZEJI7l1f9iyprXCvPmVZ9Jg03t7
	 /Wuu9oNGufwVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 920F643556;
	Thu, 22 Oct 2026 09:58:18 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Subject: [PATCH v2 0/3] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Date: Thu, 22 Oct 2026 12:58:17 +0300
Message-Id: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADne2WoC/42OQQ6CMBAAv0L2bE1bKhFP/MNwKO0Ka4CSthIN4
 e+2+AGTvcxmMrsbBPSEAW7FBh5XCuTmBPJUgBn03CMjmxgkl5XgvGbh1U0UssbGaKSqy7RaFuc
 jWwW7VkrVaFGV0kJqLB4f9D769/bHKfBEE3M0GwOF6PzneGAV2fv3VhrOSqutsKoTF6kbPevR9
 WfjJmj3ff8CQQpv7N0AAAA=
X-Change-ID: 20261009-submission-ltc2493-support-v1-86449ede432d
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792663098; l=3104;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=yPsqOFeX5OG71XtkfM53Dkyy130nnE6U9LTTm4qQtUM=;
 b=Bv5SokQryLzD6Jp1AUfflpESvj8Lt7SDZjuElK2RHsTuO7NcK33myjeO79yvfCabfHwsi1AGJ
 tVtlI2P+PpXDeUnfu6//cPQ0XAjG/9MEgMaZ/YT5Rr2GchpNakCBOLA
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

This series adds LTC2493 support to the ltc2497 driver, and adds FA/FB
line-frequency rejection for the LTC2499 and the LTC2493.

It includes:
- the LTC2493 device-tree binding,
- FA/FB line-frequency rejection (50Hz, 60Hz, or both) exposed via
  filter_mode, implemented in the core and enabled for the LTC2499,
- LTC2493 support in the driver: 4 single-ended inputs or 2 differential
  pairs, 24-bit result, same command format as the LTC2499, the internal
  PTAT temperature channel, the 2x conversion speed mode exposed via
  sampling_frequency, and the same rejection selection.

The rejection patch also adjusts the conversion wait time for each
rejection mode. The 50Hz-only mode takes up to 163.5 ms at 1x, while the
previous fixed 150 ms delay only covered the default 50/60Hz mode.

Validated on a Raspberry Pi 4 running 7.3.0-rc4, over an IIO network
backend, with a DC1010A-A board (LTC2493), a DC1012A-A board (LTC2499)
and an LTC2497:
- LTC2493: 41/41 hardware tests passed,
- LTC2499: 36/36 hardware tests passed,
- LTC2497: 24/24 hardware tests passed,
- all LTC2493 rejection x speed combinations were exercised without
  conversion or I2C errors.

LTC2496 was build-tested only because no LTC2496 hardware was available.

The source in this series matches the hardware-tested tree.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v2:
- Restructured from six patches to three, following review from Nuno Sá
  and Jonathan Cameron: the FA/FB rejection infrastructure comes first,
  and the LTC2493 is then introduced complete in a single patch instead
  of growing a chip_info entry over four of them.
- The input count is modelled as a number rather than a bool, so further
  family members do not each add a branch (Jonathan Cameron).
- FA/FB is modelled as a 2-bit field rather than two independent flags,
  with the mapping helper removed (Jonathan Cameron).
- Addressed the locking, comment and churn review on the FA/FB patch.
- Behaviour is unchanged, re-verified by hardware regression on all
  three parts; see the validation summary above.
- Per-patch changelogs are under the --- of each patch.
- Link to v1: https://lore.kernel.org/r/20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com

---
Andrei Stancovici (3):
      dt-bindings: iio: adc: lltc,ltc2497: add LTC2493 support
      iio: adc: ltc2497: add FA/FB line-frequency rejection selection
      iio: adc: ltc2497: add LTC2493 support

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   7 +
 drivers/iio/adc/ltc2496.c                          |   1 +
 drivers/iio/adc/ltc2497-core.c                     | 227 +++++++++++++++++----
 drivers/iio/adc/ltc2497.c                          |  47 +++--
 drivers/iio/adc/ltc2497.h                          |  31 ++-
 5 files changed, 251 insertions(+), 62 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261009-submission-ltc2493-support-v1-86449ede432d

Best regards,
--  
Andrei Stancovici <andrei.stancovici@analog.com>


