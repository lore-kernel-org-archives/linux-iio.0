Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34283 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248AbbLOJ0F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2015 04:26:05 -0500
Received: by mail-pa0-f44.google.com with SMTP id wq6so1848010pac.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2015 01:26:05 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 1/3] devicetree: add Atlas Scientific LLC vendor prefix
Date: Tue, 15 Dec 2015 01:26:12 -0800
Message-Id: <1450171574-3283-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1450171574-3283-1-git-send-email-mranostay@gmail.com>
References: <1450171574-3283-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the "atlas" vendor prefix for Atlas Scientific LLC

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4e5603b..2245178 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -28,6 +28,7 @@ arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 artesyn	Artesyn Embedded Technologies Inc.
 asahi-kasei	Asahi Kasei Corp.
+atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
-- 
1.9.1

