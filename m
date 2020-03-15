Return-Path: <SRS0=tzPa=5A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD3C10DCE
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 12:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C5C206B1
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584276296;
	bh=nsNKZYifArodDQfFPwxBQru3ah7xyFivqbfZZpeGm4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AHToBgGKdrmF5S5+5qcGLC+EHgwKQUjFTbXIYRyT74NxtN6w2JJvedWmMTSveIk/Z
	 Gj+uHvxuARzC2mIMq2Bc+JL69dC/I723X/8L6qTio5kzKPjxodFVukWl/XDPWv8SWi
	 fs+SyG8QcIxYr/I71b/FFbW49+DjLpuAQsd3na40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgCOMo4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgCOMo4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:44:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1471205ED;
        Sun, 15 Mar 2020 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276295;
        bh=nsNKZYifArodDQfFPwxBQru3ah7xyFivqbfZZpeGm4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hWB4M41mRKit+hec1XC2C/o8kXzMytuoO2SMMIk7zKnaPsJSmVOOyu7vjLJL+YRWk
         XH76q6UE1waylofHBvEIxm4ENyh9R0x7SfIB8ipoSjKG6OJ/IHzIsVCusr4hKx8D+D
         kcGUR05Zj0RXhRpgCg9rvCLXeBOJKTXEUX2Re/xs=
Date:   Sun, 15 Mar 2020 12:44:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 8/8] iio: humidity: hts221: Drop unneeded casting
 when print error code
Message-ID: <20200315124451.461856e2@archlinux>
In-Reply-To: <20200313104955.30423-8-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-8-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Explicit casting in printf() usually shows that something is not okay.
> Here, we really don't need it by providing correct specifier.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.  These may sit in my local tree for a few days as I have
an existing pull request out and will want to fast-forward the
tree after that.

Thanks,

Jonathan

> ---
> v2: new patch
>  drivers/iio/humidity/hts221_i2c.c | 4 ++--
>  drivers/iio/humidity/hts221_spi.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
> index 1398794e4bc7..cab39c4756f8 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -32,8 +32,8 @@ static int hts221_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
> index ba1115489c2c..729e86e433b1 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -31,8 +31,8 @@ static int hts221_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  

