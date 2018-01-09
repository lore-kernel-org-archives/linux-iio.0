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
Subject: [PATCH v2 12/16] dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
Date: Tue,  9 Jan 2018 10:33:43 +0100
Message-Id: <538e93d723d7755928ad118564a571371cb337b6.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

The AXP813 can have a battery as power supply, so let's add it to the
list of compatibles.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index c248866..4614c8e 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,12 +4,12 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp813-battery-power-supply"
 
-This node is a subnode of the axp20x/axp22x PMIC.
+This node is a subnode of the axp20x/axp22x/axp81x PMIC.
 
-The AXP20X and AXP22X can read the battery voltage, charge and discharge
-currents of the battery by reading ADC channels from the AXP20X/AXP22X
-ADC.
+The AXP20X, AXP22X and AXP81X can read the battery voltage, charge and
+discharge currents of the battery by reading ADC channels from the ADC.
 
 Example:
 
-- 
git-series 0.9.1
