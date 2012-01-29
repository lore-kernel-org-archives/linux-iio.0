Return-Path: <jic23@kernel.org>
Message-ID: <4F252456.4040700@kernel.org>
Date: Sun, 29 Jan 2012 10:49:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH v2 6/6] staging:iio:events: Use non-atmoic bitops
References: <1324290580-17511-1-git-send-email-lars@metafoo.de> <1324290580-17511-6-git-send-email-lars@metafoo.de> <4EEFA5C2.70604@kernel.org>
In-Reply-To: <4EEFA5C2.70604@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/19/2011 08:59 PM, Jonathan Cameron wrote:
> On 12/19/2011 10:29 AM, Lars-Peter Clausen wrote:
>> We always hold the waitqueue lock when modifying the flags field. So it is safe
>> to use the non-atomic bitops here instead of the atomic versions.
>>
>> The lock has to be held, because we need to clear the busy flag and flush the
>> event fifo in one atomic operation when closing the event file descriptor.
> Good spot.  Glad to be rid of these.  Thanks for doing this series, all
> excellent tidying up and general reworking!
Have these gone to Greg?  Sorry, have lost track.

If not, atmoic -> atomic in the patch title!

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/industrialio-event.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
>> index 58243d9..5e461e1 100644
>> --- a/drivers/staging/iio/industrialio-event.c
>> +++ b/drivers/staging/iio/industrialio-event.c
>> @@ -124,7 +124,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>>  	struct iio_event_interface *ev_int = filep->private_data;
>>  
>>  	spin_lock(&ev_int->wait.lock);
>> -	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>> +	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>>  	/*
>>  	 * In order to maintain a clean state for reopening,
>>  	 * clear out any awaiting events. The mask will prevent
>> @@ -153,7 +153,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>>  		return -ENODEV;
>>  
>>  	spin_lock(&ev_int->wait.lock);
>> -	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>> +	if (__test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>>  		spin_unlock(&ev_int->wait.lock);
>>  		return -EBUSY;
>>  	}
>> @@ -162,7 +162,7 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>>  				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
>>  	if (fd < 0) {
>>  		spin_lock(&ev_int->wait.lock);
>> -		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>> +		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>>  		spin_unlock(&ev_int->wait.lock);
>>  	}
>>  	return fd;
> 
