Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970581AbdDTP1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2017 11:27:38 -0400
Subject: Re: [PATCH] tools: iio: add ability to pass kernel headers
To: Sekhar Nori <nsekhar@ti.com>, Jonathan Cameron <jic23@kernel.org>
References: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
 <1f009aa7-f1c0-cf7b-344b-fe83f3b4b7b9@kernel.org>
 <6104d595-462b-c154-5b6a-73ed33d0b258@infradead.org>
 <aa079d7f-3769-6961-1a13-8448ad0bc5cf@kernel.org>
 <aa34ef71-d341-6660-27c1-c94ece65879b@ti.com>
 <b59f1267-b30e-4c64-0a93-8f75b17fcdfb@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fda2abcc-abbf-f883-e564-160b977d88a2@infradead.org>
Date: Thu, 20 Apr 2017 08:27:33 -0700
MIME-Version: 1.0
In-Reply-To: <b59f1267-b30e-4c64-0a93-8f75b17fcdfb@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/17 06:53, Sekhar Nori wrote:
> On Tuesday 18 April 2017 03:42 PM, Sekhar Nori wrote:
>> Hi Jonathan, Randy,
>>
>> On Friday 14 April 2017 08:53 PM, Jonathan Cameron wrote:
>>> On 14/04/17 16:23, Randy Dunlap wrote:
>>>> On 04/14/17 07:42, Jonathan Cameron wrote:
>>>>> On 11/04/17 12:06, Sekhar Nori wrote:
>>>>>> Very often, especially when cross compiling, there is a need
>>>>>> to pass kernel headers different from those installed on the
>>>>>> build machine.
>>>>>>
>>>>>> Add support for doing this for iio utils by using the
>>>>>> 'INSTALL_HDR_PATH' environment variable. This is supported by
>>>>>> 'make headers_install' for installing kernel headers at a
>>>>>> user specified location. So you will do:
>>>>>>
>>>>>> $ make headers_install ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>>>>> $ make -C tools/iio ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>>>>>
>>>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>>>
>>>>> It's a bit of an oddity as that usually refers to where to put
>>>>> the headers rather than where they are.
>>>>>
>>>>> Is there a more general solution?  I couldn't find anything
>>>>> particularly consistent in tools.
>>>>
>>>> Whatever the solution is, it should be used for all tools/, not just iio.
>>>>
>>> Agreed!
>>
>> Alright, I will try to come up with something more generic and post
>> another version.
> 
> I have been looking at this, and coming up with something generic is
> more complicated than I thought. The problem is the flexibility thats
> allowed in building many of the tools. For example, you can build the
> led tools using any of these three methods:
> 
> $ make -C <kernelsrcdir> tools/leds
> $ make -C <kernelsrcdir>/tools leds
> $ make -C <kernelsrcdir>/tools/leds
> 
> The last one is specifically complicated because it totally bypasses all
> top level makefiles. I think adding dependency with a top level makefile
> will be a step backwards at least for leds.
> 
> Currently the leds makefile adds '-I../../include/uapi' to CFLAGS to
> access the latest kernel headers. Something similar is done for some
> other tools too. This makes it work for all the build cases above. I
> propose we do something similar for iio too.

Thanks for diving into all of that.  I am not surprised at
what you have found.

I believe that you can go ahead with your iio proposal.


-- 
~Randy
