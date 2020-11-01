Return-Path: <SRS0=DicA=EH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D09C2D0A3
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0022249
	for <linux-iio@archiver.kernel.org>; Sun,  1 Nov 2020 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604244598;
	bh=sqk3AYKXuD6V4KehsqM0aeMZM/GIyg9DymWyj21oGmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RRS1n53WX1Cs8e3V6Aj/Npc9IPIe/4hiLD2VSD2ve2VpNgA6/UTOtaLOKiSl8q+hW
	 fVPjSXyYGj2Da8qyEzxwG19pG0I+lZI4yFHTb5XeWV19rgTBjkFmmUUg6K1I5cEJKg
	 aBreFgIm39v2ftecsQ0Airkp2+Jx7gibJgpIN/2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKAP35 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Nov 2020 10:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgKAP35 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:29:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8607522242;
        Sun,  1 Nov 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604244596;
        bh=sqk3AYKXuD6V4KehsqM0aeMZM/GIyg9DymWyj21oGmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/KR+2XkACpAh9XCP5XQZpw6uPjSmlg+iLrW+UBpW1MZ5pTW+fs3RPs9udCG0BK6I
         gb0NcnycoW15BTB4MPoqrY3edbk81lpoMm2Bop8a4QDfOAwPsDiZ+dJE2jSlVVWWFD
         5gawMOfCUbdJi0NdntAqPeVxBjki3U32JDMuOtDM=
Date:   Sun, 1 Nov 2020 15:29:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     andy.shevchenko@gmail.com, wsa@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        drew@beagleboard.org, robertcnelson@beagleboard.org,
        rajkovic@mikroe.com
Subject: Re: [PATCH v4] iio:light:tsl2563 use generic fw accessors
Message-ID: <20201101152950.26474192@archlinux>
In-Reply-To: <20201018203552.GA816421@ubuntu>
References: <20201018203552.GA816421@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Oct 2020 02:05:52 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> Replace of_property_read_u32() with device_property_read_u32(),
> when reading the amstaos,cover-comp-gain.This opens up the
> possibility of passing the properties during platform instantiation
> of the device by a suitable populated struct property_entry.
> Additionally, a minor change in logic is added to remove the
> of_node present check.
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Dropped v3 and applied this.

If no one has replied to a previous version and you decide to respin
for whatever reason, please reply yourself to that earlier version
to say you have done so.

Thanks,

Jonathan

> ---
>  v4:
> 	-update commit message, fix punctuation.
> 	-update to a shorter commit title, used for similar changes
> 	 within the subsystem, like in 00fa493b9989
> 	 ("iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors")
>  v3:
>         -modify commit message for readability, mention minor logic change
>         -include  mod_devicetable.h and property.h headers
>  v2:
>         -fix commit message
>  drivers/iio/light/tsl2563.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index abc8d7db8dc1..5bf2bfbc5379 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -12,6 +12,8 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -703,7 +705,6 @@ static int tsl2563_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct tsl2563_chip *chip;
>  	struct tsl2563_platform_data *pdata = client->dev.platform_data;
> -	struct device_node *np = client->dev.of_node;
>  	int err = 0;
>  	u8 id = 0;
>  
> @@ -738,13 +739,14 @@ static int tsl2563_probe(struct i2c_client *client,
>  	chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
>  	chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
>  
> -	if (pdata)
> +	if (pdata) {
>  		chip->cover_comp_gain = pdata->cover_comp_gain;
> -	else if (np)
> -		of_property_read_u32(np, "amstaos,cover-comp-gain",
> -				     &chip->cover_comp_gain);
> -	else
> -		chip->cover_comp_gain = 1;
> +	} else {
> +		err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
> +					       &chip->cover_comp_gain);
> +		if (err)
> +			chip->cover_comp_gain = 1;
> +	}
>  
>  	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
>  	indio_dev->name = client->name;

