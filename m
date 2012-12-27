Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:50744 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab2L0Rzn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Dec 2012 12:55:43 -0500
Message-ID: <50DC8B5F.3030404@free-electrons.com>
Date: Thu, 27 Dec 2012 18:54:39 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: add sleep mode support
References: <20121219183236.GP23971@game.jcrosoft.org> <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com> <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Le 19/12/2012 19:37, Jean-Christophe PLAGNIOL-VILLARD a écrit :
> The sleep mode will allow to put the add in sleep between conversion.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
>  drivers/iio/adc/at91_adc.c                          |   19 ++++++++++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index fd2d69e..efb6f02 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -25,6 +25,7 @@ Optional properties:
>    - atmel,adc-use-res: String corresponding to an identifier from
>  		       atmel,adc-res-names property. If not specified, the highest
>  		       resolution will be used.
> +  - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion

I forgot it in my first review, but there's a typo in the name of the
property here (one extra "atmel,")

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
