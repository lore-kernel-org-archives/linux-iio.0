Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35647 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938857AbcKLPyd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 10:54:33 -0500
Subject: Re: [PATCH 1/2] iio: bmi160: Support hardware fifo
To: Marcin Niestroj <m.niestroj@grinn-global.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
 <alpine.DEB.2.02.1611031252480.11256@pmeerw.net>
 <eed0df11-6520-c3fa-c6cd-46c13dcddc1f@grinn-global.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cc8b323a-fd59-703b-cb4b-1ad0a5a96717@kernel.org>
Date: Sat, 12 Nov 2016 15:53:31 +0000
MIME-Version: 1.0
In-Reply-To: <eed0df11-6520-c3fa-c6cd-46c13dcddc1f@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/16 14:16, Marcin Niestroj wrote:
> Hi,
> Thanks for review, below are my comments.
> 
> On 03.11.2016 13:09, Peter Meerwald-Stadler wrote:
>>
>>> This patch was developed primarily based on bmc150_accel hardware fifo
>>> implementation.
>>
>> parts of the patch are cleanup and bugfixing; should be separate?
>>
>> more comments below
>>
>>> IRQ handler was added, which for now is responsible only for handling
>>> watermark interrupts. The BMI160 chip has two interrupt outputs. By
>>> default INT is considered to be connected. If INT2 is used instead, the
>>> interrupt-names device-tree property can be used to specify that.
>>>
>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>>> ---
<snip>
>>> +    /* Handle demux */
>>> +    timestamp = last_timestamp - (last_samples * data->fifo_sample_period);
>>> +    buffer_iter = buffer;
>>> +    for (i = 0; i < fifo_samples; i++) {
>>> +        u8 tmp_buf[indio_dev->scan_bytes];
>>
>> non-constant array size, is this allowed these days?
> 
> I am not sure if this is permitted in kernel. [1] says that ISO C99 adds arrays of variable length.
> 
> The reason I have used it is that iio_push_to_buffers_with_timestamp uses indio_dev->scan_bytes to write timestamp to last element in array.
> One of the possiblities to get rid of non-constant array size is to determine maximum size. Is that what I should do?
Yes.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html
> 
>>
<snip>
