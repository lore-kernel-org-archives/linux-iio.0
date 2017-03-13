Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36305 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdCMHdo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 03:33:44 -0400
Received: by mail-pg0-f66.google.com with SMTP id 25so17271835pgy.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2017 00:33:43 -0700 (PDT)
Date: Mon, 13 Mar 2017 13:03:10 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] Replace mlock with private lock and remove
 unnecessary goto
Message-ID: <cover.1489389769.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch set replaces mlock with private lock for driver ad9834 and removes
unnecessary goto.

sayli karnik (2):
  staging: iio: ad9834: Use private driver lock instead of mlock
  staging: iio: ad9834: Remove unnecessary goto statement

 drivers/staging/iio/frequency/ad9834.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.4

