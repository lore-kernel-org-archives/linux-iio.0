Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33996 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932572AbcLYTmC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 14:42:02 -0500
Received: by mail-oi0-f68.google.com with SMTP id 3so14379316oih.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 11:42:00 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCHv4 0/8] Checkpatch fixes to driver/staging/iio/addac
Date: Sun, 25 Dec 2016 13:41:04 -0600
Message-Id: <1482694902-7400-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

*** BLURB HERE ***

Scott Matheina (8):
  fixed long description text exceeding 80 characters
  Fixed variables not being consistently lower case
  Fix camel case issues
  Fix braces not present on all arms of if else statement
  Remove line after closing braces
  Fixed code wrap alignment with preceding (.
  Changed code to align with coding style of using octat
  Fixes style issues due to mis-aligned carry over lines

 drivers/staging/iio/addac/adt7316.c | 850 +++++++++++++++++-------------------
 1 file changed, 397 insertions(+), 453 deletions(-)

--
2.7.4

