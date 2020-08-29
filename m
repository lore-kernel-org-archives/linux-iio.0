Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F1FC433E7
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 14:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315B920E65
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711674;
	bh=Bt2LcvmRA8aueOn9MiH2KddIvcJ9ARbLl4fgBrMMH28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A7IffMXqFqd4L5Lys/vykJjbXABGF80kLg5YA3vnZMMqjbjarLyM6XnyP5r0PceTT
	 bO4yg9SztJDWc0XY3azxEVvPh5QgmexMTbiQOg68MaH4UIMPoIGyXHowUNMVLwZtHS
	 0miIf53g/oPQWaEfUD9titW3/D+jZKjvsgjIFwbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgH2Oed (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2Oed (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 10:34:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EF92065F;
        Sat, 29 Aug 2020 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711672;
        bh=Bt2LcvmRA8aueOn9MiH2KddIvcJ9ARbLl4fgBrMMH28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wFpkbrgQQGSDHhMuRaTI5o3Q0C950XgQuaRIAhBM2rJVMsZnepCaD0CwIu0xjxS6I
         NkHjakIMpm68h3NjuQT1PFOxzrNnF/Ae4Y/XEfVdcM62EQV1sWjQvLqO3saoLy3LmP
         /aA2XwUc/M9D+lR7f8pKp0RiwWLhQSTsw4dR++9w=
Date:   Sat, 29 Aug 2020 15:34:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 01/18] iio: accel: bma180: Simplify with
 dev_err_probe()
Message-ID: <20200829153426.5430ad8b@archlinux>
In-Reply-To: <20200829064726.26268-1-krzk@kernel.org>
References: <20200829064726.26268-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 08:47:09 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Series applied to the togreg branch of iio.git. I'll push that out
as testing for the autobuilders to play with it sometime later
today.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 5b7a467c7b27..448faed001fd 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1000,19 +1000,15 @@ static int bma180_probe(struct i2c_client *client,
>  		return ret;
>  
>  	data->vdd_supply = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(data->vdd_supply)) {
> -		if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get vdd regulator %d\n",
> -				(int)PTR_ERR(data->vdd_supply));
> -		return PTR_ERR(data->vdd_supply);
> -	}
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "Failed to get vdd regulator\n");
> +
>  	data->vddio_supply = devm_regulator_get(dev, "vddio");
> -	if (IS_ERR(data->vddio_supply)) {
> -		if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get vddio regulator %d\n",
> -				(int)PTR_ERR(data->vddio_supply));
> -		return PTR_ERR(data->vddio_supply);
> -	}
> +	if (IS_ERR(data->vddio_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vddio_supply),
> +				     "Failed to get vddio regulator\n");
> +
>  	/* Typical voltage 2.4V these are min and max */
>  	ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
>  	if (ret)

