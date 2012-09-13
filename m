Return-Path: <anish198519851985@gmail.com>
Subject: Re:iio: Documentation change for inkern interface.
From: anish kumar <anish198519851985@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
In-Reply-To: <504C688C.3010400@kernel.org>
References: <1346600372-3284-1-git-send-email-anish198519851985@gmail.com>
	 <5049A7B8.506@kernel.org> <1347088218.5051.152.camel@anish-Inspiron-N5050>
	 <504B1941.6000708@kernel.org>
	 <1347183129.5051.174.camel@anish-Inspiron-N5050>
	 <504C655D.70901@metafoo.de>  <504C688C.3010400@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Sep 2012 21:26:51 +0530
Message-ID: <1347551811.1589.82.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

I didn't hear from you on this patch.Probably
this patch is lost in your box or somehow it
got missed.
Is it already applied?

a-n-i-s-h

Author: anish kumar <anish198519851985@gmail.com>
Date:   Sun Sep 9 01:05:26 2012 +0530

    iio: Documentation change for inkern interface.
    
    This commit- 314be14bb renamed the _st_ functions to loose the bit
    that was meant for staging version but forgot to change
    the documentation which still have _st_ sprinkled in some of the
    places.
    
    Signed-off-by: anish kumar <anish198519851985@gmail.com

diff --git a/drivers/staging/iio/Documentation/inkernel.txt
b/drivers/staging/iio/Documentation/inkernel.txt
index a05823e..ab52840 100644
--- a/drivers/staging/iio/Documentation/inkernel.txt
+++ b/drivers/staging/iio/Documentation/inkernel.txt
@@ -48,11 +48,11 @@ There are then a number of functions that can be
used to get information
 about this channel such as it's current reading.
 
 e.g.
-iio_st_read_channel_raw() - get a reading
-iio_st_read_channel_type() - get the type of channel
+iio_read_channel_raw() - get a reading
+iio_get_channel_type() - get the type of channel
 
 There is also provision for retrieving all of the channels associated
 with a given consumer.  This is useful for generic drivers such as
 iio_hwmon where the number and naming of channels is not known by the
-consumer driver.  To do this, use iio_st_channel_get_all.
+consumer driver.  To do this, use iio_channel_get_all.
