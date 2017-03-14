Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34943 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdCNRg6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Mar 2017 13:36:58 -0400
Received: by mail-io0-f178.google.com with SMTP id z13so4346702iof.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Mar 2017 10:36:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com>
 <alpine.DEB.2.20.1703122154130.7649@hadrien> <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com>
 <alpine.DEB.2.20.1703122235320.7649@hadrien> <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
 <35231dfd-af42-bbd3-3be6-4e03a728a92f@kernel.org> <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de>
From: Gargi Sharma <gs051095@gmail.com>
Date: Tue, 14 Mar 2017 23:06:16 +0530
Message-ID: <CAOCi2DEecT6tdxmz7_9Q5aWC7_+VZCKD1+Vwe9F5gA9jAuQ2=A@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Alison Schofield <amsfield22@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 14, 2017 at 2:24 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/13/2017 09:51 PM, Jonathan Cameron wrote:
> [...]
>>>> Gargi,
>>>>
>>>> Please insert the new lock above the __cacheline_aligned struct
>>>> member.
>>>
>>> I will do that, but is there any reason why the lock should be above
>>> ____cacheline_aligned struct member?
>> Yes.  It's in fact very important that nothing comes after that.
>>
>> Will leave the why as an exercise for the reader.   I'll give the
>> hit of spi drivers that do DMA...
>
>
> One hint though, the answer is somewhere in Documentation/DMA-API.txt

>From what I have understood is that cacheline is used for keeping most
frequently accessed values in adjacent cachelines. We want the
cacheline_aligned at the end in the struct definition so as to avoid
any holes after the cacheline boundary.
>
