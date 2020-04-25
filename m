Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F63C55191
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B820714
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587833706;
	bh=JjChTrtA0oJ6ePhjEidISsO81puxuHkvJCnWPoasV2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aSeKbhFRk30IhGpXnp0+NRu9wYk2gr0DxkCNHkmBQso9SIW4oEhsYGVF/DaEvuwFj
	 ajcfEHgg+XE/GMxzcqqeHDCgibuWPvcuiUB+mSPYRAqo4b8QXEfDHFWljlfLzJP+dD
	 G2Mp/v2vXKR9kfccX6MqnhVBBP3SLHLGT8ywwl0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDYQzG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgDYQzE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:55:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CCB206D4;
        Sat, 25 Apr 2020 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833704;
        bh=JjChTrtA0oJ6ePhjEidISsO81puxuHkvJCnWPoasV2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HbrDkR+BPdXmHiPtxrnTJ4qX3w2V5OSeBsbMwy3n39kNV+jOJVi1Sgjird+eIr3Wp
         lK8Gv114NK7/2Q+aIb7AJZ+G5krVjYafBOFyStPRttxL+MQxXYGmHz//wegZPOeA16
         q3kpgwzafpCtbpQHxwbBe2kD8InE+RjafBGoIWlg=
Date:   Sat, 25 Apr 2020 17:54:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5593r: Fix a typo in MODULE_DESCRIPTION
Message-ID: <20200425175458.4ba655e0@archlinux>
In-Reply-To: <20200425065653.31203-1-christophe.jaillet@wanadoo.fr>
References: <20200425065653.31203-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 08:56:53 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> This module is related to AD5593R, not AD5592R.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5593r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
> index 44ea3b8117d0..1fbe9c019c7f 100644
> --- a/drivers/iio/dac/ad5593r.c
> +++ b/drivers/iio/dac/ad5593r.c
> @@ -134,5 +134,5 @@ static struct i2c_driver ad5593r_driver = {
>  module_i2c_driver(ad5593r_driver);
>  
>  MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
> +MODULE_DESCRIPTION("Analog Devices AD5593R multi-channel converters");
>  MODULE_LICENSE("GPL v2");

