Return-Path: <SRS0=sYDY=XM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E98C4CEC9
	for <linux-iio@archiver.kernel.org>; Tue, 17 Sep 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4438F206C2
	for <linux-iio@archiver.kernel.org>; Tue, 17 Sep 2019 16:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfIQQJi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:09:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48541 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfIQQJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 12:09:38 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2i-0007j6-FW; Tue, 17 Sep 2019 18:09:28 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2g-0004VM-Hw; Tue, 17 Sep 2019 18:09:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     michael.hennerich@analog.com, lars@metafoo.de,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/3] ADC AD799x improvements
Date:   Tue, 17 Sep 2019 18:09:22 +0200
Message-Id: <20190917160925.9791-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

the main purpose of this serie is to add the pm_ops support. This is
important to free the regulators we are using within the driver.

Regards,
  Marco

Marco Felsch (3):
  iio: adc: ad799x: fix probe error handling
  iio: adc: ad799x: factor out config register update
  iio: adc: ad799x: add pm_ops to disable the device completely

 drivers/iio/adc/ad799x.c | 70 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

-- 
2.20.1

