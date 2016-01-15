Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34948 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbcAOTm5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 14:42:57 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	devel@driverdev.osuosl.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2]Staging:iio:adc:add space around '-'
Date: Sat, 16 Jan 2016 01:12:40 +0530
Message-Id: <cover.1452878721.git.bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches adds space around '-' operator.Found using checkpatch.pl.


Bhumika Goyal (2):
  staging:iio:adc:added space around '-'
  staging:iio:adc:add space around '-'

 drivers/staging/iio/adc/ad7192.c  | 2 +-
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

