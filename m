Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] Staging: iio: meter: ade7758_core: implement
 IIO_CHAN_INFO_SAMP_FREQ
To: Jonathan Cameron <jic23@kernel.org>,
 Sandhya Bankar <bankarsandhya512@gmail.com>, Michael.Hennerich@analog.com,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org
References: <20161003205906.GA9271@localhost.localdomain>
 <db94a7bd-715c-0c8d-3d9d-ecc4dbdefde4@kernel.org>
Cc: outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <26216a49-4186-1e3a-3aaf-924216c9f6f0@metafoo.de>
Date: Mon, 17 Oct 2016 12:31:57 +0200
MIME-Version: 1.0
In-Reply-To: <db94a7bd-715c-0c8d-3d9d-ecc4dbdefde4@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/09/2016 09:58 AM, Jonathan Cameron wrote:
> On 03/10/16 21:59, Sandhya Bankar wrote:
>> This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ attribute
>> wherein usage has some advantages like it can be accessed by in-kernel
>> consumers as well as reduces the code size.
>>
>> Hence moving functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
>> IIO_CHAN_INFO_SAMP_FREQ handlers. Also Adding ade7758_read_raw() and
>> ade7758_write_raw() to allow reading/writing the element as well.
>>
>> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> This is another driver where I'd argue that hardware will be needed
> to take it much further unfortunately. I've asked Lars to confirm
> if Analog have any intent wrt to these meter drivers in the other
> thread. Let's see what he comes back with,

I'll let Michael make the decision on these.

On one hand these are pretty low priory, there is a lot of work to do and I
don't have the hardware nor experience with power meters. All of this speaks
for pulling them plug, but on the other hand I've seen people actually using
these drivers.
