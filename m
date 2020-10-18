Return-Path: <SRS0=x94u=DZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C0CC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB08821582
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603021017;
	bh=+5PtGcgmtvW/PG8L6OEo1XFbWW+Cs0mMJSK/IJbw9VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CyXJcsZP4+zKfVWPij72ftURYh5wtpsHUzpC4XEHfkFxhS32S91xOjKzt4MH3WvYZ
	 daWwB7ntDLhxhmqdbcn75B0OoFxQro1g8hLeh6i2LZhn4Lpa5tqnwtmR+TOT5GHvp7
	 UywDtyAcIYiSJoX2yqx1DvpewfHesmljboo7u+oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgJRLg5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Oct 2020 07:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgJRLg5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:36:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6ED208FE;
        Sun, 18 Oct 2020 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603021016;
        bh=+5PtGcgmtvW/PG8L6OEo1XFbWW+Cs0mMJSK/IJbw9VI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0pnw7JjIVIcMV1d5CzkXuZqFP2wUO3PbOMewZb4IqZIunqIAMJcCadkm9AEamp/OE
         3EFASgh/bVXvbX0hfE0ariIo9nu0D+HOF8r44kEKcO0SeIeFv5NQDsKO7DeCvBkuSC
         +HsbNAsdUYSMN4xjDbwldiakkByAchR7Y1Z1HWmI=
Date:   Sun, 18 Oct 2020 12:36:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        drew@beagleboard.org, robertcnelson@beagleboard.org,
        rajkovic@mikroe.com
Subject: Re: [PATCH v2] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201018123651.635e2ec3@archlinux>
In-Reply-To: <20201018033602.GA27912@ubuntu>
References: <20201018033602.GA27912@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Oct 2020 09:06:02 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> add i2c_device_id for the vcnl4035 driver so that
> the device can be instantiated using i2c_new_client_device
> or from userspace, useful in cases where device tree based
> description is not possible now(Eg. a device on a gbphy i2c
> adapter created by greybus)
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Rewrite the description and this should be fine.

Thanks,

Jonathan

> ---
>  v2:
> 	- fix commit message
>  drivers/iio/light/vcnl4035.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 765c44adac57..73a28e30dddc 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
>  			   vcnl4035_runtime_resume, NULL)
>  };
>  
> +static const struct i2c_device_id vcnl4035_id[] = {
> +	{ "vcnl4035", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> +
>  static const struct of_device_id vcnl4035_of_match[] = {
>  	{ .compatible = "vishay,vcnl4035", },
>  	{ }
> @@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
>  	},
>  	.probe  = vcnl4035_probe,
>  	.remove	= vcnl4035_remove,
> +	.id_table = vcnl4035_id,
>  };
>  
>  module_i2c_driver(vcnl4035_driver);

