Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51766 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3FDSbA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 14:31:00 -0400
Message-ID: <51AE3262.6050906@kernel.org>
Date: Tue, 04 Jun 2013 19:30:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.10 - set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e919b86c3b018c0e0c5e522354e743dcc0824ee1:

  staging: alarm-dev: information leak in alarm_ioctl() (2013-06-03 13:38:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.10b

for you to fetch changes up to 6c5d4c96f979611f0165dc825af9e1cea8dd35b9:

  iio:inkern: Fix typo/bug in convert raw to processed. (2013-06-04 18:46:45 +0100)

----------------------------------------------------------------
Second round of IIO fixes for the 3.10 cycle.

A couple of little bits and pieces, some delayed due to traveling.

1) A memory leak fix in the callback buffer.
2) Wrong exit path due to a return when it should have been a goto.
3) Bug in a mask value in ad4350
4) Reading the wrong value in raw to processed utility function.

----------------------------------------------------------------
Joe Perches (1):
      inkern: iio_device_put after incorrect return/goto

Jonathan Cameron (1):
      iio:callback buffer: free the scan_mask

Michael Hennerich (2):
      iio: frequency: ad4350: Fix bug / typo in mask
      iio:inkern: Fix typo/bug in convert raw to processed.

 drivers/iio/buffer_cb.c         | 5 ++++-
 drivers/iio/frequency/adf4350.c | 2 +-
 drivers/iio/inkern.c            | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)
