Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DA59580.4010707@analog.com>
Date: Wed, 13 Apr 2011 14:22:24 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: michael.hennerich@analog.com
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
References: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com> <20110412152102.GB20710@opensource.wolfsonmicro.com>
In-Reply-To: <20110412152102.GB20710@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 04/12/2011 05:21 PM, Mark Brown wrote:
> On Tue, Apr 12, 2011 at 12:08:22PM +0100, Hennerich, Michael wrote:
>
> Please fix your mail client to word wrap at less than 80 columns - see
> Documentation/email-clients.txt for suggestions.  I've reflowed your
> text for legibility.
>
>   
>> I wonder why the voltage and current regulator framework doesn't
>> support negative voltages.  We like to use the framework to specify
>> bipolar reference voltages used with converters.  However in various
>> places negative voltages are treated as error codes, thus causing the
>> regulator to exit on probe.
>>     
> Basically just a lack of demand - there are few negative supplies in
> the mobile systems that were looked at, and most of those are like the
> charge pumps found in audio CODECs and not really visible as regulators
> that could be used with other devices.
>   

Hi Mark,

Contrast control for LC Displays typically use negative voltages, too
I agree that demand for this on typical mobile devices is low, however
we like
to use the regulator framework in the IIO subsystem where negative voltages
are quite common.
>   
>> As a workaround someone could say we specify positive and negative
>> supply by label with absolute values and add the negative sign in the
>> consumer driver.  However that doesn't work well, since the bipolar
>> 'negative' supply may also occasionally be positive.
>>     
> That'd probably work.  Or update the API to allow negative voltages to
> be returned more easily; off the top of my head the only real issue is
> get_voltage() and so on.  It'd not be great for usability, though.
>   
Updating the core to allow negative and zero voltages, is not  straight
forward.
There are more issues with constrain checking and I currently can't
oversee all side
effects. I think we need to introduce a new constrains flag
(maybe add to valid_modes_mask?), indicating a bipolar regulator.
This flag is then used to keep the current implementation untouched for
unipolar positive
regulators.

Thoughts?
 

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
