Return-Path: <fugang.duan@freescale.com>
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "otavio@ossystems.com.br"
	<otavio@ossystems.com.br>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Mon, 23 Dec 2013 01:50:08 +0000
Message-ID: <91351f475ab242d5a8db90d7d7b868b0@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1386151203-29728-1-git-send-email-B38611@freescale.com>
 <1386151203-29728-3-git-send-email-B38611@freescale.com>
 <52A36EEB.9020707@kernel.org>
 <647479cad6844130a2fbd6a78e7aa0f7@BLUPR03MB373.namprd03.prod.outlook.com>
 <52B717E1.3010606@kernel.org>
In-Reply-To: <52B717E1.3010606@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 12/23/2013 12:49 AM, Jonathan Cameron wrote:
>To: Duan Fugang-B38611
>Cc: mark.rutland@arm.com; otavio@ossystems.com.br; pmeerw@pmeerw.net;
>lars@metafoo.de; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc dr=
iver
>
>On 12/16/13 08:17, fugang.duan@freescale.com wrote:
>> Hi, Jonathan,
>>
>> On Sunday, December 08, 2013 2:55 AM, Jonathan Cameron <jic23@kernel.org=
>
>wrote:
>>> To: Duan Fugang-B38611
>>> Cc: shawn.guo@linaro.org; Li Frank-B20596; mark.rutland@arm.com;
>>> otavio@ossystems.com.br; pmeerw@pmeerw.net; lars@metafoo.de; linux-
>>> iio@vger.kernel.org
>>> Subject: Re: [PATCH v4 2/3] iio:adc:imx: add Freescale Vybrid vf610
>>> adc driver
>>>
>>> On 12/04/13 10:00, Fugang Duan wrote:
>>>> Add Freescale Vybrid vf610 adc driver. The driver only support ADC
>>>> software trigger.
>>>>
>>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>>> CC: Jonathan Cameron <jic23@kernel.org>
>>>> CC: Mark Rutland <mark.rutland@arm.com>
>>>> CC: Otavio Salvador <otavio@ossystems.com.br>
>>>> CC: Peter Meerwald <pmeerw@pmeerw.net>
>>>> CC: Lars-Peter Clausen <lars@metafoo.de>
>>>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>>>
>>> Mostly looking good, but a fair number of comments inline,
>>> particularly on the proposed userspace interfaces (which should have
>>> been clearly documented)
>>>
>>> Also, it is often helpful to provide a link to device documentation
>>> if it is available?
>>> I think :
>>>
>>> http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?fp
>>> sp=3D1&WT_TY
>>> PE=3DReference%20Manuals&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_=
ASSE
>>> T=3DDocument
>>> ation
>>>
>>> is probably the right one - chapter 37.
>>>
>>> For some of the interfaces proposed, I would like to get a better
>>> grasp on whether they actualy want to be exposed to userspace or
>>> whether there are 'right' options given other constraints.
>>>
>>>
>>>
>>>> ---
>>>>  drivers/iio/adc/Kconfig     |   10 +
>>>>  drivers/iio/adc/Makefile    |    1 +
>>>>  drivers/iio/adc/vf610_adc.c |  954
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 965 insertions(+), 0 deletions(-)
>> [...]
>>
>>>> +
>>>> +/*
>>>> + * Here, just list sample frequency available for
>>>> + * software trigger.
>>>> + */
>>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("28 32 36 38 42 46 50 54
>>>> +58");
>>>> +
>>>> +static IIO_DEVICE_ATTR(resolution_mode, S_IWUSR | S_IRUGO,
>>>> +			vf610_resolution_mode_show,
>>>> +			vf610_resolution_mode_store, 0);
>>>> +
>>>> +static IIO_DEVICE_ATTR(low_power_mode, S_IWUSR | S_IRUGO,
>>>> +			vf610_low_power_mode_show,
>>>> +			vf610_low_power_mode_store, 0);
>>>> +
>>>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO,
>>>> +			vf610_read_sample_frequency,
>>>> +			NULL);
>>>> +
>>>> +static IIO_CONST_ATTR(clk_divider_available, "1 2 4 8 16"); static
>>>> +IIO_DEVICE_ATTR(adc_internal_clk, S_IWUSR | S_IRUGO,
>>>> +			vf610_adc_internal_clk_show,
>>>> +			vf610_adc_internal_clk_store, 0);
>>> I am guessing that the two above are related to the same control?
>>> That isn't implied by there names!
>>>> +
>>>> +static struct attribute *vf610_attributes[] =3D {
>>>> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>>>
>>> Please use the info_mask elements for the relevant channel and add
>>> support to read_raw for samp_freq rather than hand coding it here.
>>> I'm in the process of pulling all of these out in favour of that
>>> support as if it is done like this, then there is no access to these
>>> values for drivers within the kernel.
>>>
>>>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> Whilst I have proposed a framework to handle *_available attributes
>>> via the core, it isn't ready to merge yet so this is currently the
>>> right way to do this one!
>>>
>>>> +	&iio_dev_attr_resolution_mode.dev_attr.attr,
>>> I raised this question before - is there a use case for polled acess
>>> (as provided so far in this driver) which is already inherently slow
>>> in which one would want to vary the resolution?
>>> If there is then this should be added as a new info_mask element and
>>> provided by the read_raw/write_raw callbacks.
>>>
>> Since the ADC support 8-bit, 10-bit, 12-bit, maybe user change it in run=
time,
>so add the sys interface.
>> You mean that the driver only enable one resolution in default ?
>That's what I was thinking.  Whilst a user might of course change the
>resolution is there any real reason for them to do so whilst using the
>relatively slow interface that is implemented here (sysfs access)

Agree it, try to simply it as much as possible.

>>
>>>> +	&iio_dev_attr_low_power_mode.dev_attr.attr,
>>> Some comments on this above.
>>>
>> I will remove the interface.
>>
>>>> +	&iio_dev_attr_adc_internal_clk.dev_attr.attr,
>>> These are very low level interfaces that won't make much sense to
>>> expose to userspace.  There is no documentation on when one would
>>> change this that I can see.  It probably effects a number of things...
>>>
>>> The possibly related long sample configuration is interesting..
>>>
>>>>From the datasheet, these would typically be changed to cope with high
>>>impedances or to allow for fast operation / lower power operation
>>>when the  impedance of the connected source is low....  Given this is
>>>about coping with  input impedances I'd argue that this is perhaps
>>>something that does belong in  device tree
>>> perhaps as a 'hint' on the input impedance.   The driver when
>>> then only offer possible sampling frequencies given the restrictions
>>>applied  whatever is being measured (reflected in the clk divider).
>>>
>>>> +	&iio_const_attr_clk_divider_available.dev_attr.attr,
>>> Anything here that is no currently documented in
>>> Documentation/bindings/testing/sysfs-bus-iio* needs to be proposed
>>> formally as a new ABI element with documentation.
>>>
>> The ADC sample frequency:
>> IPG clk -> divide 1  -> ADC conversion time =3D SFCAdder + AverageNum x =
(BCT +
>LSTAdder)
>>            divide 2
>>            divide 4
>>            divide 8
>>            divide 16
>>
>>
>>  * SFCAdder: fix to 8 ADCK cycles
>>  * AverageNum: 1, 4, 32 samples for hardware average.
>>  * BCT (Base Conversion Time):
>>  *      - 17 ADCK cycles for 8 bit mode
>>  *      - 21 ADCK cycles for 10 bit mode
>>  *      - 25 ADCK cycles for 12 bit mode
>>  *LSTAdder(Long Sample Time):
>>  *      - 3 ADCK cycles
>>  *      - 13 ADCK cycles
>>  *      - 25 ADCK cycles
>>
>>
>> Base on above formula,  we can get one frequency group:
>> static const u16 vf610_sample_freq_avail[3][9] =3D {
>>         {28, 38, 50, 88, 128, 176, 648, 968, 1352},   // for 8-bit
>>         {32, 42, 54, 104, 144, 192, 776, 1096, 1480}, // for 10-bit
>>         {36, 46, 58, 120, 160, 208, 904, 1224, 1608}, // for 12-bit };
>>
>>  * For each frequency group:
>>  * Entry 0,1,2 -> 1 sample for each conversion
>>  * Entry 3,4,5 -> hardware average 4 samples
>>  * Entry 6,7,8 -> hardware average 32 samples
>>
>>
>> For ADC sample frequency, unit is ADCK cycles, which is not Hz.
>> So, the driver use info_mask elements "IIO_CHAN_INFO_SAMP_FREQ" to read/=
write
>avail frequency, unit is ADCK cycles.
>
>No.  Can't do that.  The unit of sampling frequency is Hz.  There is no
>flexibility on this at all.  We simply cannot have different drivers worki=
ng in
>different units.
>
You are right, all driver must be generalized.

>> User can read "adc_in_voltage_sampling_frequency" to get the value.
>>     The driver use sys interface " adc_internal_clk " to read/write cloc=
k
>after divider. clk_divider_available: 1 2 4 8 16.
>>     The driver use sys interface " sampling_frequency " to read the
>> real ADC frequency, which is adc_internel_clk /
>> in_voltage_sampling_frequency
>> Exp:
>>     Resolution is 8 bit mode,  1 sample for each conversion, IPG clock i=
s
>66Mhz, divider is 2, we can get:
>>     Read sys "adc_in_voltage_sampling_frequency", which must be 28 ADCK
>cycles.
>>     Read sys "adc_internal_clk", which must be 66Mhz/2=3D33Mhz.
>>     Read sys "sampling_frequency", which is the real ADC sample
>> frequency: 33Mhz/28=3D1.18Mhz
>>
>>
>> If re-calculate the static avail frequency with adding clock divider arr=
ay to
>make the avail values are real frequency (hz), it may be more complex.
>> This is the current implementation, so you see the driver added some non=
-
>standard iio sys interfaces.
>> Do you have any other suggestion ?
>
>Firstly, what I'm always primarily interested in is generic interfaces tha=
t can
>cover any similar devices.  What we are describing here will be too device
>specific if we are not careful.
>
>So the things being controlled are:
>
>1) The sampling frequency (how often we can measure the channel).
>
>2) A filter applied to the samples taken (averaging).
>
>3) The resolution.
>
>4) The sample time - effectively a front end filter rather than a digital =
one I
>think....
>
>5) the clock speed used to driver the above.
>
>
>The sampling frequency clearly describes in Hz the rate at which input sam=
ples
>are taken at the front end of any filtering.  Here that is a rather comple=
x
>thing to compute but it needs to be done!
>
>For the averaging filter, we do have it described the other way around alr=
eady
>using oversampling, but reconsidering that I'm not entirely sure that is t=
he
>best way of describing it and presumably the filter for a typical oversamp=
ling
>adc is rather more complex than a single average.  Perhaps we need somethi=
ng
>like in_filter_subsample (values of 1, 4 and 32 here) in_filter_mean_windo=
w
>(values of 1, 4, and 32 as well)
>
>This would allow us to subsample more complex filters and to have moving
>average filtering without subsampling described rather than the case here =
where
>they are linked (note that changing any IIO attribute can change any other=
 so
>having a linked pair - in this case - isn't a problem).  Note that the set=
ting
>of this averaging filter will effect the output data rate, but as this is =
after
>sampling it will NOT effect the sampling_frequency attribute.
>
>The input clock divider is an odd one.  It is no different to an externall=
y
>provided clock (and we have one of those here driving it). Hence we need t=
o
>treat that more generally.  Do we need a way for IIO to
>a) Query what the input clocks can be so as to provide _available attribut=
es
>b) Request an input clock to allow for particular sampling frequencies etc=
?
>I have no particular problem with doing this, but it needs to be generaliz=
ed.
>We should not care that this clock divider is part of the ADC element of t=
he
>SoC from the point of view of the interface.
>
>If you want a quick 'reasonable' solution, I'd suggest implementing it as =
a
>normal clock chip provided by and used by the ADC.  Thus any future interf=
ace
>would control it just fine.  If you really want this functionality then we=
 need
