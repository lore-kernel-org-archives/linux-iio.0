Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbGMUrE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 16:47:04 -0400
Message-ID: <55A423C5.5040107@kernel.org>
Date: Mon, 13 Jul 2015 21:47:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 4.2 cycle (merge window dependency)
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 6aaf0da8728c55ff627619f933ed161cc89057c6:

  Merge tag 'md/4.2' of git://neil.brown.name/md (2015-06-29 11:10:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2b

for you to fetch changes up to 8d05abfaeff52bdf66aba3a3a337dcdbdb4911bf:

  iio: tmp006: Check channel info on write (2015-07-05 14:22:33 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.2 cycle. Note these depend (mostly) on
material in the recent merge window, hence their separation from set (a)
as the fixes-togreg branch predated the merge window.  I am running rather
later with these than I would have liked hence the large set.

* stk3310 fixes from Hartmut's review that came in post merge
  - fix direction of proximity inline with recent documentation
    clarification.
  - fix missing REGMAP_I2C dependency
  - rework the error handling for raw readings to fix an failure to power
    down in the event of a raw reading failing.
  - fix a bug in the compensation code which was toggling an extra bit in the
    register.
* mmc35240 - reported samplign frequencies were wrong.
* ltr501 fixes
  - fix a case of returning the return value of a regmap_read instead of
    the value read.
  - fix missing regmap dependency
* sx9500 - fix missing default values for ret in a couple of places to handle
  the case of no enabled channels.
* tmp006 - check that writes to info_mask elements are actually to writable
  ones.  Otherwise, writing to any of them will change the sampling frequency.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iio: sx9500: Add missing init in sx9500_buffer_pre{en,dis}able()

Hartmut Knaack (3):
      iio:light:stk3310: Fix REGMAP_I2C dependency
      iio:light:ltr501: fix variable in ltr501_init
      iio:light:ltr501: fix regmap dependency

Peter Meerwald (1):
      iio: tmp006: Check channel info on write

Teodora Baluta (1):
      iio: magnetometer: mmc35240: fix available sampling frequencies

Tiberiu Breana (1):
      iio: light: STK3310: un-invert proximity values

Vlad Dogaru (2):
      iio: sx9500: rework error handling of raw readings
      iio: sx9500: fix bug in compensation code

 drivers/iio/light/Kconfig           |  2 ++
 drivers/iio/light/ltr501.c          |  2 +-
 drivers/iio/light/stk3310.c         | 53 ++++++++++++-------------------------
 drivers/iio/magnetometer/mmc35240.c | 35 ++++++++++++++----------
 drivers/iio/proximity/sx9500.c      | 26 +++++++++---------
 drivers/iio/temperature/tmp006.c    |  3 +++
 6 files changed, 58 insertions(+), 63 deletions(-)
