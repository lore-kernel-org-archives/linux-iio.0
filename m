Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:14 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 0/7] bme680 cleanup
Date: Wed, 15 Aug 2018 13:38:28 -0700
Message-Id: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Note that I don't currently have bme680 hardware available, so I am hoping that
Himanshu is willing to validate the changes.

v2:
  This version addresses Himanshu's feedback
  - split v1 patch 1 into 6 commits
  - substantially changed "simplify oversampling handling" after review
    identified a bug in the previous patch version and I spent some more time
    thinking about the problem

v1:
  I have performed some minor cleanup on the bme680 driver. I don't think
  there's anything controversial in my changes. Let me know what you think

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
