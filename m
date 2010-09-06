Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34683 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751002Ab0IFNNq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2010 09:13:46 -0400
Date: Mon, 6 Sep 2010 14:32:56 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
	Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [IIO] Proposal for sysfs attributes
Message-ID: <20100906143256.6b49825d@lxorguk.ukuu.org.uk>
In-Reply-To: <4C84E64D.4040600@jic23.retrosnub.co.uk>
References: <4C84A93B.2050507@iis.fraunhofer.de>
	<4C84E64D.4040600@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > Do we want to resemble the 'milli' units or should we stick to
> > standard SI units (radians, kelvin, etc.) as floating point math is
> > necessary anyway.
> I've cc'd a few people who have contributed to previous abi discussions
> for IIO in ways that make me think they may have opinions on this.

FP isn't needed you can let the drivers do fixed point quite happily -
the Intel compass driver intentionally does this.

Using milli is asking for problems. There are lots of units where "milli"
is actually quite big (millifarad, millihenry) and others where its
stupendously small (eV for example). It works for hwmon because hwmon
covers such a narrow range of devices and units.

So I'd favour FP because I think there are three choices

1.	Encode the value, define the scaling factor in the ABI (not
	future proof)

2.	Encode the value and scaling factor as two fields in the ABI
	(more future proof)

3.	As 2 but use the normal encoding for this which involves
	putting a "." in the right place and using one field (ie FP)

Drivers are simply going to end up doing this with sysfs values

	snprintf(buf, sizeof(buf), "%d.%02d", v/100, v%100);

or similar - or in many cases

	snprintf(buf, sizeof(buf), "%d0000000000", v);

neither of which is a big cost.

For a ring buffer you probably need to encode the scaling factor and
field width in some sort of interface description query and the values in
the bitstream.

Which raises an interesting question. The natural way to deal with sysfs
is decimal fixed point internally. If drivers are going to do both
sysfs and rings then really you want to be able to encode powers of 10
shifts not just bitshifts.

Alan
