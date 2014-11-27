Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Jonathan Cameron <jic23@kernel.org>, James Hartley
	<james.hartley@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <Pawel.Moll@arm.com>, <Mark.Rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH v5 3/3] DT: Add a vendor prefix for Cosmic Circuits
Date: Thu, 27 Nov 2014 12:39:22 -0300
Message-ID: <1417102762-5123-4-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1417102762-5123-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1417102762-5123-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d..1bfa13a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
 cortina	Cortina Systems, Inc.
+cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
-- 
2.1.0
