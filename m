Return-Path: <lars@metafoo.de>
Message-ID: <4FD1AE08.3080602@metafoo.de>
Date: Fri, 08 Jun 2012 09:47:20 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] staging:iio: Add helper function for initializing
 triggered buffers
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-2-git-send-email-lars@metafoo.de> <4FD0FC70.2060906@kernel.org>
In-Reply-To: <4FD0FC70.2060906@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2012 09:09 PM, Jonathan Cameron wrote:
> On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
>> Add a helper function for executing the common tasks which are usually involved
>> in setting up a simple triggered buffer. It will allocate the buffer, allocate
>> the pollfunc and register the buffer.
> 
> Hi Lars-Peter,
> 
> Sorry for the delay in reviewing this.
> 
I usually need longer to respond than you do, so no problem.

> I'm not entirely sure how this will stand in the long run but the stats
> speak for themselves...
> 
> Pain that it has to be yet another module but your logic is sound.
> Perhaps naming it industrialio-triggered-buffer-helper might
> make it's purpose a tiny bit clearer?

Yeah, I had that name going through my mind as well but decided against it,
because it is rather long.

> 
> Otherwise, this needs it's own header for point of view of code
> separation (as it's a separate module).

Yep, already had that on my todolist for v2.

> 
> Beyond that fine by me.

Thanks.

> 
> [...]
>> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
>> new file mode 100644
>> index 0000000..653ebe5
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-triggered-buffer.c
[...]
>> +/**
>> + * iio_triggered_buffer_setup() - Setup simple software ringbuffer and pollfunc
>> + * @indio_dev:		IIO device structure
>> + * @pollfunc_bh:	Function which will be used as pollfunc bottom half
>> + * @pollfunc_th:	Function which will be used as pollfunc top half
>> + * @setup_ops:		Buffer setup functions to use for this device.
>> + *			If NULL the default setup functions for triggered
>> + *			buffers will be used.
>> + *
>> + * This function combines some common tasks which will normally be performed
>> + * when setting up a triggered buffer. It will allocate the buffer and the
>> + * pollfunc, as well as register the buffer with IIO core.
>> + *
>> + * Before calling this function the indio_dev structure should already be
>> + * completly initzialized but not yet registered.
> I'd rather you listed exactly what needs to have happened.
> iio_device_alloc I think...

Everything needs to have happened, except for iio_device_register. I'll add
a sentence which that the function should be called right before
iio_device_register.
