Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36699 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdCCPgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 10:36:48 -0500
Received: by mail-pf0-f194.google.com with SMTP id j5so10208272pfb.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Mar 2017 07:34:59 -0800 (PST)
Date: Fri, 3 Mar 2017 07:32:47 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] staging: iio: meter: ade7753: Header file maintenance
Message-ID: <20170303153247.GA29234@katie-Inspiron-5748>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Collapse header file into source and clean up includes. 

Changes in v2:
Removed patch deleting unused definitions
Placed all register definitions at the top of the file for easy access
Included driver name in patch titles

Katie Dunne (2):
  staging: iio: meter: ade7753: Move header content to implementation
    file
  staging: iio: meter: ade7753: Clean up includes

 drivers/staging/iio/meter/ade7753.c | 82 +++++++++++++++++++++++++++++++++----
 drivers/staging/iio/meter/ade7753.h | 72 --------------------------------
 2 files changed, 74 insertions(+), 80 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7753.h

-- 
2.7.4

