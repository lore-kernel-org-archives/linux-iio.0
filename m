Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ADEC4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC520775
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUSfj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:35:39 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:43138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727015AbgCUSfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 14:35:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DB539182CED28;
        Sat, 21 Mar 2020 18:35:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: word42_6b2f3b9dd3046
X-Filterd-Recvd-Size: 2030
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 18:35:36 +0000 (UTC)
Message-ID: <ed459ac3c268d6287f70a0aa8ca682b022f27a8e.camel@perches.com>
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
From:   Joe Perches <joe@perches.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 21 Mar 2020 11:33:48 -0700
In-Reply-To: <9aa90ffd-9574-d615-0bc0-f791e51b3be4@gmail.com>
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
         <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
         <9aa90ffd-9574-d615-0bc0-f791e51b3be4@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-03-21 at 23:56 +0530, Nishant Malpani wrote:
> On 21/03/20 5:56 pm, Joe Perches wrote:
> > On Wed, 2020-03-18 at 15:37 +0530, Nishant Malpani wrote:
> > > Provide correct specifiers while printing error logs to discard the use
> > > of unnecessary explicit casting.
> > []
> > > diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> > []
> > > @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
> > >   
> > >   	regmap = devm_regmap_init_i2c(i2c, &config);
> > >   	if (IS_ERR(regmap)) {
> > > -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> > > -			(int)PTR_ERR(regmap));
> > > +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
> > > +			PTR_ERR(regmap));
> > 
> > Another option would be to use %pe to print the error identifier
> > and not the error number
> > 
> By 'error identifier' you mean the symbolic error name (as described in 
> docs [1]), right?

Yes

> https://www.kernel.org/doc/html/latest/core-api/printk-formats.html#error-pointers


