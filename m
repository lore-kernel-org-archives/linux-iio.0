Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-061.synserver.de ([212.40.185.61]:1118 "EHLO
	smtp-out-057.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750747Ab1LFI6l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2011 03:58:41 -0500
Message-ID: <4EDDD956.4080908@metafoo.de>
Date: Tue, 06 Dec 2011 09:59:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac: Add AD5380 driver
References: <1323101333-26426-1-git-send-email-lars@metafoo.de> <4EDD3F14.804@kernel.org>
In-Reply-To: <4EDD3F14.804@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/05/2011 11:00 PM, Jonathan Cameron wrote:
> On 12/05/2011 04:08 PM, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices D5380, AD5381,
>> AD5382, AD5383, AD5384, AD5390, AD5391, AD5392 multi-channel
>> Digital to Analog Converters.
>>
> Lars-Peter
> 
> Just got a build warning on this you probably want to check out...
> 
> drivers/staging/iio/dac/ad5380.c:150:10: warning: Initializer entry
> defined twice
> drivers/staging/iio/dac/ad5380.c:160:10:   also defined here
> 
> Trivial, but good to fix!
> Jonathan

Yes, especially since this breaks support for the AD5391-5.
(I always wonder why my compiler doesn't give me these warnings)

Thanks,
- Lars
