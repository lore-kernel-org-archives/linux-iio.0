Return-Path: <SRS0=zjzt=3F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35370C33CB3
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A45246D2
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196759;
	bh=Nl/4LuWz6wnqaAMRmetzu5XfYYSDKGkIzi00bNh4lHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r10vqsazrDHzh43yER4gcsLlzuU7uecl0Q8w+3oE74V7L+S+CAccTJqjNHkZphi7r
	 Xgl7Enpk0zfqFzdJgc+2hj9hB47iJmYGOaCBrIdLphevuPcylbe9YzA9oy6hcZRuUm
	 N8kRtAu1yB9hNZJM2bgr8d6+SxEFjXNAmfiDKcac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406575AbgAPRp6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406569AbgAPRp6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D06246CA;
        Thu, 16 Jan 2020 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196757;
        bh=Nl/4LuWz6wnqaAMRmetzu5XfYYSDKGkIzi00bNh4lHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6F+aOvAfqf7rft9WdF/B8Ykj8cork+Yttf6qNPNdaum6J4GoCzyTWLy+0b5J0Y7a
         x4RV2q27KknPqxq5X6i06+2ZmmZtfAiEJGi1Pj2VKYvQD9qdTyuewoVaD3M+C5/OD7
         3xmw/uDbvjNof4r0XNAeL7di5g1xA3SyXJaZ+2jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 132/174] iio: dac: ad5380: fix incorrect assignment to val
Date:   Thu, 16 Jan 2020 12:42:09 -0500
Message-Id: <20200116174251.24326-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1e18768ef1214c0a8048327918a182cabe09f9d ]

Currently the pointer val is being incorrectly incremented
instead of the value pointed to by val. Fix this by adding
in the missing * indirection operator.

Addresses-Coverity: ("Unused value")
Fixes: c03f2c536818 ("staging:iio:dac: Add AD5380 driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c5111f43..8bf7fc626a9d 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -221,7 +221,7 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		*val >>= chan->scan_type.shift;
-		val -= (1 << chan->scan_type.realbits) / 2;
+		*val -= (1 << chan->scan_type.realbits) / 2;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 2 * st->vref;
-- 
2.20.1

