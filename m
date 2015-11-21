Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40250 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbKURxi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 12:53:38 -0500
Subject: Re: [PATCH] staging:iio:ad7780: Remove the ad7780_platform_data
To: Lars-Peter Clausen <lars@metafoo.de>,
	Dragos Bogdan <dragos.bogdan@analog.com>
References: <1447856194-26450-1-git-send-email-dragos.bogdan@analog.com>
 <564DBB91.4010400@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650AFA0.6050503@kernel.org>
Date: Sat, 21 Nov 2015 17:53:36 +0000
MIME-Version: 1.0
In-Reply-To: <564DBB91.4010400@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/11/15 12:07, Lars-Peter Clausen wrote:
> On 11/18/2015 03:16 PM, Dragos Bogdan wrote:
>> The ad7780_platform_data contains just the reference voltage information.
>> Since the preferred way of specifying this information is using the Linux
>> regulator framework and the ad7780 platform_data is not used by other
>> users, it can be completely removed.
>>
>> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> Looks good, thanks.
> 
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Just one thing to consider for future patches...
> 
> [...]
>> -		dev_warn(&spi->dev, "reference voltage unspecified\n");
>> +		dev_warn(&spi->dev, "Reference voltage unspecified\n");
> 
> Strictly speaking this is a unrelated change and ideally would have been
> split into a separate patch.
> 

