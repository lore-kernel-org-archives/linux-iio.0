Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43802 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbaFNOoh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 10:44:37 -0400
Message-ID: <539C6049.4000908@kernel.org>
Date: Sat, 14 Jun 2014 15:46:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio:adc:ad5791: Use BIT() and GENMASK() macros
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git.

As I stated deep in another thread, I'm not that fussed about the
BIT() stuff and am not going to push for this everywhere in IIO,
but getting rid of the GENMASK is well worth doing and I don't
'mind' people doing the BIT bits....

J
> ---
>   drivers/iio/dac/ad5791.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index ae49afe..5ba785f 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -16,17 +16,16 @@
>   #include <linux/sysfs.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/module.h>
> +#include <linux/bitops.h>
>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
>   #include <linux/iio/dac/ad5791.h>
>
> -#define AD5791_RES_MASK(x)		((1 << (x)) - 1)
> -#define AD5791_DAC_MASK			AD5791_RES_MASK(20)
> -#define AD5791_DAC_MSB			(1 << 19)
> +#define AD5791_DAC_MASK			GENMASK(19, 0)
>
> -#define AD5791_CMD_READ			(1 << 23)
> -#define AD5791_CMD_WRITE		(0 << 23)
> +#define AD5791_CMD_READ			BIT(23)
> +#define AD5791_CMD_WRITE		0
>   #define AD5791_ADDR(addr)		((addr) << 20)
>
>   /* Registers */
> @@ -37,11 +36,11 @@
>   #define AD5791_ADDR_SW_CTRL		4
>
>   /* Control Register */
> -#define AD5791_CTRL_RBUF		(1 << 1)
> -#define AD5791_CTRL_OPGND		(1 << 2)
> -#define AD5791_CTRL_DACTRI		(1 << 3)
> -#define AD5791_CTRL_BIN2SC		(1 << 4)
> -#define AD5791_CTRL_SDODIS		(1 << 5)
> +#define AD5791_CTRL_RBUF		BIT(1)
> +#define AD5791_CTRL_OPGND		BIT(2)
> +#define AD5791_CTRL_DACTRI		BIT(3)
> +#define AD5791_CTRL_BIN2SC		BIT(4)
> +#define AD5791_CTRL_SDODIS		BIT(5)
>   #define AD5761_CTRL_LINCOMP(x)		((x) << 6)
>
>   #define AD5791_LINCOMP_0_10		0
> @@ -54,9 +53,9 @@
>   #define AD5780_LINCOMP_10_20		12
>
>   /* Software Control Register */
> -#define AD5791_SWCTRL_LDAC		(1 << 0)
> -#define AD5791_SWCTRL_CLR		(1 << 1)
> -#define AD5791_SWCTRL_RESET		(1 << 2)
> +#define AD5791_SWCTRL_LDAC		BIT(0)
> +#define AD5791_SWCTRL_CLR		BIT(1)
> +#define AD5791_SWCTRL_RESET		BIT(2)
>
>   #define AD5791_DAC_PWRDN_6K		0
>   #define AD5791_DAC_PWRDN_3STATE		1
> @@ -72,7 +71,7 @@ struct ad5791_chip_info {
>
>   /**
>    * struct ad5791_state - driver instance specific data
> - * @us:			spi_device
> + * @spi:			spi_device
>    * @reg_vdd:		positive supply regulator
>    * @reg_vss:		negative supply regulator
>    * @chip_info:		chip model specific constants
> @@ -328,7 +327,7 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
>
>   	switch (mask) {
>   	case IIO_CHAN_INFO_RAW:
> -		val &= AD5791_RES_MASK(chan->scan_type.realbits);
> +		val &= GENMASK(chan->scan_type.realbits - 1, 0);
>   		val <<= chan->scan_type.shift;
>
>   		return ad5791_spi_write(st, chan->address, val);
>

