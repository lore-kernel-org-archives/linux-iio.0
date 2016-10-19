Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32803 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbcJSRFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:05:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so19251431pfz.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2016 10:05:10 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 0/2] tools: iio: iio_generic_buffer: -A option code cleanups
Date: Thu, 20 Oct 2016 01:04:26 +0800
Message-Id: <1476896668-2200-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Address Peter's comments:
https://marc.info/?l=linux-iio&m=147673895620791&w=2

Eva Rachel Retuya (2):
  tools: iio: iio_generic_buffer: rename and change type of force
    variable
  tools: iio: iio_generic_buffer: drop unneeded parentheses

 tools/iio/iio_generic_buffer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4

