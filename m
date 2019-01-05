Return-Path: <SRS0=5rro=PN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E742C43387
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2E921928
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546710825;
	bh=fBmnBCilQeUS+a7gGRkDLxYTiIHeVZeqVYECE9gZlYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K46oXCN4/arZSAqWfCA41oHjwiqHJb5x8VFR2EkugqEjk87GwfZXRcFAbPZpUzxRn
	 FaS+AtrmsHqlnRKDGcTTNFKID8WI5jj0hVAqh7GPnSLi+GpcYqEZEE+f4jURP5FWGX
	 +ZEIFa4BCWrGQGeIj4Qs3hDV258Y0elzSOLzlM48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfAERxo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfAERxo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Jan 2019 12:53:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8752E2190B;
        Sat,  5 Jan 2019 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546710823;
        bh=fBmnBCilQeUS+a7gGRkDLxYTiIHeVZeqVYECE9gZlYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Eykxu/cJ1X2bCFVTmlDUyk+SjQOFk7MRqrmSrl5COh735nvIJfplZaIt0xPhK5RW
         VJQBHtQDtp09dbyorPF4Y9SrPQujYlXQeNvgMN4oliz90U/kJvvF5UMZqfQN9DBep0
         PKoY8535YNce97LGqQaF+c3HmjcNOJQCpWCQYouo=
Date:   Sat, 5 Jan 2019 17:53:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v2 2/4] staging: iio: adt7316: fix handling of dac high
 resolution option
Message-ID: <20190105175338.3c458312@archlinux>
In-Reply-To: <20181223045743.10716-3-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
        <20181223045743.10716-3-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Dec 2018 21:57:41 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> The adt7316/7 and adt7516/7 have the option to output voltage proportional
> to temperature on dac a and/or dac b. The default dac resolution in this
> mode is 8 bits with the dac high resolution option enabling 10 bits. None
> of these settings affect dacs c and d. Remove the "1 (12 bits)" output from
> the show function since that is not an option for this mode. Return
> "1 (10 bits)" if the device is one of the above mentioned chips and the dac
> high resolution mode is enabled.
> 
> In the store function, the driver currently allows the user to write to the
> ADT7316_DA_HIGH_RESOLUTION bit regardless of the device in use. Add a check
> to return an error in the case of an adt7318 or adt7519. Remove the else
> statement that clears the ADT7316_DA_HIGH_RESOLUTION bit. Instead, clear it
> before conditionally enabling it, depending on user input. This matches the
> typical pattern in the driver when an attribute is a boolean.
> 
> Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index e17c1cb12c94..80cc3420036b 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -633,9 +633,7 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
>  	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
> -		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> -			return sprintf(buf, "1 (12 bits)\n");
> -		if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> +		if (chip->id != ID_ADT7318 && chip->id != ID_ADT7519)
>  			return sprintf(buf, "1 (10 bits)\n");
>  	}
>  
> @@ -652,10 +650,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	u8 config3;
>  	int ret;
>  
> +	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
> +		return -EPERM;
> +
> +	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
>  	if (buf[0] == '1')
> -		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
> -	else
> -		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> +		config3 |= ADT7316_DA_HIGH_RESOLUTION;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
>  	if (ret)

