Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40425 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbbKUSXQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 13:23:16 -0500
Subject: Re: [PATCH] iio: Move IIO Dummy Driver out of staging
To: Lars-Peter Clausen <lars@metafoo.de>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
References: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com>
 <5650B4C5.2050803@metafoo.de>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650B692.3000706@kernel.org>
Date: Sat, 21 Nov 2015 18:23:14 +0000
MIME-Version: 1.0
In-Reply-To: <5650B4C5.2050803@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/15 18:15, Lars-Peter Clausen wrote:
> On 10/09/2015 03:31 PM, Cristina Opriceana wrote:
>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>> index 6d5b38d..85de198 100644
>> --- a/drivers/staging/iio/Kconfig
>> +++ b/drivers/staging/iio/Kconfig
>> @@ -17,32 +17,32 @@ source "drivers/staging/iio/meter/Kconfig"
>>  source "drivers/staging/iio/resolver/Kconfig"
>>  source "drivers/staging/iio/trigger/Kconfig"
>>  
>> -config IIO_DUMMY_EVGEN
>> -       tristate
>> -
>> -config IIO_SIMPLE_DUMMY
>> -       tristate "An example driver with no hardware requirements"
>> -       help
>> -	 Driver intended mainly as documentation for how to write
>> -	 a driver. May also be useful for testing userspace code
>> -	 without hardware.
>> -
>> -if IIO_SIMPLE_DUMMY
>> -
>> -config IIO_SIMPLE_DUMMY_EVENTS
>> -       bool "Event generation support"
>> -       select IIO_DUMMY_EVGEN
>> -       help
>> -         Add some dummy events to the simple dummy driver.
>> -
>> -config IIO_SIMPLE_DUMMY_BUFFER
>> -	bool "Buffered capture support"
>> -	select IIO_BUFFER
>> -	select IIO_TRIGGER
>> -	select IIO_KFIFO_BUF
>> -	help
>> -	  Add buffered data capture to the simple dummy driver.
>> -
>> -endif # IIO_SIMPLE_DUMMY
>> +#config IIO_DUMMY_EVGEN
>> +#       tristate
>> +#
>> +#config IIO_SIMPLE_DUMMY
>> +#       tristate "An example driver with no hardware requirements"
>> +#       help
>> +#	 Driver intended mainly as documentation for how to write
>> +#	 a driver. May also be useful for testing userspace code
>> +#	 without hardware.
>> +
>> +#if IIO_SIMPLE_DUMMY
>> +
>> +#config IIO_SIMPLE_DUMMY_EVENTS
>> +#       bool "Event generation support"
>> +#       select IIO_DUMMY_EVGEN
>> +#      help
>> +#        Add some dummy events to the simple dummy driver.
>> +
>> +#config IIO_SIMPLE_DUMMY_BUFFER
>> +#	bool "Buffered capture support"
>> +#	select IIO_BUFFER
>> +# select IIO_TRIGGER
>> +#	select IIO_KFIFO_BUF
>> +#	help
>> +#	  Add buffered data capture to the simple dummy driver.
> 
> Any particular reason why those where commented out rather than removed?
> 
Gah I'd missed that entirely and they have now been in my tree sometime so
I will have to do it as an additional patch. Good point Lars.

Patch shortly... 

J
