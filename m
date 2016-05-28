Return-Path: <gucea.doru@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7b5bc17a-04eb-ce3b-81eb-a7378d0921e5@intel.com>
References: <1464265414-8395-1-git-send-email-doru.gucea@intel.com>
	<7b5bc17a-04eb-ce3b-81eb-a7378d0921e5@intel.com>
Date: Sat, 28 May 2016 11:32:02 +0300
Message-ID: <CANfLQrbpRaHaf-pWSgztvSbXFRF1izZhuJZH3fcDe1t9o01X9g@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Support software triggers
From: Gucea Doru <gucea.doru@gmail.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Doru Gucea <doru.gucea@intel.com>, jic23@kernel.org, daniel.baluta@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lucas.demarchi@intel.com,
	cmo@melexis.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 27, 2016 at 6:15 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 05/26/2016 03:23 PM, Doru Gucea wrote:
>> In order to support software triggers (e.g.: hr-based trigger) the
>> operations from trigger enable/disable are moved to buffer enable/
>> disable.
>>
>> This also allows us to remove the mutex from inv_mpu6050_read_fifo:
>> inv_reset_fifo can't access in parallel shared fields because the
>> buffers must be enabled prior to reading data.
>>
>> A benefit of removing the mutex is that we avoid a deadlock at
>> buffer wqdisable time. The scenario was the following:
>> (1) at buffer disable time the indio_dev->mlock is acquired
>> (2) free_irq is called and waits for IRQs completion
>> (3) inv_mpu6050_read_fifo tries to acquire the indio_dev->mlock
>
> I'm not sure this is safe, it seems to me that inv_reset_fifo assumes
> mlock is taken and this needs to be assured. I think properly removing
> the irq disabling deadlock require either using something other than
> mlock or not calling inv_reset_fifo from the interrupt at all. The
> latter seems preferable to me. But this issue should be handled
> separately from software trigger support.
>

inv_reset_fifo still needs to be called: it might happen that we miss a
DATA_RDY interrupt in which case we'll have a mismatch between
time-stamps and bytes from the FIFO queues. The only way to recover
from such a situation is to flush the FIFO's and restart the interrupt.

Regarding the locking, before my patch, inv_reset_fifo could flush the
FIFO's (see inv_mpu_data_rdy_trigger_set_state) while
inv_mpu6050_read_fifo was reading data and the role of the mlock was
to avoid this situation. This situation is not possible anymore because
the operations from trigger enable/disable were moved to buffer
enable/disable: trigger state can't be changed while buffers are enabled.
Do you see another scenario?

I'll split the software trigger support and deadlock solution in two patches.

> Another issue is that the fifo is filled at the sampling frequency
> configured in device registers and this can be different from the
> sampling frequency configured on the software trigger. It seems to me
> that the user needs to manually ensure that they are identical.
>

A solution would be to hook the iio_hrtimer_info_store_sampling_frequency
method of the hrtimer for setting the sampling frequency together with
the timer frequency. I think this will require changes to the hrtimer for
exposing the above function to drivers. Daniel, what would be the right
approach?

> Even if they are identical the timer ticks might not match perfectly.
> When reading from the fifo all available samples are handled.
>
> If device frequency is set too high you will push multiple samples to
> userspace, all but one of them with bad timestamps. It's also possible
> to find zero samples if device frequency is set higher than timer frequency.
>

In case of timer ticks mismatch there will also be a mismatch between
time-stamps and bytes from the FIFO queues. I wonder if a clean recovery
from such a situation would be to call inv_reset_fifo together with resetting
the hrtimer.

> --
> Regards,
> Leonard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Doru
