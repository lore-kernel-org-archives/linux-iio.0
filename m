Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGWTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 18:19:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so8333736pgp.7
        for <linux-iio@vger.kernel.org>; Tue, 07 Aug 2018 13:03:40 -0700 (PDT)
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org, himanshujha199640@gmail.com
Cc: David Frey <dpfrey@gmail.com>
Subject: [PATCH 0/2] bme680 cleanup
Date: Tue,  7 Aug 2018 13:07:19 -0700
Message-Id: <20180807200721.22033-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I have performed some minor cleanup on the bme680 driver. I don't think there's
anything controversial in my changes. Let me know what you think

David Frey (2):
  iio: bme680: perform cosmetic cleanup
  iio: bme680: simplify oversampling handling

 drivers/iio/chemical/bme680.h      |  17 +++---
 drivers/iio/chemical/bme680_core.c | 110 ++++++++++++-------------------------
 2 files changed, 42 insertions(+), 85 deletions(-)

-- 
2.11.0

