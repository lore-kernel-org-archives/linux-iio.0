Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:19902 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756493AbdDRKNm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2017 06:13:42 -0400
Subject: Re: [PATCH] tools: iio: add ability to pass kernel headers
To: Jonathan Cameron <jic23@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
 <1f009aa7-f1c0-cf7b-344b-fe83f3b4b7b9@kernel.org>
 <6104d595-462b-c154-5b6a-73ed33d0b258@infradead.org>
 <aa079d7f-3769-6961-1a13-8448ad0bc5cf@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <aa34ef71-d341-6660-27c1-c94ece65879b@ti.com>
Date: Tue, 18 Apr 2017 15:42:41 +0530
MIME-Version: 1.0
In-Reply-To: <aa079d7f-3769-6961-1a13-8448ad0bc5cf@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan, Randy,

On Friday 14 April 2017 08:53 PM, Jonathan Cameron wrote:
> On 14/04/17 16:23, Randy Dunlap wrote:
>> On 04/14/17 07:42, Jonathan Cameron wrote:
>>> On 11/04/17 12:06, Sekhar Nori wrote:
>>>> Very often, especially when cross compiling, there is a need
>>>> to pass kernel headers different from those installed on the
>>>> build machine.
>>>>
>>>> Add support for doing this for iio utils by using the
>>>> 'INSTALL_HDR_PATH' environment variable. This is supported by
>>>> 'make headers_install' for installing kernel headers at a
>>>> user specified location. So you will do:
>>>>
>>>> $ make headers_install ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>>> $ make -C tools/iio ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>>>
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>
>>> It's a bit of an oddity as that usually refers to where to put
>>> the headers rather than where they are.
>>>
>>> Is there a more general solution?  I couldn't find anything
>>> particularly consistent in tools.
>>
>> Whatever the solution is, it should be used for all tools/, not just iio.
>>
> Agreed!

Alright, I will try to come up with something more generic and post
another version.

Thanks,
Sekhar
