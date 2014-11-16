Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-045.synserver.de ([212.40.185.45]:1039 "EHLO
	smtp-out-035.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750722AbaKPUex (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:34:53 -0500
Message-ID: <54690A90.5070000@metafoo.de>
Date: Sun, 16 Nov 2014 21:35:28 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Fabien Proriol <Fabien.Proriol@jdsu.com>,
	Michal Simek <michal.simek@xilinx.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
References: <545B9479.5030700@jdsu.com> <545B976D.4080303@metafoo.de> <545B9EF1.8000606@jdsu.com> <545BA105.70105@metafoo.de> <54690921.5090307@kernel.org>
In-Reply-To: <54690921.5090307@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/16/2014 09:29 PM, Jonathan Cameron wrote:
> On 06/11/14 16:25, Lars-Peter Clausen wrote:
>> On 11/06/2014 05:18 PM, Fabien Proriol wrote:
>>> On 06/11/2014 16:44, Lars-Peter Clausen wrote:
>>>> On 11/06/2014 04:33 PM, Fabien Proriol wrote:
>>>>>     From 3f57e39e3c69476513c00cd5ec45703f58334972 Mon Sep 17 00:00:00 2001
>>>>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>>>>> Date: Tue, 4 Nov 2014 17:05:59 +0100
>>>>> Subject: [PATCH] xilinx-xadc-core: Fix voltage offset
>>>>>
>>>>> When xilinx-xadc is used with hwmon driver to read voltage, offset used
>>>>> for temperature is always apply.
>>>>> This patch change the return for IIO_CHAN_INFO_OFFSET to -EINVAL except
>>>>> for temperature to avoid offset.
>>>>
>>>> I think we should rather fix iio_channel_read() to check if the
>>>> channel supports the property that we try to read. Other drivers are
>>>> likely to suffer from the same issue and fixing it in a central place
>>>> fixes them all.
>>>>
>>>> - Lars
>>>>
>>>>
>>>
>>> Ok, I can propose this following patch.
>>> With my xilinx-xadc driver, it fix also the same problem...
>>>
>>
>> Yep, that looks better, thanks. It looks like your mail client screwed up the indenting and line wrapping in the patch. Can you try to re-send so it can be applied properly? One minor comment about the patch itself inline.
>>
> Hi Fabien,
>
> Did you get a chance to  make the minor tweak Lars suggested?

He did, but I just noticed he only sent it to me instead of the ml.

