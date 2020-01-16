Return-Path: <SRS0=zjzt=3F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1FC33CB6
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD64E2073A
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202275;
	bh=v62+uadh2EIx4wLh1tUeUy7PoYIjisnB1H3B4tUsUAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9U9cab86oYHfOXAuA9U4gE8/0ma/l789hcxK1bXEcWoj7OoJZEqKY8166HGUGfK0
	 nGwmvd7QQCkDJlqPQUim/r9zfjGOtQ4pqiH2tgeipPVIktanWasGKKvEMTzwCcHZ1t
	 IaOgGHM1oVD2l28isVQ4Zy2dDuiHQAd7GVwjXnv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgAPTRy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbgAPQzK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E7F2192A;
        Thu, 16 Jan 2020 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193710;
        bh=v62+uadh2EIx4wLh1tUeUy7PoYIjisnB1H3B4tUsUAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wilJg2oU6tgT26GRcBRo9JKnK6FKKbM1dV37NvErbMInjdjuDdCBrT6XOlAGl2GNT
         T/nIFd8gBN82WPpoICN9ZpaLKYRTORXjbmE+Y3g8Con6ISubkRdwHeMUvlbuCf5Rcp
         lFc3D4f2eIv6dNUcOSxNtTPpPBGgtwa6gwy5Pu6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 006/671] iio: fix position relative kernel version
Date:   Thu, 16 Jan 2020 11:43:57 -0500
Message-Id: <20200116165502.8838-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 21eab7861688aa4c69fcb88440cc0c4a422bdcd6 ]

Position relative channel type was added in 4.19 kernel version

Fixes: "3055a6cfa04ba" ("iio: Add channel for Position Relative")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a5b4f223641d..8127a08e366d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -199,7 +199,7 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
-KernelVersion:	4.18
+KernelVersion:	4.19
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Relative position in direction x or y on a pad (may be
-- 
2.20.1

