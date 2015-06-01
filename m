Return-Path: <vladimir.barinov@cogentembedded.com>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt: Add vendor prefix 'holt'
Date: Mon,  1 Jun 2015 15:20:37 +0300
Message-Id: <1433161237-22078-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

Add Holt Integrated Circuits, Inc. to the list of device tree vendor prefixes

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..7101f400 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -93,6 +93,7 @@ haoyu	Haoyu Microelectronic Co. Ltd.
 himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
+holt	Holt Integrated Circuits, Inc.
 honeywell	Honeywell
 hp	Hewlett Packard
 i2se	I2SE GmbH
-- 
1.9.1
