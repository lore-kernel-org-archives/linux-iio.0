Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56855 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964909AbeEYJ0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 May 2018 05:26:36 -0400
Subject: Re: [PATCH v6 3/9] docs: Add Generic Counter interface documentation
To: Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
CC: <benjamin.gaignard@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
 <20180520163109.22b11af8@archlinux> <20180521134729.GB5723@sophia>
 <20180522180805.2b61f0ed@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <cd045792-8ed2-8d83-231a-661975ffc7c5@st.com>
Date: Fri, 25 May 2018 11:26:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180522180805.2b61f0ed@archlinux>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2018 07:08 PM, Jonathan Cameron wrote:
>>>> +* Quadrature x2 Rising:
>>>> +  Rising edges on either quadrature pair signals updates the respective
>>>> +  count. Quadrature encoding determines the direction.  
>>> This one I've never met.  Really? There are devices who do this form
>>> of crazy? It gives really uneven counting and I'm failing to see when
>>> it would ever make sense...  References for these odd corner cases
>>> would be good.
>>>
>>>
>>> __|---|____|-----|____
>>> ____|----|____|-----|____
>>>
>>> 001122222223334444444  
>> That's the same reaction I had when I discovered this -- in fact the
>> STM32 LP Timer is the first time I've come across such a quadrature
>> mode. I'm not sure of the use case for this mode, because positioning
>> wouldn't be precise as you've pointed out. Perhaps Fabrice or Benjamin
>> can probe the ST guys responsible for this design choice to figure out
>> the rationale.
> Hmm.  My inclination would be to not support it unless someone can up
> with a meaningful use.  We are adding ABI (be it not much) for a case
> that to us makes no sense.

Hi Jonathan, William,

Sorry for the late reply. To follow your advise, we can probably drop
this for now. I think simple counter, or quadrature x4 will be mostly
used for now. As you pointed out, there's not much ABI for x2
rising/falling cases. It will not be a big deal to add it later if needed.

I can help to update (remove & test) this in LP-Timer counter driver if
you wish.

Please let me know,

Thanks,
Fabrice

> 
> Looks rather like the sort of thing that is a side effect of the
> implementation rather than deliberate.
> 
>> I'm leaving in these modes for now, as they do exist in the STM32 LP
>> Timer, but it does make me curious what the intentions for them were
>> (perhaps use cases outside of traditional quadrature encoder
>> positioning).
>>
> Sure if there is a usecase then fair enough.
> 
> Jonathan
> 
> 
