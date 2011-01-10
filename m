Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:38589 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab1AJLBP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2011 06:01:15 -0500
Message-ID: <4D2AE72D.9050000@cam.ac.uk>
Date: Mon, 10 Jan 2011 11:02:05 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D21A2AA.6080006@antcom.de> <20110103222834.GA11277@kroah.com> <4D29C64E.4040806@antcom.de> <4D2A373B.6060901@cam.ac.uk> <4D2AD0F7.3020607@antcom.de>
In-Reply-To: <4D2AD0F7.3020607@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/11 09:27, Roland Stigge wrote:
> Hi,
>=20
> On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
>> Pretty clean and nice driver so it was an easy review and should
>> be trivial to fix up for a merge.
>=20
> Thank you for your review - I will include the suggested changes in t=
he
> next update.
>=20
>> I don't think we have previously had a device that
>> allows setting multiple inputs together.
>> Two options come to mind that will generalize more
>> than your _both.
>>
>> output1&2_raw
>>
>> output_raw (suppress the index hence indicating that it sets both).
>>
>> What do you think is the clearest approach?
>> Which ever we pick it will also need proper documentation.  Whilst w=
e
>> are here, please can you explain your use case?  From a datasheet
>> read I think the first channel is latched after the value byte is pa=
ssed
>> then the second only after it's value has been passed over?
>=20
> It's actually latched after the _complete_ transmission. See datashee=
t p.9:
>=20
> "The data is transferred to the DAC=E2=80=99s output
> latch during the STOP condition following the transmis-
> sion. This allows both DACs of the MAX518/MAX519 to
> be updated simultaneously."
Ah, I missed that bit of text.  I guess the label (DAC0 INPUT LATCH set=
 to full scale)
on figure 8b is just confusing then. Now you mention it, there is anoth=
er
label at the stop condition saying the outputs change at the end. I'm n=
ot entirely
sure why they differentiate between DAC input latching and DAC output l=
atching.
Surely people only care about the output.  Ah well, the delights of dat=
asheet
interpretation.

Thanks for clearing that up!=20
>=20
> I will also document this in the driver to make it clearer.
Thanks,
>=20
> That's also why I'm constructing the I2C transfer in this nonstandard
> way. Datasheet doesn't claim to support smbus, so I will change to th=
e
> _ic2_ (non _smbus_) interface.
Good idea. If anyone really needs to get it to work on an smbus only ad=
apter
we can put this back in, but until then readability is more important.
>=20
> bye,
>   Roland
>=20

