Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34188 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbbG2M5O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 08:57:14 -0400
Received: by wibud3 with SMTP id ud3so219557848wib.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2015 05:57:13 -0700 (PDT)
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
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v3 2/7] dt: Add vendor prefix 'holt'
Date: Wed, 29 Jul 2015 15:57:10 +0300
Message-Id: <1438174630-19180-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Holt Integrated Circuits, Inc. to the list of device tree vendor
prefixes

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
Changes in version 2:
- none
Changes in version 3:
- none

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d444757..bc64cc9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -99,6 +99,7 @@ himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
 hitex	Hitex Development Tools
+holt	Holt Integrated Circuits, Inc.
 honeywell	Honeywell
 hp	Hewlett Packard
 i2se	I2SE GmbH
-- 
1.9.1

