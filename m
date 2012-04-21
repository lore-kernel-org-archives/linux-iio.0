Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35939 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab2DUJKo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Apr 2012 05:10:44 -0400
Message-ID: <4F927993.6020406@kernel.org>
Date: Sat, 21 Apr 2012 10:10:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14] Staging:iio: Cleanup and refactor pre multibuffer.
References: <1334754834-13622-1-git-send-email-jic23@kernel.org> <4F919648.2070503@metafoo.de>
In-Reply-To: <4F919648.2070503@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/2012 06:00 PM, Lars-Peter Clausen wrote:
> On 04/18/2012 03:13 PM, Jonathan Cameron wrote:
>> Sits on top of the series
>>
>> [PATCH 00/16 V3] IIO: Make the value attribute optional for channels
>>  
>> This series consists of the first chunk of what was
>> [PATCH 1/4] staging:iio: make all buffer access pass through the buffer_list
>> As Lars-Peter rightly pointed out that patch was a whole mess of different
>> elements all bunged in together.
>>
>> I believe this lot are all fairly uncontroversial unless I have trashed
>> a driver by accident. (which is entirely plausible).
> 
> Yep, looks all pretty straight forward. With the compiler warning fixed:
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Fixed up and sent on to Greg.
> 
>>
>> There are a few temporary frigs in here to ensure some of the cached
>> values are correct before we put the real change in place.
>> For example the scan_timestamp gets cached both in the core and in the
>> buffers. For this change it would have made sense to drop it from the
>> buffers but then we'd just end up putting it back again a few patches
>> later.
>>
>> Anyhow, please do take a look at what we have here.  Some are
>> trivial, but there are a good few driver reworks that could do
>> with testing (as I'll almost guarantee I've messed something up
>> ripping the original large patch apart!)
>>
>> Thanks,
>>
>> Jonathan Cameron 
>>
>> Jonathan Cameron (14):
>>   staging:iio:buffer trivial use of strtobool to remove dodgy
>>     equivalent.
>>   staging:iio:buffer: pull computation of scan length into a utility
>>     function.
>>   staging:iio: scan_index_timestamp move to iio_dev from buffer
>>   staging:iio: add caching of the number of bytes in a scan.
>>   staging:iio:adc:ad7192 make use of iio_sw_buffer_preenable.
>>   staging:iio:adc:ad7298 use iio_sw_buffer_preenable to avoid code
>>     repitition.
>>   staging:iio:adc:ad7476 use iio_sw_buffer_preenable instead of local
>>     version.
>>   staging:iio:adc:ad7793 use iio_sw_buffer_preenable to avoid
>>     repitition.
>>   staging:iio:adc:ad7887 make use of iio_sw_buffer_preenable.
>>   staging:iio:adc:ad799x use iio_sw_buffer_preenable to avoid code
>>     repitiion
>>   staging:iio:meter:ad7758 use iio_sw_buffer_preenable to avoid code
>>     repition
>>   staging:iio:impedance-analyser make use of iio_sw_buffer_preenable
>>   staging:iio: Add caching of scan_timestamp to the core as well as
>>     buffers.
>>   staging:iio: pull out demux cleanup for a particular buffer.
>>
>>  drivers/staging/iio/accel/adis16201_ring.c      |    5 +-
>>  drivers/staging/iio/accel/adis16203_ring.c      |    5 +-
>>  drivers/staging/iio/accel/adis16204_ring.c      |    5 +-
>>  drivers/staging/iio/accel/adis16209_ring.c      |    6 +-
>>  drivers/staging/iio/accel/adis16240_ring.c      |    5 +-
>>  drivers/staging/iio/accel/lis3l02dq_ring.c      |    6 +-
>>  drivers/staging/iio/adc/ad7192.c                |   24 ++------
>>  drivers/staging/iio/adc/ad7298.h                |    1 -
>>  drivers/staging/iio/adc/ad7298_ring.c           |   26 +++------
>>  drivers/staging/iio/adc/ad7476.h                |    1 -
>>  drivers/staging/iio/adc/ad7476_ring.c           |   38 +-----------
>>  drivers/staging/iio/adc/ad7606_ring.c           |    8 +--
>>  drivers/staging/iio/adc/ad7793.c                |   23 ++------
>>  drivers/staging/iio/adc/ad7887.h                |    1 -
>>  drivers/staging/iio/adc/ad7887_ring.c           |   25 ++------
>>  drivers/staging/iio/adc/ad799x.h                |    1 -
>>  drivers/staging/iio/adc/ad799x_ring.c           |   24 +-------
>>  drivers/staging/iio/adc/max1363_ring.c          |    4 +-
>>  drivers/staging/iio/buffer.h                    |    2 -
>>  drivers/staging/iio/gyro/adis16260_ring.c       |    5 +-
>>  drivers/staging/iio/iio.h                       |    6 ++
>>  drivers/staging/iio/iio_simple_dummy_buffer.c   |   11 +--
>>  drivers/staging/iio/impedance-analyzer/ad5933.c |   11 +---
>>  drivers/staging/iio/imu/adis16400_ring.c        |    4 +-
>>  drivers/staging/iio/industrialio-buffer.c       |   69 +++++++++++++++--------
>>  drivers/staging/iio/meter/ade7758_ring.c        |   22 ++-----
>>  26 files changed, 121 insertions(+), 217 deletions(-)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

