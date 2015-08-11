Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33322 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933898AbbHKKQM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 06:16:12 -0400
Date: Tue, 11 Aug 2015 13:15:08 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 0/2] Staging: iio: trigger: Fix style issues
Message-ID: <cover.1439286814.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix style issues reported by checkpatch.pl.

Cristina Opriceana (2):
  Staging: iio: trigger: Alignment should match open parenthesis
  Staging: iio: trigger: Use braces on both branches of if statement

 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 7 ++++---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.9.1

