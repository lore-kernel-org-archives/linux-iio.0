Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCDC46467
	for <linux-iio@archiver.kernel.org>; Mon,  7 Feb 2022 14:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359139AbiBGO5M (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiBGOiq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:46 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FEEC0401C3
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8C39C100006;
        Mon,  7 Feb 2022 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmLCmMWpjGtflzXx1HNHByt2kN8tM4HeD013Yp4bZDE=;
        b=iQKptoJj28P2JRm0qwys18WTgs+ULVaolvJ2J5+wlhqvxY/nBTkKq46cFW+NWVcMP8rvhg
        P3xHJEArUya1GgvVjqd1OuGzuUoE/GF6FmKxayuiJdb+44d8PVzbmh3bJM8VpI9Y4KDM89
        VAE9Or3JHrYP5ikr61yvjkNkIghh/FiynJF3M/arnfLhVuC60CiJjY/PxSmskXNFzJHBSB
        IxIj80igPnbv7mHbEvVnpzb7vaBi5El98CV/4O2tJjQ/nvtc26kIBpMNPiNZ5QesQ5HpAy
        0ZjFVr1J5c5/3DdeffCT5KDkHjQbTQk427AnCgvs9cDFhg4mzrnuz52e1P0m6w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 01/13] iio: core: Enhance the kernel doc of modes and currentmodes iio_dev entries
Date:   Mon,  7 Feb 2022 15:38:28 +0100
Message-Id: <20220207143840.707510-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207143840.707510-1-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's provide more details about these two variables because their
understanding may not be straightforward for someone not used to the IIO
subsystem internal logic. The different modes will soon be also be more
documented for the same reason.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/iio/iio.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faf00f2c0be6..f191b80466cd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -488,8 +488,15 @@ struct iio_buffer_setup_ops {
 
 /**
  * struct iio_dev - industrial I/O device
- * @modes:		[DRIVER] operating modes supported by device
- * @currentmode:	[INTERN] current operating mode
+ * @modes:		[DRIVER] bitmask listing all the operating modes
+ *			supported by the IIO device. This list should be
+ *			initialized before registering the IIO device. It can
+ *			also be filed up by the IIO core, as a result of
+ *			enabling particular features in the driver
+ *			(see iio_triggered_event_setup()).
+ * @currentmode:	[INTERN] operating mode currently in use, may be
+ *			eventually checked by device drivers but should be
+ *			considered read-only as this is a core internal bit
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @buffer:		[DRIVER] any buffer present
-- 
2.27.0

