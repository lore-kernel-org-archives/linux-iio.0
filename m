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
Subject: [PATCH v2 06/16] mfd: axp20x: make AXP209/22x cells probe their ADC via DT
Date: Tue,  9 Jan 2018 10:33:37 +0100
Message-Id: <3b801d1dada3d9604311f65033343a14260cc7ae.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

This makes AXP209 and AXP22x ADCs probe first via DT and then by
fallback via platform.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index d8c92fb..e0cbaea 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -659,6 +659,7 @@ static struct mfd_cell axp20x_cells[] = {
 		.name		= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-adc",
+		.of_compatible	= "x-powers,axp20x-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp209-battery-power-supply",
@@ -683,7 +684,8 @@ static struct mfd_cell axp221_cells[] = {
 	}, {
 		.name		= "axp20x-regulator",
 	}, {
-		.name		= "axp22x-adc"
+		.name		= "axp22x-adc",
+		.of_compatible	= "x-powers,axp22x-adc",
 	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp221-ac-power-supply",
@@ -707,6 +709,7 @@ static struct mfd_cell axp223_cells[] = {
 		.resources		= axp22x_pek_resources,
 	}, {
 		.name		= "axp22x-adc",
+		.of_compatible	= "x-powers,axp22x-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp221-battery-power-supply",
-- 
git-series 0.9.1
