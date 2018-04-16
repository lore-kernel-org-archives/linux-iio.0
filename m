Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:32990
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751199AbeDPH3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Apr 2018 03:29:17 -0400
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: Lars-Peter Clausen <lars@metafoo.de>,
        "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
 <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
 <6fff0256-c9f6-6302-45ac-afc7a3276b06@metafoo.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <181d76fd-e40c-abd2-7d22-d866c9ab3808@axentia.se>
Date: Mon, 16 Apr 2018 09:29:07 +0200
MIME-Version: 1.0
In-Reply-To: <6fff0256-c9f6-6302-45ac-afc7a3276b06@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-04-13 10:11, Lars-Peter Clausen wrote:
> On 04/13/2018 12:31 AM, Peter Rosin wrote:
>> On 2018-04-12 17:35, Andrew F. Davis wrote:
>>> On 04/12/2018 09:29 AM, Peter Rosin wrote:
>>>> But as I said in the cover letter, I didn't go with sense-gain since I
>>>> thought I would end up with requests for non-integer gains. There is
>>>> yet to be a comment on the non-integer gain problem, and before there
>>>> is a path forward for that case, I'm reluctant.
>>>
>>> Why not similar to what you had before with the resistor:
>>>
>>> sense-gain-multiplier
>>> sense-gain-divider
>>>
>>> if either are missing assume they are 1.
>>
>> Hmm, how about sense-gain for the normal integer case, and then divide
>> by sense-attenuation if needed? I.e. exactly the same functionality as
>> you describe, just different names.
> 
> There is some precedence in the clock bindings for using -mult and -div as
> the suffix for fractional scales. See fixed-factor-clock.txt.

Ok, I'm going with sense-gain-mult and sense-gain-div, but I'm going to
diverge a little bit from the clock binding and make them optional with
a default of 1 if missing.

I'm also going to use the compatible "current-sense-amplifier", and not
mention the LT6106, because I suspect that part can conceivable be used
in other ways...

But I'll wait for a bit with this and give everybody a last chance to
pitch suggestions and opinions.

Cheers,
Peter
