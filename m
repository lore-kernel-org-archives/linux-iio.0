Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45187 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbcICQYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:24:11 -0400
Subject: Re: [PATCH] iio: st_sensors: fix errorcheck for regulators
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472545119-8092-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe BARBA <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <21a68cd4-7eef-dbac-1a08-ffbb58eb4827@kernel.org>
Date: Sat, 3 Sep 2016 17:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <1472545119-8092-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/08/16 09:18, Linus Walleij wrote:
> We were checking the return code of vdd when we should be checking
> vdd_io. My mistake, mea culpa.
> 
> Cc: Giuseppe BARBA <giuseppe.barba@st.com>
> Reported-by: Giuseppe BARBA <giuseppe.barba@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 41bfe1c5f4e9..285a64a589d7 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -247,9 +247,9 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
>  	}
>  
>  	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
> -	if (IS_ERR(pdata->vdd)) {
> +	if (IS_ERR(pdata->vdd_io)) {
>  		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
> -		err = PTR_ERR(pdata->vdd);
> +		err = PTR_ERR(pdata->vdd_io);
>  		goto st_sensors_disable_vdd;
>  	}
>  	err = regulator_enable(pdata->vdd_io);
> 

