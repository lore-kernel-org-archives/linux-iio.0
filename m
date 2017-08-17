Return-Path: <SRS0=gftV=7T=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH] iio: accel: mma8452: Bugfix to enbale and allow different
 events to work parallely.
To: Martin Kepplinger <martink@posteo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com
References: <1502750644-8854-1-git-send-email-harinath922@gmail.com>
 <alpine.DEB.2.20.1708161455420.27224@vps.pmeerw.net>
 <0a512995-3fd5-e38e-73a6-417337515ce6@gmail.com>
 <13587F36-588D-4011-8E70-A8892F81887E@posteo.de>
From: Harinath Nampally <harinath922@gmail.com>
Message-ID: <9202ac3c-cc5b-2b45-ba37-d6a24364b9e6@gmail.com>
Date: Thu, 17 Aug 2017 07:55:45 -0400
MIME-Version: 1.0
In-Reply-To: <13587F36-588D-4011-8E70-A8892F81887E@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

> This patch fixes by detaching the event related information from
> chip_info struct,
>>> and based on channel type and event direction the corresponding
> event configuration registers
>>> are picked dynamically. Hence multiple events can be handled in
> read/write callbacks.
>> which chip can have which event(s)?
> I am planning to add 'supported events' field in
>
> struct mma_chip_info which indicates which chip can have which events.
> During initialization in 'mma_chip_info_table' would set this
> 'supported events' field for each chip.
> But I wonder should I add those changes as part of this patch?
> is it necessary or can it be documentation?
I think its not necessary as we only have Freefall and Transient events 
for now.
Ok I will just update the documentation.
>
> And this patch should have been called "v2". please include a persistent version history to v3 of this patch.
Sure I will send v3 patch, should I use '--in-reply-to' option of git 
send-email to send v3 patch as reply to
original thread?

On 08/17/2017 07:24 AM, Martin Kepplinger wrote:
>>>> This patch fixes by detaching the event related information from
>> chip_info struct,
>>>> and based on channel type and event direction the corresponding
>> event configuration registers
>>>> are picked dynamically. Hence multiple events can be handled in
>> read/write callbacks.
>>> which chip can have which event(s)?
>> I am planning to add 'supported events' field in
>>
>> struct mma_chip_info which indicates which chip can have which events.
>> During initialization in 'mma_chip_info_table' would set this
>> 'supported events' field for each chip.
>> But I wonder should I add those changes as part of this patch?
> is it necessary or can it be documentation?
>
> And this patch should have been called "v2". please include a persistent version history to v3 of this patch.
