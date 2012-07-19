Return-Path: <lars@metafoo.de>
Message-ID: <50081AC0.10703@metafoo.de>
Date: Thu, 19 Jul 2012 16:33:36 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Wolfgang Denk <wd@denx.de>, Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207050148.27289.marex@denx.de> <4FF55149.2080801@metafoo.de> <201207191623.14492.marex@denx.de>
In-Reply-To: <201207191623.14492.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/19/2012 04:23 PM, Marek Vasut wrote:
> Dear Lars-Peter Clausen,
> 
> Sorry for my late reply, got busy with other crazy stuff.
> 
> [...]
> 
>>>> Is there any reason not to use the mxs_lradc struct directly has the iio
>>>> data?
>>>
>>> I explained it below in the patch. I hope we'll eventually support the
>>> delay triggers, which will need 4 separate IIO devices. And this is
>>> where this structure will be augmented by other components.
>>
>> Ok I saw the comment, but it wasn't obvious to me that delay channels will
>> require multiple IIO devices. Might make sense to state this explicitly.
> 
> Fixed.
> 
>>>>> [...]
>>>>>
>>>>> +
>>>>> +/*
>>>>> + * Channel management
>>>>> + *
>>>>> + * This involves crazy mapping between 8 virtual channels the CTRL4
>>>>> register + * can harbor and 16 channels total this hardware supports.
>>>>> + */
>>>>
>>>> I suppose this means only a maximum 8 channels can be active at a time.
>>>> I've recently posted a patch which makes it easy to implement such a
>>>> restriction. http://www.spinics.net/lists/linux-iio/msg05936.html and
>>>> http://www.spinics.net/lists/linux-iio/msg05935.html for an example
>>>> validate callback implementation. In your case you'd check for
>>>> bitmap_weight(...) <= 8. Those patches are not yet in IIO though.
>>>
>>> This is good. When do you expect this to hit linux-next possibly? Or at
>>> least linux-iio?
>>
>> soon, hopefully.
> 
> So I checked this, not sure how it'll help me though.

Right now with your driver you can enable any combination of channels. If
more than 8 channels are enabled and you start sampling it will fail, since
not all channels can be mapped. With those patch you can implement a
validate callback and check for bitmap_weight(scan_mask) <= 8. This will
ensure that it is not possible to select more than 8 channels at once, which
again means that starting sampling can't fail of this.

- Lars
