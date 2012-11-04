Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42029 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2KDQZz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2012 11:25:55 -0500
Message-ID: <50969712.9030602@kernel.org>
Date: Sun, 04 Nov 2012 16:25:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO cleanups and fixes (IIO set 3 for the 3.8 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 15358a7f777529500cb1fcb089c09fb792fecf30:

  staging: comedi: adl_pci9118: support auto-attachment (2012-11-02 11:39:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8c

for you to fetch changes up to 3c7f0c2b1150eae8683a98a5a9143d81edfc2762:

  staging:iio:adis16400: Set the PROD_ID flag for the adis16334 (2012-11-04 15:55:44 +0000)

----------------------------------------------------------------
Third round of IIO subsystem updates for the 3.8 cycle.

Here we have a series of fixes to the adis16400 driver. These
were part of a previous pull request for the 3.7 cycle but
Greg suggested delaying them given their large and invasive
nature and the fact they aren't fixing regressions (as the
relevant code was never correct).

The support added for the adis16334 missed a number of small
differences between this and the parts supported.  This series
deals with those and also cleans up some related code.

----------------------------------------------------------------
Lars-Peter Clausen (4):
      staging:iio:adis16400: Fix adis16334 sampling frequency control
      staging:iio:adis16400: Fix product id check
      staging:iio:adis16400: Remove now duplicated chip_table entry
      staging:iio:adis16400: Set the PROD_ID flag for the adis16334

 drivers/staging/iio/imu/adis16400.h      |  12 ++-
 drivers/staging/iio/imu/adis16400_core.c | 145 +++++++++++++++++++++----------
 2 files changed, 106 insertions(+), 51 deletions(-)
