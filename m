Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935160AbeCGUJh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:09:37 -0500
Date: Wed, 7 Mar 2018 20:09:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging:iio:meter: Remove unused macro
 IIO_DEV_ATTR_CH_OFF
Message-ID: <20180307200932.040bf33b@archlinux>
In-Reply-To: <d22093b4c22f6df9c6efc2e7f711417726719fee.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <d22093b4c22f6df9c6efc2e7f711417726719fee.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Mar 2018 21:44:07 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes the macro IIO_DEV_ATTR_CH_OFF. The macro
> IIO_DEV_ATTR_CH_OFF is not required, due to the replace of it by the
> direct use of IIO_DEVICE_ATTR in files staging/iio/meter/ade7759.c and
> staging/iio/meter/ade7753.c.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Doh! I should have read to the next patch.

Personally I wouldn't have split this in to, but it is a small thing
so doesn't matter.

Applied to the togreg branch of iio.git (having reverted my tweak
to the previous patch) and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/meter.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
> index edf26302fa57..5ed59bf30a25 100644
> --- a/drivers/staging/iio/meter/meter.h
> +++ b/drivers/staging/iio/meter/meter.h
> @@ -348,9 +348,6 @@
>  #define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
>  	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
>  
> -#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
> -
>  /* active energy register, AENERGY, is more than half full */
>  #define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
>  	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)

