Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094297;
	b=Wsm80Qc/t/FxZxR053y9XRKhcO4h1kLpMWvQF3upu/fc9g6b7UyzN5o7yeJIv+VtW7um
	 cvbqe2UFQDVu5ZK4j2saC7IZBE/UD+A64rRmVApDHxS6m5PA3du9M1P7nI3ebMYjMfPZO
	 hJZkP/IxtneXQLgU0AHFsW6/EnYKA6TXQum3kwony7lQmxspvyFFV9IsioKtjdcx/DjbS
	 QITQyCFPztU50x0JPwtBkKH43ANtuk/ADroTT0AY4G5V9yPRS1gLs9VR3T/V0uZtHcEcB
	 zKTHhDkAMHBsTVwDWn79XfAx3W/y19TlqsNdPhbGvcAayfbq+vn9qhZz4ZiFyEapJ5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094297;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=QhPNcCTXxIH6G/4ByFtsityMhAbYnRKhubcMsfn3Pdk=;
	b=s0epuT5UWrAjDDwLcqmJketAoIaWBSmo7H41BDuDxJgubSC9vm3air/QZnPzpsR00zjA
	 6Us2PAsugh+7R75QEA2gFgNvdTFEgMH4puEDoKrqnXL/H7Tz7mfwGNkzL9F/h73yi+B08
	 7qOZMsPKc8/al/EmdH6rBGJXeCmVdlOhJegzRfnx18Qdigs+KfVH7iaOXKMea75m2YcXD
	 BAnWDNQsy8ICDMPhmTnjzmZElEZEejaEfdXk+eLMikrYXA2scgr1mKLMOxX0Tb+2VFGFF
	 NcJ3O730rLvY3L0wIvB4r53jGkNeMzcsM6zYt0IpVsDV4pY8OTBkdRy4nwi3bp93I2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHf7WqOS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371F606A326;
	Sat,  7 Nov 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHf7WqOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C9D1F0089F;
	Sat,  7 Nov 2026 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094297;
	bh=QhPNcCTXxIH6G/4ByFtsityMhAbYnRKhubcMsfn3Pdk=;
	h=From:Subject:Date:To:Cc;
	b=RHf7WqOSl36K7/P3zexeq5Owhe1BGN9ZLsZ88NRbdr/GuaQOvOHM0dLAWwuyNzlyf
	 VnIbD3yk2tpRm1IxmxCZbEjViV//EczjwKXPbe5wrbkJ92B+L0QSlUFlMHpQ53traZ
	 eDNj6kS3NG+ig/XxBTIqlA3ItXV0ESkv/qrwtiordQk7xskT+c9xOSZ1q5ZYriGDWk
	 6OD8+jNr2bo7fEtzwrU8EyMNlkuxsy8gyN9IGVvC+xRUVl4kv9JCOPuVwuqOViGYuv
	 Ip75YeCar2MW2puQdYR8r/hjzq85GDSjHnYMzPXnx8wU52o+VpwR4gkGG2ydNjwXY9
	 veroMlMtaoC7w==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/4] iio: light: gp2ap020a00f: Add supplies and
 GP2AP030A00F support
Date: Sun, 08 Nov 2026 00:31:32 +0100
Message-Id: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MTQqAIBAG0KsM3zphtH+vEi3EpppNiUIE0d2D3
 gHegyJZpcDTgyyXFj0PeLIVIe7h2MToAk9w7DpruTdbciFxzWYcW26iWyLXAypCyrLq/VfT/L4
 fWNenCFoAAAA=
X-Change-ID: 20261107-gp2ap030-99504c2dc038
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Describe and enable optional core and I2C/interrupt pull-up supplies for
the GP2AP020A00F. Preserve compatibility with existing device trees that
only describe the LED supply.

Extend the existing binding and driver to support the GP2AP030A00F. It
shares the register layout, but has different proximity resolution
encodings and no automatic lux calculation. Select model-specific
initialization, keep reserved bits clear and expose fixed-range raw
clear and infrared counts. Keep generic supply handling in separate
patches from the model-specific binding and driver additions.

Assisted by LLM.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (4):
      dt-bindings: iio: light: sharp,gp2ap020a00f: Add supplies
      dt-bindings: iio: light: sharp,gp2ap020a00f: Add GP2AP030A00F
      iio: light: gp2ap020a00f: Enable the core and I/O supplies
      iio: light: gp2ap020a00f: Add GP2AP030A00F support

 .../bindings/iio/light/sharp,gp2ap020a00f.yaml     | 20 ++++-
 drivers/iio/light/Kconfig                          |  6 +-
 drivers/iio/light/gp2ap020a00f.c                   | 88 ++++++++++++++++++++--
 3 files changed, 100 insertions(+), 14 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-gp2ap030-99504c2dc038

Best regards,
--  
Linus Walleij <linusw@kernel.org>

