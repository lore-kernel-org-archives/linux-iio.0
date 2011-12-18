Return-Path: <jic23@kernel.org>
Message-ID: <4EEE5E6D.6000703@kernel.org>
Date: Sun, 18 Dec 2011 21:43:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 2/4] staging:iio:events: Use kfifo for event queue
References: <1324055542-31272-1-git-send-email-lars@metafoo.de> <1324055542-31272-2-git-send-email-lars@metafoo.de> <4EEE5E35.3020506@kernel.org>
In-Reply-To: <4EEE5E35.3020506@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/18/2011 09:42 PM, Jonathan Cameron wrote:
> On 12/16/2011 05:12 PM, Lars-Peter Clausen wrote:
>> The current IIO event code uses a list to emulate FIFO like behaviour.
>> Just use a kfifo directly instead to implement the event queue.
> Please also add that this changes number of elements queue to 16 from
> (I think) 10.
> 
> One bit to do with remove comment but not code that needs fixing...
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/staging/iio/industrialio-event.c |   89 ++++++------------------------
>>  1 files changed, 18 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
>> index 17ed582..50d03bd 100644
>> --- a/drivers/staging/iio/industrialio-event.c
>> +++ b/drivers/staging/iio/industrialio-event.c
>> @@ -26,31 +26,17 @@
>>  #include "events.h"
>>  
>>  /**
>> - * struct iio_detected_event_list - list element for events that have occurred
>> - * @list:		linked list header
>> - * @ev:			the event itself
>> - */
>> -struct iio_detected_event_list {
>> -	struct list_head		list;
>> -	struct iio_event_data		ev;
>> -};
>> -
>> -/**
>>   * struct iio_event_interface - chrdev interface for an event line
>>   * @dev:		device assocated with event interface
>>   * @wait:		wait queue to allow blocking reads of events
>> - * @event_list_lock:	mutex to protect the list of detected events
> The comment goes in this patch, but the element is still there.  The
> next patch removes the users for this but not I think the actual element.
Ah my mistake, it is removed in the next patch.  Please shift this
comment removal to there.
>>   * @det_events:		list of detected events
>> - * @max_events:		maximum number of events before new ones are dropped
>> - * @current_events:	number of events in detected list
>>   * @flags:		file operations related flags including busy flag.
>>   */
>>  struct iio_event_interface {
>>  	wait_queue_head_t			wait;
>>  	struct mutex				event_list_lock;
>> -	struct list_head			det_events;
>> -	int					max_events;
>> -	int					current_events;
>> +	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
>> +
>>  	struct list_head dev_attr_list;
>>  	unsigned long flags;
>>  	struct attribute_group			group;
>> @@ -59,33 +45,24 @@ struct iio_event_interface {
>>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>>  {
>>  	struct iio_event_interface *ev_int = indio_dev->event_interface;
>> -	struct iio_detected_event_list *ev;
>> +	struct iio_event_data ev;
>>  	int ret = 0;
>>  
>>  	/* Does anyone care? */
>>  	mutex_lock(&ev_int->event_list_lock);
>>  	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>> -		if (ev_int->current_events == ev_int->max_events) {
>> -			mutex_unlock(&ev_int->event_list_lock);
>> -			return 0;
>> -		}
>> -		ev = kmalloc(sizeof(*ev), GFP_KERNEL);
>> -		if (ev == NULL) {
>> -			ret = -ENOMEM;
>> -			mutex_unlock(&ev_int->event_list_lock);
>> -			goto error_ret;
>> -		}
>> -		ev->ev.id = ev_code;
>> -		ev->ev.timestamp = timestamp;
>>  
>> -		list_add_tail(&ev->list, &ev_int->det_events);
>> -		ev_int->current_events++;
>> +		ev.id = ev_code;
>> +		ev.timestamp = timestamp;
>> +
>> +		ret = kfifo_put(&ev_int->det_events, &ev);
>> +
>>  		mutex_unlock(&ev_int->event_list_lock);
>> -		wake_up_interruptible(&ev_int->wait);
>> +		if (ret != 0)
>> +			wake_up_interruptible(&ev_int->wait);
> perhaps rename ret to something indicating that it is the number
> of elements copied?  That way it is obvious we are checking if
> the kfifo is full rather than for errors.
>>  	} else
>>  		mutex_unlock(&ev_int->event_list_lock);
>>  
>> -error_ret:
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(iio_push_event);
>> @@ -96,15 +73,14 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>>  				     loff_t *f_ps)
>>  {
>>  	struct iio_event_interface *ev_int = filep->private_data;
>> -	struct iio_detected_event_list *el;
>> -	size_t len = sizeof(el->ev);
>> +	unsigned int copied;
>>  	int ret;
>>  
>> -	if (count < len)
>> +	if (count < sizeof(struct iio_event_data))
>>  		return -EINVAL;
>>  
>>  	mutex_lock(&ev_int->event_list_lock);
>> -	if (list_empty(&ev_int->det_events)) {
>> +	if (kfifo_is_empty(&ev_int->det_events)) {
>>  		if (filep->f_flags & O_NONBLOCK) {
>>  			ret = -EAGAIN;
>>  			goto error_mutex_unlock;
>> @@ -112,52 +88,29 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>>  		mutex_unlock(&ev_int->event_list_lock);
>>  		/* Blocking on device; waiting for something to be there */
>>  		ret = wait_event_interruptible(ev_int->wait,
>> -					       !list_empty(&ev_int
>> -							   ->det_events));
>> +					!kfifo_is_empty(&ev_int->det_events));
>>  		if (ret)
>>  			goto error_ret;
>>  		/* Single access device so no one else can get the data */
>>  		mutex_lock(&ev_int->event_list_lock);
>>  	}
>>  
>> -	el = list_first_entry(&ev_int->det_events,
>> -			      struct iio_detected_event_list,
>> -			      list);
>> -	if (copy_to_user(buf, &(el->ev), len)) {
>> -		ret = -EFAULT;
>> -		goto error_mutex_unlock;
>> -	}
>> -	list_del(&el->list);
>> -	ev_int->current_events--;
>>  	mutex_unlock(&ev_int->event_list_lock);
>> -	kfree(el);
>> -
>> -	return len;
>> +	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
>>  
>>  error_mutex_unlock:
>>  	mutex_unlock(&ev_int->event_list_lock);
>>  error_ret:
>> -
>> -	return ret;
>> +	return ret ? ret : copied;
>>  }
>>  
>>  static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
>>  {
>>  	struct iio_event_interface *ev_int = filep->private_data;
>> -	struct iio_detected_event_list *el, *t;
>>  
>>  	mutex_lock(&ev_int->event_list_lock);
>>  	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>> -	/*
>> -	 * In order to maintain a clean state for reopening,
>> -	 * clear out any awaiting events. The mask will prevent
>> -	 * any new __iio_push_event calls running.
>> -	 */
> Comment is still relevant (if updated appropriately)
>> -	list_for_each_entry_safe(el, t, &ev_int->det_events, list) {
>> -		list_del(&el->list);
>> -		kfree(el);
>> -	}
>> -	ev_int->current_events = 0;
>> +	kfifo_reset_out(&ev_int->det_events);
>>  	mutex_unlock(&ev_int->event_list_lock);
>>  
>>  	return 0;
>> @@ -269,9 +222,6 @@ static ssize_t iio_ev_value_store(struct device *dev,
>>  	unsigned long val;
>>  	int ret;
>>  
>> -	if (!indio_dev->info->write_event_value)
>> -		return -EINVAL;
>> -
>>  	ret = strict_strtoul(buf, 10, &val);
>>  	if (ret)
>>  		return ret;
>> @@ -402,10 +352,7 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
>>  static void iio_setup_ev_int(struct iio_event_interface *ev_int)
>>  {
>>  	mutex_init(&ev_int->event_list_lock);
>> -	/* discussion point - make this variable? */
>> -	ev_int->max_events = 10;
>> -	ev_int->current_events = 0;
>> -	INIT_LIST_HEAD(&ev_int->det_events);
>> +	INIT_KFIFO(ev_int->det_events);
>>  	init_waitqueue_head(&ev_int->wait);
>>  }
>>  
> 
