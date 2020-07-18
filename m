Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9435C433E1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9471B20829
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595086332;
	bh=lusgy4vQ5ZPiBOpgbrbfYAbp3Ei0kOHjqiB2nSapRJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jISessC9rBC9O3eDUHEXqAOnGCFE59hSwTczpHedgFbL/kIHiG2JPTNkO0qByQxM4
	 bWA6gMZzMSrccOmHQGmsb2jsSMJ1R4vbSbMBwVpShtu/R2bpDlMg/wHYhGle4pkS6g
	 VUntAbFqkt5GiwbZ/X1vqsEx6Bs5PnJww7VKjmK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgGRPcM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgGRPcL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:32:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC4D2076A;
        Sat, 18 Jul 2020 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086331;
        bh=lusgy4vQ5ZPiBOpgbrbfYAbp3Ei0kOHjqiB2nSapRJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1mYZGubbeBcguxWrYGVVFkJpJvYt0htD7PVdMaLaVGukLd1Tjd176tWPBVdBfCQZO
         GaKM0+AV197s7xnNsHBBFT07Zb+/F/BEl+lGwf7x+/srsTUkvV2AxnrjA8rjBXc4wO
         Ps5TU+umGDEvroHptC9GMixtaiYa1NJqBypiOlzk=
Date:   Sat, 18 Jul 2020 16:32:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        J Keerthy <j-keerthy@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>,
        Amit Kucheria <amit.kucheria@canonical.com>
Subject: Re: [PATCH 02/30] iio: adc: twl4030-madc: Remove set but unused
 variables 'len'
Message-ID: <20200718163206.7bf45466@archlinux>
In-Reply-To: <20200717165538.3275050-3-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-3-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:10 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/adc/twl4030-madc.c: In function =E2=80=98twl4030_madc_thread=
ed_irq_handler=E2=80=99:
>  drivers/iio/adc/twl4030-madc.c:475:9: warning: variable =E2=80=98len=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>  475 | int i, len, ret;
>  | ^~~
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: J Keerthy <j-keerthy@ti.com>
> Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
> Cc: Amit Kucheria <amit.kucheria@canonical.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing or the au=
tobuilders
to play with them.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl4030-madc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-mad=
c.c
> index 472b08f37feae..826d8295e9b3c 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -472,7 +472,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(=
int irq, void *_madc)
>  	struct twl4030_madc_data *madc =3D _madc;
>  	const struct twl4030_madc_conversion_method *method;
>  	u8 isr_val, imr_val;
> -	int i, len, ret;
> +	int i, ret;
>  	struct twl4030_madc_request *r;
> =20
>  	mutex_lock(&madc->lock);
> @@ -504,8 +504,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(=
int irq, void *_madc)
>  			continue;
>  		method =3D &twl4030_conversion_methods[r->method];
>  		/* Read results */
> -		len =3D twl4030_madc_read_channels(madc, method->rbase,
> -						 r->channels, r->rbuf, r->raw);
> +		twl4030_madc_read_channels(madc, method->rbase,
> +					   r->channels, r->rbuf, r->raw);
>  		/* Free request */
>  		r->result_pending =3D false;
>  		r->active =3D false;
> @@ -525,8 +525,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(=
int irq, void *_madc)
>  			continue;
>  		method =3D &twl4030_conversion_methods[r->method];
>  		/* Read results */
> -		len =3D twl4030_madc_read_channels(madc, method->rbase,
> -						 r->channels, r->rbuf, r->raw);
> +		twl4030_madc_read_channels(madc, method->rbase,
> +					   r->channels, r->rbuf, r->raw);
>  		/* Free request */
>  		r->result_pending =3D false;
>  		r->active =3D false;

