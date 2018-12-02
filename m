Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2352C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6549820881
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 15:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANtsDC4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLBPhH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLBPhH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Dec 2018 10:37:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C142082F;
        Sun,  2 Dec 2018 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543765024;
        bh=7w0PxYg3bEIBqZiV1G+Mu7PpP0nghmwnRPSIRYgREmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANtsDC4mfeSk2k67z/Mrer8o2RVV8c1tCWOYd0hrbTkuXyKyjfOBefqy7JCtJbF25
         9i3MfMV+C9JeWVXGSvV/4nByCA/Rn/LQUriawCedOWGtN+cBbW4oNZq8YBFb5ATcs0
         WXejMFPGCIhZc61sZnclqkerKAheJFdnFXltYT3M=
Date:   Sun, 2 Dec 2018 15:36:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] staging: iio: adc: ad7280a: fix overwrite of the
 returned value
Message-ID: <20181202153659.1c8eb23c@archlinux>
In-Reply-To: <20181202114235.12443-1-sst@poczta.fm>
References: <20181202114235.12443-1-sst@poczta.fm>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Dec 2018 12:42:35 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> The ret returned from ad7280_chain_setup() is needed to initialize the
> slave_num. Don't overwrite it with call to devm_add_action_or_reset().
>=20
> Fixes: cc9c58ef6e06 ("staging: iio: adc: ad7280a: use devm_* APIs")
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Good find.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/=
ad7280a.c
> index 7a0ba26f9fd9..14f6a3ced060 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -879,15 +879,15 @@ static int ad7280_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
> -	if (ret)
> -		return ret;
> -
>  	st->slave_num =3D ret;
>  	st->scan_cnt =3D (st->slave_num + 1) * AD7280A_NUM_CH;
>  	st->cell_threshhigh =3D 0xFF;
>  	st->aux_threshhigh =3D 0xFF;
> =20
> +	ret =3D devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Total Conversion Time =3D ((tACQ + tCONV) *
>  	 *			   (Number of Conversions per Part)) =E2=88=92

