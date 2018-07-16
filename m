Return-Path: <SRS0=DQey=KA=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 1/5] iio: adxl372: New driver for Analog Devices ADXL372
 Accelerometer
To: Jonathan Cameron <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
 mchehab@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, rdunlap@infradead.org,
 shreeya.patel23498@gmail.com, mirq-linux@rere.qmqm.pl,
 thierry.escande@collabora.com, himanshujha199640@gmail.com,
 gwendal@chromium.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1531409663-19846-1-git-send-email-stefan.popa@analog.com>
 <20180715105121.4c94bc53@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a54890d1-9ca4-b026-5c9c-539cf840315b@metafoo.de>
Date: Mon, 16 Jul 2018 13:13:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180715105121.4c94bc53@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 07/15/2018 11:51 AM, Jonathan Cameron wrote:
> On Thu, 12 Jul 2018 18:34:23 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
>> This patch adds basic support for Analog Devices ADXL372 SPI-Bus
>> Three-Axis Digital Accelerometer.
>>
>> The device is probed and configured the with some initial default
>> values. With this basic driver, it is possible to read raw acceleration
>> data.
>>
>> Datasheet:
>> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf
>>
>> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> 
> Hi Stefan,
> 
> Looks pretty good, but a few comments inline.
> 
> The slightly 'unusual' register read / write field in the least significant
> bit is a pain.  I really don't like the approach of 'fiddling' the register
> addresses each time though so I think you need a custom version of
> regmap-spi to deal with this inside.  I wonder how often this
> pattern actually occurs and whether it's worth thinking about extending
> the core regmap to deal with it (so add a shift value for addresses).

regmap should be able to handle this as is. pad_bits = 1, reg_bits = 7
should ensure the correct behavior.
