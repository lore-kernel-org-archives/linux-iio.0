Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49732 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3ITUyh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2013 16:54:37 -0400
Message-ID: <523CC42F.7010403@kernel.org>
Date: Fri, 20 Sep 2013 22:54:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 07/15] staging:iio:hmc5843: Use CALIBSCALE instead
 of magn_range
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-8-git-send-email-pmeerw@pmeerw.net> <523CA8B1.7030003@kernel.org> <alpine.DEB.2.01.1309202147420.5504@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1309202147420.5504@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/13 21:12, Peter Meerwald wrote:
> Hi,
> 
>> I'm afraid I don't follow why you don't just make scale writeable
>> rather than introducing a second element to control the same thing.
>> Calibscale is intended for the case where the hardware can change
>> the scale without it being apparent from the raw readings. Sometimes
>> it also gets used to handling amplifiers in cases where the conversion
>> function is 'interesting' and we have no choice but to do it in kernel
>> in order to have data provided to userspace in a comprehensible form
>> but that doesn't apply here.
> 
> I guess this is reminiscent of the staging code which had magn_range and 
> scale; magn_range being the nice, human-readable measurement range (such 
> as +- 1.9 Gauss)
True enough, but unfortunately we then have to have two controls for
the same things which leads to a messy inconsistent interface.

The best I can offer at the moment is the much stated plan to have an
extending 'available' type attribute for every element of the info mask.
Then combining the available scale with the available values that _raw
can take will give you the range of values that the part can take.

In the vast majority of cases this would provide userspace with all the
numbers to present this however is desired. The only nasty case would
be where the available raw values are stricted for some of the scales
but that would be rather unusual.

Note that such a generic _available (or other equivalent named) attribute
would need to cover both the discrete case and the data range cases.  Things
like

0.1111111 0.222222 0.3333333 0.444444

vs

0.111111..0.111111..0.444444

to specify the same thing.

An RFC on this has been my 'next thing to do' for the last couple of weeks
but I've been rather swamped with reviews to do so it hasn't happened yet!

> 
> setting the expected measurement range sounds like calibration to me...
Not really.  Things like a trim resistor value in an amplifier circuit
would be calibration. Ways  of fixing inaccuracies in the hardware.
The use in the various light sensors is sort of equivalent to this as
there is no direct output.
> 
> I think this is one of the biggest issues of iio: that there is no 
> guideline when to use what

True enough.  We are kind of working by precedence which is fine if it
is easy to find an equivalent case.   Perhaps adding more stuff to
the dummy driver to cover the uses of some of this stuff would help?

> 
> regards, p.
> 
