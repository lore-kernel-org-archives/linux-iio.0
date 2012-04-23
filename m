Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net,
        linux@arm.linux.org.uk, jic23@cam.ac.uk, gregkh@linuxfoundation.org,
        swarren@nvidia.com, olof@lixom.net,
        devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 1/4] devicetree: Document Intersil Corporation vendor prefix
Date: Mon, 23 Apr 2012 17:41:33 +0530
Message-Id: <1335183097-21104-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1335183097-21104-1-git-send-email-ldewangan@nvidia.com>
References: <1335183097-21104-1-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Change the vendor prefix for Intersil Corporation to "isil".

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 107d8ad..5c78eb2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -23,6 +23,7 @@ hp	Hewlett Packard
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
 intercontrol	Inter Control Group
+isil	Intersil Corporation
 linux	Linux-specific binding
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
-- 
1.7.1.1
