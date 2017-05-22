Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760729AbdEVSp7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 May 2017 14:45:59 -0400
Date: Mon, 22 May 2017 19:45:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 4.12 cycle.
Message-ID: <20170522194318.25e236ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e44adf05b85e5a9d1d224f5ecde1c1c5e5371e36:

  staging/android: Update Ion TODO list (2017-04-18 20:43:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.12a

for you to fetch changes up to 82237f268281d338aa35cd014be8ffb0b5445482:

  iio: adc: sun4i-gpadc-iio: fix parent device being used in devm function (2017-05-21 15:17:40 +0100)

----------------------------------------------------------------
First set of IIO fixes in the 4.12 cycle.

Matt finally set up the lightning storm he needed to test the as3935.

* core
  - Fix a null pointer deference in iio_trigger_write_current when changing
  from a non existent trigger to another non existent trigger.
* a3935
  - Recalibrate the RCO after resume.
  - Fix interrupt mask so that we actually get some interrupts.
  - Use iio_trigger_poll_chained as we aren't in interrupt context.
* am335x
  - Fix wrong allocation size provided for private data to iio_device_alloc.
* bcm_iproc
  - Swapped primary and secondary isr handlers.
* ltr501
  - Fix swapped als/ps register fields when enabling interrupts
* max9611
  - Wrong scale factor for the shunt_resistor attribute.
* sun4-gpadc
  - Module autoloading fixes by adding the device table declarations.
  - Fix parent device being used in devm functions.

----------------------------------------------------------------
Dan Carpenter (2):
      iio: adc: Max9611: checking for ERR_PTR instead of NULL in probe
      iio: adc: ti_am335x_adc: allocating too much in probe

Eduardo Molinas (2):
      iio: adc: sun4i-gpadc-iio: Fix module autoload when PLATFORM devices are registered
      iio: adc: sun4i-gpadc-iio: Fix module autoload when OF devices are registered

Franziska Naepelt (1):
      iio: light: ltr501 Fix interchanged als/ps register field

Jacopo Mondi (1):
      iio: adc: max9611: Fix attribute measure unit

Marcin Niestroj (1):
      iio: trigger: fix NULL pointer dereference in iio_trigger_write_current()

Matt Ranostay (3):
      iio: proximity: as3935: recalibrate RCO after resume
      iio: proximity: as3935: fix AS3935_INT mask
      iio: proximity: as3935: fix iio_trigger_poll issue

Quentin Schulz (1):
      iio: adc: sun4i-gpadc-iio: fix parent device being used in devm function

Raveendra Padasalagi (1):
      iio: adc: bcm_iproc_adc: swap primary and secondary isr handler's

 drivers/iio/adc/bcm_iproc_adc.c    |  8 ++++----
 drivers/iio/adc/max9611.c          | 10 +++++-----
 drivers/iio/adc/sun4i-gpadc-iio.c  | 38 ++++++++++++++++++++++++--------------
 drivers/iio/adc/ti_am335x_adc.c    |  2 +-
 drivers/iio/industrialio-trigger.c |  3 ++-
 drivers/iio/light/ltr501.c         |  4 ++--
 drivers/iio/proximity/as3935.c     | 14 ++++++--------
 7 files changed, 44 insertions(+), 35 deletions(-)
