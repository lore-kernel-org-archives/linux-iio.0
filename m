Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174175;
	b=tLgrNWnoiYnGKAyP+NIBlH4McCGs/9tMcisG6pVzDDfT3XKACR3A9e5Uhs6njer0fKSV
	 bYWf/Q54mD9lqGZU0b+KERxaVtsssGdPNgZUYzjXZd+llMM9x0SZfQoMBanmckvBuqIxw
	 i7NX83fmlLFjWA2qoNPf/t2idOwRB2Rw0obiFgto8qATl1TNteVmGQL7vVt1rwWI5mX+n
	 Gyu1y/iucBc485gUOVOsvGM4W8H1IiOKTNRCeiY7T7VbCONsilrUVo9mUEv9J8xGSaHtZ
	 G1CUo3LQtCFJXdTG7QfDBkYL0PyJ8IHBbWyWbtpTF3Q5MZb2mLRIjrCPnluB+qeAqKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174175;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=rlJc4keRK6GaSsiQevuIQLXi+2Lt/suk1mQdTtafZTM=;
	b=q+Oy6D28TxSlkr3WaUShvlqWKFWyt4zIMXpL1Zy2aQCHECog3lKhuMVveR3NmH8OzST3
	 2WEEWgAjHJZN44E5dR4Jv5ESC33s5OZ7DmpKLBdENe+kuP8WovTg3qAPDS9I8T5V1IEPc
	 lEx5GOokXOnfPQBi0cIzg0YNjtlagQGkUXBalkWeZPKsxw5nKygp6RNj5LtgvTXbJrOPt
	 P5Z6nALq8Eoo7xg2yWg9cp7QwfgQLquvtYV90fRfVqdywvfZVElLg2aafzz1v8BoPnpUH
	 sBDir0mB4/tK3O2oNRXvmuNDhDH6cmLTMoqesHqqOZXuoh/GzwTcgUwY7rGpXxR6ceg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+qDtJPx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08905606A331;
	Fri, 20 Nov 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+qDtJPx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795174174;
	b=xi4LXMD9JNPiJBJgCm5nW7KWPzSbomuM0384c0Hn+4E2H6+DGLcbQWU+jyhJujBETRAR
	 X26xVWvrzemo7SDmvbGIr+INDzVRfOTu/IYpLOw2WU9CLnMIIHRREInp7fY5rcnnZ2LC/
	 gvF7N3FT3cF8pMCHLpPaIc49xIOIpUuY2kUmifvHPYp68RyorVg0M29o9g3gFGcSQEm5M
	 YYF8mp8FVMefRbTcxTvX2RKavGaLL7APwyqoXoWJPJ6F1xC4Laww5Y+swtU2z6RnqaXE1
	 AhRcLIiZ5UkwohpTZPz/UCcvYg3fLUm58SxLgMF+qQGNdt1hBcvB4wqecGSRvciDJBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795174174;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=rlJc4keRK6GaSsiQevuIQLXi+2Lt/suk1mQdTtafZTM=;
	b=rn0xJV7FcXEAOg5JDMp8P52f7j2ac5BPY+RFhRINz418+gio2zt2VYzXTXBnl4gjz4nu
	 OvkXsPgJFV21SEry37m6f9Rj2AmTuGTJprG2CBaEYuJjRfyBNttfESGuUIP5OnJOfZf2s
	 WN4MrwdBTamOUdskKggBI0XcPt8GXV7+iU2mHYN6ibF66Mt7OzmV6PRojJX/grj98PGsz
	 zSv3ifaS3U76GFBJKVGrlr9lK1NDlyTuDxX4GpbNYMV1XEYeKmpgzL+SdtjigBv44O+fu
	 N+uXE1yf0jjbt+Or20TdXhogLlSQ8yCMm+xE3pndclQndccchSXvC8de+u6ZBKxfP5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 85C321F000EF;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174174;
	bh=rlJc4keRK6GaSsiQevuIQLXi+2Lt/suk1mQdTtafZTM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=g+qDtJPxdC0ZXfU4aB4m1RLmeGPhux4kX39vWLgnyTFwE6rXZnosHsHMtdocA82UI
	 gGl6h7A+CWt1Ku99Z3DR35ykzAXCKcsuyhdc1wgMoS70f/jCeM2/+XiaXpMlPaiGRP
	 hZSVLu2/ZU3J6mAuMWc5HbeKhONpo5mRgWxnxRfsJh2SSmIFkGytn6OU7YC6Fesru8
	 9fEG1pk6Ro4ZipOYcsORcjX/wt6fPo4fwxJqxEockw3BIujOkMwrO5cqW95s6qRk22
	 rYBcgIqqI1eeU43u79vAhCdNeevVNKfNhiOcO2Ma4BcZSiuBmksXYEwiPrJsDVrvLC
	 /RAKFvIbyrVrg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 12C8049849;
	Fri, 20 Nov 2026 11:29:24 +0000 (UTC)
