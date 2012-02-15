Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36690 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2BOTr0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2012 14:47:26 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com, guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/6 V6] IIO: in kernel (as opposed to userspace) pull consumers
Date: Wed, 15 Feb 2012 19:47:59 +0000
Message-Id: <1329335285-31006-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previously IIO: in kernel pull interfaces.

Changes since the RFC V5.  The race condition on exit is avoided by
the introduction of the first patch and related modifications later.
All in kernel consumers ultimately access the IIO devices through
the iio_info structure pointer in the relevant iio_dev structure.
Thus (protected by a mutex) we can set this to null on device removal
and check it in users.  Thus ensuring a clean error is returned if
the provider is removed before the consumer has finished with it.
Right now there is nothing to even make this hard but we can
easily get the module at a later date to cut down on this happening.

Otherwise, I've made the whole thing no longer an option for IIO
as suggested by Linus.

Few cleanups beyond that from testing and appopriate updates to the
documentation.

Any comments?  I'd like to get this out the way so we can move
on to the more 'interesting' case of push interfaces (those that
are interrupt driven).  Patches for that are ready but need cleaning
up and are more invasive that these within IIO itself.

Jonathan

Jonathan Cameron (6):
  staging:iio:core set the iio_dev.info pointer to null on unregister
    under lock.
  staging:iio:core add in kernel interface mapping and getting IIO
    channels.
  staging:iio: move iio data return types into types.h for use by
    inkern
  staging:iio::hwmon interface client driver.
  staging:iio:Documentation in kernel pull description.
  stargate2: example of map configuration for iio to hwmon example.

 arch/arm/mach-pxa/stargate2.c                  |   24 ++
 drivers/staging/iio/Documentation/inkernel.txt |   58 +++++
 drivers/staging/iio/Kconfig                    |    7 +
 drivers/staging/iio/Makefile                   |    4 +-
 drivers/staging/iio/consumer.h                 |   96 ++++++++
 drivers/staging/iio/driver.h                   |   34 +++
 drivers/staging/iio/iio.h                      |    8 +-
 drivers/staging/iio/iio_hwmon.c                |  232 +++++++++++++++++++
 drivers/staging/iio/industrialio-core.c        |    4 +
 drivers/staging/iio/inkern.c                   |  292 ++++++++++++++++++++++++
 drivers/staging/iio/machine.h                  |   24 ++
 drivers/staging/iio/types.h                    |    4 +
 12 files changed, 780 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/inkernel.txt
 create mode 100644 drivers/staging/iio/consumer.h
 create mode 100644 drivers/staging/iio/driver.h
 create mode 100644 drivers/staging/iio/iio_hwmon.c
 create mode 100644 drivers/staging/iio/inkern.c
 create mode 100644 drivers/staging/iio/machine.h

-- 
1.7.8.4

