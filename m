Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:37095 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab0IVKGz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2010 06:06:55 -0400
Message-ID: <4C99D67E.7010307@cam.ac.uk>
Date: Wed, 22 Sep 2010 11:12:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	Robin.Getz@analog.com
Subject: Re: [RFC PATCH 0/6] staging:iio:imu driver merges, fixes and new
 features.
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk> <4C99C2BF.5030107@iis.fraunhofer.de>
In-Reply-To: <4C99C2BF.5030107@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/22/10 09:47, Manuel Stahl wrote:
> Hi Jonathan,
> 
> the merge still has severe problems for adis16400. Ring buffer doesn't read elements (bytes_per_datum is always 8) but the buffer contains zeros for the elements and a valid timestamp.
> 
> The temp attribute has a different address for adis300 and adis400, so we need a separate entry here.
gah. I missed that one.  It should actually be temp_x_attr  as the datasheet clearly labels it as
the X-axis gyroscope temperature measurement. It matches the address for that on the adis16350 so that
should be fine. Otherwise the only fix would have been to add this a chip_info field and change
the attribute look up appropriately.
> 
> The attached patch fixes a few problems, but the ring buffer still does not work.
Strange. I must have messed something up. It's likely to be in the area around burst read.
The original code may have worked with all channels on, but I had to rewrite a chunk to make
it support various channel combinations.  This is in the earlier patches in the series
(before the merge ones).  I don't have any devices that will do burst mode so I couldn't
test that code.

Will look into it.

Thanks for the patch.

Those alarm attributes can wait until someone implements support for the alarms on the
adis16400. Right now they aren't used.

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index d8f76c6..b921f1d 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -484,7 +484,7 @@ static int adis16350_initial_setup(struct adis16350_state *st)
 	/* use high spi speed if possible */
 	ret = adis16350_spi_read_reg_16(dev, ADIS16350_SMPL_PRD, &smp_prd);
 	if (!ret && (smp_prd & ADIS16350_SMPL_PRD_DIV_MASK) < 0x0A) {
-		st->us->max_speed_hz = ADIS16350_SPI_SLOW;
+		st->us->max_speed_hz = ADIS16350_SPI_FAST;
 		spi_setup(st->us);
 	}

Is quite clearly a bug in the original code. I'll push that out as a separate fix patch
prior to the series. As it's obvious I'll send that directly to Greg (author as you
of course!).

The reorder doesn't matter, but does make the code order more logical.

oops on the last bug chunk. On the author front, shall we just add to the copyright
notices at the top rather than listing multiple authors?  I know a lot of the code
in here is your driver, but technically it was Barry who first used it for the central
device.  I'll propose some possible wording in an updated patch set.
> 
> Am 11.09.2010 16:58, schrieb Jonathan Cameron:
>> The first 4 are repeat postings but are now complete (oops).
>>
>> Cleaning up this driver set has been on my todo list for a while
>> and I've finally had a bit of time to see what could be done to
>> reduce the huge amount of repeat code found in the 3 IMU drivers.
>>
>> This is an RFC for two reasons. Firstly I haven't tested this as
>> fully yet and will do so before merging.  I will do a whole
>> lot more testing on the adis16350 that I have.  Coverage of the
>> adis16300 and adis16400 would be great if anyone can do so.
>> I also haven't done full testing on all the build combinations yet.
>> (there is at least one known issue to clean up!)
>> Secondly the event patch in particularly has some elements not seen
>> elsewhere before that I would like people to consider.
>>
>> Right now, only the adis16350 and adis16360 famillies are supported
>> by the event support patch.  I'll add support for the other parts
>> at a later date unless someone else beats me to it (hint!).  Note
>> this patch now actually contains the adis16350_event.c file that
>> was missing previously.
>>
>> There is one effective change to all but the adis16400 ABIs.
>> When we originally proposed the [m]_<type>_<modifier>_en
>> attributes for scan modes I very carefully stated that the index
>> [m] for a given device would not necessarily cover all values between
>> 0 and the highest present.  It was exactly this possible driver
>> merge that motivated that arguement. By allowing indexes to be
>> missed, we can have single drivers supporting various subsets of
>> sensor elements.  Here the devices are such that some interleaving
>> is possible.  This reduces the storage required for the event code,
>> so I have done it where possible.  Note the addition
>> of new devices to this driver in future may change this again!
>>
>> As ever, all comments welcome.  Any tested-bys with a part number
>> would be particularly welcome.
>>
>> Should be trivial to add the adis16367 and adis16385 to this driver.
>> Does anyone have one of these parts to test?
>>
>> Jonathan Cameron (6):
>>    staging:iio:adis16350 add non burst buffer fill and fix burst logic
>>    staging:iio:adis16350 move datardy trigger to straight interrupt.
>>    staging:iio:adis16350 Add optional event support
>>    staging:iio:adis16350 add missing registration of temp_offset attr
>>    staging:iio:adis16300 merge into adis16350 driver
>>    staging:iio:adis16400 merge into adis16350 driver
>>
>>   drivers/staging/iio/adc/adc.h               |    8 +-
>>   drivers/staging/iio/gyro/gyro.h             |   31 +-
>>   drivers/staging/iio/imu/Kconfig             |   30 +-
>>   drivers/staging/iio/imu/Makefile            |    9 +-
>>   drivers/staging/iio/imu/adis16300.h         |  184 -------
>>   drivers/staging/iio/imu/adis16300_core.c    |  756 ---------------------------
>>   drivers/staging/iio/imu/adis16300_ring.c    |  220 --------
>>   drivers/staging/iio/imu/adis16300_trigger.c |  125 -----
>>   drivers/staging/iio/imu/adis16350.h         |  117 ++++-
>>   drivers/staging/iio/imu/adis16350_core.c    |  287 +++++++++--
>>   drivers/staging/iio/imu/adis16350_event.c   |  499 ++++++++++++++++++
>>   drivers/staging/iio/imu/adis16350_ring.c    |  167 +++++-
>>   drivers/staging/iio/imu/adis16350_trigger.c |   40 +-
>>   drivers/staging/iio/imu/adis16400.h         |  208 --------
>>   drivers/staging/iio/imu/adis16400_core.c    |  752 --------------------------
>>   drivers/staging/iio/imu/adis16400_ring.c    |  231 --------
>>   drivers/staging/iio/sysfs.h                 |   17 +-
>>   17 files changed, 1067 insertions(+), 2614 deletions(-)
>>   delete mode 100644 drivers/staging/iio/imu/adis16300.h
>>   delete mode 100644 drivers/staging/iio/imu/adis16300_core.c
>>   delete mode 100644 drivers/staging/iio/imu/adis16300_ring.c
>>   delete mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
>>   create mode 100644 drivers/staging/iio/imu/adis16350_event.c
>>   delete mode 100644 drivers/staging/iio/imu/adis16400.h
>>   delete mode 100644 drivers/staging/iio/imu/adis16400_core.c
>>   delete mode 100644 drivers/staging/iio/imu/adis16400_ring.c
>>
> 
> 