From: ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org>
Subject: [PATCH 0/2] iio: adc: ad7124: support boards without RDY interrupt
Date: Fri, 20 Nov 2026 12:26:46 +0100
Message-Id: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
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
X-B4-Tracking: v=1; b=H4sIAHYuAGsC/yXMTQ6CMBBA4auQWTtJ/5DEqxgXpTPgsCjSqjFpe
 ncKLr/FewUyJ+EMt65A4q9kWWODvnQQnj7OjELNYJS5amUVehq0cRhXlLQhMVnTE3vnA7TmlXi
 S3/m7P/7On3Hh8D4mUOsO9FM0enEAAAA=
X-Change-ID: 20261030-ad7124-no-irq-ded325dea4ac
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ILYAS NHASSE <ilyas.nhasse@skf.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174009; l=2214;
 i=ilyas.nhasse@skf.com; s=20261120; h=from:subject:message-id;
 bh=bCTZjYQqzky+qnBbt4zskphWPNqvvqYylRoFceegAkA=;
 b=XrY+1DgQTQzurTiTdSTmcm2xbCafCOp+fgphvI9Sdr68cWSlgcAzHQ0S0v3/6l961U9KUrQW9
 DiR4X2m1IMFBZIeDWzoRtypKA/63hisWMA2Bnf8KTVotSgINX18KNV4
X-Developer-Key: i=ilyas.nhasse@skf.com; a=ed25519;
 pk=DeEyhWzUoP0HCAWFV/8oy5EFF+41tZxPpWZhfGyiMS4=
X-Endpoint-Received: by B4 Relay for ilyas.nhasse@skf.com/20261120 with
 auth_id=1581
X-Original-From: ILYAS NHASSE <ilyas.nhasse@skf.com>
Reply-To: ilyas.nhasse@skf.com

Boards may wire the AD7124 DOUT/RDY pin to the SPI MISO line only, for
instance when the ADC sits behind a digital isolator that carries just
the SPI signals. Such boards can't use the driver today: the binding
requires an interrupt, and the sigma-delta core can't probe without one.

The end of a conversion or calibration is also reported by the RDY bit
of the status register. Analog Devices' no-OS driver waits for AD7124
conversions and calibrations this way (ad7124_wait_for_conv_ready()).

Patch 1 makes the interrupt optional in the AD7124 binding.
Patch 2 lets the sigma-delta core poll the RDY bit when there is no
interrupt, for single conversions and calibrations. These devices then
only support direct mode, as the RDY interrupt is the only trigger of
the triggered buffer. No AD7124 driver change is needed.

The polling applies to every device with registers, but only the AD7124
binding is relaxed: the other bindings still require the interrupt, so
boards using them are not affected.

Open questions:
- Poll period: 20 ms, a fifth of a conversion at the AD7124 default
  10 SPS. On our board the SPI clock runs at about 6 kHz through the
  isolator and the controller uses PIO, so each status read costs about
  2.7 ms of CPU time and the period directly sets the CPU load during a
  conversion.
- Should polling rather be opt-in per driver, with a flag in
  struct ad_sigma_delta_info?

Tested on a TI J721E based board with four AD7124-8 on one SPI bus
behind an isolator, without RDY interrupt: direct reads of all channels
with an equivalent implementation on a v6.12 based kernel. The polled
calibration path is build-tested only.

---
ILYAS NHASSE (2):
      dt-bindings: iio: adc: adi,ad7124: make interrupts optional
      iio: adc: ad_sigma_delta: support devices without RDY interrupt

 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |  1 -
 drivers/iio/adc/ad_sigma_delta.c                   | 47 +++++++++++++++++++---
 2 files changed, 41 insertions(+), 7 deletions(-)
---
base-commit: 7d80b4b383bc53b48abd3a30ca4a91cdab568bfa
change-id: 20261030-ad7124-no-irq-ded325dea4ac

Best regards,
--  
ILYAS NHASSE <ilyas.nhasse@skf.com>


