Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60221 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaLPJMP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Dec 2014 04:12:15 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so12970935wib.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2014 01:12:14 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/3] iio: frequency: Fix checkpatch warnings
Date: Tue, 16 Dec 2014 11:11:44 +0200
Message-Id: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fixes warnings detected using checkpatch.pl,
such as: useless 'out of memory' message, unnecessary braces around single
statement block, inadequate usage of msleep function.


Roberta Dobrescu (3):
  iio: frequency: Remove 'out of memory' message
  iio: frequency: Remove unnecessary braces around single statement block
  iio: frequency: Use usleep_range instead of msleep

 drivers/iio/frequency/ad9523.c  | 2 +-
 drivers/iio/frequency/adf4350.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
1.9.1

