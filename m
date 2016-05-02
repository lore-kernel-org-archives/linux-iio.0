Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 02 May 2016 14:25:00 +0200
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <kernel@pengutronix.de>, Marek Vasut <marex@denx.de>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] mxs-lradc: Add support for current sources
In-Reply-To: <ac57f3e9-f8f2-a6ef-52fa-0a13d7df5d4f@kernel.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
 <572379F5.8000501@i2se.com> <aadb3f41413d093312c0af3e4c207a8a@ccbib.org>
 <ac57f3e9-f8f2-a6ef-52fa-0a13d7df5d4f@kernel.org>
Message-ID: <a0d59747ffca9d900feecece4cfcae82@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

On 01.05.2016 20:02, Jonathan Cameron wrote:
> On 29/04/16 18:45, Harald Geyer wrote:
>> My thinking is that there should be a thermistor (or whatever else) 
>> driver,
>> that is a consumer of the regulator and a consumer of the 
>> IIO_VOLTAGE
>> iio channel and provides a new device with an IIO_RESISTANCE or 
>> IIO_TEMP
>> channel. Maybe there is a simpler solution, that I'm missing?
> I agree with that approach - need a way to describe the upstream
> hardware - so
> will need a thermistor driver
>>
>> Actually I'm not 100% happy with the above solution myself, because 
>> if we
>> start supporting devices that act as an iio-multiplexer (some device 
>> that
>> is an iio consumer and provides many new iio channels and can 
>> control
>> via gpios which of it child channels is actually routed to the 
>> upstream
>> device) I don't know how to properly manage the regulator device.
> Hmm. Are you talking about muxing the regulator as well?  That will 
> get
> complex indeed.  Might be possible to cheat and imply the regulators 
> are
> always connected to all inputs...  or do you want to dynamically 
> change
> the regulator output?  That gets messy fast - though in theory might 
> be
> possible...

Yes, that's a good summary of what I'm thinking. As there is no
iio-multiplexer yet, this is sort of an academic question. But it's
kind of an obvious thing to want, so we shouldn't be surprised when
somebody actually starts working on that.

Thanks,
Harald
