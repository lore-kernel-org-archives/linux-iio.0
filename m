Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36235 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcGDRPh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:15:37 -0400
Subject: Re: [PATCH v2 5/7] iio:st_pressure:lps22hb: open drain support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1467023672.git.gregor.boirie@parrot.com>
 <b258d9982e4abf5188456c3a20d7453918b0b8bd.1467023672.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4d414f13-4aea-1150-47c0-7afe8a321cee@kernel.org>
Date: Mon, 4 Jul 2016 18:15:35 +0100
MIME-Version: 1.0
In-Reply-To: <b258d9982e4abf5188456c3a20d7453918b0b8bd.1467023672.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 11:38, Gregor Boirie wrote:
> Add support for open drain interrupt line.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied.  Thanks
> ---
>  drivers/iio/pressure/st_pressure_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index ea8241f..70230a1 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -213,6 +213,8 @@
>  #define ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK	0x08
>  #define ST_PRESS_LPS22HB_IHL_IRQ_ADDR		0x12
>  #define ST_PRESS_LPS22HB_IHL_IRQ_MASK		0x80
> +#define ST_PRESS_LPS22HB_OD_IRQ_ADDR		0x12
> +#define ST_PRESS_LPS22HB_OD_IRQ_MASK		0x40
>  #define ST_PRESS_LPS22HB_MULTIREAD_BIT		true
>  
>  static const struct iio_chan_spec st_press_1_channels[] = {
> @@ -511,6 +513,9 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_int2 = ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_PRESS_LPS22HB_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_PRESS_LPS22HB_IHL_IRQ_MASK,
> +			.addr_od = ST_PRESS_LPS22HB_OD_IRQ_ADDR,
> +			.mask_od = ST_PRESS_LPS22HB_OD_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS22HB_MULTIREAD_BIT,
>  	},
> 

