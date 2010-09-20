Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:47580 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0ITKNj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 06:13:39 -0400
Message-ID: <4C97350E.6020209@cam.ac.uk>
Date: Mon, 20 Sep 2010 11:18:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH 00/10] staging:iio: implement _type attrs for scan elements
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk> <4C97207D.8090109@iis.fraunhofer.de>
In-Reply-To: <4C97207D.8090109@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/10 09:51, Manuel Stahl wrote:
> Hi Jonathan,
> 
> basically I like the patches. Just a few things:
> 
> - I know you prefer the IIO_CONST_ATTR instead of sophisticated
> macros. But if we do want to change the format, we have to modify all
> drivers again. So I'd like to see a macro like
> IIO_SCAN_EL_TYPE(_name_, signed/unsigned, _actual_size_,
> _storage_size_).
Ultimately we are rapidly approaching the point where the interfaces
are going to be near enough locked in stone for all time (or at least
we'll have to replicate any attributes we change and maintain both
for about a year). Still what you suggest is nice and clear.  I'll amend
it slightly to:

IIO_CONST_ATTR_SCAN_EL_TYPE because this isn't always constant. For the non
const version it'll need to be driver specific so I'd rather leave that local
to the drivers.  So how about:

/**
 * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan el
 * @name: the scan el name (may be more general and cover a set of scan elements
 * @_sign: either s or u for signed or unsigned
 * @_bits: number of actual bits occuplied by the value
 * @_storagebits: number of bits _bits is padded to when read out of buffer
 **/
#define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);

Not completely flexible as it doesn't allow us to change how the signed, unsigned bit
is printed, but it's short and simple.  Also, I don't have to go change all the
previous usage of these attributes as they have the same names ;)
> 
> - From "Proposal for sysfs attributes":
>>> One additional point here.  What we currently have that the enable
>>> > parameters are currently [m]_accel_x_en etc with m being an indicator
>>> > of the position of a parameter within the buffer.  Note not all channels
>>> > are enabled at a time.  For all devices we have so far, the ordering
>>> > is fixed, so this naming is constant.  Basically we roll the accel_x_index
>>> > attribute into the naming of the enable attribute.  Manuel, could you summarize
>>> > what you have against that approach? (I'm not particularly tied to it, but
>>> > it is in place and it does work).
>> Any response to this question Manuel?  Basically this question asks whether
>> we want to explicitly tell userspace what the ordering is, or instead provide
>> it with sufficient info to trivially figure it out itself.  I'm inclined to leave
>> this job to user space.
> No input yet. After thinking again about the "one value per sysfs
> attribute" mantra, I think people won't accept to read values from
> the attribute's name instead of using read/write ops. 
Fair point. Lets keep this uncontroversial and have that additional attribute
you suggested.  I'll do this as another set as it'll keep the patches nice and
clean and easy to review.

> I have no
> preference wether we recalculate the index depending on the enabled
> status.
I'm definitely against and as only us two are contributing to the discussion,
lets not recalculate them.
> 
> 
> 
> Am 19.09.2010 19:04, schrieb Jonathan Cameron:
>> Implementation of Manuel Stahl's suggested interface to describe how
>> a given scan element is stored in the buffer.
>>
>> The final patch removes the previous partial implementation of related
>> functionality.
>>
>> This is done off a combination of what was marked in the drivers and
>> datasheets.  Where the in driver elements disagree with the datasheet
>> I have assumed a bug (be it one that did not previously have any affect)
>> and gone with the datasheet.
>>
>> In one case, I don't believe the datasheet so have asked the manufacturer
>> to confirm.
>>
>> This is applied on a clean version of staging-next as I would like to
>> merge this asap and hence do not want to have it dependant on the
>> two large adis related patch sets I have posted to the mailining list.
>> Clearly those will both need to be rebased.
>>
>> Jonathan Cameron (10):
>>    staging:iio:lis3l02dq add _type attributes for all scan elements
>>    staging:iio:max1363 add _type attributes for all scan elements
>>    staging:iio:adis16209 add _type attributes for all scan elements
>>    staging:iio:adis16240 add _type attributes for all scan elements
>>    staging:iio:sca3000 add _type attributes for all scan elements
>>    staging:iio:adis16260 add _type attributes for all scan elements
>>    staging:iio:adis16300 add _type attributes for all scan elements
>>    staging:iio:adis16350 add _type attributes for all scan elements
>>    staging:iio:adis16400 add _type attributes for all scan elements
>>    staging:iio: Remove unused bit_count from struct iio_scan_el
>>
>>   drivers/staging/iio/accel/adis16209_ring.c |   36 ++++---
>>   drivers/staging/iio/accel/adis16240_ring.c |   27 +++--
>>   drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ++-
>>   drivers/staging/iio/accel/sca3000_ring.c   |   52 +++++-----
>>   drivers/staging/iio/adc/max1363_core.c     |  154 +++++++++++++++++-----------
>>   drivers/staging/iio/gyro/adis16260_ring.c  |   27 +++--
>>   drivers/staging/iio/imu/adis16300_ring.c   |   39 +++++---
>>   drivers/staging/iio/imu/adis16350_ring.c   |   44 ++++----
>>   drivers/staging/iio/imu/adis16400_ring.c   |   50 +++++----
>>   drivers/staging/iio/ring_generic.h         |   17 +--
>>   10 files changed, 261 insertions(+), 195 deletions(-)
>>
> 
> 

