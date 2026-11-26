Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680713;
	b=WWMjUEMnV1rPCZIpNOPjqyHi1E2HpMGIRkkcKqxBxvEFnrVEKcSj442K+UsvWqMNTMr1
	 GLHkK7wR6zSRPsFOaCt+Eo9WVrHua99slXFoGtPyVzD2fw7fRHCWIF3kANEEjGh/As8MK
	 ESpXlRmGeEqXBevdRfxLMqrQ10sq7CXvCMpTFteHRT5gnq66uhaaEWMS8vNDVklsJpPEV
	 Z5dxawlSWSvQGsid0+Xu2WQQAjE+LCXbt1YyBD93MoxrAko6LhplB12ZNkIr1LoaDMUkK
	 vAlQCnTfro/4QUVzPN0mtypoUfqKsC63csA4iiFqppbaUWQ5uTvaOdeyAQPjnr03XWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680713;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qS0qQWCBaGoqQJ4yzdVeAx2982yYGUh5X7QjAiHCBVQ=;
	b=0+y1fLFbPlxwBmIgj/JB2Xs2Cp+DvOAeIlLo87E3StFf0Xnub/Sv1Qr6IKt250Z6Wy3w
	 I0VCyPrNa8vqE8gcHZc3Ad7NtPoCArof4ROobNQoWM0eRtXGmnnavjMYJYB7Eg0gAgKJ3
	 tBLIi6CB93H7dcTyVDl9x4FthYoQCWgB1vAR/tivI74SDN4EIKrZ/2W+MlW2zb81qCNHt
	 lzZUXR7cmKkOqlMZC/dIjgDlgg1s40ZuMUVNBXs+WHyrdnswI3w5yBbv54/mcrYKXvl1Q
	 Mh8rhsRbAy6kOnkOy5/MtDDCmleGQcP3P1MhpXVYSOEbSITPCjyq6E0G2Ct+Qr51wLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrEhG3zx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFE606A31E;
	Thu, 26 Nov 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrEhG3zx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795680713;
	b=ECrnpiM+oScB1mam0GXib9Fk7/O6iPSrjH5rpM2Gv56EckGfIAqXlewvYw5RD2vrMYRx
	 80JNSh3TQlCGBXLY/lukiYr2K20IWCWfrMrSqogKf6RBOF3NBOIwWHiWH1oARmOkbbyQE
	 5k5iGqnQfdw9K9aTr6qAkOoL2PTmVd8e6LfCrPrzNqToNeMa1toLjYLGArWRKMBzfYRGR
	 gmwmb0C6t8jof9r5gPq9mQR9pkzRSGP870hGT1Ckaj+YGq26mQkY0AZhRSuB/C+a9XDvs
	 gnV4ZfMIF59sznhKda0FVH/lk3CYZcxCF43AHcllOojCMM43FN0jgXKUrSlcMRUQSLA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795680713;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qS0qQWCBaGoqQJ4yzdVeAx2982yYGUh5X7QjAiHCBVQ=;
	b=fZWntgLAOMABObaR+B3FEZu0BGkPPLKqKu8mzzwzPV8ELPvy+tf56i8m2dDKx/gNEavG
	 03STEeyJbk8UIkNH1C/xq9ueaGE+LMqYyeWo223MkED4Qo6Q0uwjytjI3ef1qpXnnV+ZR
	 TZyqUA76+DOp3mO/oTEeKEHJ+2+Fyl5cOKT2COtW4GXspu8bapLFALSdouho/LF2X+2Wc
	 nLlV/xM7gQaBal+F35Ph0edASNmyt+qpXMrdVyi44a+GU4HGTtymiT2F3nVEeOaPBjPjC
	 bCtS0bSJAAsf8Ojc5dYdxeTRfsFSpULk2/mc9JBgoEuG1tADWiCogjTRKbu4kYzAEPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13C801F000C4;
	Thu, 26 Nov 2026 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680713;
	bh=qS0qQWCBaGoqQJ4yzdVeAx2982yYGUh5X7QjAiHCBVQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GrEhG3zx98S9qFRiAEb8WHPiBVgQbjO+bAft5mf6X5bcURrVry/3V3i9xCge0WqDs
	 bm9AcSyBrR29YqkK6h+gHP9TPnU1YFZB7LwJzF3w12CR5xGNeJspJcSq63v8Tabz+j
	 YYhiGW1b9xzIRr/r2LG5+ZpCgWQaWZi7Agy24/Tjauhu/4Wxm26LFcRFn8LyQjBGar
	 WQNmw08C8LLpeEo5+4HGx7z49fCHrmKt4miZlWtR6r4WEWEW06tuxwFKgiATCQF1JU
	 /Q4xLjj1nrowGxTduVsVv51ki3W7SSN84RFaMNHZNaTgMzbhHgiSyLq+gdBEaDYfea
	 5bzmDqs0DeLhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5428C4D2D9;
	Thu, 26 Nov 2026 08:11:47 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] iio: light: add support for ams OSRAM TCS3430
