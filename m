Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-208.synserver.de ([212.40.185.208]:1032 "EHLO
	smtp-out-208.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaLRQSO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Dec 2014 11:18:14 -0500
Message-ID: <5492FE42.70009@metafoo.de>
Date: Thu, 18 Dec 2014 17:18:10 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
References: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/17/2014 06:59 PM, Angelo Compagnucci wrote:
> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>

Looks good to me, but you might want to send this to the devicetree list and 
the devicetree bindings maintainers.

[...]
> +Example:
> +adc@0 {
> +	compatible = "ti,adc128s052";
> +	reg = <0>;
> +        vref-supply = <&vdd_supply>;

strange indention here

> +	spi-max-frequency = <1000000>;
> +};
>

