Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36589 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbaL3S6U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Dec 2014 13:58:20 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so24515053wiv.6
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2014 10:58:19 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/3] iio: accel: Fix checkpatch warnings
Date: Tue, 30 Dec 2014 20:57:52 +0200
Message-Id: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fixes warnings detected using checkpatch.pl,
such as: missing blank line after declarations, trailing whitespaces,
incomplete config symbol description.

Roberta Dobrescu (3):
  iio: accel: kxcjk-1013: Add a blank line after declarations
  iio: accel: mma8452: Remove trailing whitespace
  iio: accel: Annotate Kconfig entries with module name information

 drivers/iio/accel/Kconfig      | 6 ++++++
 drivers/iio/accel/kxcjk-1013.c | 1 +
 drivers/iio/accel/mma8452.c    | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1

