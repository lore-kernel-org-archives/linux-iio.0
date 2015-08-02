Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58466 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbbHBTnQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 15:43:16 -0400
Message-ID: <55BE72C5.5020900@gmx.de>
Date: Sun, 02 Aug 2015 21:43:01 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com
Subject: Re: [PATCH 4/6] iio: event: Add missing fields in kernel docs
References: <cover.1437737942.git.cristina.opriceana@gmail.com> <a446690ea75ff4c5dd304b4bffb2200975e284cc.1437737942.git.cristina.opriceana@gmail.com> <55BE5483.6080509@kernel.org>
In-Reply-To: <55BE5483.6080509@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb am 02.08.2015 um 19:33:
> On 24/07/15 14:21, Cristina Opriceana wrote:
>> Fix kernel docs warnings by adding the missing fields,
>> each with its associated description.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> Applied.  Thanks
> 
> Jonathan
>> ---
>>  drivers/iio/industrialio-event.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
>> index 894d813..b2f63f9 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -32,6 +32,7 @@
>>   * @dev_attr_list:	list of event interface sysfs attribute
>>   * @flags:		file operations related flags including busy flag.
>>   * @group:		event interface sysfs attribute group
>> + * @read_lock:		lock to protect kfifo read operations
>>   */
>>  struct iio_event_interface {
>>  	wait_queue_head_t	wait;
>> @@ -75,6 +76,11 @@ EXPORT_SYMBOL(iio_push_event);
>>  
>>  /**
>>   * iio_event_poll() - poll the event queue to find out if it has data
>> + * @filep:	File structure pointer to identify the device
>> + * @wait:	Poll table pointer to add the wait queue on
>> + *
>> + * Return: (POLLIN | POLLRDNORM) if data is available for reading
>> + *	   or a negative error code on failure

This can also return 0 if no data is available.

Actually, being unsigned int, the intended negative error code won't
appear - ouch! Any volunteers to address this issue?

>>   */
>>  static unsigned int iio_event_poll(struct file *filep,
>>  			     struct poll_table_struct *wait)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

