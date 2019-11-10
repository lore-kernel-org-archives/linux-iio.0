Return-Path: <SRS0=iney=ZC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CBC43331
	for <linux-iio@archiver.kernel.org>; Sun, 10 Nov 2019 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42FC214E0
	for <linux-iio@archiver.kernel.org>; Sun, 10 Nov 2019 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573382791;
	bh=2mD1N37Ng1ONM4ShKf2/mBWotKppk5ld+szJC/rkQxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n7RMgmCD1Ntv9HDaISbxjSMvv+C9RGQjDrsW0FExSPTQWq63RQ3GW+qwR+4T/MMZM
	 6i+EIUVsRdweAxoL5vyyYPmgVEi8tAt00C1X6t3pyBv6W2QkvEslapGUnHRRY6CWOl
	 HbU6h4JQH18S/+/ZnHbyONUN/IzSnztZnnUH9wwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfKJKqb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:46:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfKJKqb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 05:46:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F71207FA;
        Sun, 10 Nov 2019 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573382790;
        bh=2mD1N37Ng1ONM4ShKf2/mBWotKppk5ld+szJC/rkQxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CRv+irT9gkWePcbnkxVzb5AJfLGPZqHVY3g/Pc2b8m/QXnqza/wI5ZyQJ8WLIsP81
         TVUbiYUHq8aB0JgFDEA4E111Yo6PXzHCVLQLPGMeIDR4oXrXUehNFXlYTXmEvshL7r
         2Kh9YryyiTZSAaCOCKIvkinnnw/71zEv4JkDFgb0=
Date:   Sun, 10 Nov 2019 10:46:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        <rwoerle@mibtec.de>
Subject: Re: [PATCH] iio: adc: ad7606: fix reading unnecessary data from
 device
Message-ID: <20191110104625.346152de@archlinux>
In-Reply-To: <20191104162634.5394-1-beniamin.bia@analog.com>
References: <20191104162634.5394-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 18:26:34 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> When a conversion result is being read from ADC, the driver reads the
> number of channels + 1 because it thinks that IIO_CHAN_SOFT_TIMESTAMP
> is also a physical channel. This patch fixes this issue.
>=20
> Fixes: 552a21f35477 ("staging: iio: adc: ad7606: Move out of staging")
> Reported-by: Robert W=C3=B6rle <rwoerle@mibtec.de>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

We are at that point in the cycle where I 'might' move this into
the togreg branch for the merge window.  All depends on what Linus
says in his rc7 email that'll probably be out later today.
Previously he hinted we'd have an rc8 this time. If that happens
I'll do one last pull request and hence take the queued up fixes
in with that for the merge window.  I don't have anything critical
enough to do a fixes pull this later in the cycle.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index f5ba94c03a8d..e4683a68522a 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -85,7 +85,7 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
> =20
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
> -	unsigned int num =3D st->chip_info->num_channels;
> +	unsigned int num =3D st->chip_info->num_channels - 1;
>  	u16 *data =3D st->data;
>  	int ret;
> =20

