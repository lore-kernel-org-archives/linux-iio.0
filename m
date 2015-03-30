Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48390 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbC3Tkn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 15:40:43 -0400
Message-ID: <5519A6B7.1000706@kernel.org>
Date: Mon, 30 Mar 2015 20:40:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
CC: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org,
	jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, tglx@linutronix.de, daniel.lezcano@linaro.org
Subject: Re: [PATCH 6/6] iio/adc/cc10001_adc.c: Fix !HAS_IOMEM build
References: <1426541230-928-1-git-send-email-richard@nod.at> <1426541230-928-6-git-send-email-richard@nod.at> <550D5772.2010400@kernel.org>
In-Reply-To: <550D5772.2010400@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/15 11:35, Jonathan Cameron wrote:
> On 16/03/15 21:27, Richard Weinberger wrote:
>> Fixes:
>> drivers/built-in.o: In function `cc10001_adc_probe':
>> cc10001_adc.c:(.text+0x412e92): undefined reference to `devm_ioremap_resource'
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> Applied to the fixes-togreg branch of iio.git.
> Won't push this out for a day or so as waiting for Greg to pull the previous set.
>> ---
>>  drivers/iio/adc/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 202daf8..46379b1 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -137,7 +137,8 @@ config AXP288_ADC
>>  
>>  config CC10001_ADC
>>  	tristate "Cosmic Circuits 10001 ADC driver"
>> -	depends on HAS_IOMEM || HAVE_CLK || REGULATOR
>> +	depends on HAVE_CLK || REGULATOR
>> +	depends on HAS_IOMEM
>>  	select IIO_BUFFER
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>
Hmm. Just noticed this whilst sending the pull request.  That
HAVE_CLK || REGULATOR also seems rather implausible!

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

