Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF97C4CECE
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C2D207FF
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570990338;
	bh=MIB0uySEmy2qxR8n4Ge2mPBHsGT2R57wc80SxbEt2tE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SHi16xGSsmhCSUqXb7/5nMtPfQ3YeidiNJupDj8yQWqPZdbSx5U8H6o28aXCbxLBp
	 OxDm37vG7Gausp/OfgGSD5DFxVA4coCJjvaGJwvoH7/JVC0Wbt3Fs8n+5WzHduNKT7
	 nCO0xma+/jjnm9UflONCdZrmEXkb7shlXuJ5u3E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfJMSMR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfJMSMR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 14:12:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234A620673;
        Sun, 13 Oct 2019 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570990336;
        bh=MIB0uySEmy2qxR8n4Ge2mPBHsGT2R57wc80SxbEt2tE=;
        h=From:To:Cc:Subject:Date:From;
        b=qs3i+HCxOtW7bcPRQ0Teltnox+D6jqjHP8Jlk7mr5A04CyvwV4GssYvB+w5YtZVT2
         cUJSe9HwqXWt/RJL0ydjmDGqaX3mZgYfGEb0yYlKjRD1b66B0YRANs+YgPo76+yRLw
         WjMCWIukFoouA1B3qyvfRhT0SC/8s4Q9HbNce+9Y=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: temp: maxim thermocouple: Drop unneeded semi colon.
Date:   Sun, 13 Oct 2019 19:10:13 +0100
Message-Id: <20191013181013.2399842-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identified by coccinelle

CHECK   drivers/iio/temperature/maxim_thermocouple.c
drivers/iio/temperature/maxim_thermocouple.c:197:3-4: Unneeded semicolon

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 2ab68282d0b6..d1360605209c 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -194,7 +194,7 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
 		default:
 			*val = 250; /* 1000 * 0.25 */
 			ret = IIO_VAL_INT;
-		};
+		}
 		break;
 	}
 
-- 
2.23.0

