Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60925 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbcFCLN6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 07:13:58 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Support software triggers
To: Gucea Doru <gucea.doru@gmail.com>
References: <1464265414-8395-1-git-send-email-doru.gucea@intel.com>
 <7b5bc17a-04eb-ce3b-81eb-a7378d0921e5@intel.com>
 <CANfLQrbpRaHaf-pWSgztvSbXFRF1izZhuJZH3fcDe1t9o01X9g@mail.gmail.com>
 <2032e108-d159-64df-922e-24ed8f23fc9b@kernel.org>
 <CANfLQrYpEQMo96Hk35z7gfhDckOupCvoCMtnqfuRfyvNaOau3g@mail.gmail.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Doru Gucea <doru.gucea@intel.com>, daniel.baluta@intel.com,
	knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1576fc81-0490-d24a-da88-b58bbfe65cad@kernel.org>
Date: Fri, 3 Jun 2016 12:13:55 +0100
MIME-Version: 1.0
In-Reply-To: <CANfLQrYpEQMo96Hk35z7gfhDckOupCvoCMtnqfuRfyvNaOau3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/16 08:55, Gucea Doru wrote:
> On Sun, May 29, 2016 at 7:14 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 28/05/16 09:32, Gucea Doru wrote:
>>> On Fri, May 27, 2016 at 6:15 PM, Crestez Dan Leonard
>>> <leonard.crestez@intel.com> wrote:
>>>> On 05/26/2016 03:23 PM, Doru Gucea wrote:
>>>>> In order to support software triggers (e.g.: hr-based trigger) the
>>>>> operations from trigger enable/disable are moved to buffer enable/
>>>>> disable.
>>>>>
>>>>> This also allows us to remove the mutex from inv_mpu6050_read_fifo:
>>>>> inv_reset_fifo can't access in parallel shared fields because the
>>>>> buffers must be enabled prior to reading data.
>>>>>
>>>>> A benefit of removing the mutex is that we avoid a deadlock at
>>>>> buffer wqdisable time. The scenario was the following:
>>>>> (1) at buffer disable time the indio_dev->mlock is acquired
>>>>> (2) free_irq is called and waits for IRQs completion
>>>>> (3) inv_mpu6050_read_fifo tries to acquire the indio_dev->mlock
>>>>
>>>> I'm not sure this is safe, it seems to me that inv_reset_fifo assumes
>>>> mlock is taken and this needs to be assured. I think properly removing
>>>> the irq disabling deadlock require either using something other than
>>>> mlock or not calling inv_reset_fifo from the interrupt at all. The
>>>> latter seems preferable to me. But this issue should be handled
>>>> separately from software trigger support.
>>>>
>>>
>>> inv_reset_fifo still needs to be called: it might happen that we miss a
>>> DATA_RDY interrupt in which case we'll have a mismatch between
>>> time-stamps and bytes from the FIFO queues. The only way to recover
>>> from such a situation is to flush the FIFO's and restart the interrupt.
>>>
>>> Regarding the locking, before my patch, inv_reset_fifo could flush the
>>> FIFO's (see inv_mpu_data_rdy_trigger_set_state) while
>>> inv_mpu6050_read_fifo was reading data and the role of the mlock was
>>> to avoid this situation. This situation is not possible anymore because
>>> the operations from trigger enable/disable were moved to buffer
>>> enable/disable: trigger state can't be changed while buffers are enabled.
>>> Do you see another scenario?
>>>
>>> I'll split the software trigger support and deadlock solution in two patches.
>>>
>>>> Another issue is that the fifo is filled at the sampling frequency
>>>> configured in device registers and this can be different from the
>>>> sampling frequency configured on the software trigger. It seems to me
>>>> that the user needs to manually ensure that they are identical.
>>>>
>>>
>>> A solution would be to hook the iio_hrtimer_info_store_sampling_frequency
>>> method of the hrtimer for setting the sampling frequency together with
>>> the timer frequency. I think this will require changes to the hrtimer for
>>> exposing the above function to drivers. Daniel, what would be the right
>>> approach?
>> Back to basic questions from me ;)
>>
>> Why do you want to use a software trigger here at all?  Trying to align the two
>> sampling frequencies is really a non starter - it'll never work however hard
>> you try.  So I am guessing you want to support sampling when the interrupts
>> are not wired up?  If so the only way to handle that is to use a thread
>> to sample the interrupt status register fast enough to get a reasonable idea
>> of when it changed... basically fake the interrupt wire.
>>
> 
> Yes, I was trying to use a software trigger because I have a chip without GPIO
> support. I followed the model from BMC150 accel that allows installing
> a software
> trigger even if there is no interrupt line connected. At this moment,
> the probe for
> MPU60X0 fails if there is no interrupt line connected.
> 
> Another reason for using a sw trigger was for masking the USB latency because
> the sensor is connected to an USB to SPI adapter while a hardware
> interrupt would
> have eaten some bandwidth.
> 
> Sampling once the interrupt status register will need one USB TX operations and
> one USB RX operation. This is expensive compared to a hardware
> interrupt that will
> need only a USB RX operation. However, I could send a rework for this patch that
> uses a thread for sampling the intr register if you consider that
> someone needs it.
Sadly there is never a good way to handle this problem - but yes I think
the best we can do is the threaded sampling of that register.  We
did have one driver that allowed a custom overriding to do 'best guess'
timing. So it defaulted to the right thing, but if the user explicitly
overrode it, the driver would start sampling at the supposed sampling
frequency.

Can I remember which one it was... err. Sorry nope..  Not entirely sure
it even merged.

Jonathan
> 
>> If you want to be able to run this device on say a much slower clock then we
>> need to look at how to bypass the fifo entirely (read from the relevant sensor
>> registers instead I think...)
>>
>>
>>
>>
>>
>>
>>>
>>>> Even if they are identical the timer ticks might not match perfectly.
>>>> When reading from the fifo all available samples are handled.
>>>>
>>>> If device frequency is set too high you will push multiple samples to
>>>> userspace, all but one of them with bad timestamps. It's also possible
>>>> to find zero samples if device frequency is set higher than timer frequency.
>>>>
>>>
>>> In case of timer ticks mismatch there will also be a mismatch between
>>> time-stamps and bytes from the FIFO queues. I wonder if a clean recovery
>>> from such a situation would be to call inv_reset_fifo together with resetting
>>> the hrtimer.
>> This is going to happen frequently  - how frequently will depend on the drift
>> between the two clocks.  Not a lot of point of having a high frequency sampling
>> system that resets every few seconds dropping some samples on the floor.
>>
>> Jonathan
>>>
>>>> --
>>>> Regards,
>>>> Leonard
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> Regards,
>>> Doru
>>>
>>

