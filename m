Return-Path: <javier@osg.samsung.com>
Subject: Re: [PATCH 02/18] staging: iio: hmc5843: Export missing SPI module
 alias information
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-3-git-send-email-javier@osg.samsung.com>
 <55D8B875.3060200@kernel.org>
Cc: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hartmut Knaack <knaack.h@gmx.de>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <55E4DE8D.9070109@osg.samsung.com>
Date: Tue, 1 Sep 2015 01:09:01 +0200
MIME-Version: 1.0
In-Reply-To: <55D8B875.3060200@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

On 08/22/2015 07:59 PM, Jonathan Cameron wrote:
> On 20/08/15 08:07, Javier Martinez Canillas wrote:
>> The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
>> regardless of the mechanism that was used to register the device
>> (i.e: OF or board code) and the table that is used later to match
>> the driver with the device (i.e: SPI id table or OF match table).
>>
>> So drivers needs to export the SPI id table and this be built into
>> the module or udev won't have the necessary information to autoload
>> the needed driver module when the device is added.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Applied to the togreg branch of iio.git.
> 
> This is too late for the upcoming merge window so it will be queued up for
> the next one.
>

IMHO this patch and "[PATCH 01/18] iio: Export SPI module alias
information in missing drivers" [0] are fixing broken module
autoloading which are bugs so are material for the 4.3 -rc cycle.
 
> Thanks,
> 
> Jonathan

[0]: https://lkml.org/lkml/2015/8/20/111

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
