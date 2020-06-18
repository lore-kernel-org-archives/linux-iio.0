Return-Path: <SRS0=n5n8=77=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE8C433E0
	for <linux-iio@archiver.kernel.org>; Thu, 18 Jun 2020 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C22192A
	for <linux-iio@archiver.kernel.org>; Thu, 18 Jun 2020 02:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447169;
	bh=2cMtX8fwpKcEiA6q2xD7o+IaXiYer2+ESCtWjkQfOTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O24USosZa/0PmQFhpQWfTpa6LmxDWc2SDGjMOh9+qWorYqiR++dN1imSmkZPryvzH
	 MOTo4NFMJoobw/8FBwR4Ibbm0b4MbKtJ625RHgCCmI8/wi+nBDZlqcMHFchhOdaXJQ
	 5+F9Va0UjkYL91zvbiVlANLIb/w13q0+3o7604Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgFRC0I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgFRBRG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A0121D82;
        Thu, 18 Jun 2020 01:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443026;
        bh=2cMtX8fwpKcEiA6q2xD7o+IaXiYer2+ESCtWjkQfOTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfutdW6N2wzatsNXXMiXbi3wl9e+9lLOjdJghxqnipqCZcE7XWdT4Z8ZskvD7uAZ5
         wOwKOblKDryPy+2uemuC9YXAJY9xYAJ6v2aTVBRupDfB6FF1RnpW/s+yes7SK7NleN
         9CX1TXd6QeQNKSHN/VClrDbzcFH8MVl846unkMD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 026/266] iio: bmp280: fix compensation of humidity
Date:   Wed, 17 Jun 2020 21:12:31 -0400
Message-Id: <20200618011631.604574-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andreas Klinger <ak@it-klinger.de>

[ Upstream commit dee2dabc0e4115b80945fe2c91603e634f4b4686 ]

Limit the output of humidity compensation to the range between 0 and 100
percent.

Depending on the calibration parameters of the individual sensor it
happens, that a humidity above 100 percent or below 0 percent is
calculated, which don't make sense in terms of relative humidity.

Add a clamp to the compensation formula as described in the datasheet of
the sensor in chapter 4.2.3.

Although this clamp is documented, it was never in the driver of the
kernel.

It depends on the circumstances (calibration parameters, temperature,
humidity) if one can see a value above 100 percent without the clamp.
The writer of this patch was working with this type of sensor without
noting this error. So it seems to be a rare event when this bug occures.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 084a1d56cc2f..0a95afaa48fe 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -264,6 +264,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
 	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
 
+	var = clamp_val(var, 0, 419430400);
+
 	return var >> 12;
 };
 
-- 
2.25.1