>the generalized version, not something device specific.
>
>Resolution is an interesting one.  Right now we have this reasonably well
>defined (though not as yet writable!) for buffered output, but have taken =
the
>view that if people are using sysfs to read a channel then they aren't tha=
t
>fussed about how quickly the read it and will hence want the highest possi=
ble
>resolution. Unless there are very clear reasons why we need to change this=
 I
>think it will prove a messy nightmare given that resolution changes tend t=
o
>make every single other element (scale, offset, sampling frequency etc) ch=
ange.
>
>According to the datasheet, the long sample time option is all about handl=
ing
>high impedance inputs.  Sounds like a wiring question for me  (hence devic=
e
>tree) rather than something where a userspace interface makes sense.
>
>How many of the above want to be controlled on a per channel basis?  Worth
>thinking about now, before you get stuck with an ABI where they are all
>shared...
>
Sys interface is slow speed interface, so resolution, clock divider are not=
 necessary, just=20
Use normal clock for ADC modules. From above of your suggestion, I think I =
need to simply
the implemention.

>I'm growing to really dislike SoC adcs ;)  Every piece of hardware does
>something new making generic interfaces (which are a must if anyone is eve=
r
>going to
>use them) harder!   It seems that with discrete parts, things are simpler
>as people chose an appropriate one for their application, whereas when som=
eone
>sticks and ADC on the side of a SoC they decide to make it possible to
>everything but in a way that makes it very hard to have variable in a clea=
n
>fashion.
>
>
Yes, I'am also dislike SOC adcs. But it is a trend for future ADCs market.
There will have more specific function/features, which are hard for softwar=
e to implement in generalized interfaces.


Thanks for your suggestion!
Wish you a merry Christmas day!=09

Thanks,
Andy
