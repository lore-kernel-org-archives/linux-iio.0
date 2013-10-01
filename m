Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3JAKVW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 06:21:22 -0400
Message-ID: <524AB04C.4070409@kernel.org>
Date: Tue, 01 Oct 2013 12:21:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 9/9] Staging/iio: add TODO reminder
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-10-git-send-email-jbe@pengutronix.de> <524AAEA8.4090106@kernel.org>
In-Reply-To: <524AAEA8.4090106@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 12:14, Jonathan Cameron wrote:
> On 09/23/13 15:36, Juergen Beisert wrote:
>> Some things have still to be done to the LRADC driver.
>>
>> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-input@vger.kernel.org
>> CC: devel@driverdev.osuosl.org
>> CC: Marek Vasut <marex@denx.de>
>> CC: Fabio Estevam <fabio.estevam@freescale.com>
>> CC: Jonathan Cameron <jic23@cam.ac.uk>
> Applied to the togreg branch of iio.git
> 
> Thanks.
> 
> Please check over the entire series as it was more than a little
> fiddly to apply and I may well have messed it up!
There may be a delay on me pushing this out.  Kernel.org isn't talking
to me right now for some reason.
> 
> Jonathan
>> ---
>>  drivers/staging/iio/TODO | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
>> index 04c2326..c22a0ed 100644
>> --- a/drivers/staging/iio/TODO
>> +++ b/drivers/staging/iio/TODO
>> @@ -13,6 +13,17 @@ Would be nice
>>  3) Expand device set. Lots of other maxim adc's have very
>>     similar interfaces.
>>  
>> +MXS LRADC driver:
>> +This is a classic MFD device as it combines the following subdevices
>> + - touchscreen controller (input subsystem related device)
>> + - general purpose ADC channels
>> + - battery voltage monitor (power subsystem related device)
>> + - die temperature monitor (thermal management)
>> +
>> +At least the battery voltage and die temperature feature is required in-kernel
>> +by a driver of the SoC's battery charging unit to avoid any damage to the
>> +silicon and the battery.
>> +
>>  TSL2561
>>  Would be nice
>>  1) Open question of userspace vs kernel space balance when
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
