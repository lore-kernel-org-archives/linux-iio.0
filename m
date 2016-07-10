Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36571 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbcGJV3L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 17:29:11 -0400
Date: Sun, 10 Jul 2016 14:29:08 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: humidity: hdc100x: update driver locking
Message-ID: <cover.1468180067.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset intends to tidy up the driver locking. 

The global data lock needs to to protect writes to the configuration
register and single channel reads which can be of temp or humidity.

First patch moves the config register locking to the config update
function.  This continues to protect updates to heater and integration
times. It puts the lock in one place, right where it needs to occur.

Second patch removes the lock on configuration reads of data stored
in global data.  While the write lock prevents two simultaneous writes
(ie. Heater and int_time) to the register, which could return false
success status, the read doesn't have the same issue.  You get the 
status at the moment, at it's guaranteed for that moment only.
This also aligns with drivers non-locking of other reads of global
data configuration status - ie integration time.
  
I believe these changes stand alone as good cleanups to the locking.
Alas, my ulterior motive is to prep it so that I can cleanly apply
the locks for triggered buffer mode.

 
Alison Schofield (2):
  iio: humidity: hdc100x: move lock on config updates to single function
  iio: humidity: hdc100x: remove lock on heater configuration read

 drivers/iio/humidity/hdc100x.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.1.4

