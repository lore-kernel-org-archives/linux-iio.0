Return-Path: <fugang.duan@freescale.com>
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "otavio@ossystems.com.br"
	<otavio@ossystems.com.br>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Mon, 16 Dec 2013 08:17:16 +0000
Message-ID: <647479cad6844130a2fbd6a78e7aa0f7@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
 <1386151203-29728-3-git-send-email-B38611@freescale.com>
 <52A36EEB.9020707@kernel.org>
In-Reply-To: <52A36EEB.9020707@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi, Jonathan,

On Sunday, December 08, 2013 2:55 AM, Jonathan Cameron <jic23@kernel.org> w=
rote:
>To: Duan Fugang-B38611
>Cc: shawn.guo@linaro.org; Li Frank-B20596; mark.rutland@arm.com;
>otavio@ossystems.com.br; pmeerw@pmeerw.net; lars@metafoo.de; linux-
>iio@vger.kernel.org
>Subject: Re: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc dr=
iver
>
>On 12/04/13 10:00, Fugang Duan wrote:
>> Add Freescale Vybrid vf610 adc driver. The driver only support ADC
>> software trigger.
>>
>> CC: Shawn Guo <shawn.guo@linaro.org>
>> CC: Jonathan Cameron <jic23@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Otavio Salvador <otavio@ossystems.com.br>
>> CC: Peter Meerwald <pmeerw@pmeerw.net>
>> CC: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>
>Mostly looking good, but a fair number of comments inline, particularly on=
 the
>proposed userspace interfaces (which should have been clearly documented)
>
>Also, it is often helpful to provide a link to device documentation if it =
is
>available?
>I think :
>
>http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fpsp=3D=
1&WT_TY
>PE=3DReference%20Manuals&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_ASS=
ET=3DDocument
>ation
>
>is probably the right one - chapter 37.
>
>For some of the interfaces proposed, I would like to get a better grasp on
>whether they actualy want to be exposed to userspace or whether there are
>'right' options given other constraints.
>
>
>
>> ---
>>  drivers/iio/adc/Kconfig     |   10 +
>>  drivers/iio/adc/Makefile    |    1 +
>>  drivers/iio/adc/vf610_adc.c |  954
>> +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 965 insertions(+), 0 deletions(-)
[...]

