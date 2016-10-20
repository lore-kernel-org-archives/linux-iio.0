Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36637 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933937AbcJTJTg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 05:19:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id e6so33081524pfk.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2016 02:19:35 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 0/2] tools: iio: iio_generic_buffer: -A option code cleanups
Date: Thu, 20 Oct 2016 17:19:22 +0800
Message-Id: <cover.1476952931.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Address Peter's comments:
https://marc.info/?l=linux-iio&m=147673895620791&w=2

Change in v2:
* Update force_autochannels to true/false instead of 1/0.

Eva Rachel Retuya (2):
  tools: iio: iio_generic_buffer: rename and change type of force
    variable
  tools: iio: iio_generic_buffer: drop unneeded parentheses

 tools/iio/iio_generic_buffer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4

