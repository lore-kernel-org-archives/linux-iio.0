Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35978 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdIWU4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 16:56:36 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH 0/2] This patchset is for fixes reported by checkpatch.pl
Date: Sat, 23 Sep 2017 16:56:28 -0400
Message-Id: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please find the following patches:
  iio: accel: mma8452: Fix code style warning for symbolic permissions
  iio: accel: mma8452: Fix code style warning for unsigned int
    declarations

 drivers/iio/accel/mma8452.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4

