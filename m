Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:41267 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036Ab1JRP3j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2011 11:29:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, zdevai@gmail.com,
	linux@arm.linux.org.uk, arnd@arndb.de,
	broonie@opensource.wolfsonmicro.com, gregkh@suse.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] IIO: core: add datasheet_name to chan_spec
Date: Tue, 18 Oct 2011 16:29:31 +0100
Message-Id: <1318951776-19393-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318951776-19393-1-git-send-email-jic23@cam.ac.uk>
References: <1318951776-19393-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows for matching against the name given
on a datasheet, however silly/inconsistent it might
be.

Useful for in kernel interfaces.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 include/linux/iio/iio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8066c8a..beedc5c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -128,6 +128,7 @@ struct iio_chan_spec {
 	} scan_type;
 	long                    info_mask;
 	char			*extend_name;
+	const char		*datasheet_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-- 
1.7.7

