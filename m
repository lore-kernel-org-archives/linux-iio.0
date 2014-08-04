Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-033.synserver.de ([212.40.185.33]:1059 "EHLO
	smtp-out-031.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751147AbaHDHSk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Aug 2014 03:18:40 -0400
Message-ID: <53DF33CE.4080100@metafoo.de>
Date: Mon, 04 Aug 2014 09:18:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Aniroop Mathur <aniroop.mathur@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: IIO: Why cannot open two iio device node file descriptors simultaneously
 ?
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>	<53DCCB4A.3020304@kernel.org>	<CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>	<53DD1881.1020607@kernel.org>	<53DDEEC6.2070300@metafoo.de> <CADYu30--CpVmTowroGJEcKbg78B-xrzGXfdhFxpOYXAgcD41gA@mail.gmail.com>
In-Reply-To: <CADYu30--CpVmTowroGJEcKbg78B-xrzGXfdhFxpOYXAgcD41gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/2014 11:32 AM, Aniroop Mathur wrote:
> On Sun, Aug 3, 2014 at 1:41 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 08/02/2014 06:57 PM, Jonathan Cameron wrote:
>> [...]
>>
>>>> So, even after opening iio device node,
>>>> can we write the data to IIO device node from user space ?
>>>> (I do not see write function in below fileops)
>>>
>>>
>>> Indeed.  Lars was working on some buffered support for DACs but hasn't
>>> yet submitted it for mainline inclusion.  Lars how is the buffered output
>>> stuff coming along?
>>
>>
>> I still need to do the re-write you wanted me to do, otherwise its working
>> fine ;)
>>
>
> Great :)
> So, it is possible to write data to iio fd ?

No you can't. At least not with the upstream code. What exactly is it that 
you want to do with this?

- Lars
