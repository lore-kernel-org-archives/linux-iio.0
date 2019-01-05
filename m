Return-Path: <SRS0=5rro=PN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02297C43387
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41BD2085A
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546706065;
	bh=1EnQr3NJhuutTVHRqMYAZr41eyRe3Uwb4QfEqoNJDMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=leaxFExI48I4zZ6X0ydCQKhr9jU10zGblQH3aKFjCCAagPBbQbryQPAWEIAeLQgIP
	 rw4pQTtd96Sek+APvkvDJMbCkC9ujh5ssuTBQxUkNcLpMVcwAsez39936Ooybn1SlQ
	 qjMNGj/7E/0W+TViDAKEeOyhU2prTP368HU3TkEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAEQeZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfAEQeZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Jan 2019 11:34:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214242085A;
        Sat,  5 Jan 2019 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546706064;
        bh=1EnQr3NJhuutTVHRqMYAZr41eyRe3Uwb4QfEqoNJDMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lubOMMDcSYXSGoC5qAY85gnK8gSWT/S0VrGtdwHv2xAJtpaV1GECHRoD584JVN8IB
         zBm7pGxMRXJbVYY23XQQQDMIkxgC8Ln8jkKD3fbqsNSxJs6BXEe9RGlSCJC6haa92L
         /bNSmiYVSgGDGCC1M5QBMUpYjX755J5DHIqMDNKE=
Date:   Sat, 5 Jan 2019 16:34:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values
 to millicelsius
Message-ID: <20190105163420.48a047fc@archlinux>
In-Reply-To: <20181231030701.29789-1-matt.ranostay@konsulko.com>
References: <20181231030701.29789-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Dec 2018 19:07:01 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> IIO_TEMP scale value for temperature was incorrect and not in millicelsius
> as required by the ABI documentation.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Ideally would have had a fixes tag.  Looks superficially like this
goes back a long way but always nice to confirm how far :)

Anyhow, given we are in the merge window, I'll pick this up once rc1
is out and mark it for stable etc.

Give me a poke if I seem to have lost it in a week or so.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index a406ad31b096..3a20cb5d9bff 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -444,9 +444,8 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val = 1; /* 0.01 */
> -			*val2 = 100;
> -			break;
> +			*val = 10;
> +			return IIO_VAL_INT;
>  		case IIO_PH:
>  			*val = 1; /* 0.001 */
>  			*val2 = 1000;
> @@ -477,7 +476,7 @@ static int atlas_write_raw(struct iio_dev *indio_dev,
>  			   int val, int val2, long mask)
>  {
>  	struct atlas_data *data = iio_priv(indio_dev);
> -	__be32 reg = cpu_to_be32(val);
> +	__be32 reg = cpu_to_be32(val / 10);
>  
>  	if (val2 != 0 || val < 0 || val > 20000)
>  		return -EINVAL;

