Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/2] iio: sx9500: couple of bug fixes
Date: Tue, 30 Jun 2015 14:20:57 +0300
Message-Id: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Spotted by Hartmut during a review of an already applied patch.  Once again,
thanks for the feedback.

Vlad Dogaru (2):
  iio: sx9500: rework error handling of raw readings
  iio: sx9500: fix bug in compensation code

 drivers/iio/proximity/sx9500.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
1.9.1
