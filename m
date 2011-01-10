Return-Path: <stigge@antcom.de>
Message-ID: <4D2AD0F7.3020607@antcom.de>
Date: Mon, 10 Jan 2011 10:27:19 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D21A2AA.6080006@antcom.de> <20110103222834.GA11277@kroah.com> <4D29C64E.4040806@antcom.de> <4D2A373B.6060901@cam.ac.uk>
In-Reply-To: <4D2A373B.6060901@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
> Pretty clean and nice driver so it was an easy review and should
> be trivial to fix up for a merge.

Thank you for your review - I will include the suggested changes in the
next update.

> I don't think we have previously had a device that
> allows setting multiple inputs together.
> Two options come to mind that will generalize more
> than your _both.
>=20
> output1&2_raw
>=20
> output_raw (suppress the index hence indicating that it sets both).
>=20
> What do you think is the clearest approach?
> Which ever we pick it will also need proper documentation.  Whilst we
> are here, please can you explain your use case?  From a datasheet
> read I think the first channel is latched after the value byte is passe=
d
> then the second only after it's value has been passed over?

It's actually latched after the _complete_ transmission. See datasheet p.=
9:

"The data is transferred to the DAC=E2=80=99s output
latch during the STOP condition following the transmis-
sion. This allows both DACs of the MAX518/MAX519 to
be updated simultaneously."

I will also document this in the driver to make it clearer.

That's also why I'm constructing the I2C transfer in this nonstandard
way. Datasheet doesn't claim to support smbus, so I will change to the
_ic2_ (non _smbus_) interface.

bye,
  Roland
