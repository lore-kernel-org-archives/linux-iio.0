Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35791 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdCMJX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 05:23:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so13027264pge.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2017 02:23:53 -0700 (PDT)
Message-ID: <58c66523.d638620a.5414c.30b9@mx.google.com>
Date: Mon, 13 Mar 2017 14:53:35 +0530
From: Varsha Rao <rvarsha016@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] staging: iio: adis16240: Replace mlock with private lock
 and modify comment.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset replaces mlock with private lock and modifies existing
comment in iio driver.

Varsha Rao (2):
  staging: iio: adis16240: Replace mlock with driver private lock.
  staging: iio: adis16240: Modify existing comment.

 drivers/staging/iio/accel/adis16240.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.9.3

