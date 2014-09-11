Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46883 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529AbaIKIj0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Sep 2014 04:39:26 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Pavel Machek <pavel@denx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Yan Burman <burman.yan@gmail.com>,
	Yan Burman <yanb@mellanox.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Thu, 11 Sep 2014 10:38:59 +0200
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
Message-ID: <54115FA3.1040403@st.com>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org>
 <53FB6205.5020704@kernel.org>
 <CACRpkdb5NXJiTvaHz9_nJiZcFsyVnjPYjaYZ1YH9meBgJhoTJA@mail.gmail.com>
 <54104B26.5080707@st.com> <20140910133607.GA13361@xo-6d-61-c0.localdomain>
In-Reply-To: <20140910133607.GA13361@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When I have time yes for sure...:D

Denis

On 09/10/14 15:36, Pavel Machek wrote:
> Hi!
>
>> I'm sorry but I was in business trip. I think that current lis3lv02d
>> supports more things, I want to support everything in the current IIO
>> drivers but always I have no time.
> Ok then, can you add hwmon interfaces from the other driver to your one? That way,
> we can deprecate one of them...
>
> 									Pavel
>
>> BR,
>> Denis
>>
>>
>> On 08/27/14 15:38, Linus Walleij wrote:
>>> On Mon, Aug 25, 2014 at 6:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> On 23/08/14 18:31, Linus Walleij wrote:
>>>>> This adds support for the LIS3LV02 accelerometer found in the
>>>>> ST Microelectronics Nomadik board series.
>>>>>
>>>>> Cc: devicetree@vger.kernel.org
>>>>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>> This is a little 'interesting', given the part is already supported by
>>>> drivers/misc/lis3lv02d*.c and already has bindings under there.
>>>> Documentation/devicetree/bindings/misc/lis302.txt
>>>> (some of these are interesting).
>>> Grrr how come I missed this... It was originally merged as a
>>> hwmon driver.
>>>
>>>
>>>>> +/* CUSTOM VALUES FOR SENSOR 4 */
>>>>>
>>>> I wish now we'd nipped this naming convention in the bud and insisted
>>>> on naming after a relevant part. Oh well.
>>> Well we can always make an invasive patch fixing that. I can
>>> probably do it using sed or something.
>>>
>>>> Do we think this is the right way to handle the alternative support
>>>> here?
>>> Well this patch is a driver using the IIO framework and was written
>>> by ST, but the other driver support a few other interesting features
>>> and seems to be for the laptop usecase.
>>>
>>> Adding the other authors to the TO: line...
>>>
>>> Yours,
>>> Linus Walleij
