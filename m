Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43855 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbcDJN3z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:29:55 -0400
Subject: Re: [PATCH v6] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
To: Rob Herring <robh@kernel.org>, michael.hennerich@analog.com
References: <1459842379-26275-1-git-send-email-michael.hennerich@analog.com>
 <20160407175748.GL32257@rob-hp-laptop>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, lars@metafoo.de,
	knaack.h@gmx.de, paul.cercueil@analog.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5550.20107@kernel.org>
Date: Sun, 10 Apr 2016 14:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <20160407175748.GL32257@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/16 18:57, Rob Herring wrote:
> On Tue, Apr 05, 2016 at 09:46:19AM +0200, michael.hennerich@analog.com wrote:
>> From: Paul Cercueil <paul.cercueil@analog.com>
>>
>> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
>> ADC/DAC/GPIO devices.
>>
>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 	* Fix mutex usage
>> 	* Remove unnecessary NULL pointer guards
>> 	* Add comment explaining the invalid data read
>> 	* AD5593R Remove surplus adc readback
>>
>> Changes since v2:
>> 	* Use child nodes to describe channels
>> 	* Fix probe return and driver remove path
>> 	* Move locking closer to where its used
>> 	* Remove WARN_ON but return error
>> 	* Remove OPEN DRAIN configuration option
>>
>> Changes since v3:
>> 	* Documentation: Add missing vendor prefixes in the examples
>> 	* Minor function reordering in remove() to match the reverse of probe()
>>
>> Changes since v4:
>> 	* Documentation: Add missing gpio bindings
>> 	* Kconfig: Select GPIOLIB and remove ifdefs in code
>> 	* Remove surplus error check in ad5592r_gpio_request()
>> 	* Add comment about reset magic
>>
>> Changes since v5:
>> 	* Remove surplus error check
>> 	* Remove additional ifdef CONFIG_GPIOLIB guards in the header
>> 	* Bindings: Add additional comments about CH_MODE_DAC_AND_ADC mode
>> ---
>>  .../devicetree/bindings/iio/dac/ad5592r.txt        | 155 +++++
> 
> I've acked this twice before, and the last change seems minor. 
> Please add acks unless it is more than minor changes and you need it 
> reviewed again.
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
>>  drivers/iio/dac/Kconfig                            |  27 +
>>  drivers/iio/dac/Makefile                           |   3 +
>>  drivers/iio/dac/ad5592r-base.c                     | 691 +++++++++++++++++++++
>>  drivers/iio/dac/ad5592r-base.h                     |  76 +++
>>  drivers/iio/dac/ad5592r.c                          | 164 +++++
>>  drivers/iio/dac/ad5593r.c                          | 131 ++++
>>  include/dt-bindings/iio/adi,ad5592r.h              |  16 +
>>  8 files changed, 1263 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
>>  create mode 100644 drivers/iio/dac/ad5592r-base.c
>>  create mode 100644 drivers/iio/dac/ad5592r-base.h
>>  create mode 100644 drivers/iio/dac/ad5592r.c
>>  create mode 100644 drivers/iio/dac/ad5593r.c
>>  create mode 100644 include/dt-bindings/iio/adi,ad5592r.h
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

