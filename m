Return-Path: <SRS0=B/3F=AB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4419C433DF
	for <linux-iio@archiver.kernel.org>; Sat, 20 Jun 2020 15:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AB02082F
	for <linux-iio@archiver.kernel.org>; Sat, 20 Jun 2020 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592666437;
	bh=Ff2Qo2Rso741YPPWtS9yZ69PsIOakDnaAMXHSNDoGuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gtfMtNesZ5zdxHhXoKbmlKb0FN6ntcm1KJcYkcda+e13MTrrMuCBTe5fVsfqSGcWC
	 /fDA2d+8M781O8NoSxkG3LxhovZ68ilmIZLq3bK/s07F1KxldHx4CZ2ND0jgd9V3uU
	 nQzN+EytErKLbqCfAzChzXlsnDzGPnZ7mLCDl6rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgFTPUg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgFTPUg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 11:20:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145A520720;
        Sat, 20 Jun 2020 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592666435;
        bh=Ff2Qo2Rso741YPPWtS9yZ69PsIOakDnaAMXHSNDoGuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OiGBzPmzn40PXZn+IOoi9hibPjsSmNS64HbcPU9rHG9xcGaaLNr/h9xOzEU5kxdyV
         1VmbnjuJPlIx/scf7P8qvrrfMRUjTiUfGjmqc3XvYVgwp0wscFZqY7OvpTa6U/BbaG
         JKWMTh08mPDk5Lntl7IkkgOXQ1Y35kd2sdpp6WeA=
Date:   Sat, 20 Jun 2020 16:20:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darius Berghe <darius.berghe@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] iio:adc:ltc2471: add match table for existing
 devices
Message-ID: <20200620162031.5e9330d8@archlinux>
In-Reply-To: <20200617133523.58158-1-darius.berghe@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Jun 2020 16:35:21 +0300
Darius Berghe <darius.berghe@analog.com> wrote:

> OF style match table is the proper way of matching device tree nodes
> with drivers and such table was missing, this commit adds it.
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>

Hi Darius

A few minor things inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ltc2471.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index 55fab612843a..0e5cdb43a943 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -143,9 +143,17 @@ static const struct i2c_device_id ltc2471_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
>  
> +static const struct of_device_id ltc2471_of_match[] = {

Should include mod_device_table.h as we are using of_device_id
which is defined in that header.

> +	{ .compatible = "adi,ltc2471" },
> +	{ .compatible = "adi,ltc2473" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ltc2471_of_match);
> +
>  static struct i2c_driver ltc2471_i2c_driver = {
>  	.driver = {
>  		.name = "ltc2471",
> +		.of_match_table = of_match_ptr(ltc2471_of_match)

Drop the of_match_ptr protection. That prevents the use of
this binding with ACPI (via the magic of PRP0001 which allows
you to use DT bindings in an ACPI DSDT). 

We are slowly working our way through all the drivers removing the
use of this macro (and converting to generic binding handling
where relevant). It'll take a while yet though before there
are no instances of this to copy!


>  	},
>  	.probe    = ltc2471_i2c_probe,
>  	.id_table = ltc2471_i2c_id,

