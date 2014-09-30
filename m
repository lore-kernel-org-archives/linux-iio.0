Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64405 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaI3MA0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Sep 2014 08:00:26 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so5394264pab.9
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2014 05:00:25 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v3 2/4] Documentation: devicetree: bindings: Document deprecated device vendor name to fix related warning
Date: Tue, 30 Sep 2014 17:29:06 +0530
Message-Id: <1412078348-7646-3-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch documents deprecated vendor name of device isl29028 for compatibility with older kernels.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..e2503b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,6 +68,7 @@ img	Imagination Technologies Ltd.
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
+isil 	Intersil (deprecated, use isl)
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
-- 
1.9.1

