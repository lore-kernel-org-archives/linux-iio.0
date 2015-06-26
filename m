Return-Path: <knaack.h@gmx.de>
Message-ID: <558DCA63.6040001@gmx.de>
Date: Fri, 26 Jun 2015 23:55:47 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Thomas Betker <thomas.betker@freenet.de>,
 linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-4-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-4-git-send-email-thomas.betker@freenet.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Thomas Betker schrieb am 15.04.2015 um 21:11:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> The scaling factor for VREFP is 3.0/4096, not 1.0/4096; fix this to get
> correct readings.
> 

Hi Thomas,
I just had a look at the datasheet [1], table 3-1 on page 37, and get the feeling
that this scaling factor also applies to the VREFN channel. What is your opinion?

Thanks,
Hartmut

[1] http://www.xilinx.com/support/documentation/user_guides/ug480_7Series_XADC.pdf

> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0ad7b50..6fa629b 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -856,6 +856,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  			switch (chan->address) {
>  			case XADC_REG_VCCINT:
>  			case XADC_REG_VCCAUX:
> +			case XADC_REG_VREFP:
>  			case XADC_REG_VCCBRAM:
>  			case XADC_REG_VCCPINT:
>  			case XADC_REG_VCCPAUX:
> 
