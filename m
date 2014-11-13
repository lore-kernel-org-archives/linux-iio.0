Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:60140 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbaKMOQN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Nov 2014 09:16:13 -0500
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Jonathan Cameron" <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <Pawel.Moll@arm.com>, <Mark.Rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<Naidu.Tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v3 3/3] DT: Add a vendor prefix for Cosmic Circuits
Date: Thu, 13 Nov 2014 11:14:00 -0300
Message-ID: <1415888044-16635-4-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

