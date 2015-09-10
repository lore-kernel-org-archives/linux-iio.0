Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36673 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbIJQdA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:33:00 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 5/6] Staging: lustre: ptlrpc: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:02:40 +0530
Message-Id: <1441902761-11190-2-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
References: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/lustre/lustre/ptlrpc/layout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/layout.c b/drivers/staging/lustre/lustre/ptlrpc/layout.c
index d14c200..5d19cfc 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/layout.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/layout.c
@@ -789,17 +789,17 @@ enum rmf_flags {
 	/**
 	 * The field is a string, must be NUL-terminated.
 	 */
-	RMF_F_STRING = 1 << 0,
+	RMF_F_STRING = BIT(0),
 	/**
 	 * The field's buffer size need not match the declared \a rmf_size.
 	 */
-	RMF_F_NO_SIZE_CHECK = 1 << 1,
+	RMF_F_NO_SIZE_CHECK = BIT(1),
 	/**
 	 * The field's buffer size must be a whole multiple of the declared \a
 	 * rmf_size and the \a rmf_swabber function must work on the declared \a
 	 * rmf_size worth of bytes.
 	 */
-	RMF_F_STRUCT_ARRAY = 1 << 2
+	RMF_F_STRUCT_ARRAY = BIT(2)
 };
 
 struct req_capsule;
-- 
2.1.4

