Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56560 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab2F3Wro (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 30 Jun 2012 18:47:44 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio: another typo in comment
Date: Sun,  1 Jul 2012 00:47:42 +0200
Message-Id: <1341096463-13789-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net>
References: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 include/linux/iio/iio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2afbb6f..72f8851 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -220,7 +220,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *			unlike modifiers.
  * @datasheet_name:	A name used in in-kernel mapping of channels. It should
  *			correspond to the first name that the channel is referred
- *			to by in the datasheet (e.g. IND), or the nearest
+ *			to in the datasheet (e.g. IND), or the nearest
  *			possible compound name (e.g. IND-INC).
  * @modified:		Does a modifier apply to this channel. What these are
  *			depends on the channel type.  Modifier is set in
-- 
1.7.9.5

