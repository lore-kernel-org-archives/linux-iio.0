Return-Path: <SRS0=WE6a=VY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B218C76186
	for <linux-iio@archiver.kernel.org>; Sat, 27 Jul 2019 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BD0208E4
	for <linux-iio@archiver.kernel.org>; Sat, 27 Jul 2019 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564257550;
	bh=5n8JGghd0Fl1yahsjm3v8Qo8y8eH7slQ/09TtSOnluo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PEYzUOJpX1loFkFlDVpCbLyXtw2Dh3hcRkAXu25OVO9gFoUGhNK5yI9/G24MrbvQ6
	 5XGQZ603lArx1q0ibxRvMhTotQ0Gn5if3iqtU3/kIS9bca/8wADzNuljxXUi9Vk/hr
	 byqgY9Rb0M/H+d4W0lyU0rKHxQSsEqWufXA0lofI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfG0T7G (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbfG0T7G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 15:59:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 277A5208C0;
        Sat, 27 Jul 2019 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564257545;
        bh=5n8JGghd0Fl1yahsjm3v8Qo8y8eH7slQ/09TtSOnluo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnGmy3gJwed03NJToua28mFYXmudPtPJYADoGMT/a2tTKTJZK/9IpWhGHXJLc08//
         C6ea1kDxchc5jnNNFIopMSkL1UCPMTfITk4eaDl85Zm3IZxZuZgMWM1VcqmdUhZu4S
         ESI++foEsmcOjcqBvOe3CVP3cTmWkVv9zn4X8cKg=
Date:   Sat, 27 Jul 2019 20:59:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: pressure: hp03: convert to
 i2c_new_dummy_device
Message-ID: <20190727205900.0cbc4064@archlinux>
In-Reply-To: <20190722172613.3890-4-wsa+renesas@sang-engineering.com>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
        <20190722172613.3890-4-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jul 2019 19:26:13 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied, thanks.

J
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/iio/pressure/hp03.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
> index f00102577fd5..026ba15ef68f 100644
> --- a/drivers/iio/pressure/hp03.c
> +++ b/drivers/iio/pressure/hp03.c
> @@ -243,10 +243,10 @@ static int hp03_probe(struct i2c_client *client,
>  	 * which has it's dedicated I2C address and contains
>  	 * the calibration constants for the sensor.
>  	 */
> -	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
> -	if (!priv->eeprom_client) {
> +	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
> +	if (IS_ERR(priv->eeprom_client)) {
>  		dev_err(dev, "New EEPROM I2C device failed\n");
> -		return -ENODEV;
> +		return PTR_ERR(priv->eeprom_client);
>  	}
>  
>  	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,

