Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36284 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbcHYGpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 02:45:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so2658339pfg.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2016 23:44:55 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/4] iio: chemical: vz89x: add multiple chip functionality
Date: Wed, 24 Aug 2016 23:44:46 -0700
Message-Id: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for multiple chip configuration, support for the vz89te part,
CRC check functionality, and buffer corruption check.

Changes from v1:
 * Move chip configuration to vz89_chip_data struct
 * Removed redundant mutex and use indio_dev->mlock instead

Matt Ranostay (4):
  iio: chemical: vz89x: abstract chip configuration
  iio: chemical: vz89x: add support for VZ89TE part
  iio: chemical: vz89x: prevent corrupted buffer from being read
  iio: chemical: vz89x: remove mutex and replace with
    iio_device_*_direct_mode

 drivers/iio/chemical/vz89x.c | 222 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 178 insertions(+), 44 deletions(-)

-- 
2.7.4

