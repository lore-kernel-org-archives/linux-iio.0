Return-Path: <SRS0=lRSj=4S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214BC3F2D1
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA76222C2
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583072655;
	bh=R0f7aWVxkB1VclGcflnTl+GpVS4uJevvWw/NgoP2MdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D98g53sqyB4rcOvB9l4/diLn7WN7+Xr5uMmQLuyR4U6Rkdpxbrxu36LdGJSn32+rO
	 xkXUgbPX9CoXSevBM4GdkQARt62WuyOxtfNUOG7brObZHCAvDWdpmvKio4DV/5hAen
	 eJ4l4ENm0R2dTlzpRWy5Vs0eP8dpAVcmjR20xxmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAOYP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgCAOYP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 09:24:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABA2214DB;
        Sun,  1 Mar 2020 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583072654;
        bh=R0f7aWVxkB1VclGcflnTl+GpVS4uJevvWw/NgoP2MdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNQKRYiVUa6RtuajN/EogC9xb2mRbz1jJUxpjVl31syYK5YqWCqgx+W+HegjD8FoH
         peQUe1y2gKuJCaxjwalg5dMnpDyvPU5papopFsfCVN/vAnofvNTMSnOMaS10Wrz1NR
         9kvQHyUtPbZbsXgAwHBYTWw7wapMYI0x0F+2yMRU=
Date:   Sun, 1 Mar 2020 14:24:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Petr =?UTF-8?B?xaB0ZXRpYXI=?= <ynezz@true.cz>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>, stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: fix missing triggered buffer
 dependency
Message-ID: <20200301142407.0e63f6dc@archlinux>
In-Reply-To: <20200227162734.604-1-ynezz@true.cz>
References: <20200227162734.604-1-ynezz@true.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 17:27:34 +0100
Petr =C5=A0tetiar <ynezz@true.cz> wrote:

> SPS30 uses triggered buffer, but the dependency is not specified in the
> Kconfig file.  Fix this by selecting IIO_BUFFER and IIO_TRIGGERED_BUFFER
> config symbols.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sens=
or")
> Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 0b91de4df8f4..a7e65a59bf42 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -91,6 +91,8 @@ config SPS30
>  	tristate "SPS30 particulate matter sensor"
>  	depends on I2C
>  	select CRC8
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to build support for the Sensirion SPS30 particulate
>  	  matter sensor.

