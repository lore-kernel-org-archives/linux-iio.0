Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48074 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcFZRca (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:32:30 -0400
Subject: Re: [PATCH v1 3/7] iio:st_pressure: align storagebits on power of 2
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1466687364.git.gregor.boirie@parrot.com>
 <cbdd28c13f645d33d4f34a26fc031ae9c86e38e6.1466687364.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <978854c7-a37a-3536-0a4c-6d9e5fc91a07@kernel.org>
Date: Sun, 26 Jun 2016 18:32:28 +0100
MIME-Version: 1.0
In-Reply-To: <cbdd28c13f645d33d4f34a26fc031ae9c86e38e6.1466687364.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/16 14:49, Gregor Boirie wrote:
> Sampled pressure data are 24 bits long and should be stored in a 32 bits
> word.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
looks good - will pick up with the previous.

thanks,

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 79616e0..31e5e41 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -146,7 +146,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 24,
> -			.storagebits = 24,
> +			.storagebits = 32,
>  			.endianness = IIO_LE,
>  		},
>  		.info_mask_separate =
> @@ -218,7 +218,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 24,
> -			.storagebits = 24,
> +			.storagebits = 32,
>  			.endianness = IIO_LE,
>  		},
>  		.info_mask_separate =
> 

