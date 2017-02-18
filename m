Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33423 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbdBRUTg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 15:19:36 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so6668875pfg.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2017 12:19:36 -0800 (PST)
Date: Sun, 19 Feb 2017 01:49:23 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/3] Use macros BIT() and GENMASK()
Message-ID: <cover.1487448326.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use BIT() and GENMASK() macros for left shifts. Also add a blank line after a
function declaration.

sayli karnik (3):
  staging: iio: ad7152: Use BIT() macro for left shifting 1
  staging: iio: ad7152: Use GENMASK() macro for left shifts
  staging: iio: ad7152: Add a blank line after a function

 drivers/staging/iio/cdc/ad7152.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.7.4

