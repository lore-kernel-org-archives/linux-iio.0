Return-Path: <lars@metafoo.de>
Message-ID: <4EEFAC89.8070703@metafoo.de>
Date: Mon, 19 Dec 2011 22:28:41 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH v2 1/6] staging:iio: Update iio_event_interface documentation
References: <1324290580-17511-1-git-send-email-lars@metafoo.de> <4EEFA4C3.4030607@kernel.org>
In-Reply-To: <4EEFA4C3.4030607@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/19/2011 09:55 PM, Jonathan Cameron wrote:
> On 12/19/2011 10:29 AM, Lars-Peter Clausen wrote:
>> The documentation for the iio_event_interface does not match the actual struct
>> anymore. This patch removes the documentation for non-existing fields and adds
>> documentation for missing fields.
>>
> Thanks for cleaning that up.  We could add that the dev_attr_list is for
> internal management only but I guess that easily established from
> how it is use...

All of the fields are more or less internal, since the struct is only defined
in this c file, so don't know if it makes sense to explicitly state it for
dev_attr_list.

>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/industrialio-core.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
>> index 2eef85f..23dd624 100644
>> --- a/drivers/staging/iio/industrialio-core.c
>> +++ b/drivers/staging/iio/industrialio-core.c
>> @@ -112,13 +112,14 @@ struct iio_detected_event_list {
>>  
>>  /**
>>   * struct iio_event_interface - chrdev interface for an event line
>> - * @dev:		device assocated with event interface
>>   * @wait:		wait queue to allow blocking reads of events
>>   * @event_list_lock:	mutex to protect the list of detected events
>>   * @det_events:		list of detected events
>>   * @max_events:		maximum number of events before new ones are dropped
>>   * @current_events:	number of events in detected list
>> + * @dev_attr_list:	list of event interface sysfs attribute
>>   * @flags:		file operations related flags including busy flag.
>> + * @group:		event interface sysfs attribute group
>>   */
>>  struct iio_event_interface {
>>  	wait_queue_head_t			wait;
> 
