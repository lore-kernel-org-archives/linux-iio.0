Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33157 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcEXTP1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 15:15:27 -0400
Date: Tue, 24 May 2016 12:15:25 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] iio: adc: clean up claims on direct mode in ad7* drivers
Message-ID: <cover.1464115008.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This set looks at the ad7* drivers and migrates them to use the 
iio helper functions iio_device_claim|release_direct_mode(). 

The first three (7266,7791,7793) were not already holding a lock on
direct mode, so this will be a change in behavior for those drivers.

The last four (7476,7887,7923,799x) were already locking so these
are migrations to the claim/release helper functions.

Worth noting: This does not clean up all mlock (ab-)uses in ad799x. 
This driver is still using mlock in a few other places not associated
with locking down direct mode. 

Alison Schofield (7):
  iio: adc: ad7266: claim direct mode during sensor read
  iio: adc: ad7791: claim direct mode when writing frequency
  iio: adc: ad7793: claim direct mode when writing frequency
  iio: adc: ad7476: use iio helper function to guarantee direct mode
  iio: adc: ad7887: use iio helper function to guarantee direct mode
  iio: adc: ad7923: use iio helper function to guarantee direct mode
  iio: adc: ad799x: use iio helper function to guarantee direct mode

 drivers/iio/adc/ad7266.c |  7 +++----
 drivers/iio/adc/ad7476.c | 11 +++++------
 drivers/iio/adc/ad7791.c | 15 ++++-----------
 drivers/iio/adc/ad7793.c | 13 ++++---------
 drivers/iio/adc/ad7887.c | 11 +++++------
 drivers/iio/adc/ad7923.c | 11 +++++------
 drivers/iio/adc/ad799x.c | 24 +++++++++---------------
 7 files changed, 35 insertions(+), 57 deletions(-)

-- 
2.1.4

