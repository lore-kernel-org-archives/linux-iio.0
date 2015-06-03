Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-080.synserver.de ([212.40.185.80]:1107 "EHLO
	smtp-out-080.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965474AbbFCRTb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 13:19:31 -0400
Message-ID: <556F3720.80504@metafoo.de>
Date: Wed, 03 Jun 2015 19:19:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Require strict scan mask matching in hardware
 mode
References: <1432916062-15195-1-git-send-email-lars@metafoo.de> <1432916062-15195-4-git-send-email-lars@metafoo.de> <556C3546.4020300@kernel.org>
In-Reply-To: <556C3546.4020300@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2015 12:34 PM, Jonathan Cameron wrote:
> On 29/05/15 17:14, Lars-Peter Clausen wrote:
>> In hardware mode we can not use the software demuxer, this means that the
>> selected scan mask needs to match one of the available scan masks exactly.
>>
>> It also means that all attached buffers need to use the same scan mask.
>> Given that when operating in hardware mode there is typically only a single
>> buffer attached to the device this not an issue. Add a sanity check to make
>> sure that only a single buffer is attached in hardware mode nevertheless.
>>
> That pretty much sums up why devices supporting only hardware buffers
> are probably not going to be a long term feature!
> Mind you for fast devices we may want to allow forced bypassing of the
> demux (i.e. a hardware buffer).
>
> Out of curiosity is this series a precursor to another hardware buffered
> device or just a useful intellectual exercise?

It's all for real hardware and I'm already using it in some projects. E.g. 
one thing I'm working on is adding optional DMA support for some of the 
converters, if DMA is available it will use hardware mode. If no DMA is 
available or the consumer wants to run in software triggered mode fallback 
to software triggered mode.

- Lars
