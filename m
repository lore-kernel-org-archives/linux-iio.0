Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DA6D01B.9080202@analog.com>
Date: Thu, 14 Apr 2011 12:44:43 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: michael.hennerich@analog.com
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Liam Girdwood <lrg@slimlogic.co.uk>, Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
References: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com> <20110412152102.GB20710@opensource.wolfsonmicro.com> <4DA59580.4010707@analog.com> <1302702201.3600.81.camel@odin> <20110413172404.GB18008@opensource.wolfsonmicro.com>
In-Reply-To: <20110413172404.GB18008@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 04/13/2011 07:24 PM, Mark Brown wrote:
> On Wed, Apr 13, 2011 at 02:43:21PM +0100, Liam Girdwood wrote:
>   
>> On Wed, 2011-04-13 at 14:22 +0200, Michael Hennerich wrote:
>>     
>   
>>> Contrast control for LC Displays typically use negative voltages, too
>>> I agree that demand for this on typical mobile devices is low, however
>>> we like
>>>       
> Yeah, that and the eInk displays are the only application I'm aware of.
>
>   
>>> to use the regulator framework in the IIO subsystem where negative voltages
>>> are quite common.
>>>       
> Are these regulators software controlled?
>   
The cases I'm dealing with are fix voltage regulators with only
enable/disable controls.
 
>   
>>> Updating the core to allow negative and zero voltages, is not  straight
>>> forward.
>>> There are more issues with constrain checking and I currently can't
>>> oversee all side
>>>       
> What are the issues that you see?
>   
In case the output voltage can be negative, the input voltage may be
negative as well.
In functions drms_uA_update() and regulator_set_optimum_mode(), the
input supply voltage
is checked for being > 0, if that fails it uses the constrains->input_uV
instead...

BTW: Function drms_uA_update() looks suspicious.

    /* get input voltage */
    input_uV = 0;
    if (rdev->supply)
        input_uV = _regulator_get_voltage(rdev);

it checks for rdev->supply but later uses rdev, which will ultimately
mean input_uV == output_uV.
 
>   
>>> effects. I think we need to introduce a new constrains flag
>>> (maybe add to valid_modes_mask?), indicating a bipolar regulator.
>>> This flag is then used to keep the current implementation untouched for
>>> unipolar positive
>>> regulators.
>>>       
>   
>> My preference is to keep it simple and the API consistent with unipolar
>> regulators.
>>     
> I agree, though if people do ever use the same regulators for both
> polarities (with the polarity determined by supply) then we'll need a
> way of dealing with this in the constraints as the regulators might not
> know they're running negative voltages with respect to the system.
>
>   
>> One of the problem areas will be regulator_get_voltage() since it
>> returns negative errors. It may be desirable to deprecate this API call
>> in favour of a new call that we pass in an int for the voltage (e.g.
>> get_voltage(reg, &voltage)).
>>     
> I'm not sure deprecating it is ideal - it's quite a convenient API.  We
> could just implement a new API and leave that one as an adaption layer.
> Transition issues would mean that we'd want to do that for at least one
> kernel release anyway.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
