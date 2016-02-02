Return-Path: <afd@ti.com>
Subject: Re: [PATCH v4 2/4] iio: health: Add driver for the TI AFE4404 heart
 monitor
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, Dan
 Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell
	<ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
References: <1453742941-12086-1-git-send-email-afd@ti.com>
 <1453742941-12086-3-git-send-email-afd@ti.com> <56ACCFC6.2000700@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56B0D04B.1090208@ti.com>
Date: Tue, 2 Feb 2016 09:50:35 -0600
MIME-Version: 1.0
In-Reply-To: <56ACCFC6.2000700@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/30/2016 08:59 AM, Jonathan Cameron wrote:
> On 25/01/16 17:28, Andrew F. Davis wrote:
>> Add driver for the TI AFE4404 heart rate monitor and pulse oximeter.
>> This device detects reflected LED light fluctuations and presents an ADC
>> value to the user space for further signal processing.
>>
>> Datasheet: http://www.ti.com/product/AFE4404/datasheet
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Hi Andrew,
>
> This changed rather more than I was expecting, but fair enough.
>
> A few bits are missing from remove.  Few other little bits inline,
> though mostly those are about readability rather than what the code
> is doing.
>
> I was a little suprised to see no control over whether the trigger is
> enabled or not.  I'm trying to get my head around what the result of this will
> be.  I guess we'll have interrupts pinging away merilly doing nothing until
> the buffer is attached then the demux will get set up to actually do
> something with the data.
>
> hmm. Might be fine, if I ususual.  Normally devices have some means of
> masking the interrupt.

I wasn't sure about this ether, but it doesn't seem to break anything.

>
> Jonathan
>
>> ---
>>   .../ABI/testing/sysfs-bus-iio-health-afe440x       |  54 ++
>>   drivers/iio/health/Kconfig                         |  19 +-

[...]

>> +
>> +static const struct afe440x_reg_info afe4404_reg_info[] = {
>
> As noted below, I'd find
> [LED1] = AFE440X_REG_INFO(AFE440_LED1VAL...
> more readable.
>

ACK

[...]

>> +	int ret;
>> +
>> +	iio_device_unregister(indio_dev);
>> +
> Would expect unwinding of the triggered_buffer here.
> iio_triggered_buffer_cleanup()
>

ACK

>> +	iio_trigger_unregister(afe->trig);
> This should be protected by a check on afe->irq as for the register in probe.
> There is no protection against afe->trig == NULL in iio_trigger_unregister.
> That is kind of deliberate as it makes sure the probe / remove in drivers
> are balanced unlike here.
>

Makes sense, will add.

[...]

> I'm not overly keen on the hiding fo the indexing.  I'd prefer
> this was just the bit {...} and you had the fact it was filling in an
> indexed element explicit where used.

That works.

[...]

> I'd prefix reg_type to avoid possible name clashes in future.
>> +enum reg_type {
>> +	SIMPLE,
>> +	RESISTANCE,
>> +	CAPACITANCE,
>> +};

ACK

>> +
>> +/* this could be made more general for other IIO drivers if needed --------- */
>
> Yes, but lets do that at as a follow up.
>

Sure.

Thanks,
Andrew
