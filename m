Return-Path: <lars@metafoo.de>
Message-ID: <52F657F9.3080701@metafoo.de>
Date: Sat, 08 Feb 2014 17:14:49 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Michal Simek <michal.simek@xilinx.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio:adc: Add Xilinx XADC driver
References: <1391534692-9049-1-git-send-email-lars@metafoo.de> <1391534692-9049-2-git-send-email-lars@metafoo.de> <52F63DCE.6030107@kernel.org>
In-Reply-To: <52F63DCE.6030107@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/08/2014 03:23 PM, Jonathan Cameron wrote:
> On 04/02/14 17:24, Lars-Peter Clausen wrote:
>> The Xilinx XADC is a ADC that can be found in the series 7 FPGAs from Xilinx.
>> The XADC has a DRP interface for communication. Currently two different
>> frontends for the DRP interface exist. One that is only available on the ZYNQ
>> family as a hardmacro in the SoC portion of the ZYNQ. The other one is
>> available
>> on all series 7 platforms and is a softmacro with a AXI interface. This
>> driver
>> supports both interfaces and internally has a small abstraction layer that
>> hides
>> the specifics of these interfaces from the main driver logic.
>>
>> The ADC has a couple of internal channels which are used for voltage and
>> temperature monitoring of the FPGA as well as one primary and up to 16
>> channels
>> auxiliary channels for measuring external voltages. The external auxiliary
>> channels can either be directly connected each to one physical pin on the
>> FPGA
>> or they can make use of an external multiplexer which is responsible for
>> multiplexing the external signals onto one pair of physical pins.
>>
>> The voltage and temperature monitoring channels also have an event capability
>> which allows to generate a interrupt when their value falls below or raises
>> above a set threshold.
>>
>> Buffered sampling mode is supported by the driver, but only for AXI-XADC
>> since
>> the ZYNQ XADC interface does not have capabilities for supporting buffer mode
>> (no end-of-conversion interrupt).
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Hi Lars,

Hi,

Thanks for the review.

>
> One double free bug in the error handling at the end of probe and
> a few requests for some explanatory comments.  Otherwise looks great to me.
>
> Could you describe the two triggers in the description section of the patch.
>

Ok.

> Also, if you could insert a few references to the relevant docs from Xilinx
> that
> would also be great!

I can include the names of the documents which describe the XADC. The URLs 
seem to change on a regular basis.

>
> Hmm.. To think I read this one first as it looked like it might be the easiest
> driver in my inbox to review :)

Yea, its a beast.

[...]
>> +static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd,
>> +    unsigned int n)
>> +{
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < n; i++)
>> +        xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
>> +}
>> +
>> +static void xadc_zynq_drain_fifo(struct xadc *xadc)
>> +{
>> +    uint32_t status, tmp;
>> +
>> +    xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
>> +
>> +    while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
>> +        xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
>> +        xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
>> +    }
>> +}
>> +
>> +static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask,
>> +    unsigned int val)
>> +{
>> +    xadc->zynq_intmask &= ~mask;
>> +    xadc->zynq_intmask |= val;
>> +
>> +    xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK,
>> +        xadc->zynq_intmask | xadc->zynq_masked_alarm);
>> +}
>> +
> Hmm. These are complex beasts. I'm not entirely sure I've understood them
> correctly... Might take another look at some point.

The core that talks to the XADC is basically doing jtag do this. You submit 
register writes/reads to a FIFO and then a couple of moments later you can 
read the response from a different FIFO. I'll add a few comments explaining 
this.

[...]
>> +static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>> +{
>> +    struct xadc *xadc = iio_priv(indio_dev);
>> +    const struct iio_chan_spec *chan;
>> +    unsigned int offset;
>> +    uint16_t val;
>> +    int ret;
>> +
>> +    /* Temperature threshold error, we don't handle this yet */
>> +    if (event == 0)
>> +        return;
>> +
>> +    if (event < 4)
>> +        offset = event;
>> +    else
>> +        offset = event + 4;
>> +
>> +    if (event < 3)
>> +        chan = &indio_dev->channels[event];
>> +    else if (event == 3)
>> +        chan = &indio_dev->channels[0];
>> +    else
>> +        chan = &indio_dev->channels[event - 1];
>> +
>> +    if (event != 3) {
>
> Is there any guarantee that, by the time we get here, the value will not
> have crossed back over the threshold?   Might be better just to not
> separate the two and use IIO_EV_DIR_EITHER.  I'm not sure either way on this
> one.

Hm, ok. I'm not to sure, but I'll give it a though.
