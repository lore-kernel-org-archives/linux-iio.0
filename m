Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45220 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbHBRBp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:01:45 -0400
Subject: Re: [PATCH 3/4] iio: ti-adc128s052: Documentation: Add adc108s022 ID
To: Denis Carikli <denis@eukrea.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>
References: <1437581064-9733-1-git-send-email-denis@eukrea.com>
 <1437581064-9733-3-git-send-email-denis@eukrea.com>
Cc: =?UTF-8?Q?Eric_B=c3=a9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE4CF8.5050502@kernel.org>
Date: Sun, 2 Aug 2015 18:01:44 +0100
MIME-Version: 1.0
In-Reply-To: <1437581064-9733-3-git-send-email-denis@eukrea.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/07/15 17:04, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
Part of the same job as patch 2. Please roll them into a single patch.
> ---
>  Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> index 15ca6b4..c8a958d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,7 @@
> -* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
> +* Texas Instruments' ADC128S052, ADC122S021 and ADC108S022 ADC chips
>  
>  Required properties:
> - - compatible: Should be "ti,adc128s052" or "ti,adc122s021"
> + - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc108s022"
>   - reg: spi chip select number for the device
>   - vref-supply: The regulator supply for ADC reference voltage
>  
> 

