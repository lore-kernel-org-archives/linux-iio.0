Return-Path: <SRS0=GgFY=PE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5117CC43387
	for <linux-iio@archiver.kernel.org>; Thu, 27 Dec 2018 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DB8214C6
	for <linux-iio@archiver.kernel.org>; Thu, 27 Dec 2018 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YqRhkZj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbeL0TzF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:55:05 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59752 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbeL0TzE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Dec 2018 14:55:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 448F4D4D
        for <linux-iio@vger.kernel.org>; Thu, 27 Dec 2018 19:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sQoYfb-mA-6R for <linux-iio@vger.kernel.org>;
        Thu, 27 Dec 2018 13:55:03 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 17354D5B
        for <linux-iio@vger.kernel.org>; Thu, 27 Dec 2018 13:55:03 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id q18so2563802ioj.5
        for <linux-iio@vger.kernel.org>; Thu, 27 Dec 2018 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hu1jqh/oLjWGatdKi5LxSCSeLVZPpR4Y3Ivsb+hWC3U=;
        b=YqRhkZj1F8AP93nQIT6mtvISNfqK8COn7pwOcfi7KqxZbdqIqVRgZmgx1MEmfjvWmA
         WoUVirnxQSUk42Fd0s/4noJolIKBIhGCOfEJTWkAnyLNwxA4Cz1ViNCmYgisrlPPewfk
         zAgfS9s+8wODjb2EiBgK9P1t2MeT/GHMtEJHlGHhoT99exP+BJQl51iw+MCYXBZa8POY
         pJwYfqZIITkiY3EQ3I6mIplgpKObYm8Zqo49KzW7oSPDoG28n4cBt7dbj4ulSw03cucG
         dP2NWOZnfk09yYcP6pAa2IboKllSZlIrxxcZKHUUgzFZJlrmxC/bdt4hgEUpHPxh+oNV
         /JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hu1jqh/oLjWGatdKi5LxSCSeLVZPpR4Y3Ivsb+hWC3U=;
        b=CjN72ffBWXeBKz1tner47TK5svo53i6PpTFWDthyRdQrn1i8snPaAUOgyBAK3HNlkU
         bQaiyM8TjlI/VQbVswO/MfOM1h9sc+GR+WPUeI3TUbS8grkHO7Qp+6TG38AXrd4Ye4OV
         iH+DZjl5SWTpiMYhWtvaw3d+xrnyFU7dikEIHR8gVJpiwuVq/9FI7cFJoXBa+huyMJf0
         l/AeHsGy1AP4dXZN/v5/floi/WMSkh3UcPSBDo4qceUU2YtvVmAsM7I7B8gSCS8PCmes
         lk+k5NQJf2VXoUHdbC/y051sdsnKhlb4x/XSeJIdwQibUCr4Bz5NKW090XhL5x73WoDR
         z24w==
X-Gm-Message-State: AJcUukeTIdsMgt9eZYYdqvYrmMSnXSuP2sJnxGgZa82Vv5thkiVaN53z
        /6uqwIZOf7HJpFGSkqvPgL2PSVQ1FK5RZu7BqRowsRUSQF1fvxTjBhc3I2ZdN7Im47EAm9LpnKY
        o+iaWWxnrlIrUfyTciPRSH4XG
X-Received: by 2002:a5d:934a:: with SMTP id i10mr16607198ioo.162.1545940502656;
        Thu, 27 Dec 2018 11:55:02 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4/Fs7FcOOR/IB5wY4/JpfTvK7IM0aan8n8kWN1UC5NgHKhfiIwHkmxVp6ucjZWR79qMZTU5A==
X-Received: by 2002:a5d:934a:: with SMTP id i10mr16607177ioo.162.1545940502407;
        Thu, 27 Dec 2018 11:55:02 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id 137sm15667190itm.21.2018.12.27.11.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 11:55:01 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx: check return value of xadc_write_adc_reg
Date:   Thu, 27 Dec 2018 13:54:52 -0600
Message-Id: <20181227195454.26344-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function xadc_probe, xadc_write_adc_reg can return an error value
when write fails. The fix checks for the return value consistent with
other invocations of the latter function.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 3f6be5ac049a..b13c61539d46 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1273,8 +1273,10 @@ static int xadc_probe(struct platform_device *pdev)
 			xadc->threshold[i] = 0xffff;
 		else
 			xadc->threshold[i] = 0;
-		xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
+		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			xadc->threshold[i]);
+		if (ret)
+			goto err_free_irq;
 	}
 
 	/* Go to non-buffered mode */
-- 
2.17.1

