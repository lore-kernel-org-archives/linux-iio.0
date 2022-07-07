Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14021C433EF
	for <linux-iio@archiver.kernel.org>; Thu,  7 Jul 2022 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiGGQlK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiGGQlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 12:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1A5A2F9;
        Thu,  7 Jul 2022 09:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0FD6242D;
        Thu,  7 Jul 2022 16:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0E1C3411E;
        Thu,  7 Jul 2022 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657212055;
        bh=K/z6EoPFhwPiN4meKXo3KdBrKFUfTxiK9h9ex+XHdmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PXzhx7L+DHeien0CyByFCzmMKqFuckFOQXjUyrg/2pw28OqqhV51aPucNB17dCqcm
         x7oxWoGsXRtC4YIvt6OwF4TGNo16vvg36b1S0IeLmosDOzNmB45Bzk7LpxCBvwq47Q
         qZJxnRL7YEMYkTZfqPPMCJmHRT8yiho4eqBS5e/z+ALnOSe/2iIk804wBnbLb504HR
         JmIsOufllJE91ZDCU7/Oz32Z+Nedw1NLGjRzPqJMNIqTnAOxi9RCrwmfhxCc2aSSHN
         7M6GJyIb+lOHc9IfZguHQ+MNcdt7tlmv/4WAFdIO523/1tSVooX9D1RMIOc/+LX/2/
         Tnjfrgjr5FPSA==
Date:   Thu, 7 Jul 2022 17:50:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ktsai@capellamicro.com, lars@metafoo.de, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: cm32181: Add PM support
Message-ID: <20220707175037.1352fa6b@jic23-huawei>
In-Reply-To: <20220707000151.33381-1-kai.heng.feng@canonical.com>
References: <20220707000151.33381-1-kai.heng.feng@canonical.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  7 Jul 2022 08:01:51 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> The read on in_illuminance_input keeps at 0 after system sleep.
> 
> So add proper suspend and resume callback to make the sensor keep
> working after system sleep.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and see if we missed anything,

Thanks,

Jonathan

> ---
> v2:
>  - Use dev_get_drvdata() instead of i2c_get_clientdata() to avoid extra
>    dereference.
> 
>  drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 97649944f1df6..edbe6a3138d0b 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -460,6 +460,8 @@ static int cm32181_probe(struct i2c_client *client)
>  			return PTR_ERR(client);
>  	}
>  
> +	i2c_set_clientdata(client, indio_dev);
> +
>  	cm32181 = iio_priv(indio_dev);
>  	cm32181->client = client;
>  	cm32181->dev = dev;
> @@ -486,6 +488,25 @@ static int cm32181_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int cm32181_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +					 CM32181_CMD_ALS_DISABLE);
> +}
> +
> +static int cm32181_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +
> +	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> +}
> +
> +DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
> +
>  static const struct of_device_id cm32181_of_match[] = {
>  	{ .compatible = "capella,cm3218" },
>  	{ .compatible = "capella,cm32181" },
> @@ -506,6 +527,7 @@ static struct i2c_driver cm32181_driver = {
>  		.name	= "cm32181",
>  		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
>  		.of_match_table = cm32181_of_match,
> +		.pm = pm_sleep_ptr(&cm32181_pm_ops),
>  	},
>  	.probe_new	= cm32181_probe,
>  };

