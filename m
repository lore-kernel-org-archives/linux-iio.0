Return-Path: <SRS0=7TZI=DA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CFC2D0A8
	for <linux-iio@archiver.kernel.org>; Wed, 23 Sep 2020 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74F420936
	for <linux-iio@archiver.kernel.org>; Wed, 23 Sep 2020 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600893179;
	bh=gHFFV1w4lxx7eARZ0yLaTND7KFsxROCfFvF55wymmLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IONfs7xiYzcTuLKru8GqiMQOl5kj/caoY2j/KCpg3yI4J1F86N941F3yGk4ILPCEF
	 eJtvkSk3zbIvxxYdW6ADXK+V3QGjym/uklD+VxUGuVV/9v1DB4HdMLfTILMjqmxS9C
	 2Xspe1ZOe2dQQNTGrIX4QgOVpqaahGTAxO/dIH8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIWUc7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUc7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:32:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E1520725;
        Wed, 23 Sep 2020 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600893178;
        bh=gHFFV1w4lxx7eARZ0yLaTND7KFsxROCfFvF55wymmLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+Ybo+3XYqXGu3uiY17LzDkONnr+sDU/8kab3LLidVSnW6eCCBAJX1X8d4OGa45US
         DYiS1Ew4CcEZN/8u7kj7iyklZyzW7n2O3YwgVIYk9TRDCqG+6D0MEz19mBLVrZaIj9
         z0IFowtZojuUmu2A8HRpAV7m35iIwR4SZUQEttro=
Date:   Wed, 23 Sep 2020 21:32:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ssp: use PLATFORM_DEVID_NONE
Message-ID: <20200923213252.25e19944@archlinux>
In-Reply-To: <20200921204939.20341-1-krzk@kernel.org>
References: <20200921204939.20341-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 22:49:39 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Use PLATFORM_DEVID_NONE define instead of "-1" value because:
>  - it brings some meaning,
>  - it might point attention why auto device ID was not used.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index a94dbcf491ce..1aee87100038 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -503,7 +503,8 @@ static int ssp_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	ret = mfd_add_devices(&spi->dev, -1, sensorhub_sensor_devs,
> +	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
> +			      sensorhub_sensor_devs,
>  			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "mfd add devices fail\n");

