Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33337 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbcLYUDu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 15:03:50 -0500
Received: by mail-oi0-f67.google.com with SMTP id f201so43117009oib.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 12:03:50 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCHv4 0/8] Checkpatch fixes to driver/staging/iio/addac
Date: Sun, 25 Dec 2016 13:56:38 -0600
Message-Id: <1482696216-8013-1-git-send-email-scott@matheina.com>
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

