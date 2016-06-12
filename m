Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] devicetree: add Sensirion AG vendor id
Date: Sat, 11 Jun 2016 22:13:16 -0700
Message-Id: <1465708397-19649-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a7440bcd67ff..70ee5f5c5291 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -225,6 +225,7 @@ sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
 semtech	Semtech Corporation
+sensirion	Sensirion AG Switzerland
 sgx	SGX Sensortech
 sharp	Sharp Corporation
 si-en	Si-En Technology Ltd.
-- 
2.7.4
