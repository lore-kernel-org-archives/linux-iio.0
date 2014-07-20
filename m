Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36650 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaGTSwy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jul 2014 14:52:54 -0400
Message-ID: <53CC1094.4040306@jic23.retrosnub.co.uk>
Date: Sun, 20 Jul 2014 19:55:16 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL]  Fifth set of IIO fixes for the 3.16 cycle
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  The following changes since commit 71702e6e52c8312f4c6797a9787d0f8b5656156f:

   iio: mma8452: Use correct acceleration units. (2014-07-12 13:18:55 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.16e

for you to fetch changes up to 9b2a4d35a6ceaf217be61ed8eb3c16986244f640:

   iio:bma180: Missing check for frequency fractional part (2014-07-20 17:39:47 +0100)

----------------------------------------------------------------
Fifth set of fixes for IIO in the 3.16 cycle.

One nasty one that has been around a long time and a couple of non compliant
ABI fixes.

* The demux code used to split out desired channels for devices that only
   support reading sets of channels at one time had a bug where it was
   building it's conversion tables against the wrong bitmap resulting in
   it never actually demuxing anything.  This is an old bug, but will be
   effecting an increasing number of drivers as it is often used to avoid
   some fiddly code in the individual drivers.

* bma180 and mma8452 weren't obeying the ABI wrt to units for acceleration.
   Were in G rather than m/s^2. A little input check was missing from bma180
   that might lead to acceptance of incorrect values.  This last one is minor
   but might lead to incorrect userspace code working and problems in the
   future.

----------------------------------------------------------------
Lars-Peter Clausen (1):
       iio: buffer: Fix demux table creation

Peter Meerwald (2):
       iio:bma180: Fix scale factors to report correct acceleration units
       iio:bma180: Missing check for frequency fractional part

  drivers/iio/accel/bma180.c        | 8 +++++---
  drivers/iio/industrialio-buffer.c | 2 +-
  2 files changed, 6 insertions(+), 4 deletions(-)
