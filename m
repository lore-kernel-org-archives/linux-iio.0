Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:37752 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751922AbdJYDnk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Oct 2017 23:43:40 -0400
Subject: Re: [PATCH 1/1] iio: inkern: add helper to enable a channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
References: <1507171066-83517-1-git-send-email-preid@electromag.com.au>
 <20171008114115.7002f440@archlinux>
 <10792f6e-76d0-5804-8306-e893d8b8f23c@electromag.com.au>
 <20171021173920.31a90145@archlinux>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <0a23ecfa-f682-4182-bf21-b86c86bdcfce@electromag.com.au>
Date: Wed, 25 Oct 2017 11:43:33 +0800
MIME-Version: 1.0
In-Reply-To: <20171021173920.31a90145@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/2017 00:39, Jonathan Cameron wrote:
> On Mon, 16 Oct 2017 09:50:34 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> On 8/10/2017 18:41, Jonathan Cameron wrote:
>>> On Thu,  5 Oct 2017 10:37:46 +0800
>>> Phil Reid <preid@electromag.com.au> wrote:
>>>    
>>>> This is done by calling a generic write attribute helper similar
>>>> to the existing read attribute helper. Update write raw helper
>>>> to use new write attribute function.
>>>>
>>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>>
>>> Hi Phil,
>>>
>>> In principle this is fine but there are a few subtle details that need
>>> tidying up...
>>>
>>> Also - normally a core ABI patch like this would only be applied as
>>> part of a series that is using the change.  Is such a series on its
>>> way?  We would want to see a usecase to evaluate the additional
>>> interface.
>>
>> G'day Jonathan,
>>
>> Not really. The hardware for the driver is custom fpga core and external hardware device.
>> No reason it can't be up-streamed but I doubt it'd be of use to anyone else and I haven't
>> made much effort to write the driver to meet the kernel coding standards.
>>
>> Driver is basically a posix clock using an OCXO that is tuned using a DAC.
>> Don't know if there's any interest in such a thing.
> Yeah - that one is a little random ;)
> 
> Hohum.  Lets make an exception - with the tidy ups below I'll take this
> even though we don't have an in kernel user for now...
> 

Thanks, I'll send v2 soon.

-- 
Regards
Phil Reid

