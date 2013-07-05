Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51D6F78E.5080301@digi.com>
Date: Fri, 5 Jul 2013 18:42:54 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>, "fabio.estevam@freescale.com"
	<fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-3-git-send-email-hector.palacios@digi.com> <201307051341.35612.marex@denx.de>
In-Reply-To: <201307051341.35612.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Dear Marek,

On 07/05/2013 01:41 PM, Marek Vasut wrote:
> Dear Hector Palacios,
>
>> Some LRADC channels have a fixed pre-divider, and all can have enabled
>> an optional divisor by two which allows a maximum input voltage of
>> VDDIO - 50mV.
>>
>> This patch
>>   - adds the scaling info flag to all channels
>>   - adds a lookup table with max reference voltage per channel
>>     (where the fixed pre-dividers apply)
>>   - allows to read the scaling attribute (computed from the Vref)
>>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>> ---
>>   drivers/staging/iio/adc/mxs-lradc.c | 122
>> +++++++++++++++++++++++++++--------- 1 file changed, 93 insertions(+), 29
>> deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index d65a594..012c42e 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -107,19 +107,63 @@ static const char * const mx28_lradc_irq_names[] = {
>>   	"mxs-lradc-button1",
>>   };
>>
>> +/*
>> + * Max reference voltage (mV) for each channel
>> + */
>> +static const int mx23_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
>> +	1850,		/* CH0 */
>> +	1850,		/* CH1 */
>> +	1850,		/* CH2 */
>> +	1850,		/* CH3 */
>> +	1850,		/* CH4 */
>> +	1850,		/* CH5 */
>> +	1850 * 2,	/* CH6 VDDIO */
>> +	1850 * 4,	/* CH7 VBATT */
>> +	1850,		/* CH8 Temp sense 0 */
>> +	1850,		/* CH9 Temp sense 1 */
>> +	1850,		/* CH10 */
>> +	1850,		/* CH11 */
>> +	1850,		/* CH12 USB_DP */
>> +	1850,		/* CH13 USB_DN */
>> +	1850,		/* CH14 VBG */
>> +	1850 * 4,	/* CH15 VDD5V */
>> +};
>> +
>> +static const int mx28_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
>> +	1850,		/* CH0 */
>> +	1850,		/* CH1 */
>> +	1850,		/* CH2 */
>> +	1850,		/* CH3 */
>> +	1850,		/* CH4 */
>> +	1850,		/* CH5 */
>> +	1850,		/* CH6 */
>> +	1850 * 4,	/* CH7 VBATT */
>> +	1850,		/* CH8 Temp sense 0 */
>> +	1850,		/* CH9 Temp sense 1 */
>> +	1850 * 2,	/* CH10 VDDIO */
>> +	1850,		/* CH11 VTH */
>> +	1850 * 2,	/* CH12 VDDA */
>> +	1850,		/* CH13 VDDD */
>> +	1850,		/* CH14 VBG */
>> +	1850 * 4,	/* CH15 VDD5V */
>> +};
>
> Should the above not be in DT ?

Do you mean for example:

	lradc@80050000 {
		compatible = "fsl,imx28-lradc";
		reg = <0x80050000 0x2000>;
		interrupts = <10 14 15 16 17 18 19
				20 21 22 23 24 25>;
		vref = <1850 1850 1850 1850
			1850 1850 1850 7400
			1850 1850 3700 1850
			3700 1850 1850 7400>
	};

I'm ok with it, but are there other examples of driver using a similar approach?
I see for example the spear-adc which reads:

	Optional properties:
	- vref-external: External voltage reference in milli-volts. If omitted
	  the internal voltage reference will be used.

which makes me believe the 'internal voltage reference' is hardcoded in the driver.
More opinions?

Best regards,
--
Hector Palacios
