Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823Ab2GLTVF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:21:05 -0400
Message-ID: <4FFF239F.5090502@kernel.org>
Date: Thu, 12 Jul 2012 20:21:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [GIT PULL] IIO enhancements for staging-next
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c732a24c5a9392cf3738f5957e0d97d37c09e6e1:

  staging:iio:adt7410: use local platformdata if none is specified
(2012-07-08 10:39:59 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/togreg-3.6a

for you to fetch changes up to bbdb822c4c3f8dbefd8f6dc84f6d98c33af6e051:

  iio: add adjd_s311 I2C digital color sensor driver (2012-07-12
17:45:34 +0100)

----------------------------------------------------------------
One new driver and a couple of nice cleanups.

----------------------------------------------------------------
I'm still working on a coherent tag naming. Suggestions welcome!

Jon Brenner (1):
      IIO channel type and modifiers for CCT and RGBC data

Jonathan Cameron (1):
      iio: Trivial documentation fix to correct kernel version info in
   21cd1fab058671313f7c178b640999fcd0d8de21

Lars-Peter Clausen (5):
      iio: Add callback to check whether a scan mask is valid
      iio: Introduce iio_validate_scan_mask_onehot
      staging:iio:ad7192: Use iio_validate_scan_mask_onehot
      staging:iio:ad7793: Use iio_validate_scan_mask_onehot
      staging:iio:ade7758: Use iio_validate_scan_mask_onehot

Peter Meerwald (1):
      iio: add adjd_s311 I2C digital color sensor driver

 drivers/iio/industrialio-buffer.c                  |  43 ++-
 drivers/iio/industrialio-core.c                    |   5 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/adjd_s311.c                      | 364
+++++++++++++++++++++
 .../staging/iio/Documentation/sysfs-bus-iio-light  |  23 ++
 drivers/staging/iio/adc/ad7192.c                   |  10 +-
 drivers/staging/iio/adc/ad7793.c                   |  14 +-
 drivers/staging/iio/meter/ade7758.h                |   1 -
 drivers/staging/iio/meter/ade7758_core.c           |   7 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   1 +
 include/linux/iio/buffer.h                         |   3 +
 include/linux/iio/iio.h                            |   4 +
 include/linux/iio/types.h                          |   5 +
 14 files changed, 460 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iio/light/adjd_s311.c
