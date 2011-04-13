Return-Path: <lgirdwood@gmail.com>
Subject: Re: voltage and current regulator framework: specifying negative
 voltages
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: michael.hennerich@analog.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonathan Cameron
 <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org"
 <device-drivers-devel@blackfin.uclinux.org>
In-Reply-To: <4DA59580.4010707@analog.com>
References: 
	 <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
	 <20110412152102.GB20710@opensource.wolfsonmicro.com>
	 <4DA59580.4010707@analog.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Apr 2011 14:43:21 +0100
Message-ID: <1302702201.3600.81.camel@odin>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2011-04-13 at 14:22 +0200, Michael Hennerich wrote:
> On 04/12/2011 05:21 PM, Mark Brown wrote:
> > On Tue, Apr 12, 2011 at 12:08:22PM +0100, Hennerich, Michael wrote:
> >
> > Please fix your mail client to word wrap at less than 80 columns - see
> > Documentation/email-clients.txt for suggestions.  I've reflowed your
> > text for legibility.
> >
> >   
> >> I wonder why the voltage and current regulator framework doesn't
> >> support negative voltages.  We like to use the framework to specify
> >> bipolar reference voltages used with converters.  However in various
> >> places negative voltages are treated as error codes, thus causing the
> >> regulator to exit on probe.
> >>     
> > Basically just a lack of demand - there are few negative supplies in
> > the mobile systems that were looked at, and most of those are like the
> > charge pumps found in audio CODECs and not really visible as regulators
> > that could be used with other devices.
> >   
> 
> Hi Mark,
> 
> Contrast control for LC Displays typically use negative voltages, too
> I agree that demand for this on typical mobile devices is low, however
> we like
> to use the regulator framework in the IIO subsystem where negative voltages
> are quite common.
> >   
> >> As a workaround someone could say we specify positive and negative
> >> supply by label with absolute values and add the negative sign in the
> >> consumer driver.  However that doesn't work well, since the bipolar
> >> 'negative' supply may also occasionally be positive.
> >>     
> > That'd probably work.  Or update the API to allow negative voltages to
> > be returned more easily; off the top of my head the only real issue is
> > get_voltage() and so on.  It'd not be great for usability, though.
> >   
> Updating the core to allow negative and zero voltages, is not  straight
> forward.
> There are more issues with constrain checking and I currently can't
> oversee all side

The voltage constraints are just treated as numbers so negative
constraints for bipolar regulators should be fine here. I don't
anticipate lots of rework here. 

There is also some core logic that selects the lowest voltage within a
range of valid voltages (to save power) when consumers set a voltage.
This would need changed a little to support negative voltages since the
lowest voltage will be the _highest_ negative voltage. 

> effects. I think we need to introduce a new constrains flag
> (maybe add to valid_modes_mask?), indicating a bipolar regulator.
> This flag is then used to keep the current implementation untouched for
> unipolar positive
> regulators.
> 
> Thoughts?
>  

My preference is to keep it simple and the API consistent with unipolar
regulators.

One of the problem areas will be regulator_get_voltage() since it
returns negative errors. It may be desirable to deprecate this API call
in favour of a new call that we pass in an int for the voltage (e.g.
get_voltage(reg, &voltage)).

Lets also hear what Mark's thoughts too.

Regards

Liam
