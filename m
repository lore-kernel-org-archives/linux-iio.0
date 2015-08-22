Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38235 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbHVSIY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 14:08:24 -0400
Subject: Re: [PATCH 01/18] iio: Export SPI module alias information in missing
 drivers
To: Lars-Peter Clausen <lars@metafoo.de>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-2-git-send-email-javier@osg.samsung.com>
 <55D5F714.4020903@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8BA96.1090509@kernel.org>
Date: Sat, 22 Aug 2015 19:08:22 +0100
MIME-Version: 1.0
In-Reply-To: <55D5F714.4020903@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 16:49, Lars-Peter Clausen wrote:
> On 08/20/2015 09:07 AM, Javier Martinez Canillas wrote:
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
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> 
> Thanks.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

