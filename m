Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33272 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbaGMTIs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 15:08:48 -0400
Message-ID: <53C2D9C6.5070102@kernel.org>
Date: Sun, 13 Jul 2014 20:11:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] Fourth set of IIO fixes for the 3.16 cycle
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bdac8ca90e07edde8bbef5396784f7011e6e5b8d:

   Merge tag 'iio-fixes-for-3.16c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2014-07-08 15:43:45 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.16d

for you to fetch changes up to 71702e6e52c8312f4c6797a9787d0f8b5656156f:

   iio: mma8452: Use correct acceleration units. (2014-07-12 13:18:55 +0100)

----------------------------------------------------------------
4th set of fixes for IIO in the 3.16 cycle

* Fix incorrect handling of the iio_event_spec mask_shared_by_type
   bitmap. The point of this was to allow multiple channels to specify
   elements that lead to the same sysfs attribute.  A but in the handling
   meant that this failed.  The handling is modified to be similar to that
   used for the main IIO info_mask_shared_by_type which works correclty.
* The acceleration scale factors reported by the mma8452 driver gave
   accelerations in g, wherease the IIO ABI is in m/s^2. The fix simply
   corrects the reported scale factors.

----------------------------------------------------------------
Martin Fuzzey (1):
       iio: mma8452: Use correct acceleration units.

Srinivas Pandruvada (1):
       iio:core: Handle error when mask type is not separate

  drivers/iio/accel/mma8452.c      | 8 +++++++-
  drivers/iio/industrialio-event.c | 3 +++
  2 files changed, 10 insertions(+), 1 deletion(-)
