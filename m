Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:52004 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaKDXsh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 18:48:37 -0500
Message-ID: <54596575.4080509@imgtec.com>
Date: Tue, 4 Nov 2014 20:47:01 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<Naidu.Tellapati@imgtec.com>, <james.hartley@imgtec.com>,
	<abrestic@chromium.org>, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <alpine.DEB.2.02.1410312054310.18476@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1410312054310.18476@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/31/2014 05:26 PM, Peter Meerwald wrote:
> Hi,
> 
>> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
> 
> some more comments & nitpicking...
> 
> datasheet URL available?
> 

Not right now, but I'm working on it. I'll try to push one if I get the
permission.

>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: code style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> ---
>>  drivers/iio/adc/Kconfig        |   7 +
>>  drivers/iio/adc/Makefile       |   1 +
>>  drivers/iio/adc/cc_10001_adc.c | 421 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 429 insertions(+)
>>  create mode 100644 drivers/iio/adc/cc_10001_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 88bdc8f..be86c99 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -127,6 +127,13 @@ config AT91_ADC
>>  	help
>>  	  Say yes here to build support for Atmel AT91 ADC.
>>  
>> +config CC_10001_ADC
>> +	tristate "Cosmic Circuits 10001 ADC driver"
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
> 
> would there be a meaningful 'depends on'?
> 

This ADC will be available in a MIPS SoC from Imagination Technologies,
called "Pistachio", so we would put a "depends on MACH_PISTACHIO", once
the support for the SoC hits mainline (which should happen anytime soon).

For the time being, we are pushing some of the peripherals so we can put
the pieces progressively.

I've fixed the driver as per all your comments, thanks a lot for the review!
-- 
Ezequiel
