Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de,
	matt@ohporter.com,
	pantelis.antoniou@gmail.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 1/2] devicetree: add PulsedLight vendor prefix
Date: Fri, 31 Jul 2015 20:58:03 -0700
Message-Id: <1438401484-22101-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438401484-22101-1-git-send-email-mranostay@gmail.com>
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 181b53e..e466902 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -163,6 +163,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
1.9.1
