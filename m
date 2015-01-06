Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Jonathan Cameron <jic23@kernel.org>, James Hartley
	<james.hartley@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>,
	<robh+dt@kernel.org>, <Mark.Rutland@arm.com>, <knaack.h@gmx.de>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<Pawel.Moll@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v7 3/3] DT: Add a vendor prefix for Cosmic Circuits
Date: Tue, 6 Jan 2015 17:47:37 -0300
Message-ID: <1420577257-10846-4-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1420577257-10846-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1420577257-10846-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..014770f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -36,6 +36,7 @@ chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
 cnm	Chips&Media, Inc.
 cortina	Cortina Systems, Inc.
+cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
-- 
2.2.1
