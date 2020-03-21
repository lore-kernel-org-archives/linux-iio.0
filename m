Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFCC4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 21:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EA520753
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 21:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCUVLF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:11:05 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:49014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgCUVLF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:11:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2AED72490;
        Sat, 21 Mar 2020 21:11:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer68_9258a7d97a5b
X-Filterd-Recvd-Size: 2021
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 21:11:02 +0000 (UTC)
Message-ID: <e7188ce191ab1dfb06db0346f45e20829df63c70.camel@perches.com>
Subject: Re: [PATCH 01/13] iio: accel: kxsd9: Use suitable format specifier
From:   Joe Perches <joe@perches.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>, jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Mar 2020 14:09:14 -0700
In-Reply-To: <20200321210204.18106-2-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
         <20200321210204.18106-2-nish.malpani25@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-03-22 at 02:31 +0530, Nishant Malpani wrote:
> Provide more suitable format specifiers while printing error logs.
> Discards the use of unnecessary explicit casting and prints symbolic
> error name which might prove to be convenient during debugging.


'Use suitable format specifier' is obscure and not specific.

All the subjects should likely be something like

[PATCH] subsystem: Use vsprintf extension %pe for symbolic error name


> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
[]
> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  
>  	regmap = devm_regmap_init_i2c(i2c, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i2c->dev, "Failed to register i2c regmap %pe\n",
> +			regmap;

And this could use a separator between regmap and errname like

		dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n",
or
		dev_err(&i2c->dev, "Failed to register i2c regmap - %pe\n",


