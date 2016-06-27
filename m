Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0S7R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 14:59:17 -0400
Subject: Re: [PATCH 9/9 v2] iio: pressure: bmp280: read calibration data once
To: Linus Walleij <linus.walleij@linaro.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-10-git-send-email-linus.walleij@linaro.org>
 <e6a52c1b-8863-e977-a256-3be0151c0933@kernel.org>
 <CACRpkdb_fxLSRJq_8ki7u1i9BwxmTS35XD14HDCe9WXfO+L05g@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2efdabca-f229-89d4-cbc1-4b4e05856296@kernel.org>
Date: Mon, 27 Jun 2016 19:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdb_fxLSRJq_8ki7u1i9BwxmTS35XD14HDCe9WXfO+L05g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 13:11, Linus Walleij wrote:
> On Sun, Jun 26, 2016 at 12:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 22/06/16 21:53, Linus Walleij wrote:
>>> The calibration data is described as coming from an E2PROM and that
>>> means it does not change. Just read it once at probe time and store
>>> it in the device state container. Also toss the calibration data
>>> into the entropy pool since it is device unique.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> One nitpick inline, but it's minor enough I'm just being grumpy
>> about it so don't bother fixing it unless you want to.
>>
>> On the adding entropy bit, any idea who to sanity check that with?
>> It's not something we've done before, so I just want a bit of
>> reassurance ideally;)
> 
> I've done it in a few places whenever I ran into device-unique numbers,
> actually sensors often have device-unique calibration and are thus well
> suited to toss into the entropy pool.
> 
> The data from devices isn't really trusted to increase entropy: it may,
> but it's not relied on by the algorithm, just mixed in, see:
> http://lwn.net/Articles/507115/
Fair enough then.

J
> 
>>>       ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
>>>                              sizeof(buf));
>>> -
>> Good but unrelated change.  Should have been in a different patch...
> 
> Dropped unrelated whitespace fix.
> 
> Yours,
> Linus Walleij
> 

