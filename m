Return-Path: <ldewangan@nvidia.com>
Message-ID: <57052432.8070700@nvidia.com>
Date: Wed, 6 Apr 2016 20:28:58 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, <linux-doc@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for iio_channel_{get,release}
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com> <CAEnQRZBtqDQjydDKywYy9oLecFtjntfWhgOtd2xekVyFrYkH3w@mail.gmail.com>
In-Reply-To: <CAEnQRZBtqDQjydDKywYy9oLecFtjntfWhgOtd2xekVyFrYkH3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Daniel,


On Wednesday 06 April 2016 07:19 PM, Daniel Baluta wrote:
> On Wed, Apr 6, 2016 at 1:31 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>> Some of kernel driver uses the IIO framework to get the sensor
>> value via ADC or IIO HW driver. The client driver get iio channel
>> by iio_channel_get() and release it by calling iio_channel_release().
>>
>> Add resource managed version (devm_*) of these APIs so that if client
>> calls the devm_iio_channel_get() then it need not to release it explicitly,
>> it can be done by managed device framework when driver get un-binded.
>>
>> This reduces the code in error path and also need of .remove callback in
>> some cases.
>>
> Please provide at least one example of code that uses this API.

Most of client for this APIs are in other subsystem.
When I was working on the patch
[PATCH 2/2] thermal: generic-adc: Add ADC based thermal sensor driver

if I have devm_iio_channel_get() then I can get .remove callback at all.

I did not use this new APIs in my patch because they are in different 
subsystem.