Date: Thu, 26 Nov 2026 09:11:46 +0100
Message-Id: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAMLpB2sC/22Nyw6CMBBFf4XM2pp2Wh668j8Mi1oGGCPUtEg0h
 H+34NblSc49d4FIgSnCOVsg0MyR/ZgADxm43o4dCW4SA0oslEIjmL2YXNRGS4FtrqvylGNJDaT
 FM1DL7712rX8cX7c7uWlLbEbPcfLhs9/NavP+l2clpJAtWl3ZwhqnLt1g+XF0foB6Xdcvl5vYH
 bgAAAA=
X-Change-ID: 20261124-iio-tcs3430-2f53879527ed
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795680706; l=1886;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=0+sMFzcSS5li54XaXhcSaRKdwk6n5ZYNxtJoIRuT8+w=;
 b=IQt15XFVbKpTHfAvNrLLYxYqKjbJVOjn7rOzdu8KdFeKTFNicWObXDqbUXEz4JMM+WB1qTQuf
 WdOgC+K3Rx6AMAUoYJd3B7g+J0Gg7rORW36s9QLYfxhPWT0zTjCuPjZ
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com

Add Devicetree binding documentation and an IIO driver for the ams OSRAM
TCS3430 ambient light and CIE 1931 XYZ tristimulus color sensor.

Tested on Microsoft Surface Pro X SQ2 (SC8180X), where the sensor is
connected on I2C at 0x39 and used for ambient light sensing.

Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Changes in v2:
- Replace hardwaregain control with standard IIO _scale and configurable
  integration time using the IIO GTS helper (Jonathan Cameron).
- Hold data->lock across the entire IIO_CHAN_INFO_SCALE path in
  tcs3430_read_raw() (Jonathan Cameron).
- Convert register I/O to regmap_i2c (Joshua Crofts).
- Wrap guard(mutex) declarations in tcs3430_read_raw() switch cases in
  enclosing blocks to fix Clang -Wjump-misses-init / cleanup scoping
  (kernel test robot, Joshua Crofts).
- Use switch(mask) in tcs3430_read_avail() and tcs3430_write_raw(), and
  drop unused linux/mod_devicetable.h include (Joshua Crofts).
- Drop redundant L: mailing-list line from MAINTAINERS (Joshua Crofts).
- Pick up Krzysztof Kozlowski's Reviewed-by on dt-bindings.
- Link to v1: https://patch.msgid.link/20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com

---
Robert Ijtsma (2):
      dt-bindings: iio: light: add ams OSRAM TCS3430
      iio: light: add ams OSRAM TCS3430 XYZ and ambient light sensor driver

 .../devicetree/bindings/iio/light/ams,tcs3430.yaml |  52 +++
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tcs3430.c                        | 489 +++++++++++++++++++++
 5 files changed, 560 insertions(+)
---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261124-iio-tcs3430-2f53879527ed

Best regards,
-- 
Robert Ijtsma <robertijtsma@gmail.com>


