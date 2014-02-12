Return-Path: <lars@metafoo.de>
Message-ID: <52FBAF44.6090008@metafoo.de>
Date: Wed, 12 Feb 2014 18:28:36 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Harald Geyer <harald@ccbib.org>,
 linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [RFC] iio: mxs-lradc: Add support for current source
References: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at> <52F61C2A.90101@kernel.org> <20140212161046.GC28112@sirena.org.uk> <3adf03e3-5f35-4400-8d5a-2fa415f46d2e@email.android.com>
In-Reply-To: <3adf03e3-5f35-4400-8d5a-2fa415f46d2e@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/12/2014 06:20 PM, Jonathan Cameron wrote:
>
>
> On February 12, 2014 4:10:46 PM GMT+00:00, Mark Brown <broonie@kernel.org> wrote:
>> On Sat, Feb 08, 2014 at 11:59:38AM +0000, Jonathan Cameron wrote:
>>> On 28/01/14 13:52, Harald Geyer wrote:
>>
>>>> The LRADC can drive two of its ADC channels with a defined current
>>>> between 0 and 300uA to allow reading thermistors without external
>>>> current source. I'm not sure what the right IIO ABI in this case
>>
>>> I'd be tempted to do this via the regulator framework instead of IIO.
>>> At somepoint we could have a bridge to allow an iio interface on a
>> regulator
>>> if anyone wants it (you never know)
>>
>> I'm very worried about the idea of an ABI - if IIO wants to offer
>> something that is implemented using the regulator API that's fine but
>> doing it directly from the regulator API sounds worrying.
>
> Would definitely be implemented using the regulator ABI. Would effectively pipe DAC writes from user space to regulator voltage requests.
>
> Not sure I really like the idea anyway but some DACs look awfully like regulators so it might become an issue...

Yep, e.g. see drivers/regulator/ad5398.c

- Lars
