Return-Path: <SRS0=P9Ek=BK=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] dt-bindings: iio: health: Use binding name for max30102 in example
Date: Wed, 11 Oct 2017 11:09:08 +0200
Message-Id: <1507712948-29300-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1507712948-29300-1-git-send-email-pmeerw@pmeerw.net>
References: <1507712948-29300-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 Documentation/devicetree/bindings/iio/health/max30102.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/health/max30102.txt b/Documentation/devicetree/bindings/iio/health/max30102.txt
index c695e7c..8629c18 100644
--- a/Documentation/devicetree/bindings/iio/health/max30102.txt
+++ b/Documentation/devicetree/bindings/iio/health/max30102.txt
@@ -20,7 +20,7 @@ Optional properties:
 
 Example:
 
-max30100@57 {
+max30102@57 {
 	compatible = "maxim,max30102";
 	reg = <0x57>;
 	maxim,red-led-current-microamp = <7000>;
-- 
2.7.4
