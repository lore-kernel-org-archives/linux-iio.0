Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/2] ade7854 beginning of cleanup.
Date: Fri, 11 Feb 2011 15:39:14 +0000
Message-Id: <1297438756-26920-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is an RFC because of the macro usage in the second patch. For starters
I haven't actually checked I got those write beyond build testing!

Just wondering what peoples opinions are on that sort of Macro usage
before I head too far in that direction.

Jonathan Cameron (2):
  staging:iio:meter:ade7854 move to spi_write and spi_write_the_read
  staging:iio:meter:ade7854 spi - use macros for the whole series of
    nearly     identical read and write functions.

 drivers/staging/iio/meter/ade7854-spi.c |  339 +++++--------------------------
 1 files changed, 56 insertions(+), 283 deletions(-)

-- 
1.7.3.4
