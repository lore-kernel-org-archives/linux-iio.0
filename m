Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA8C433F5
	for <linux-iio@archiver.kernel.org>; Mon, 28 Mar 2022 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiC1VY5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiC1VY4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 17:24:56 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4D713858E;
        Mon, 28 Mar 2022 14:23:07 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 6a3d8f32 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 21:23:05 +0000 (UTC)
Date:   Mon, 28 Mar 2022 16:23:03 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: accel: kxsd9-spi: changed leading spaces to tabs
Message-ID: <YkInN6SL7pP2f5Sf@hp-amd-paul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changed the leading spaces to tabs, in accordance with kernel coding
conventions, and removed trailing comma.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 drivers/iio/accel/kxsd9-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index ec17e35e5..b7b5af454 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
 
 static const struct of_device_id kxsd9_of_match[] = {
-        { .compatible = "kionix,kxsd9" },
-        { },
+	{ .compatible = "kionix,kxsd9" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 
-- 
2.35.1

