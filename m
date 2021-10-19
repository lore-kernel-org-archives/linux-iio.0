Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E77C433F5
	for <linux-iio@archiver.kernel.org>; Tue, 19 Oct 2021 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B5561212
	for <linux-iio@archiver.kernel.org>; Tue, 19 Oct 2021 10:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJSKCj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:02:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8459 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhJSKCe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 06:02:34 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5616e9728c89-fb37b; Tue, 19 Oct 2021 18:00:09 +0800 (CST)
X-RM-TRANSID: 2ee5616e9728c89-fb37b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3616e97244be-dc5d5;
        Tue, 19 Oct 2021 18:00:08 +0800 (CST)
X-RM-TRANSID: 2ee3616e97244be-dc5d5
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 0/3] iio: Use of_device_get_match_data to clean code
Date:   Tue, 19 Oct 2021 18:00:10 +0800
Message-Id: <20211019100013.27312-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all:

This patch series replace 'of_match_device' with
'of_device_get_match_data', to make code cleaner and better.

Thanks

Tang Bin (3):
  iio: adc: rockchip_saradc: Use of_device_get_match_data to simplify
    code
  iio: adc: max9611: Use of_device_get_match_data to simplify code
  iio: adc: twl6030-gpadc: Use of_device_get_match_data to simplify code

 drivers/iio/adc/max9611.c         | 4 +---
 drivers/iio/adc/rockchip_saradc.c | 7 ++-----
 drivers/iio/adc/twl6030-gpadc.c   | 7 ++-----
 3 files changed, 5 insertions(+), 13 deletions(-)

-- 
2.20.1.windows.1