>> +
>> +/*
>> + * Here, just list sample frequency available for
>> + * software trigger.
>> + */
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("28 32 36 38 42 46 50 54 58");
>> +
>> +static IIO_DEVICE_ATTR(resolution_mode, S_IWUSR | S_IRUGO,
>> +			vf610_resolution_mode_show,
>> +			vf610_resolution_mode_store, 0);
>> +
>> +static IIO_DEVICE_ATTR(low_power_mode, S_IWUSR | S_IRUGO,
>> +			vf610_low_power_mode_show,
>> +			vf610_low_power_mode_store, 0);
>> +
>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO,
>> +			vf610_read_sample_frequency,
>> +			NULL);
>> +
>> +static IIO_CONST_ATTR(clk_divider_available, "1 2 4 8 16"); static
>> +IIO_DEVICE_ATTR(adc_internal_clk, S_IWUSR | S_IRUGO,
>> +			vf610_adc_internal_clk_show,
>> +			vf610_adc_internal_clk_store, 0);
>I am guessing that the two above are related to the same control?
>That isn't implied by there names!
>> +
>> +static struct attribute *vf610_attributes[] =3D {
>> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>
>Please use the info_mask elements for the relevant channel and add support=
 to
>read_raw for samp_freq rather than hand coding it here.
>I'm in the process of pulling all of these out in favour of that support a=
s if
>it is done like this, then there is no access to these values for drivers
>within the kernel.
>
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>Whilst I have proposed a framework to handle *_available attributes via th=
e
>core, it isn't ready to merge yet so this is currently the right way to do=
 this
>one!
>
>> +	&iio_dev_attr_resolution_mode.dev_attr.attr,
>I raised this question before - is there a use case for polled acess (as
>provided so far in this driver) which is already inherently slow in which =
one
>would want to vary the resolution?
>If there is then this should be added as a new info_mask element and provi=
ded
>by the read_raw/write_raw callbacks.
>
Since the ADC support 8-bit, 10-bit, 12-bit, maybe user change it in runtim=
e, so add the sys interface.
You mean that the driver only enable one resolution in default ?

>> +	&iio_dev_attr_low_power_mode.dev_attr.attr,
>Some comments on this above.
>
I will remove the interface.

>> +	&iio_dev_attr_adc_internal_clk.dev_attr.attr,
>These are very low level interfaces that won't make much sense to expose t=
o
>userspace.  There is no documentation on when one would change this that I=
 can
>see.  It probably effects a number of things...
>
>The possibly related long sample configuration is interesting..
>
>>From the datasheet, these would typically be changed to cope with high
>impedances or to allow for fast operation / lower power operation  when th=
e
>impedance of the connected source is low....  Given this is about coping w=
ith
>input impedances I'd argue that this is perhaps something that does belong=
 in
>device tree
>perhaps as a 'hint' on the input impedance.   The driver when
>then only offer possible sampling frequencies given the restrictions appli=
ed
>whatever is being measured (reflected in the clk divider).
>
>> +	&iio_const_attr_clk_divider_available.dev_attr.attr,
>Anything here that is no currently documented in
>Documentation/bindings/testing/sysfs-bus-iio* needs to be proposed formall=
y as
>a new ABI element with documentation.
>
The ADC sample frequency:
IPG clk -> divide 1  -> ADC conversion time =3D SFCAdder + AverageNum x (BC=
T + LSTAdder)
           divide 2
           divide 4
           divide 8
           divide 16       =20
	=20

 * SFCAdder: fix to 8 ADCK cycles
 * AverageNum: 1, 4, 32 samples for hardware average.
 * BCT (Base Conversion Time):
 *      - 17 ADCK cycles for 8 bit mode
 *      - 21 ADCK cycles for 10 bit mode
 *      - 25 ADCK cycles for 12 bit mode
 *LSTAdder(Long Sample Time):
 *      - 3 ADCK cycles
 *      - 13 ADCK cycles
 *      - 25 ADCK cycles


Base on above formula,  we can get one frequency group:
static const u16 vf610_sample_freq_avail[3][9] =3D {=20
        {28, 38, 50, 88, 128, 176, 648, 968, 1352},   // for 8-bit
        {32, 42, 54, 104, 144, 192, 776, 1096, 1480}, // for 10-bit
        {36, 46, 58, 120, 160, 208, 904, 1224, 1608}, // for 12-bit
};

 * For each frequency group:
 * Entry 0,1,2 -> 1 sample for each conversion
 * Entry 3,4,5 -> hardware average 4 samples
 * Entry 6,7,8 -> hardware average 32 samples


For ADC sample frequency, unit is ADCK cycles, which is not Hz.
So, the driver use info_mask elements "IIO_CHAN_INFO_SAMP_FREQ" to read/wri=
te avail frequency, unit is ADCK cycles. User can read "adc_in_voltage_samp=
ling_frequency" to get the value.
    The driver use sys interface " adc_internal_clk " to read/write clock a=
fter divider. clk_divider_available: 1 2 4 8 16.=20
    The driver use sys interface " sampling_frequency " to read the real AD=
C frequency, which is adc_internel_clk / in_voltage_sampling_frequency
Exp:
    Resolution is 8 bit mode,  1 sample for each conversion, IPG clock is 6=
6Mhz, divider is 2, we can get:
    Read sys "adc_in_voltage_sampling_frequency", which must be 28 ADCK cyc=
les.
    Read sys "adc_internal_clk", which must be 66Mhz/2=3D33Mhz.
    Read sys "sampling_frequency", which is the real ADC sample frequency: =
33Mhz/28=3D1.18Mhz


If re-calculate the static avail frequency with adding clock divider array =
to make the avail values are real frequency (hz), it may be more complex.
This is the current implementation, so you see the driver added some non-st=
andard iio sys interfaces.=20
Do you have any other suggestion ?

>> +	NULL
>> +};
>> +
>> +static const struct attribute_group vf610_attribute_group =3D {
>> +	.attrs =3D vf610_attributes,
>> +};
>> +

[...]

Thanks for your review.
