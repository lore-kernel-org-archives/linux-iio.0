Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60269 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758692Ab3CDVQb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:16:31 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] IIO break info_mask into a pair of masks - Additional drivers 2 (missed ones)
Date: Mon,  4 Mar 2013 21:16:17 +0000
Message-Id: <1362431780-27682-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As Lars-Peter noticed, I missed these 3 drivers for some reason in the earlier
two series of patches.  Oops.  Have now deployed grep more carefully/thoroughly.

These will shortly appear at an appropriate spot in the info_mask_split branch
of iio.git.

This short series applies the equivalent changes to three drivers missed
from the series in

[PATCH 00/67 V2] IIO break info_mask into a pair of masks
was under way.

If there are no issues, I'll slot these in just before patch 67 of that
series.

As a quick summary for anyone just looking at these, I am proposing to
split info_mask into info_mask_separate and info_mask_shared_by_type
so as to simplify the handling, shorten the code and make more space
for new elements.  With the benefit of hindsight info_mask should
have been done like this in the first place.

Jonathan


Jonathan Cameron (3):
  staging:iio:adc:spear move to info_mask_(shared_by_type/separate)
  staging:iio:adc:mxs move to info_mask_(shared_by_type/separate)
  staging:iio:adc:lpc32xx move to info_mask_(shared_by_type/separate)

 drivers/staging/iio/adc/lpc32xx_adc.c | 2 +-
 drivers/staging/iio/adc/mxs-lradc.c   | 2 +-
 drivers/staging/iio/adc/spear_adc.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.1.4

