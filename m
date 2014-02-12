Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52751 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaBLRUU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 12:20:20 -0500
In-Reply-To: <20140212161046.GC28112@sirena.org.uk>
References: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at> <52F61C2A.90101@kernel.org> <20140212161046.GC28112@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] iio: mxs-lradc: Add support for current source
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 12 Feb 2014 17:20:11 +0000
To: Mark Brown <broonie@kernel.org>
CC: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Liam Girdwood <lgirdwood@gmail.com>
Message-ID: <3adf03e3-5f35-4400-8d5a-2fa415f46d2e@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On February 12, 2014 4:10:46 PM GMT+00:00, Mark Brown <broonie@kernel.org> wrote:
>On Sat, Feb 08, 2014 at 11:59:38AM +0000, Jonathan Cameron wrote:
>> On 28/01/14 13:52, Harald Geyer wrote:
>
>> >The LRADC can drive two of its ADC channels with a defined current
>> >between 0 and 300uA to allow reading thermistors without external
>> >current source. I'm not sure what the right IIO ABI in this case
>
>> I'd be tempted to do this via the regulator framework instead of IIO.
>> At somepoint we could have a bridge to allow an iio interface on a
>regulator
>> if anyone wants it (you never know)
>
>I'm very worried about the idea of an ABI - if IIO wants to offer
>something that is implemented using the regulator API that's fine but
>doing it directly from the regulator API sounds worrying.

Would definitely be implemented using the regulator ABI. Would effectively pipe DAC writes from user space to regulator voltage requests.

Not sure I really like the idea anyway but some DACs look awfully like regulators so it might become an issue...

Definitely leave it until someone cares though!
>
>> I guess the main advantage in doing it in IIO would be to keep stuff
>in
>> one logical group.  Still they might just as easily be using an
>external
>> regulator to drive thermistors so using the regulator framework would
>be
>> more consistent...
>
>The current that's driven seems more a property of the thermistor than
>of the regulator if it is a generic regulator.

True. So do we give the thermistor a driver of its own?  Might make sense with it using a regulator and an iio channel. Output probably as hwmon?

Would be a small bit of glue code really.  There are quite a few similar cases with analog sensors that we don't currently represent at all.  Trick would be writing something generic and lightweight.

J



-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
