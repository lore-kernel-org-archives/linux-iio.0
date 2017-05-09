Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35420 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEIXl5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2017 19:41:57 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] coding style warnings fixes
Date: Tue,  9 May 2017 19:41:51 -0400
Message-Id: <cover.1494370925.git.harinath922@gmail.com>
In-Reply-To: <20170509074617.x6bdqs7innxhrude@mwanda>
References: <20170509074617.x6bdqs7innxhrude@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This revised patchset is for improvement in [PATCH v2 1/3]
as per the code review comment from Dan Carpenter.

Other two patches [PATCH v2 2/3] and [PATCH v2 3/3] are unchanged,
so they are same as [PATCH 2/3] and [PATCH 3/3] respectively.

Please find the following related patches:
[PATCH v2 1/3] staging: iio: meter: Add the comment for mutex definition
[PATCH v2 2/3] staging: iio: meter: Fix the identations for proper alignments
[PATCH v2 3/3] staging: iio: meter: Replace symbolic permissions with octal permissions

Harinath Nampally (3):
  staging: iio: meter: Add the comment for mutex definition
  staging: iio: meter: Fix the identations for proper alignments    
  staging: iio: meter: Replace symbolic permissions with octal
    permissions 

 drivers/staging/iio/meter/ade7753.c | 104 ++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

-- 
2.7.4

