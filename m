Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53570 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3DNLX7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Apr 2013 07:23:59 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3]  staging:iio:adis16130 bits and bobs.
Date: Sun, 14 Apr 2013 12:23:42 +0100
Message-Id: <1365938625-21778-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Had a few bored moments so thought I'd take a quick look at this driver.
The read function is rather odd to say the least, Lars/Michael could one of
you take a quick look at this.  Right now it does an spi sync that I think
should read the data and follows it with an additional read.  I can't
immediately see what the read is for.

Also note the introduction of IIO_INT_PLUS_PICO which is going to be common
with 24 bit plus devices.  For now I've ignored the write case as this driver
doesn't support it, but it will be needed if for example 24/16 bit options
are both supported for this driver.

Note to my mind this device is far enough away from the other adis parts
in interface to justify it's own driver.

Also could someone check my scale/offset calcs are right. It's Sunday
morning and I'm not feeling all that awake ;)

Thanks,

Jonathan 

Jonathan Cameron (3):
  iio:Add an IIO_VAL_INTO_PLUS_PICO return type for read_raw callbacks.
  staging:iio:gyro:adis16130 drop unused list.h header.
  staging:iio:gyro:adis16130 add offset and scale info mask elements.

 drivers/iio/industrialio-core.c           |  5 +++
 drivers/staging/iio/gyro/adis16130_core.c | 58 +++++++++++++++++++++++++------
 include/linux/iio/types.h                 |  1 +
 3 files changed, 53 insertions(+), 11 deletions(-)

-- 
1.8.2.1

