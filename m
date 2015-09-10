Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35513 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbbIJQbG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:31:06 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 3/6] Staging: lustre: libcfs: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:00:31 +0530
Message-Id: <1441902634-11129-3-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1441902634-11129-1-git-send-email-shraddha.6596@gmail.com>
References: <1441902634-11129-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/lustre/lustre/libcfs/hash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/libcfs/hash.c b/drivers/staging/lustre/lustre/libcfs/hash.c
index 0ed0631..e5a5036 100644
--- a/drivers/staging/lustre/lustre/libcfs/hash.c
+++ b/drivers/staging/lustre/lustre/libcfs/hash.c
@@ -588,13 +588,13 @@ EXPORT_SYMBOL(cfs_hash_bd_move_locked);
 
 enum {
 	/** always set, for sanity (avoid ZERO intent) */
-	CFS_HS_LOOKUP_MASK_FIND     = 1 << 0,
+	CFS_HS_LOOKUP_MASK_FIND     = BIT(0),
 	/** return entry with a ref */
-	CFS_HS_LOOKUP_MASK_REF      = 1 << 1,
+	CFS_HS_LOOKUP_MASK_REF      = BIT(1),
 	/** add entry if not existing */
-	CFS_HS_LOOKUP_MASK_ADD      = 1 << 2,
+	CFS_HS_LOOKUP_MASK_ADD      = BIT(2),
 	/** delete entry, ignore other masks */
-	CFS_HS_LOOKUP_MASK_DEL      = 1 << 3,
+	CFS_HS_LOOKUP_MASK_DEL      = BIT(3),
 };
 
 typedef enum cfs_hash_lookup_intent {
-- 
2.1.4

