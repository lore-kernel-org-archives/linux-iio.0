Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1034 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753481AbbERMTV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 08:19:21 -0400
Message-ID: <5559D8C5.9060407@metafoo.de>
Date: Mon, 18 May 2015 14:19:17 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>,
	jic23@kernel.org, angelo.compagnucci@gmail.com
CC: iivanov@mm-sol.com, ezequiel.garcia@imgtec.com,
	jacob.jun.pan@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: add support for adc122s021
References: <1431950676-22379-1-git-send-email-urs.fassler@bytesatwork.ch> <1431950676-22379-2-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1431950676-22379-2-git-send-email-urs.fassler@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,7 @@
> -* Texas Instruments' ADC128S052 ADC chip
> +* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
>
>   Required properties:
> - - compatible: Should be "ti,adc128s052"
> + - compatible: Should be "adc128s052" or "adc122s021"

Why are you removing the vendor prefix? The compatible string is not valid 
without a vendor prefix.

>    - reg: spi chip select number for the device
>    - vref-supply: The regulator supply for ADC reference voltage
>
> @@ -11,7 +11,7 @@ Recommended properties:
>
>   Example:
>   adc@0 {
> -	compatible = "ti,adc128s052";
> +        compatible = "adc128s052";

Indention.

