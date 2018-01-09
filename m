Return-Path: <SRS0=s4UA=EE=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	wens@csie.org,
	sre@kernel.org,
	linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com,
	lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	linux-sunxi@googlegroups.com,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 14/16] mfd: axp20x: add battery power supply cell for AXP813
Date: Tue,  9 Jan 2018 10:33:45 +0100
Message-Id: <9f360d2724893421f5a8838639bbd9370361f61a.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

As axp20x-battery-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index d112414..1175091 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -887,6 +887,9 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp813-adc",
 		.of_compatible		= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
 	},
 };
 
-- 
git-series 0.9.1
