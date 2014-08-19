Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1041 "EHLO
	smtp-out-184.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753526AbaHSTVB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Aug 2014 15:21:01 -0400
Message-ID: <53F3A39C.4090209@metafoo.de>
Date: Tue, 19 Aug 2014 21:21:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add entry for Analog Devices IIO drivers
References: <1408349339-21757-1-git-send-email-lars@metafoo.de> <53F3A30B.80705@kernel.org>
In-Reply-To: <53F3A30B.80705@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/2014 09:18 PM, Jonathan Cameron wrote:
> On 18/08/14 09:08, Lars-Peter Clausen wrote:
>> Add Michael and myself as the maintainer for the Analog Devices IIO drivers.
>> The entry matches on all files in drivers/staging/iio and drivers/iio/ starting
>> with the 'ad' prefix, except for 'adjd' as that one is used by Avago
>> Technologies.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Not quite sure why but this didn't apply cleanly so I did it by hand.

Yea, that was me being stupid. Always drink your coffee first, then send 
patches. Sorry for the mess, thanks for fixing it up.

