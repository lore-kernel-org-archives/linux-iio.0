Return-Path: <lars@metafoo.de>
Message-ID: <53DDEEC6.2070300@metafoo.de>
Date: Sun, 03 Aug 2014 10:11:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Aniroop Mathur <aniroop.mathur@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: IIO: Why cannot open two iio device node file descriptors simultaneously
 ?
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>	<53DCCB4A.3020304@kernel.org> <CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com> <53DD1881.1020607@kernel.org>
In-Reply-To: <53DD1881.1020607@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/02/2014 06:57 PM, Jonathan Cameron wrote:
[...]
>> So, even after opening iio device node,
>> can we write the data to IIO device node from user space ?
>> (I do not see write function in below fileops)
>
> Indeed.  Lars was working on some buffered support for DACs but hasn't
> yet submitted it for mainline inclusion.  Lars how is the buffered output
> stuff coming along?

I still need to do the re-write you wanted me to do, otherwise its working 
fine ;)

- Lars
