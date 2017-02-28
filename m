Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34599 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdB1EPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 23:15:33 -0500
Received: by mail-pf0-f193.google.com with SMTP id x66so54354pfb.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 20:14:21 -0800 (PST)
Date: Mon, 27 Feb 2017 19:14:15 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/3] staging: iio: meter: Header file maintenance
Message-ID: <cover.1488250884.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove unnecessary definitions, collapse header file into source,
and clean up includes in implementation.

Katie Dunne (3):
  staging: iio: meter: Remove unused definitions
  staging: iio: meter: Move header content to implementation file
  staging: iio: meter: Clean up #includes

 drivers/staging/iio/meter/ade7753.c | 70 ++++++++++++++++++++++++++++++++----
 drivers/staging/iio/meter/ade7753.h | 72 -------------------------------------
 2 files changed, 63 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7753.h

-- 
2.7.4

