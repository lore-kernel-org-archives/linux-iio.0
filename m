Return-Path: <SRS0=B0fY=57=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 0/2] iio: light: tcs3472: support out-of-threshold events
Date: Tue, 27 Jun 2017 00:44:53 +0900
Message-Id: <1498491895-19393-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is a second attempt to support out-of-threshold events for tcs3472 driver.

* Changes from v1
- Drop "fix ATIME register write" patch as it has been applied to iio.git
- Prepare the addition of datasheet link as a separate patch
- Neaten the special function code notation
- Improve the code comment for tcs3472_intr_pers[]
- Fix error path with invalid event info in write_event_value()
- Handle correctly if the negative period time is specified (round to the
  minimum available period time)
- Remove redundant the PERS register write
- Call free_irq() in reverse order of the initialization.

Akinobu Mita (2):
  iio: light: tcs3472: add link to datasheet
  iio: light: tcs3472: support out-of-threshold events

 drivers/iio/light/tcs3472.c | 264 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 256 insertions(+), 8 deletions(-)

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
