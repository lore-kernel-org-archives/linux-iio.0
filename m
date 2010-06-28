Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:55914 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0F1Jr5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2010 05:47:57 -0400
Message-ID: <4C287067.6080805@cam.ac.uk>
Date: Mon, 28 Jun 2010 10:50:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org, Barry.Song@analog.com
Subject: Re: [PATCH 0/6] Various cleanups.
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk> <AANLkTil0gGAy1qJFPizZyl0AvmUCMLMVOoaXGXXBNzOI@mail.gmail.com>
In-Reply-To: <AANLkTil0gGAy1qJFPizZyl0AvmUCMLMVOoaXGXXBNzOI@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/28/10 09:16, Barry Song wrote:
> On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> This patch set is the result of taking a look at Barry Song's
>> RFC.  The idea was to get the simple uncontroversial elements
>> of that in place before we move on to discussion of the more
>> involved elements.
> Thanks a lot for your great help.  I acked the three patches
> abstracted from the discussion.
Thanks, though for some reason I only got the ack emails on patches
3 and 4.  Which other one were you happy to ack? If you have a chane
to cast your eyes over 6 (the be16 one) just to check I got that the
right way round that would be great!

Thanks,

Jonathan
> 
>>
>> One or two general cleanups have slipped in here as well.
>>
>> Jonathan Cameron (6):
>>  staging:iio: Use kasprintf to allocate and fill trig->name
>>  staging:iio:lis3l02dq remove unused set_ring_length function
>>  staging:iio: Add and convert drivers to use iio_alloc_pollfunc
>>  staging:iio: Add iio_triggered_ring postenable and predisable + use
>>    in drivers
>>  staging:iio: remove timestamp field from trigger and pass instead
>>    through pollfuncs
>>  staging:iio: replace combine_8_to_16 with be16_to_cpup where
>>    possible.
>>
>>  drivers/staging/iio/accel/adis16209_ring.c         |   51 ++++---------------
>>  drivers/staging/iio/accel/adis16209_trigger.c      |   10 ++--
>>  drivers/staging/iio/accel/adis16240_ring.c         |   51 ++++---------------
>>  drivers/staging/iio/accel/adis16240_trigger.c      |   10 ++--
>>  drivers/staging/iio/accel/lis3l02dq_ring.c         |   53 +++++---------------
>>  drivers/staging/iio/adc/max1363_ring.c             |   45 ++---------------
>>  drivers/staging/iio/gyro/adis16260_ring.c          |   51 ++++---------------
>>  drivers/staging/iio/gyro/adis16260_trigger.c       |   10 ++--
>>  drivers/staging/iio/imu/adis16300_ring.c           |   51 ++++---------------
>>  drivers/staging/iio/imu/adis16300_trigger.c        |   10 ++--
>>  drivers/staging/iio/imu/adis16350_ring.c           |   51 ++++---------------
>>  drivers/staging/iio/imu/adis16350_trigger.c        |   10 ++--
>>  drivers/staging/iio/imu/adis16400_ring.c           |   51 ++++---------------
>>  drivers/staging/iio/imu/adis16400_trigger.c        |   10 ++--
>>  drivers/staging/iio/industrialio-trigger.c         |   48 ++++++++++++++----
>>  drivers/staging/iio/trigger.h                      |   24 ++++++---
>>  drivers/staging/iio/trigger/iio-trig-gpio.c        |   12 ++---
>>  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   15 ++----
>>  18 files changed, 164 insertions(+), 399 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

