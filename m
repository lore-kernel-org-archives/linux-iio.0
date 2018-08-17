Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40490 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeHQWGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Aug 2018 18:06:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so4115793plp.7
        for <linux-iio@vger.kernel.org>; Fri, 17 Aug 2018 12:02:15 -0700 (PDT)
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 0/7] bme680 cleanup
Date: Fri, 17 Aug 2018 12:03:12 -0700
Message-Id: <20180817190319.13119-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v3:
  - Added "MSK->MASK" patch hunk accidentally omitted from v2
  - Applied Himanshu's "iio: chemical: bme680: Add check for val2 in
    the write_raw function" patch on top of jic23/iio rev 5e45729608dd
    before rebasing this patch series on top.

v2:
  This version addresses Himanshu's feedback
  - split v1 patch 1 into 6 commits
  - substantially changed "simplify oversampling handling" after review
    identified a bug in the previous patch version and I spent some more
    time thinking about the problem

v1:
  I have performed some minor cleanup on the bme680 driver. I don't
  think there's anything controversial in my changes. Let me know what
  you think

David Frey (7):
  iio: chemical: bme680: use clamp macro
  iio: chemical: bme680: cleanup bme680_read_calib formatting
  iio: chemical: bme680: indent #defines consistently
  iio: chemical: bme680: change MSK->MASK in #defines
  iio: chemical: bme680: use GENMASK macro
  iio: chemical: bme680: use FIELD_GET macro
  iio: chemical: bme680: simplify oversampling handling

 drivers/iio/chemical/bme680.h      |  17 +++--
 drivers/iio/chemical/bme680_core.c | 144 +++++++++++++------------------------
 2 files changed, 59 insertions(+), 102 deletions(-)

-- 
2.11.0
