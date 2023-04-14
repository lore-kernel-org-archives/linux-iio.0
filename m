Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D59C77B6E
	for <linux-iio@archiver.kernel.org>; Fri, 14 Apr 2023 01:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDNBiP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Apr 2023 21:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDNBiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 21:38:15 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18095103
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=gPGZNX9pQHW6WahdEHbQCaGGm0RUBEWhOrb8ferroNY=; b=mOTLqZEVucApTQnPnc51foZTKx
        8SBn9TsfaL9bZfvunplDK9XGTdkmcP4Kd1wPj+Ggob7RZXNHHH6k+nFNSxQDWnnL22z5ddVfl9FlM
        9kBy0FZIT1xSccNuYnylRw7PcPrVE2HGmO5Sr5IcSLTL2j95FRXsWg4GyQz/1nBdoBo07TlzyFgKQ
        9DcZ4+Rrwp9Qp6xR8h4qUa6/tLLDME62kFRE1EL1EgRrXT7h+i0nfN7wZzCQNMe+ls/F9e0gYaKwG
        mgdrvdLtEjCOPBXRG5XmFCEfVAETXmxEf9bb4Z9Js+/DVBQtT012bDU21TUWokOM63YsCpT3GfWIN
        mXKunWNw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pn8OA-000OJ3-GS; Fri, 14 Apr 2023 03:38:10 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pn8OA-000Lz8-1m; Fri, 14 Apr 2023 03:38:10 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: tmag5273: Fix runtime PM leak on measurement error
Date:   Thu, 13 Apr 2023 18:37:52 -0700
Message-Id: <20230414013752.498767-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26874/Thu Apr 13 09:30:39 2023)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The tmag5273 gets a runtime PM reference before reading a measurement and
releases it when done. But if the measurement fails the tmag5273_read_raw()
function exits before releasing the reference.

Make sure that this error path also releases the runtime PM reference.

Fixes: 866a1389174b ("iio: magnetometer: add ti tmag5273 driver")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/magnetometer/tmag5273.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 28bb7efe8df8..e155a75b3cd2 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -296,12 +296,13 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle, &magnitude);
-		if (ret)
-			return ret;
 
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 
+		if (ret)
+			return ret;
+
 		switch (chan->address) {
 		case TEMPERATURE:
 			*val = t;
-- 
2.30.2

