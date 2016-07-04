Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36198 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcGDRK2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:10:28 -0400
Subject: Re: [PATCH v2 2/7] iio:st_pressure: align storagebits on power of 2
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1467023672.git.gregor.boirie@parrot.com>
 <b1ccebea1a6b2f18dcd122cc1792880de14a53c7.1467023672.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f208c660-0bef-adbe-185b-4c71f8eb5451@kernel.org>
Date: Mon, 4 Jul 2016 18:10:25 +0100
MIME-Version: 1.0
In-Reply-To: <b1ccebea1a6b2f18dcd122cc1792880de14a53c7.1467023672.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 11:38, Gregor Boirie wrote:
> Sampled pressure data are 24 bits long and should be stored in a 32 bits
> word.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied.
> ---
>  drivers/iio/pressure/st_pressure_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 56d8f5e..8fa3d81 100644
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

