Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47123 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbcFAQWS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2016 12:22:18 -0400
Subject: Re: [PATCH] staging: iio: ad5933: fix handling of settling time
 cycles
To: Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1464796525-9030-1-git-send-email-luisbg@osg.samsung.com>
Cc: gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <574F0BB5.7080105@metafoo.de>
Date: Wed, 1 Jun 2016 18:22:13 +0200
MIME-Version: 1.0
In-Reply-To: <1464796525-9030-1-git-send-email-luisbg@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2016 05:55 PM, Luis de Bethencourt wrote:
> Correctly handle the settling time cycles value. The else branch was an
> impossible condition (> 1022 in the else branch of > 511) and the handling
> of the values was dividing by 2 and 4, with a left shift, instead of
> multiplying.
> 
> Based on the Table 13 at the bottom of Page 25 of the Data Sheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
> 
> Hi,
> 
> I decided to use the hexadecimal values instead of (1 << 10) and (1 << 9), for
> briefness, I could resend using those instead if it is prefered.
> 
> I also decided to use multiplications instead of right-shifts for readability.
> I could use change that as well.
> 
> Thanks,
> Luis
> 
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 9f43976..3a2cf8f3 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -444,10 +444,13 @@ static ssize_t ad5933_store(struct device *dev,
>  		st->settling_cycles = val;
>  
>  		/* 2x, 4x handling, see datasheet */
> -		if (val > 511)
> -			val = (val >> 1) | (1 << 9);
> -		else if (val > 1022)
> -			val = (val >> 2) | (3 << 9);
> +		if (val & 0x400 && val & 0x200) {
> +			val &= 0x1ff;
> +			val *= 4;
> +		} else if (val & 0x200) {
> +			val &= 0x1ff;
> +			val *= 2;
> +		}

This does not look correct. D10 and D9 select an additional multiplier of
either 1, 2 or 4. So dividing the value before writing it to the register is
the right approach in that case. Just flipping the order in which the
conditions are evaluated should be sufficient.

>  
>  		dat = cpu_to_be16(val);
>  		ret = ad5933_i2c_write(st->client,
> 

