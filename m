Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D112FF69;
	Sat, 16 May 2026 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909714; cv=none; b=TAsXnkJIP4yx9p7gy5IucVWKgWB6CtapNQwFSe1cEQKp3wS1hpBfdLiwFtXipGK6Q9Iukw8RGMXENO0IItQUCdV566r5SrrXBp1Oj8VvN7h1lSU5z6V8Mhb4I3Cu5+WjJfTbYtdFVEnBwBNHCsw5C7xvPSq4aZwm5V6vE4zlofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909714; c=relaxed/simple;
	bh=8GoHeq9jR+/2KxfeL+lHcdywJFQkb502/IOBEjFLrJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CgTVL4Pa0rORlxS8R64KmZnDyUN/l23d8ceF0mQ+zI81dNrQ/t77Bw9IruAek+fcjOafsQHDpUXQOTv7rbPSfKIjlS1xemT/EvRouMILHnHgBGRp3pRUGE/k6nei/gI2OOHUSyW+btPZRiZms6BXFBPSsl/HLebBjkmzUd4zeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=B1KrSNTf; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="B1KrSNTf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IAiw1WCrW9eFilDGxnRI0+TcsuxqhR+PLAhpGbnPnBI=; b=B1KrSNTfg3tI+U7X15zpEzRQPk
	zd2maOxtwHG8791lXzGr2gk5e0gO3jbZoicb2nkKiMWQ19yMlbCKbth71maitPhFaH7oVYubm0vqq
	B1awmDli0kYzK0wPdJoBJK+0piBDI37LqdEgliDKGsK1DC1O7uziXxtBcVtwAjWBPfdL1iyKH+Aak
	9tYY6XsgSls7Qp9Yx08g6WbQpejvMko7dpQefP5m5F/Q2ohFouO23U1mlir1dVo0MaMD3QlYWx6JN
	AGUPr6bdvB/qoHaSJBCujDFxrIvPdnoVOW0WH1OKtclKK6k/DSPWmmBVNISC2TgMSm9ycd7Ii01Ir
	QYt9wcug==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.3)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wO7g2-0000000GasF-0t1M;
	Sat, 16 May 2026 07:35:06 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Subject: [PATCH v3 0/3] Add GPADC support for A523
Date: Sat, 16 May 2026 07:34:13 +0200
Message-Id: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANUBCGoC/23NQQ6CMBQE0KuYrq35LRTUlfcwLgr9hRqBhg8EQ
 ri7BV0YdTnJzJuZEbYOiZ13M2txcOSaOoRov2N5qesCuTMhMwkyAQUpp74eHddKRrzw2uRcHNO
 T1srYVMUszHyL1o0beb29MvXZHfNuddZG6ahr2mn7HMTae/MCfvlBcOCxTTKwMQDY7FJVnibqs
 KKDf7D1YpCfSPQHkQExCq1BoYTR+TeyLMsTPrgiBQsBAAA=
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
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778909655; l=2320;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=8GoHeq9jR+/2KxfeL+lHcdywJFQkb502/IOBEjFLrJI=;
 b=gt2LAeGzMxoGrrckQQX49mfSrf88U060DBS/Zb3T9J7WJN8StEtOUlcjWP7+fGGa0e60Fx6wn
 B7RnkDO0a/rAVi9jBXvTL5wnL/gGCVscyKy4/0dV+wjCUohLVMuKoig
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Add support for Allwinner A523 GPADC in sun20i gpadc driver and describe
corresponding node in dts for A523 SoC.

A523 uses same model as existing driver except it has two clocks.

Added support to enable more than one clock in the driver, extended the
binding with new compatible and wired up dts node for A523 as its own
fallback compatible.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
Changes in v3:
- More granular handling of devm_clk_bulk_get_all_enabled() return value
- Added #size-cells and #address-cells to node description
- Fixed formatting
- Link to v2: https://patch.msgid.link/20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl

Changes in v2:
- Handle scenario when 0 clocks has been defined
- Fix copy&paste sentence in 3rd patch commit message
- Moved status as last property in dts node
- Make A523 its own fallback compatible
- Removed redundant maxItems/minItems properties from binding
- Link to v1: https://patch.msgid.link/20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
Michal Piekos (3):
      dt-bindings: iio: adc: Add GPADC for Allwinner A523
      iio: adc: sun20i-gpadc: add A523 gpadc support
      arm64: dts: allwinner: a523: add gpadc node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 32 +++++++++++++++++++++-
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 13 +++++++++
 drivers/iio/adc/sun20i-gpadc-iio.c                 | 13 +++++----
 3 files changed, 52 insertions(+), 6 deletions(-)
---
base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
change-id: 20260507-sunxi-a523-gpadc-1879aa5df754

Best regards,
--  
Michal Piekos <michal.piekos@mmpsystems.pl>

