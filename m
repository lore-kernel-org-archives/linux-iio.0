Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48328 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaBCTAs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2014 14:00:48 -0500
Message-ID: <52EFE77A.3030802@kernel.org>
Date: Mon, 03 Feb 2014 19:01:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes 3.14 set 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c6236c0ce39c809c336ca929f68cf8ad02cf94e0:

   staging: comedi: drivers: fix return value of comedi_load_firmware() (2013-12-17 13:05:53 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.14a

for you to fetch changes up to 8c314da583c9d5c67fe59aa8c92f94f15cb8de90:

   staging:iio:lpc32xx_adc: Add dependency on HAS_IOMEM (2014-01-18 11:49:39 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 3.14 cycle.

Included is the patch previously set as the fourth round for 3.13 which was
to late to be appropriate.

* Another endian fix (ad799x adc) due to missuse of the IIO_ST macro (which
   is going away very shortly)
* A reversed error check in ad5933 which will make the probe fail.
* A buffer overflow in the example code in the documentation.
* ad799x was freeing an irq that might or might not have been requested.
* tsl2563 was checking the wrong element of chan_spec for modifiers. Thus some
   sysfs reads would give the wrong values.
* A missing dependency on HAS_IOMEM in spear_adc and lpc32xx was causing some
   test build failures (on s390 and perhaps elsewhere).

I also have a few fixes queued up for things that went in during the 3.14
merge window which will follow as a separate pull request (to avoid rebasing
my tree).

----------------------------------------------------------------
Craig Markwardt (1):
       iio: Fix a buffer overflow in iio_utils.h example code

Hartmut Knaack (1):
       staging:iio:ad799x fix error_free_irq which was freeing an irq that may not have been requested

Ivaylo Dimitrov (1):
       iio: tsl2563: Use the correct channel2 member

Jonathan Cameron (1):
       staging:iio:ad799x fix incorrect endianness specification for buffer elements

Julia Lawall (1):
       staging:iio:impedance:ad5933: correct error check

Richard Weinberger (2):
       staging:iio:spear_adc: Add dependency on HAS_IOMEM
       staging:iio:lpc32xx_adc: Add dependency on HAS_IOMEM

  drivers/iio/light/tsl2563.c                     | 16 ++++++++++------
  drivers/staging/iio/Documentation/iio_utils.h   |  6 +++---
  drivers/staging/iio/adc/Kconfig                 |  2 ++
  drivers/staging/iio/adc/ad799x_core.c           | 11 +++++++++--
  drivers/staging/iio/impedance-analyzer/ad5933.c |  2 +-
  5 files changed, 25 insertions(+), 12 deletions(-)
