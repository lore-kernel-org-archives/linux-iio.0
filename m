Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:54047 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab3HSOu4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 10:50:56 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRS0052J97NJ6A0@mailout3.w1.samsung.com> for
 linux-iio@vger.kernel.org; Mon, 19 Aug 2013 15:50:55 +0100 (BST)
Message-id: <521230CB.20801@samsung.com>
Date: Mon, 19 Aug 2013 16:50:51 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 0/3] gp2ap020a00f ambient light/proximity sensor
References: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com>
 <5210ADC3.6090704@kernel.org>
In-reply-to: <5210ADC3.6090704@kernel.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/18/2013 01:19 PM, Jonathan Cameron wrote:
> On 08/16/13 14:11, Jacek Anaszewski wrote:
>> This driver supports:
>>   - reading channels in 'one shot' mode through read_raw callback,
>>   - four events - rising and falling ambient light events and
>>     rising and falling proximity roc events.
>>   - triggers for all the three channels (triggers can't be enabled
>>     simultaneosly with proximity detection event)
>>
>> This is a follow-up of the previous patch and it includes
>> following improvements (Jonathan - thanks for the review)
>>    - switched over to using devm_iio_device_alloc
>>    - switched over to using devm_request_threaded_irq
>>    - switched over to using newly implemented managed allocator
>>      for iio_trigger
>>    - simplified error handling path in the probe function
>>    - switched over to using standard endian conversion
>>      functions
>>    - removed redundant debugfs interface
>>    - removed local reg_mask variables from gp2ap020a00f_set_operation_mode
>>
>> Jonathan, I'd like to also make sure that you've seen my emails
>> in the threads related to the first and the second version of this RFC.
>> I asked there some vital questions related to this driver but they are
>> left unanswered. I will repeat them here:
> oops. I'm awful at responding to tricky questions / or reading cover
> letters.  Sorry about that.
>>
>>    - I am getting warning while calling iio_trigger_poll, and I am not
>>      sure if it is acceptable:
>>
>>      WARNING: at kernel/irq/handle.c:146handle_irq_event_percpu+0x2a4/0x2b4()
>>      irq 8 handler iio_pollfunc_store_time+0x0/0x38 enabled interrupts
> Drat, I'd missed this entirely. The issue here is that your trigger has
> to sleep (and hence occurs in a bottom half) in order to work out what it is
> receiving (event or dataready).  Triggers are actually interrupt chips thus
> the top half is expected to be called in interrupt context but you've already
> left it in this case.  Hence there are two options... Either don't allow for a
> top half and call iio_trigger_poll_chained instead (which will only call the
> bottom halfs) or do it in a similar fashion to that done in the sysfs trigger.
> (drivers/iio/triggers/iio-trig-sysfs) This uses an irq_work structure
> to jump back into interrupt context and call the iio_trigger_poll successfully.

I've applied the second option. The first one also works but there
is a problem with timestamp - its value for each capture is the same.
It gets changed only after the driver module is reloaded. It seems
to contain garbage as it can assume also extremely high negative
values.

> We probably need to check for other drivers suffering this issue.  Mostly
> hardware uses separate physical pins for events vs data ready so this isn't
> that common. I know some ST devices do this.  This always made the lis3l02dq
> driver a pain to deal with (though now the that the irq_work stuff exists
> that should be easy to tidy up).
>
>>
>>    - I am still encountering "module in use" message when I am trying
>>      to execute rmmod on a driver module after generic_buffer application
>>      has been launched at least once. This is not specific only to my
>>      implementation but also for lps331ap driver (the only one of the
>>      remaining IIO drivers supporting triggers I am able to test
>>      currently).
> Umm.. I'm unsure, but it 'might' be something to do with the interrupt issues
> that are firing the above warning (though I doubt it as the lps331ap isn't
> suffering from that bug - as it currently stands in tree).
> Check that all the sysfs entries are as one would expect (no trigger attached
> or buffered enabled etc).  Might be a bug in generic_buffer but I haven't
> personally seen it do this.

Fixing the warning didn't fix this problem. I've checked sysfs entries
- the buffer is not enabled, no trigger is attached. I don't know if
this is correct, but when I build build my driver as a module I get
also the module industrialio-triggered-buffer.ko built, which has to
be loaded prior to the driver module.

>>    - The scale value for the illuminance_clear channel changes dynamically,
>>      depending on the lux mode set. I think that currently IIO isn't
>>      prepared for such a situation?
>
> Indeed not.  The overhead to indicate this in buffered mode will completely
> defeat the object of having that so lightweight.  My suggestion would be
> to apply the scale to the data before pushing it to the driver.

Do you mean before pushing it to the buffer, in the trigger handler?
If so, then how to inform the user what scale has been applied to
the values in the buffer? And how to provide in-driver-scaled
output value to sysfs? Currently there are only *_raw and _*scale
attributes available. Maybe it would be convenient to come up with
a new attrribute, dedicated to the in-driver-scaled values?

Thanks,
Jacek
