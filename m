Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49024 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbHOTtp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 15:49:45 -0400
Subject: Re: [PATCH v2] staging: iio: hmc5843: Set iio name dynamically
To: Lars-Peter Clausen <lars@metafoo.de>, sdliyong@gmail.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	marek@goldelico.com
References: <1439385946-28388-1-git-send-email-sdliyong@gmail.com>
 <55CB6475.4020506@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF97D4.7080100@kernel.org>
Date: Sat, 15 Aug 2015 20:49:40 +0100
MIME-Version: 1.0
In-Reply-To: <55CB6475.4020506@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 16:21, Lars-Peter Clausen wrote:
> On 08/12/2015 03:25 PM, sdliyong@gmail.com wrote:
>> From: Yong Li <sdliyong@gmail.com>
>>
>> Load the driver using the below command:
>> echo hmc5983 0x1e > /sys/bus/i2c/devices/i2c-?/new_device
>>
>> In sysfs, the iio name is hmc5843, however the i2c name is hmc5983,
>> they are inconsistent.
>>
>> With this patch, the iio name will be the same as the i2c device name
>>
>> Signed-off-by: Yong Li <sdliyong@gmail.com>
> 
> Looks good.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

