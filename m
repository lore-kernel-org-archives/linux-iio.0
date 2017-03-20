Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36239 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbdCTPYo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 11:24:44 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 0/2] staging: iio: ade7754: Header file maintenance
Date: Mon, 20 Mar 2017 20:45:03 +0530
Message-Id: <1490022905-18422-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Collapse header file into source, and clean up includes in 
implementation.

simran singhal (2):
  staging: ade7754: Move header content to implementation file
  staging: ade7754: Clean up #includes

 drivers/staging/iio/meter/ade7754.c | 98 ++++++++++++++++++++++++++++++++++---
 drivers/staging/iio/meter/ade7754.h | 90 ----------------------------------
 2 files changed, 91 insertions(+), 97 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7754.h

-- 
2.7.4

