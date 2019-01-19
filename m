Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B03C61CE8
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05E2086D
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547916562;
	bh=jAnKHnJwvT6Y31cz6bIdcW7vf2UFLZI+tsS6HLQTVEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cER60K7C3P4UjKArL8vWozU6R5BWUXvmSZNb+PnZc4P0IQwGVZbzeHePbcGg3g8ds
	 F1ji2bOWLS+7vapUHMCIVfCyococNB5c/mcfinVKJacQvU2cgHcBpzc56jwB0ukBLd
	 U/cZGUrM1Ho23rRiJBDk0kLzvrSNEDRI6u41Xm1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfASQtV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfASQtV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Jan 2019 11:49:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB7220823;
        Sat, 19 Jan 2019 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547916560;
        bh=jAnKHnJwvT6Y31cz6bIdcW7vf2UFLZI+tsS6HLQTVEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nXNvd3Kl3B2383ZkXkhOgf6qvkdc17c29kZDAmbXA9RLLYlLNDg0vtma+DZJA0E3D
         DN8hUT+kUK59aeOQd5rtxlNuzM9KS1caeYc3IvcW7HsH3ZMwJxYCBtpshl0Lt6i9A7
         kW6x5OJfu4GJx1cY+doumRFCtKAvkMWtjcVFsLQ0=
Date:   Sat, 19 Jan 2019 16:49:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux@endlessm.com,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        hadess@hadess.net, hdegoede@redhat.com
Subject: Re: [PATCH 1/2] iio: drop const typing from iio_mount_matrix
 rotation
Message-ID: <20190119164915.2475b713@archlinux>
In-Reply-To: <20181220065933.25964-1-drake@endlessm.com>
References: <20181220065933.25964-1-drake@endlessm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Dec 2018 14:59:32 +0800
Daniel Drake <drake@endlessm.com> wrote:

> In order to conform with orientation data from the firmware, we
> need to dynamically construct the mount matrix in the ST accelerometer
> driver.
>=20
> Drop the const type from the mount matrix data to make this possible.
>=20
> Signed-off-by: Daniel Drake <drake@endlessm.com>
Not quite that simple...

drivers/iio/industrialio-core.c:551:21: error: passing argument 3 of =E2=80=
=98of_property_read_string_array=E2=80=99 from incompatible pointer type [-=
Werror=3Dincompatible-pointer-types]
     propname, matrix->rotation,
               ~~~~~~^~~~~~~~~~
In file included from ./include/linux/iio/iio.h:16,
                 from drivers/iio/industrialio-core.c:29:
./include/linux/of.h:1107:42: note: expected =E2=80=98const char **=E2=80=
=99 but argument is of type =E2=80=98char **=E2=80=99
       const char *propname, const char **out_strs,
                             ~~~~~~~~~~~~~^~~~~~~~
cc1: some warnings being treated as errors

Also, I didn't think that much about it until now, but I'm not sure
why you need this change in the first place. It is an array of
pointers to constant characters.  Given we allocate said array
before setting this variable to it and don't modify it via this
pointer, I believe we are fine with out this.

Compiler certainly isn't complaining about patch 2 without this
one.  Am I missing something?

Jonathan


> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..d3094ffeb9da 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -125,7 +125,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   *            main hardware
>   */
>  struct iio_mount_matrix {
> -	const char *rotation[9];
> +	char *rotation[9];
>  };
> =20
>  ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,

