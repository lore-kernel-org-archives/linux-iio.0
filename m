Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55C30DD11;
	Tue, 23 Jun 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230916; cv=none; b=teqEcB5bd+lKoSPNKuET7nZpQiSVpN8wUYcOw9KDZaGozc7Pxp01gTMh9lAo2oI8u0U/V3E98vzoslluJ1iA4hGabT622L+d2TXmVrYBgR3Xth0b3lOWTYDROPbDTC/OJQv9lBH7F2hqQ8+Y6kA6E1FpjlHMKTuDtyGyuTu8U8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230916; c=relaxed/simple;
	bh=RxvvIrWn/6wkhvP3V9MM9eHBVpFn2Xq4lJWH/BRzVFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LMRNsc39P1toIMFDA3/IidRBiPJy9R/+jS9mLKwq5xzP1vp5KS9HnjRT55GGXfchJ0vevULuGuwX2kGy/Tf/ASVd1HVgXT8oB/xUG2eW8Saxr00EhQBhN3ES2G0OPLIaNdqoKbX8cTgI4t4OsEMwqrLNbgK+ilfPndOuIK6GYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=geZLEkuw; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="geZLEkuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782230906; x=1782835706; i=lukas.metz@gmx.net;
	bh=7SjlYb0vXIyExb+MyafZT01AotT4yQ0/grBMUUp8uek=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=geZLEkuw5szAgJp3kVTKjBKSm5+F1KWrgsVgrUsmOHYXkzlOtE4k3UdldTYKHtHp
	 Joy1elq1jrKPVlicIFp1AN1pow4oD1CtAKOJzsisZAAeLipH/i14lW/u0K+CYJBR1
	 PRfvF0Bw6SuygakS+9PZoh6Wf6cH5y3tHB2LcLOnSDe+k0W/bGWQIAXCmmJdCVgyp
	 +lPhQfWBZ3JVZUAR3zb0/MeKblyzqWFTy33VKCNIpguON3nT/o0f5neVm+k3LEhoK
	 25EKvOP9OGc/rf1Mj2qvXAaj96aIb4S4sKsfDQZtn/b6Jx5UljBBsGk77HAb0Trif
	 +NPsTewNUJXVoYXOJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1xBw7h0w6h-00lDLd; Tue, 23
 Jun 2026 18:08:26 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Subject: [PATCH 0/2] Add driver for DAC8163:
Date: Tue, 23 Jun 2026 18:07:26 +0200
Message-Id: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAD6vOmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nj3ZTEZAtDM2Pd8vyibF0jQ2OLRHNz0yRTQ1MloJaCotS0zAqwcdG
 xtbUALOslF14AAAA=
X-Change-ID: 20260413-dac8163-work-2138a775b515
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782230905; l=1812;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=GTpGtMFf4FBmnGqbKP2PO7dmPxfA4Gcne6r7lNx7pDs=;
 b=bGjWVGebi+NsWneYwCkc1QN73rcaQ7LkmupiNvfMomNDk6Hm2yWaB/lSPktS6cQAiS7vArLmj
 G0rWSMuZxiVDx6ijxVTbR2oOvcISLEpoi7S2LCyWX2Zvm1weJygkG+6
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:5FulpitLyYkxqKIFL6KTKXFtf8j1JvJxplW5ZbM8qxiYsEwYKW9
 JLOtIYlqWEMVv1d7d420geBi64fJpz/lveLDCQeMhcsJSfLCD5rEGZlqqgoFQ8SCHmkelPF
 9jlb/N9Aby0kTed+gBq7LdHgaG3wZVy0KyJI0w7RmoAdqNofsa8ZA4UwpwRuZ030hMaqFWi
 Npy/6aWBOCzmO6Cl1gBdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UPIspjnz6NQ=;iKiWJ5k/j+Tw4ssp0SxC7jPquJf
 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

This series adds an IIO driver for the Texas Instruments DAC7562, DAC7563,
DAC8162, DAC8163, DAC8562, and DAC8563 dual-channel voltage-output DACs.

These devices are pin-compatible 12-, 14-, and 16-bit variants sharing the
same 24-bit SPI command interface. Each device provides two independently
addressable output channels and includes a 2.5 V, 4 ppm/=C2=B0C internal
reference that can be enabled via device tree, or an external reference
supplied through a regulator. The register and command structure differs
from already existing drivers which makes adding a new driver a
reasonable choice in my opinion.

The driver supports:
 - All six device variants via a shared chip info table
 - DAC updates in synchronous mode
 - Configurable internal or external voltage reference
 - Optional LDAC GPIO which has to be asserted permanently when using
   synchronous updates.
 - IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_SCALE attributes per channel

Datasheet (DAC8163):
  https://www.ti.com/lit/gpn/dac8163

The driver was tested with a DAC8163 on a custom STM32MP157F board with
external reference enabled.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
Lukas Metz (2):
      iio: dac: dac8163: Add driver for DAC8163
      dt-bindings: iio: dac: Add DAC8163

 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    |  75 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ti-dac8163.c                       | 339 ++++++++++++++++=
+++++
 5 files changed, 432 insertions(+)
=2D--
base-commit: 76b6720279964612111352ca5d09f5bd61e41ce4
change-id: 20260413-dac8163-work-2138a775b515

Best regards,
=2D- =20
Lukas <lukas.metz@gmx.net>

