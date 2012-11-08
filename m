Return-Path: <alban.bedel@avionic-design.de>
Date: Thu, 8 Nov 2012 17:56:17 +0100
From: Alban Bedel <alban.bedel@avionic-design.de>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Roland Stigge <stigge@antcom.de>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH] staging:iio:lpc32xx_adc: Add scale/offset support
Message-ID: <20121108175617.06429ab1@avionic-0020.adnet.avionic-design.de>
In-Reply-To: <509BD1D9.20100@jic23.retrosnub.co.uk>
References: <1352306690-25841-1-git-send-email-alban.bedel@avionic-design.de>
	<509B7BF0.5050704@antcom.de>
	<509BD1D9.20100@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 08 Nov 2012 15:38:01 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> Why not do this with regulators?  That would give a more flexible
> system and all that stuff is already well supported (if fixed voltages
> are supplied then used fixed regulators).

I agree that would probably be better. But for me that raise the
question of having this stuff in the ADC driver at all. Most ADC just
return a value from 0 to MAX and have no way to find out their supply
voltage. If we start with binding to regulators in the drivers we'll
soon get a lots of non-flexible and duplicated code.

It would be a lot nicer if the ADC channels could be bound to a
regulator and a transform function that compute a real world voltage out
of:
 - The ADC value
 - The ADC range
 - The regulator representing the ADC reference voltage

The simplest transform would be a linear curve with an optional offset,
but any kind of transform would also be possible allowing to represent
about any circuit that might be between the supply regulator and the ADC
input.

Alban
