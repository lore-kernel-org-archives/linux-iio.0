Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45744 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2KBKlf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 06:41:35 -0400
Message-ID: <5093A35C.5030806@kernel.org>
Date: Fri, 02 Nov 2012 10:41:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO new device support and cleanups (set 2 for the 3.8 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e446f5a8540a845ed92fca4109e67c8f0c76031f:

  Staging: bcm: Remove typedef stLocalSFAddRequestAlt. (2012-10-30 19:44:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8b

for you to fetch changes up to 1e45cf3c493cb76618558201a8ef6f3a065f9073:

  iio: isl29018: Support suspend and resume. (2012-11-02 09:50:59 +0000)

----------------------------------------------------------------
Second round of new IIO drivers and cleanups for the 3.8 cycle.

Usual mixed bag of cleanups and minor improvements including
one reversion for a patch in the previous series.

* adt7310 and adt7410 drivers merged into one.
* Revert use devm_kcalloc in at91_adc (because it doesn't exist)
* unlocking fix for error path in the ad5449
* isl29018 suspend and resume support.
* improved pseudo floating point parsing for info_mask write
attributes (and hence into write_raw).  Reject some messed up
strings.

----------------------------------------------------------------
Axel Lin (1):
      Revert "iio: at91_adc: Use devm_kcalloc to allocate arrays"

Bryan Freed (1):
      iio: isl29018: Support suspend and resume.

Dan Carpenter (1):
      iio:dac:ad5449: unlock on error path

Kumar Amit Mehta (1):
      staging: iio: adc: ad7280a.c: fixed macro coding style

Lars-Peter Clausen (4):
      staging:iio: Consolidate adt7310 and adt7410 driver
      iio: Do not accept multiple '.' in fixed point numbers
      iio: Reject trailing garbage when parsing fixed point numbers
      iio: Accept a leading '+' sign when parsing fixed point numbers

 drivers/iio/adc/at91_adc.c           |  16 +-
 drivers/iio/dac/ad5449.c             |   7 +-
 drivers/iio/industrialio-core.c      |   6 +-
 drivers/staging/iio/adc/Kconfig      |  13 +-
 drivers/staging/iio/adc/Makefile     |   1 -
 drivers/staging/iio/adc/ad7280a.c    |   2 +-
 drivers/staging/iio/adc/adt7310.c    | 881 -----------------------------------
 drivers/staging/iio/adc/adt7410.c    | 458 ++++++++++++++----
 drivers/staging/iio/light/isl29018.c |  45 ++
 9 files changed, 427 insertions(+), 1002 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/adt7310.c
