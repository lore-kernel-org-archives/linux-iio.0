Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Weinberger <richard@nod.at>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2 0/2] Provide new API to get the current time resolution
Date: Tue,  7 Apr 2015 11:12:34 +0000
Message-Id: <1428405156-6761-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

Hi,

this patch series introduces a new kernel internal API to get the
current time resolution. The first patch adds the implementation and
the second patch updates an example driver to show the possible code
simplification.

If patches 1 and 2 can't go in via the same tree, I'll resend patch 2
with more cleanup patches to dth11.c later -- the main goal for now is,
to get the new code for timekeeping reviewed and merged.

changes since V1:
* dropped patch for adding wrapper code to the iio framework
* improved commit messages

Harald Geyer (2):
  timekeeping: Provide new API to get the current time resolution
  iio: dht11: Use new function ktime_get_resolution_ns()

 drivers/iio/humidity/dht11.c |   42 ++++++++++++++++++++++--------------------
 include/linux/timekeeping.h  |    1 +
 kernel/time/timekeeping.c    |   17 +++++++++++++++++
 3 files changed, 40 insertions(+), 20 deletions(-)

-- 
1.7.2.5
