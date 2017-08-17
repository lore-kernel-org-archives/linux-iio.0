Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdHQO7i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:59:38 -0400
Date: Thu, 17 Aug 2017 15:59:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: st_sensors: decouple irq1 configuration
 parameters from the irq2 ones
Message-ID: <20170817155932.2feab01a@archlinux>
In-Reply-To: <20170816191316.11469-2-lorenzo.bianconi@st.com>
References: <20170816191316.11469-1-lorenzo.bianconi@st.com>
        <20170816191316.11469-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 21:13:12 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Separate data-ready configuration parameters for INT1 and INT2 pins in
> st_sensor_data_ready_irq data structure. That change will be use to
> properly support LIS2DW12 accel sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

One oddity which was there already that you've kept.

I'd clean it up whilst we are here rather than doubling it ;)

Jonathan

> @@ -336,7 +341,12 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask = 0x04,
>  		},
>  		.drdy_irq = {
> -			.addr = 0,
> +			.int1 = {
> +				.addr = 0x00,
> +			},
> +			.int2 = {
> +				.addr = 0x00,
> +			},
This is presumably for a device which doesn't support data ready.
Why not rely on the default value of 0 and scrap this explicit entry?
>  		},
>  		.multi_read_bit = true,
>  		.bootime = 2,
