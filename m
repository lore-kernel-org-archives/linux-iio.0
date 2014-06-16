Return-Path: <denis@eukrea.com>
Message-ID: <539F1373.9090006@eukrea.com>
Date: Mon, 16 Jun 2014 17:55:31 +0200
From: Denis Carikli <denis@eukrea.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
 linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/6] mfd: fsl imx25 Touchscreen ADC driver
References: <1402910933-20534-1-git-send-email-denis@eukrea.com> <20140616112649.GQ14323@lee--X1>
In-Reply-To: <20140616112649.GQ14323@lee--X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/16/2014 01:26 PM, Lee Jones wrote:
>
>> +static void mx25_tsadc_nop(struct irq_data *d)
>> +{
>> +}
>
> Err, no, this is not required.  Just don't populate the call-backs.
>
>> +static int mx25_tsadc_set_wake_nop(struct irq_data *d, unsigned int state)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip mx25_tsadc_irq_chip = {
>> +	.name = "mx25-tsadc",
>> +	.irq_ack = mx25_tsadc_nop,
>> +	.irq_mask = mx25_tsadc_nop,
>> +	.irq_unmask = mx25_tsadc_nop,
>
> No need to do this.

I can avoid all callbacks but the irq_mask/irq_unmask ones:
Even if I add some flags to prevent it to be called during probe, it 
can't be avoided to be called when an IRQ arrives.

It's called by handle_level_irq, which is setup as handler in 
mx25_tsadc_domain_map. I don't think it's a good idea to rewrite it not 
to depend on irq_mask/irq_unmask.

Here's what happens when an IRQ arrives (Shortened version):
[<c005391c>] (handle_level_irq)
[<c0050930>] (generic_handle_irq)
[<c02dc544>] (mx25_tsadc_irq_handler)
[<c0050930>] (generic_handle_irq)
[<c0009e64>] (handle_IRQ)
[<c0008710>] (avic_handle_irq)
[...]

Then handle_level_irq it runs mask_ack_irq inconditionally.
mask_ack_irq in turn will try to executes irq_mask_ack or else irq_mask 
(without checking if it's NULL) and then will provoke the NULL pointer.

Instead when I look in drivers/mfd/ I see the following drivers which 
have some dummy handlers:
wm8994-irq.c, ucb1x00-core.c, tc6393xb.c, htc-egpio.c, arizona-irq.c

So I wonder if dummy callbacks are allowed or if it's an old practice 
that has been deprecated.

Else I wonder how to avoid them:
- By setting some flags (which ones?).
- Or by re-architecting the IRQ handling between the MFD and its 
sub-devices in a way that the mfd driver is responsible for enabling and 
disabling the IRQs (instead of its subdevices). That would be done 
inside .irq_enable() and a .irq_disable().
Most of the mfd drivers that handle an IRQ controller have theses callbacks.

In the later case, how the subdevice would enable the interrupts, would 
it be done automatically? or would it have to enable the parent mfd's 
interrupts trough explicit callbacks or wrapper functions that will call 
the callbacks(irq_enable and so on, with the irq taken from the mfd's 
private struct).

I've fixed the rest of the concerns but I'll wait for an answer before 
resending so I can fix this issue too.

Denis.
