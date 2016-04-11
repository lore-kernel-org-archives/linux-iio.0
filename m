Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56294 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbcDKQsy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2016 12:48:54 -0400
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
To: Guenter Roeck <linux@roeck-us.net>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
 <570A3FB2.7000600@kernel.org> <570BC74B.3000208@ti.com>
 <20160411163843.GA27218@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jean Delvare <jdelvare@suse.de>, <linux-hwmon@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <570BD530.8060508@ti.com>
Date: Mon, 11 Apr 2016 11:47:44 -0500
MIME-Version: 1.0
In-Reply-To: <20160411163843.GA27218@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/2016 11:38 AM, Guenter Roeck wrote:
> On Mon, Apr 11, 2016 at 10:48:27AM -0500, Andrew F. Davis wrote:
>> On 04/10/2016 06:57 AM, Jonathan Cameron wrote:
>>> On 08/04/16 19:19, Andrew F. Davis wrote:
>>>> The INA3221 is a three-channel, high-side current and bus voltage monitor
>>>> with an I2C and SMBUS compatible interface.
>>>>
>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>> Hi Andrew,
>>>
>>> My immediate thought on this one is whether it would be better off in hwmon.
>>> I'm not convinced either way from a quick glance at the data sheet, but the
>>> question needs to be addressed.
>>>
>>
>> I was on the fence with this also, I was leaning towards hwmod until I
>> looked onto how the ina2xx driver has been ported to iio. This is almost
>> the same part but the ina3x has three monitors vs one. In addition it
>> looks like NVIDIA has written a hwmod driver for this part
>> (https://github.com/Bogdacutu/STLinux-Kernel/blob/master/drivers/hwmon/ina3221.c)
>> but then also ported it over to IIO (although doesn't appear to be
>> upstream ready or ever has been submitted for such)
>> (https://github.com/SuperPichu/shield-tablet-kernel/blob/master/drivers/staging/iio/meter/ina3221.c)
>> So I figured this was the way things are moving, but I have no problem
>> working this as a hwmod driver. The IIO work is already done here, I'll
>> write the hwmod version also but keep working this, I see no reason we
>> cant have both if needed. (unless using this and just using iio_hwmod.c
>> if needed is more acceptable?)
>>
> 
> You can not have both since they would conflict with each other.
> ina2xx has possibly created a bad precedent. I am not inclined to accept
> a hwmon driver if an iio driver already exists. If you want an iio driver,
> fine with me, but then you (and its users) will have to live with its
> limitations when it comes to hardware monitoring.
> 

Hmm, my plan was an MFD device core, that then could mediate the two
sub-drivers, but I'm not sure about this yet.

> I don't really mind if things are going all towards iio if that is where
> the community wants to go. However, if that is the case, I would suggest
> that someone should spend the time to define a clear sense of 'limits'
> as well as alert handling in iio, in a way that is exportable to other
> subsystems (hwmon and thermal come into mind).
> 

I agree. I think both frameworks offer useful interfaces, so I would
hate to limit users to one, but for now I'll just post the hwmon version
here in a bit and live with that until someone requests the IIO support.

Andrew
