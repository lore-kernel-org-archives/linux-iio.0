Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51112 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbcHUKvw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:51:52 -0400
Subject: Re: [RFC v4 2/3] iio: adc: ti-adc161s626: add support for TI
 1-channel differential ADCs
To: Marek Vasut <marek.vasut@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471663024-25623-1-git-send-email-mranostay@gmail.com>
 <1471663024-25623-3-git-send-email-mranostay@gmail.com>
 <de1272c8-cf35-84f3-84db-eaa42525a5bc@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d8780f4a-5a83-724d-88b5-0cc1d0a51728@kernel.org>
Date: Sun, 21 Aug 2016 11:51:50 +0100
MIME-Version: 1.0
In-Reply-To: <de1272c8-cf35-84f3-84db-eaa42525a5bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/16 17:47, Marek Vasut wrote:
> On 08/20/2016 05:17 AM, Matt Ranostay wrote:
>> Add support for Texas Instruments ADC141S626, and ADC161S626 chips.
> 
> Hi,
> 
> [...]
> 
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
>> @@ -0,0 +1,17 @@
>> +* Texas Instruments ADC141S626, and ADC161S626 chip
> 
> I think you should drop the comma and use plural (chips) here.
> 
>> +Required properties:
>> + - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
>> + - reg: spi chip select number for the device
>> +
>> +Recommended properties:
>> + - spi-max-frequency: Definition as per
>> +		Documentation/devicetree/bindings/spi/spi-bus.txt
>> +
>> +Example:
>> +adc@0 {
>> +	compatible = "ti,adc161s626";
>> +	reg = <0>;
>> +	spi-max-frequency = <4300000>;
>> +};
>> +
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 1de31bdd4ce4..2658f2f69bad 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -426,6 +426,18 @@ config TI_ADC128S052
>>  	  This driver can also be built as a module. If so, the module will be
>>  	  called ti-adc128s052.
>>  
>> +config TI_ADC161S626
>> +	tristate "Texas Instruments ADC161S626 1-channel differential ADC"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  If you say yes here you get support for Texas Instruments ADC141S626,
>> +	  and ADC161S626 chips.
>> +
>> +	  This driver can also be build
> 
> ... be built ... :-)
> 
>> as a module. If so, the module will be
>> +	  called ti-adc161s626.
>> +
>>  config TI_ADS1015
>>  	tristate "Texas Instruments ADS1015 ADC"
>>  	depends on I2C && !SENSORS_ADS1015
> 
> The code looks OK.
> 
Agreed - I fixed the above up and applied to the togreg branch of iio.git.
This is a good little driver in it's own right.  No need to wait
for the consumer you have for it Matt to be ready!

Jonathan
