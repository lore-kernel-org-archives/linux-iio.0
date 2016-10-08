Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34780 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbcJHQGB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:06:01 -0400
Received: by mail-pa0-f67.google.com with SMTP id r9so4311960paz.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Oct 2016 09:06:01 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v4 0/2] staging: iio: ad7606: oversampling_ratio clean-up
Date: Sun,  9 Oct 2016 00:05:38 +0800
Message-Id: <cover.1475942324.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Implement the oversampling_ratio attribute using standard global define
as well as fix bug about incorrect setting of oversampling pins

Changes in v4:
* Reverse the order of patches: fix first followed by rework
* Add Lars' Acked-by tag for the bug fix

Changes in v3:
* Add follow-up patch fixing bug about incorrect setting of oversampling
  pins
* Add Fixes tag

Changes in v2:
* Add Lars' Acked-by tag
* Update dev_err() to use proper arguments

Eva Rachel Retuya (2):
  staging: iio: ad7606: fix improper setting of oversampling pins
  staging: iio: ad7606: implement IIO_CHAN_INFO_OVERSAMPLING_RATIO

 drivers/staging/iio/adc/ad7606_core.c | 67 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

-- 
2.7.4

