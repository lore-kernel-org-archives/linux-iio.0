Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:3676 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760550AbbJ3Tl4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2015 15:41:56 -0400
Date: Fri, 30 Oct 2015 12:41:50 -0700
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>
CC: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Johan Hovold <jhovold@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] devicetree: mfd: Add binding for the TI LM3533
Message-ID: <20151030194150.GD24668@usrtlx11787.corpusers.net>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151030184220.GJ4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151030184220.GJ4058@x1>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri 30 Oct 11:42 PDT 2015, Lee Jones wrote:

Rob, please see the discussion regarding ti,boost-freq-khz below. Should
we both specify unit at the same time as we use standard units? (This is
not the first time I have to change this back and forth)

> On Tue, 27 Oct 2015, Bjorn Andersson wrote:
> 
[..]
> > +- ti,hwen-gpios:
> > +	Usage: required
> > +	Value type: <prop-encoded-array>
> > +	Definition: reference to gpio pin connected to the HWEN input; as
> > +		    specified in "gpio/gpio.txt"
> 
> Why have you made this a vendor binding?
> 
> *-gpios is a generic property.
> 

Because the hwen gpio is a ti lm3533 specific thing, but I get what
you're saying. Will drop the prefix.

> > +- ti,als-supply:
> > +	Usage: optional
> > +	Value type: <prop-encoded-array>
> > +	Definition: reference to regulator powering the V_als input; as
> > +		    specified in "regulator/regulator.txt"
> 
> Same goes for *-supply.
> 

Same here

> > +- ti,boost-freq-khz:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: switch-frequency of the boost converter, must be either:
> > +		    500 or 1000
> 
> Quite a few vendors are using 'boost' now.
> 

The ti,boost-low-freq from the bq25890 binding is the only other
property I can find that describes the same thing. So I'm not sure I
follow you here.

> Perhaps we need to create a set of generic bindings.
> 
> Also, we usually measure DT bindings in HZ, not kHz.
> 

I thought we had defined frequencies to be in HZ and HZ only, but then
Rob's comment that I need to actually specify the unit doesn't make any
sense.

Do we want these properties in a standard unit or do we want them
specifying the unit? Having both seems excessive.

> > +- ti,boost-ovp:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: over voltage protection limit, must be one of: 16, 24, 32
> > +		    or 40
> 
> Is this in volts?  If so, it should be microvolts.
> 

Okay, will update.

[..]
> > += ALS SUBNODE
> > +The als subnode must be named "als", it carries the als related properties.
> 
> Perfect time to tell us what ALS is/means.
> 

You're right, I'll expand this.

> > +- ti,als-resistance-ohm:
> > +	Usage: required (unless ti,pwm-mode is specified)
> > +	Value type: <u32>
> > +	Definition: specifies the resistor value (R_als), in Ohm. Valid values
> > +		    ranges from 200kOhm to 1574Ohm.
> 
> Might be worth specifying the values which you are actually going to
> use here i.e. "200kOhm" is not a valid u32.
> 

I'll drop the units.

> > +- ti,pwm-mode:
> > +	Usage: optional
> > +	Value type: <empty>
> > +	Definition: specifies, if present, that the als should operate in pwm
> 
> Suggest s/pwm/PWM/
> 

OK

[..]
> > +- ti,pwm-zones:
> > +	Usage: optional
> > +	Value type: <u32 list>
> > +	Definition: lists the ALS zones to be PWM controlled for this backlight,
> > +		    the values in the list are in the range [0 - 4]
> > +
> 
> It's usually a good idea to point to where all of the aforementioned
> generic properties are documented.  I personally like the format
> (See: ../<subsystem>/<binding>.txt)
> 

OK

> > += LED NODES

Regards,
Bjorn
