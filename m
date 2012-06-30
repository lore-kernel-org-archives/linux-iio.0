Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab2F3MY2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 08:24:28 -0400
Message-ID: <4FEEEFF8.8050305@kernel.org>
Date: Sat, 30 Jun 2012 13:24:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes v3.5-rc4
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Please consider pulling the following fixes.

I've based these on your staging-linus branch which happens
right now to be v3.5-rc4.

None are exactly critical if you want to hold them for the next
merge window.

Obviously any suggestions / requests on how to do these pull
requests welcomed!

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg

for you to fetch changes up to 06d5199d4c53615338d0453b62458cd82fb88f33:

  staging:iio: Add some missing peak elements to the info_mask
(2012-06-30 10:12:36 +0100)

----------------------------------------------------------------
Jonathan Cameron (2):
      staging:iio:accel:adis16204 fix bug in channel modifier handling
      staging:iio: Add some missing peak elements to the info_mask

Lars-Peter Clausen (1):
      staging:iio:ad7793: Fix scan index for the "shorted" channel

Peter Meerwald (3):
      iio staging: fix potential resource leak in generic_buffer
      iio staging: fix potential memory/resource leaks in
find_type_by_name()
      iio staging: fix resource leak in _write_sysfs_int()

 drivers/staging/iio/Documentation/iio_utils.h | 24 +++++++++++++++++++-----
 drivers/staging/iio/accel/adis16204_core.c    |  2 +-
 drivers/staging/iio/accel/adis16240_core.c    |  9 ++++++---
 drivers/staging/iio/adc/ad7793.c              |  4 ++--
 4 files changed, 28 insertions(+), 11 deletions(-)
