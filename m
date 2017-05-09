Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33102 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbdEICAl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 22:00:41 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] coding style warnings fixes
Date: Mon,  8 May 2017 22:00:36 -0400
Message-Id: <cover.1494293664.git.harinath922@gmail.com>
In-Reply-To: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
References: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset is for fixes reported by checkpatch.pl

Please find the following related patches:
[PATCH 1/3] staging: iio: meter: Add the comment for mutex definition
[PATCH 2/3] staging: iio: meter: Fix the identations for proper alignments
[PATCH 3/3] staging: iio: meter: Replace symbolic permissions with octal permissions
-------------------------------------------------------------------------
Harinath Nampally (3):
  staging: iio: meter: Add the comment for mutex definition
  staging: iio: meter: Fix the identations for proper alignments
  staging: iio: meter: Replace symbolic permissions with octal permissions 

 drivers/staging/iio/meter/ade7753.c | 104 ++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

-- 
2.7.4

