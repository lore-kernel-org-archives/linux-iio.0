Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32939 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbcHWDpD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 23:45:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so7446575pfe.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2016 20:45:02 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/3] iio: chemical: vz89x: add multiple chip functionality
Date: Mon, 22 Aug 2016 20:44:51 -0700
Message-Id: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for multiple chip configuration, support for the vz89te part,
CRC check functionality, and buffer corruption check.

Matt Ranostay (3):
  iio: chemical: vz89x: abstract chip configuration
  iio: chemical: vz89x: add support for VZ89TE part
  iio: chemical: vz89x: prevent corrupted buffer from being read

 drivers/iio/chemical/vz89x.c | 175 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 144 insertions(+), 31 deletions(-)

-- 
2.7.4

