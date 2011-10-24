Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-167.synserver.de ([212.40.185.167]:1083 "HELO
	smtp-out-167.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755758Ab1JXL71 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 07:59:27 -0400
Message-ID: <4EA5533E.40703@metafoo.de>
Date: Mon, 24 Oct 2011 13:59:58 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:events: Make sure userspace buffer is large
 enough
References: <1319457163-15889-1-git-send-email-lars@metafoo.de> <4EA5521D.90403@cam.ac.uk>
In-Reply-To: <4EA5521D.90403@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2011 01:55 PM, Jonathan Cameron wrote:
> On 10/24/11 12:52, Lars-Peter Clausen wrote:
>> Make sure that the userspace buffer is large enough to hold a iio_event_data
>> struct before writing to it.
>>
> Good catch.  Shall I tack this on the end of the two fixes sets I sent earlier?

Fine with me. Thanks.

>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/industrialio-core.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
>> index 74904f1..733e83a 100644
>> --- a/drivers/staging/iio/industrialio-core.c
>> +++ b/drivers/staging/iio/industrialio-core.c
>> @@ -169,8 +169,11 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>>  {
>>  	struct iio_event_interface *ev_int = filep->private_data;
>>  	struct iio_detected_event_list *el;
>> +	size_t len = sizeof(el->ev);
>>  	int ret;
>> -	size_t len;
>> +
>> +	if (count < len)
>> +		return -EINVAL;
>>  
>>  	mutex_lock(&ev_int->event_list_lock);
>>  	if (list_empty(&ev_int->det_events)) {
>> @@ -192,7 +195,6 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>>  	el = list_first_entry(&ev_int->det_events,
>>  			      struct iio_detected_event_list,
>>  			      list);
>> -	len = sizeof el->ev;
>>  	if (copy_to_user(buf, &(el->ev), len)) {
>>  		ret = -EFAULT;
>>  		goto error_mutex_unlock;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

