Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 26 May 2015 17:46:14 -0500
From: Michael Welling <mwelling@ieee.org>
To: "Griffis, Brad" <bgriffis@ti.com>
Cc: "Cooper Jr., Franklin" <fcooper@ti.com>, "Balbi, Felipe" <balbi@ti.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"R, Vignesh" <vigneshr@ti.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"GWilson@sakuraus.com" <GWilson@sakuraus.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: AM335x touchscreen issues
Message-ID: <20150526224614.GA24948@deathray>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com>
 <20150526205310.GA2104@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com>
 <20150526212851.GA12224@deathray>
 <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com>
 <912A29987EAE174BA6CF187D7CDFA9CE270A8C43@DLEE08.ent.ti.com>
 <20150526215049.GC12224@deathray>
 <912A29987EAE174BA6CF187D7CDFA9CE270A8D48@DLEE08.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912A29987EAE174BA6CF187D7CDFA9CE270A8D48@DLEE08.ent.ti.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 26, 2015 at 10:25:01PM +0000, Griffis, Brad wrote:
> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of Michael
> > Welling
> > 
> > It seems to have something to do with the characteristic of the touchscreen
> > as this does not happen on my 7" display.
> > 
> > Looking at the datasheet these pin are dedicated analogs and cannot be
> > MUX'd otherwise.
> > 
> > http://www.ti.com/lit/ds/symlink/am3354.pdf
> > page 20
> 
> Let me please re-ask a previously asked question just to be certain we're on the same page, because I think it is an extremely important question.
> 
> As background, the analog pins you mention belong to the "TSCADC" peripheral.  This peripheral, as the name suggests, has two purposes:
> 
> 1. It's a touchscreen controller.  For example, you might use 4 of the 8 analog inputs for the purpose of a touchscreen.
> 2. It's a general purpose A/D converter.  The remaining unused analog inputs can be used for general purposes such as checking a battery voltage, reading a thermistor, etc.
> 
> What I would like to know is how many of those 8 pins are being used.  Are you only using 4 pins for a resistive touchscreen, or are some other pins being used for general purpose ADC?
>

Here is my device tree registration:
&tscadc {
	status = "okay";
	tsc {
		ti,wires = <4>;
		ti,x-plate-resistance = <200>;
		ti,coordinate-readouts = <5>;
		ti,wire-config = <0x00 0x11 0x22 0x33>;
		ti,charge-delay = <0x4000>;
	};

	adc {
		ti,adc-channels = <4 5 6 7>;
	};
};

The adc channel are not being sampled but they are being configured in the
device tree.

I commented out the adc section and it had no effect on the behavior.

> Let me also provide more background on why I'm asking...  The patch set I created was originally developed on a 3.12 kernel.  On the 3.14 kernel there were some pretty major changes done with regard to how the general purpose ADC samples are collected.  So far, all the problematic areas I've bumped into with respect to integrating these patches in newer kernels have been in scenarios where there is ADC collection happening simultaneously.  So I'm trying to understand if your issue falls into that bucket or is something completely different.
>

I am not sampling the ADCs.

> It would be useful to probe the touchscreen signals during your test, particularly AIN0 which controls the pen-down interrupt.  Fundamentally I want to understand how it's possible that you're getting a pen-down interrupt when nothing is touching the screen.  I agree it's odd that you don't see the issue without my patch, though if you want to get to the heart of the issue we will need to make some observations to understand what's happening.  I'm afraid we're moving in the wrong direction by just adding extra checks and filters into the kernel code.  In other words, I think that's a more of a workaround than a solution, but it's hard to know for sure without some additional data points.

I am travelling and do not have my oscilloscope with me. It will be next
week before I can make any measurements.
