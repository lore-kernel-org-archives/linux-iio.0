Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53090 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KE3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:04:29 -0400
Message-ID: <51F3A940.6000006@kernel.org>
Date: Sat, 27 Jul 2013 12:04:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 00/11] iio: adc: Use devm_* APIs
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <51EE621E.3000108@metafoo.de>
In-Reply-To: <51EE621E.3000108@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 11:59, Lars-Peter Clausen wrote:
> On 07/23/2013 10:58 AM, Sachin Kamat wrote:
>> All patches are compile tested and based on togreg branch
>> of following tree:
>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>
>> Sachin Kamat (11):
>>   iio: adc: ad7298: Use devm_* APIs
>>   iio: adc: ad7476: Use devm_* APIs
>>   iio: adc: ad7791: Use devm_* APIs
>>   iio: adc: ad7793: Use devm_* APIs
>>   iio: adc: ad7887: Use devm_* APIs
>>   iio: adc: ad7923: Use devm_* APIs
> 
> For those above:
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
All applied to the togreg branch of iio.git

> 
> Thanks.
> 
>>   iio: adc: lp8788_adc: Use devm_* APIs
>>   iio: adc: mcp320x: Use devm_* APIs
>>   iio: adc: nau7802: Use devm_iio_device_alloc
>>   iio: adc: ti-adc081c: Use devm_* APIs
>>   iio: adc: viperboard_adc: Use devm_iio_device_alloc
>>
>>  drivers/iio/adc/ad7298.c         |   24 ++++++++----------------
>>  drivers/iio/adc/ad7476.c         |   26 ++++++++------------------
>>  drivers/iio/adc/ad7791.c         |   19 +++++--------------
>>  drivers/iio/adc/ad7793.c         |   23 ++++++-----------------
>>  drivers/iio/adc/ad7887.c         |   23 +++++++----------------
>>  drivers/iio/adc/ad7923.c         |   20 +++++++-------------
>>  drivers/iio/adc/lp8788_adc.c     |    7 ++-----
>>  drivers/iio/adc/mcp320x.c        |   18 +++++-------------
>>  drivers/iio/adc/nau7802.c        |   19 ++++++++-----------
>>  drivers/iio/adc/ti-adc081c.c     |   18 +++++-------------
>>  drivers/iio/adc/viperboard_adc.c |    9 ++-------
>>  11 files changed, 63 insertions(+), 143 deletions(-)
>>
> 
