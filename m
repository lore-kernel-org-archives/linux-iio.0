Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280E3DD51B;
	Fri, 10 Apr 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838993; cv=none; b=GS8Y3+20n5aLrst/eoB+DSNTGFhgf8w3cua/1x7rGbiXb5Z0gVrnO6mWCe+Km4FSwd4dcXYNhpbNT5+NXsYsT/ieW4B2OMtt8mxapxAWyRIe7Yl8d5JFX4OiaJJ5Rhuq/1VMMl74sJz/uQsDx5DeeesjA5jUG+2S5z+4iOmn//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838993; c=relaxed/simple;
	bh=MHsuapnVqVvtErwyI+RLIPBL2U+Tz9GyW/nkEUEMkhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0N7sKok0+1lOyRDJhXD80c4oKFCvK7cT1YaDoV2qI4XOtZdnRgwciNquSKYu+fVdwedoTn6DxmJkIrCN85JFO3Na2ApWObK3X0SfMEEO3iQpskoPw3a39YTCCNjoY9xohANFolfv2hs2nakPl6rr7b/ecyLAzgaHNW9WR+g6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: uxruXWlLRKmiakba6A6Wig==
X-CSE-MsgGUID: bp8J//fcReioQBLYlud6ag==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 01:36:23 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C7AFF400CD4C;
	Sat, 11 Apr 2026 01:36:17 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 00/10] Add MTU3 for RZ/T2H and RZ/N2H
Date: Fri, 10 Apr 2026 19:35:20 +0300
Message-ID: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have an MTU3
block. Add support for them and fix the non-existing TCIU8 interrupt.

V2:
 * reword to mention that TCIU8 used to exist
 * squash "move required resets to conditional" into
   "document RZ/{T2H,N2H}"
 * disable the resets in the else branch of the condition

Cosmin Tanislav (10):
  clk: renesas: r9a09g077: add MTU3 module clock
  mfd: rz-mtu3: use device-managed reset deassert
  mfd: rz-mtu3: use device-managed mfd_add_devices()
  mfd: rz-mtu3: store &pdev->dev in local variable
  mfd: rz-mtu3: make reset optional
  dt-bindings: timer: renesas,rz-mtu3: remove TCIU8 interrupt
  dt-bindings: timer: renesas,rz-mtu3: document RZ/{T2H,N2H}
  arm64: dts: renesas: r9a07g0{43,44,54}: remove TCIU8 interrupt from
    MTU3
  arm64: dts: renesas: r9a09g077: add MTU3 support
  arm64: dts: renesas: r9a09g087: add MTU3 support

 .../bindings/timer/renesas,rz-mtu3.yaml       | 26 +++++--
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  5 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  5 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  5 +-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 68 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 68 +++++++++++++++++++
 drivers/clk/renesas/r9a09g077-cpg.c           |  1 +
 drivers/mfd/rz-mtu3.c                         | 39 +++--------
 8 files changed, 173 insertions(+), 44 deletions(-)

-- 
2.53.0

