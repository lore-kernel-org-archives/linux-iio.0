Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57245 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab1JULrn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 07:47:43 -0400
Message-ID: <4EA15BE5.50906@cam.ac.uk>
Date: Fri, 21 Oct 2011 12:47:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: core.  Allow for event chrdev obtaining
 ioctl if no buffer present.
References: <1319196865-22766-1-git-send-email-jic23@cam.ac.uk> <1319196865-22766-2-git-send-email-jic23@cam.ac.uk> <4EA15B98.5050506@metafoo.de>
In-Reply-To: <4EA15B98.5050506@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 12:46, Lars-Peter Clausen wrote:
> On 10/21/2011 01:34 PM, Jonathan Cameron wrote:
>> Logic bug meant the chrdev would fail to open if there was no buffer support
>> in a driver or in the core. This meant the ioctl to get the event chrdev
>> would fail and hence events were not available.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
> 
>> I've tested this on the tsl2563 driver and it all seems fine.
>> Lars-Peter - could you hammer this a little to see if I have
>> missed any corner cases?
> 
> This is basically what I had locally for testing my tool, so it should work.
> One minor comment though.
> 
> 
>>  drivers/staging/iio/iio_core.h            |    2 +-
>>  drivers/staging/iio/industrialio-buffer.c |    6 +++++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
>> index 36159e0..ff27f13 100644
>> --- a/drivers/staging/iio/iio_core.h
>> +++ b/drivers/staging/iio/iio_core.h
>> @@ -49,7 +49,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>  
>>  static inline int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
>>  {
>> -	return -EINVAL;
>> +	return 0;
>>  }
>>  
>>  static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
>> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
>> index bac672d..1a71171 100644
>> --- a/drivers/staging/iio/industrialio-buffer.c
>> +++ b/drivers/staging/iio/industrialio-buffer.c
>> @@ -42,6 +42,8 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>  	struct iio_dev *indio_dev = filp->private_data;
>>  	struct iio_buffer *rb = indio_dev->buffer;
>>  
>> +	if (!rb)
>> +		return -ENODEV;
> 
> I think -EINVAL would be a better return code here.
> Quote from the read(3) manpage:
> "EINVAL: fd is attached to an object which is unsuitable for reading;"
Hmm. arguably you are reading form a buffer than doesn't exist, but I guess
that bit of semantics might make no sense to users.  Will change that for v2.

Jonathan
> 
>>  	if (!rb->access->read_first_n)
>>  		return -EINVAL;
>>  	return rb->access->read_first_n(rb, n, buf);
>> @@ -67,7 +69,7 @@ int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
>>  {
>>  	struct iio_buffer *rb = indio_dev->buffer;
>>  	if (!rb)
>> -		return -EINVAL;
>> +		return 0;
>>  	if (rb->access->mark_in_use)
>>  		rb->access->mark_in_use(rb);
>>  	return 0;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

