Return-Path: <SRS0=5nFi=5L=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274CC2D0E9
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D351220719
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCZVJ6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:09:58 -0400
Received: from sauhun.de ([88.99.104.3]:54366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgCZVJ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:58 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id F26FE2C1F84;
        Thu, 26 Mar 2020 22:09:56 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] iio: convert to use new I2C API
Date:   Thu, 26 Mar 2020 22:09:54 +0100
Message-Id: <20200326210955.12991-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR.


Wolfram Sang (1):
  iio: imu: inv_mpu6050: convert to use i2c_new_client_device()

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.20.1

