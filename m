Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12202C77B7D
	for <linux-iio@archiver.kernel.org>; Sat, 20 May 2023 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjETPd3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 May 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjETPd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 11:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3CD103;
        Sat, 20 May 2023 08:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C51D860B04;
        Sat, 20 May 2023 15:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90740C433D2;
        Sat, 20 May 2023 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596807;
        bh=v2J4QcmeQzjUO1CUDFFKdSrX6QMMRgCiCMtenkolPlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=saGd+R5YIQWo5HvkhlsM7ywmRukcLhf2Kgb3vtXaUdjya86Ia9ulrRP1ID2G0lpwp
         jehUTPp1qXNEbMKx7JiO6CykDrQ9H9M5VZ71ADjTAG+F4eUXuw/ap6KYpDWkfjBOMw
         KSPFG2/zqDGKLlBYCi0Hi6qCFSg3mTaJ6UeHvR8/KytNG7jC3eU8DZwW+9tu5+gRLN
         fmOsfadxDhg2lWgAfVNJwG2dvOMWjQXnLdVKqXueEq7KN73EzCTygK0zjvcTS+4O5i
         1gqlyTL3zMgLkEV+tJGSAkWlCnzivD2vSi5GnZs6qqFSqOcTNBsSGhr1GS0Iq65zlN
         iZV2/2HrJVO9A==
Date:   Sat, 20 May 2023 16:49:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH 5/7] iio: adc: rockchip_saradc: Use dev_err_probe
Message-ID: <20230520164935.70094206@jic23-huawei>
In-Reply-To: <d1955b9e-c719-9c7c-b1fd-f11fa97e44af@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
        <20230516230051.14846-6-shreeya.patel@collabora.com>
        <d1955b9e-c719-9c7c-b1fd-f11fa97e44af@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 May 2023 12:40:37 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 17/05/23 01:00, Shreeya Patel ha scritto:
> > Use dev_err_probe instead of dev_err in probe function,
> > which simplifies code a little bit and prints the error
> > code.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> >   drivers/iio/adc/rockchip_saradc.c | 45 ++++++++++++++-----------------
> >   1 file changed, 20 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> > index 5e1e8575bc76..a52021fd477d 100644
> > --- a/drivers/iio/adc/rockchip_saradc.c
> > +++ b/drivers/iio/adc/rockchip_saradc.c  
> 
> ..snip..
> 
> > @@ -494,23 +492,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
> >   	 * This may become user-configurable in the future.
> >   	 */
> >   	ret = clk_set_rate(info->clk, info->data->clk_rate);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "failed to set adc clk rate, %d\n", ret);
> > -		return ret;
> > -	}
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to set adc clk rate\n");
> >   
> >   	ret = regulator_enable(info->vref);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "failed to enable vref regulator\n");
> > -		return ret;
> > -	}
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to enable vref regulator\n");
> > +
> >   	ret = devm_add_action_or_reset(&pdev->dev,
> >   				       rockchip_saradc_regulator_disable, info);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> > -			ret);
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to register devm action\n");  
> 
> It's not your fault - and it's about a pre-existing issue, but there's that:
> you're returning an error if devm_add_action_or_reset() fails (which is highly
> unlikely), but you're leaving the regulator enabled!
Which regulator?  The _or_reset() part means that the callback is called if
the devm_add_action_or_reset is going to return an error.  So in the
path you talk about
rockchip_saradc_regulator_disable() is called and disables vref

> 
> As for how to proceed here, I would suggest to fix this issue in a separated
> commit (before the dev_err_probe() conversion); it'd look like...
> 
> 	if (ret) {
> 		regulator_disable(info->vref);
> 		dev_err( .... blurb );
> 		return ret;
> 	}
> 
> and after the conversion it'd look like...
> 
> 	if (ret) {
> 		regulator_disable(info->vref);
> 		return dev_err_probe( ... blurb );
> 	}
> 
> Cheers,
> Angelo
> 
> >   
> >   	ret = regulator_get_voltage(info->vref);
> >   	if (ret < 0)  
> 

