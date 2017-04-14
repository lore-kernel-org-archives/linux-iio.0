Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56690 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdDNPXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 11:23:53 -0400
Subject: Re: [PATCH] tools: iio: add ability to pass kernel headers
To: Randy Dunlap <rdunlap@infradead.org>, Sekhar Nori <nsekhar@ti.com>
References: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
 <1f009aa7-f1c0-cf7b-344b-fe83f3b4b7b9@kernel.org>
 <6104d595-462b-c154-5b6a-73ed33d0b258@infradead.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aa079d7f-3769-6961-1a13-8448ad0bc5cf@kernel.org>
Date: Fri, 14 Apr 2017 16:23:51 +0100
MIME-Version: 1.0
In-Reply-To: <6104d595-462b-c154-5b6a-73ed33d0b258@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/17 16:23, Randy Dunlap wrote:
> On 04/14/17 07:42, Jonathan Cameron wrote:
>> On 11/04/17 12:06, Sekhar Nori wrote:
>>> Very often, especially when cross compiling, there is a need
>>> to pass kernel headers different from those installed on the
>>> build machine.
>>>
>>> Add support for doing this for iio utils by using the
>>> 'INSTALL_HDR_PATH' environment variable. This is supported by
>>> 'make headers_install' for installing kernel headers at a
>>> user specified location. So you will do:
>>>
>>> $ make headers_install ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>> $ make -C tools/iio ARCH=arm INSTALL_HDR_PATH=<absolute-path>
>>>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>
>> It's a bit of an oddity as that usually refers to where to put
>> the headers rather than where they are.
>>
>> Is there a more general solution?  I couldn't find anything
>> particularly consistent in tools.
> 
> Whatever the solution is, it should be used for all tools/, not just iio.
> 
Agreed!
>>> ---
>>>  tools/iio/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 

