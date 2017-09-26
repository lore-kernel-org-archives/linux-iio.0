Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35747 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031141AbdIZO6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Sep 2017 10:58:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so5108207pfi.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Sep 2017 07:58:50 -0700 (PDT)
From: Aastha Gupta <aastha.gupta4104@gmail.com>
To: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: Aastha Gupta <aastha.gupta4104@gmail.com>
Subject: [PATCH 0/2] staging: iio: adc: ad7192: use private driver lock to protect hardware changes
Date: Tue, 26 Sep 2017 20:28:35 +0530
Message-Id: <1506437917-7219-1-git-send-email-aastha.gupta4104@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches
- replace mlock with private driver lock
- add lock where there are hardware state changes

Aastha Gupta (2):
  staging: iio: adc: ad7192: Replace mlock with driver private lock
  staging: iio: adc: ad7192: add lock to protect hardware state changes

 drivers/staging/iio/adc/ad7192.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4

