Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdHLMsy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:48:54 -0400
Date: Sat, 12 Aug 2017 13:48:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, gregor.boirie@parrot.com,
        denis.ciocca@st.com, lorenzo.bianconi@st.com
Subject: Re: [PATCH 1/2] iio: pressure: st_pressure: fix drdy configuration
 for LPS22HB and LPS25H
Message-ID: <20170812134803.71da7c55@archlinux>
In-Reply-To: <20170811194414.20741-2-lorenzo.bianconi@st.com>
References: <20170811194414.20741-1-lorenzo.bianconi@st.com>
        <20170811194414.20741-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 11 Aug 2017 21:44:13 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Remove int2 configuration parameter for LPS22HB and LPS25H since
> these devices export just int1 as data-ready line
> 
> Fixes: 931878405b86 (iio:pressure: Add support for LPS25H pressure sensor)
> Fixes: e039e2f5b4da (iio:st_pressure:initial lps22hb sensor support)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
While this is clearly a fix, as I understand it you would also need to have
some crazy configuration to make this a problem so I am going to take it
for the next merge window rather than quicker.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index aa61ec15c139..c84eea73b3ae 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -390,7 +390,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = 0x23,
>  			.mask_int1 = 0x01,
> -			.mask_int2 = 0x10,
> +			.mask_int2 = 0x00,
>  			.addr_ihl = 0x22,
>  			.mask_ihl = 0x80,
>  			.addr_od = 0x22,
> @@ -449,7 +449,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = 0x12,
>  			.mask_int1 = 0x04,
> -			.mask_int2 = 0x08,
> +			.mask_int2 = 0x00,
>  			.addr_ihl = 0x12,
>  			.mask_ihl = 0x80,
>  			.addr_od = 0x12,

