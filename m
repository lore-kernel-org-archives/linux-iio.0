Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] IIO break info_mask into a pair of masks - Additional drivers
Date: Sun,  3 Mar 2013 20:03:51 +0000
Message-Id: <1362341033-9506-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This short series applies the equivalent changes to the two new drivers
to enter the IIO tree whilst the series in

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

Jonathan Cameron (2):
  iio:adc:exynos move to info_mask_(shared_by_type/separate)
  iio:adc:ad7923 move to info_mask_(shared_by_type/separate)

 drivers/iio/adc/ad7923.c     | 4 ++--
 drivers/iio/adc/exynos_adc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.1.4
