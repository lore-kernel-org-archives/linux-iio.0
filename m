Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60784 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755185AbcIEIwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 04:52:03 -0400
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1609041754350.2060@pmeerw.net>
 <aed1e00f-ceaa-27e9-502d-51428f59a84f@free-electrons.com>
 <alpine.DEB.2.02.1609050924370.12528@pmeerw.net>
Cc: thomas.petazzoni@free-electrons.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        knaack.h@gmx.de, maxime.ripard@free-electrons.com, jic23@kernel.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <d40388ec-bf25-92b2-eeb6-39749d88c15c@free-electrons.com>
Date: Mon, 5 Sep 2016 10:52:00 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1609050924370.12528@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/2016 10:07, Peter Meerwald-Stadler wrote:
> 
>>>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>>>> controller and a thermal sensor. This patch adds the ADC driver which is
>>>> based on the MFD for the same SoCs ADC.
>>>
>>> nitpicking ahead
> 
>> [...]
>>>> +
>>>> +const unsigned int sun4i_gpadc_chan_select(unsigned int chan)
>>>
>>> static instead of const?
> 
>> static const then?
> 
> no, the const is redundant and ignored
> -Wignored-qualifiers gives a warning
> 
> just static, no const
> 
> see
> http://stackoverflow.com/questions/12052468/type-qualifiers-on-function-return-type
> 

ACK. Thanks.

>>>> +{
>>>> +	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>>>> +}
>>>> +
>>>> +struct soc_specific {
>>>> +	const int		temp_offset;
>>>
>>> wondering why you constify every member?
>>>
>>
>> Because they're supposed to be fixed values? It won't change in runtime.
>> Is there any reason why I shouldn't do that?
> 
> yes, but using the entire struct as const has the same effect;
> constifying individual members makes more sense if there are also 
> non-const members
> 
> nothing wrong, just unusual
> 

So I would let all members non-const and then when using the struct
soc_specific as a member in a struct or as a variable I would prefix it
with const? That's what you mean by using the entire struct as const?

[...]

Thanks,
Quentin
