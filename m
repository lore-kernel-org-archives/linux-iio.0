Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39052 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbDSMsP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:48:15 -0400
Message-ID: <5533A40C.1040001@kernel.org>
Date: Sun, 19 Apr 2015 13:48:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [PATCH 1/5] iio: adc: xilinx: Fix register addresses
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-2-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-2-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 20:11, Thomas Betker wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> Define the register addresses for MIN_VCCPINT, MIN_VCCPAUX, MIN_VCCO_DDR
> correctly.
> 
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
Applied to the fixes-togreg branch of iio.git, marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index c7487e8..54adc50 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -145,9 +145,9 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
>  #define XADC_REG_MAX_VCCPINT	0x28
>  #define XADC_REG_MAX_VCCPAUX	0x29
>  #define XADC_REG_MAX_VCCO_DDR	0x2a
> -#define XADC_REG_MIN_VCCPINT	0x2b
> -#define XADC_REG_MIN_VCCPAUX	0x2c
> -#define XADC_REG_MIN_VCCO_DDR	0x2d
> +#define XADC_REG_MIN_VCCPINT	0x2c
> +#define XADC_REG_MIN_VCCPAUX	0x2d
> +#define XADC_REG_MIN_VCCO_DDR	0x2e
>  
>  #define XADC_REG_CONF0		0x40
>  #define XADC_REG_CONF1		0x41
> 

