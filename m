Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41199 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750842AbbG0HsM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:48:12 -0400
Date: Mon, 27 Jul 2015 09:48:10 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 3/8] iio:adc:berlin2-adc: use GENMASK and BIT for masks
Message-ID: <20150727074810.GC16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <9f846746de9c1bc1e35b14f4a3b9f7ee1168870d.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9f846746de9c1bc1e35b14f4a3b9f7ee1168870d.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Sun, Jul 26, 2015 at 12:43:21AM +0200, Hartmut Knaack wrote:
> Make use of GENMASK for consecutive bitmasks and BIT for single bitmasks.

Thanks for doing this clean-up.

> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> @@ -50,7 +50,7 @@
>  #define  BERLIN2_SM_CTRL_TSEN_MODE_10_50	(0x1 << 22)	/* 10-50 C */
>  #define  BERLIN2_SM_CTRL_TSEN_RESET		BIT(29)
>  #define BERLIN2_SM_ADC_DATA			0x20
> -#define  BERLIN2_SM_ADC_MASK			0x3ff
> +#define  BERLIN2_SM_ADC_MASK			GENMASK(9, 0)
>  #define BERLIN2_SM_ADC_STATUS			0x1c
>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
> @@ -60,14 +60,14 @@
>  #define  BERLIN2_SM_TSEN_STATUS_DATA_RDY	BIT(0)
>  #define  BERLIN2_SM_TSEN_STATUS_INT_EN		BIT(1)
>  #define BERLIN2_SM_TSEN_DATA			0x28
> -#define  BERLIN2_SM_TSEN_MASK			0xfff

There was actually an error here. It should have been 0x3ff as
BERLIN2_SM_ADC_MASK.

> +#define  BERLIN2_SM_TSEN_MASK			GENMASK(11, 0)

So, GENMASK(9, 0).

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
