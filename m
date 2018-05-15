Return-Path: <SRS0=y68c=IC=linux-m68k.org=geert@kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Kosina <trivial@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] dt-bindings: iio: afe: Spelling s/mesaurement/measurement/
Date: Tue, 15 May 2018 15:06:24 +0200
Message-Id: <1526389584-19835-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt | 2 +-
 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
index 0ddbaebba8ceca13..821b61b8c542ff92 100644
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
@@ -2,7 +2,7 @@ Current Sense Amplifier
 =======================
 
 When an io-channel measures the output voltage from a current sense
-amplifier, the interesting mesaurement is almost always the current
+amplifier, the interesting measurement is almost always the current
 through the sense resistor, not the voltage output. This binding
 describes such a current sense circuit.
 
diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
index 8e7b3e408a5253c5..0f67108a07b6327b 100644
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
@@ -2,7 +2,7 @@ Current Sense Shunt
 ===================
 
 When an io-channel measures the voltage over a current sense shunt,
-the interesting mesaurement is almost always the current through the
+the interesting measurement is almost always the current through the
 shunt, not the voltage over it. This binding describes such a current
 sense circuit.
 
-- 
2.7.4
