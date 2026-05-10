Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F1DDCD;
	Sun, 10 May 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418091; cv=none; b=baPWZje371RjlfzE/gZkyukXb4G6oaXpca/xYqGRuJUeO9AGvNtQIUxpnN79dmO8EJXL3s257mppkR+xY6aBuwGXdjwneEVohGLGO9NXksS7JS0xHUg4o6inr5oN5VFYMD54HwUR2UF/Io0PFGLOoqQJyCZzRdAgAzVvb+Dn7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418091; c=relaxed/simple;
	bh=P8xM934ybSF+ohjTs7dFZU1OSOviwUGH/0T5IT1lDBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XHTQNyrHvClXAZZthqJE2QVaT1f/G1vo0t4uIgZTaNGP1CKjBPMZ7UTP74Z7MMKI5yMKklbUa14jqGEvYtYh2YH8shErYyTpza3bC7J37COw51NvVEOg+aGV5jehL4TTHFrwuhHFyrXTJ0E/XsXiA22GOm/iWpvGPj7PsO7X2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=KSJHJyIh; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="KSJHJyIh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dvPq9iN8WATQt+rdmec5wkojG/hdk2qbLAicxWxCraE=; b=KSJHJyIhqtwZK183YrflR2asdT
	k2LXD7nUtrNDhaNUyE0Fvruuxs32UT6+NlPSWReI4RD9uQXQzsUfy0TBOJ2FADcwmJtgiG+gCj1fR
	ro8hXdhmUbvlok6Asy+tHN8sy6NdV3x0mH9XPEBZdHbM6w3VicFjoVqbXroEEGHvkaQsBjzuwQbU0
	QINXHjMXwPwixEnkn+yTjNE9KeD1L8N2z+zE22N3jRZsTI34Gothiub9zAkUdXtq6bbHw8bqKWVMk
	tlilg251WkUI8MMttCirxhmLGDySw1mc7FoNp/Kl1B7VHcKiTTQG2uw3qsQi60i7LNHtMJ88mG2K6
	WjEt2XTQ==;
Received: from user-188-33-36-99.play-internet.pl ([188.33.36.99] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wM3mL-0000000DItk-1dvg;
	Sun, 10 May 2026 15:01:05 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Subject: [PATCH 0/3] Add GPADC support for A523
Date: Sun, 10 May 2026 14:57:21 +0200
Message-Id: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGAAGoC/yXMQQ6CMBBA0auQWTtJKZaqVyEsxnaAcVFJBwgJ4
 e5WXb7F/wcoZ2GFR3VA5k1U3qmgvlQQJkojo8RisMa2xhmPuqZdkJxtcJwpBqxv/k7k4uDdFUo
 2Zx5k/y27/m9dny8Oy/cD5/kB3EBfXXQAAAA=
X-Change-ID: 20260507-sunxi-a523-gpadc-1879aa5df754
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778417853; l=1053;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=P8xM934ybSF+ohjTs7dFZU1OSOviwUGH/0T5IT1lDBI=;
 b=OETFZqziFi/khRjPAfcStRkuugnTEDXQMcPrtnQGDrWSAub17ffGZ1Uj/F6EkA9sY8ZRDlXfk
 SbJoPEbAApJCoQYjifz/aMbH9l79sSYwYiA4i5GpL7wAPWmf+dIxxFD
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Add support for Allwinner A523 GPADC in sun20i gpadc driver and describe
corresponding node in dts for A523 SoC.

A523 uses same model as existing driver except it has two clocks.

Added support to enable more than one clock in the driver, extended the
binding with new compatible and wired up dts node for A523 which uses D1
as fallback compatible.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
Michal Piekos (3):
      dt-bindings: iio: adc: Add GPADC for Allwinner A523
      iio: adc: sun20i-gpadc: add A523 gpadc support
      arm64: dts: allwinner: a523: add gpadc node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 37 +++++++++++++++++++++-
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 12 +++++++
 drivers/iio/adc/sun20i-gpadc-iio.c                 |  8 ++---
 3 files changed, 52 insertions(+), 5 deletions(-)
---
base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
change-id: 20260507-sunxi-a523-gpadc-1879aa5df754

Best regards,
--  
Michal Piekos <michal.piekos@mmpsystems.pl>

