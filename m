Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51871 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab3BGJAo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Feb 2013 04:00:44 -0500
Message-ID: <51136D35.3030608@jic23.retrosnub.co.uk>
Date: Thu, 07 Feb 2013 09:00:37 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: Add OF support
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net> <1360009566-26347-3-git-send-email-linux@roeck-us.net> <20130206182923.GA14417@roeck-us.net> <5112B101.7040709@kernel.org> <20130207015346.GA15240@roeck-us.net>
In-Reply-To: <20130207015346.GA15240@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/13 01:53, Guenter Roeck wrote:
> On Wed, Feb 06, 2013 at 07:37:37PM +0000, Jonathan Cameron wrote:
>> On 02/06/2013 06:29 PM, Guenter Roeck wrote:
>>> Provide bindings and parse OF data during initialization.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> looks good to me.  Couple of little queries inline.
>>
> [ ... ]
>
>>> +
>>> +Example for a configuration with trigger:
>>> +
>>> +	adc@35 {
>>> +		compatible = "maxim,max1139";
>>> +		reg = <0x35>;
>>> +
>>> +		adc: iio-device {
>>> +			#io-channel-cells = <1>;
>>> +		};
>>> +		trigger: iio-trigger {
>>> +			#io-channel-cells = <1>;
>> Why would the trigger have channel-cells?
>> So far we don't have any device tree stuff for the triggers.
>
> I thought about keeping the example and adding a note that trigger support is
> not currently implemented, but a better idea is to replace it with a second iio
> device. I'll do that unless someone objects.
>
> 	adc@35 {
> 		compatible = "some-vendor,some-adc";
> 		reg = <0x35>;
>
> 		adc1: iio-device@0 {
> 			#io-channel-cells = <1>;
> 			/* other properties */
> 		};
> 		adc2: iio-device@1 {
> 			#io-channel-cells = <1>;
> 			/* other properties */
> 		};
> 	};
Agreed.

>
>>> +
>>> +==Example==
>>> +
>>> +	adc: max1139@35 {
>>> +		compatible = "maxim,max1139";
>>> +		reg = <0x35>;
>>> +		#io-channel-cells = <1>;
>>> +	};
>>> +
>>> +	...
>>> +
>>> +	iio_hwmon {
>>> +		compatible = "iio-hwmon";
>>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
>>> +			<&adc 3>, <&adc 4>, <&adc 5>,
>>> +			<&adc 6>, <&adc 7>, <&adc 8>,
>>> +			<&adc 9>, <&adc 10>, <&adc 11>;
>>> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
>> This example still seems a little odd. Why give one where there are
>> more channels than names?
>
> I replaced the example with
>
> 	iio_hwmon {
> 		compatible = "iio-hwmon";
> 		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> 			<&adc 3>, <&adc 4>, <&adc 5>,
> 			<&adc 6>, <&adc 7>, <&adc 8>,
> 			<&adc 9>;
> 		};
>
> 	some_consumer {
> 		compatible = "some-consumer";
> 		io-channels = <&adc 10>, <&adc 11>;
> 		io-channel-names = "adc1", "adc2";
> 	};
Good as well. Much happier with these examples as they
won't cause any confusion.
>
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

