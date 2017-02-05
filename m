Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdBEJiW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 04:38:22 -0500
Subject: Re: [PATCH v2 2/2] iio: pressure: mpl115: do not rely on structure
 field ordering
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1485981657-14586-1-git-send-email-peda@axentia.se>
 <1485981657-14586-3-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Ken Lin <ken.lin@advantech.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fe029d44-1e59-9854-aed3-e25d8833bc68@kernel.org>
Date: Sun, 5 Feb 2017 09:38:15 +0000
MIME-Version: 1.0
In-Reply-To: <1485981657-14586-3-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/17 20:40, Peter Rosin wrote:
> Fixes a regression triggered by a change in the layout of
> struct iio_chan_spec, but the real bug is in the driver which assumed
> a specific structure layout in the first place. Hint: the three bits were
> not OR:ed together as implied by the indentation prior to this patch,
> there was a comma between the first two, which accidentally moved the
> ..._SCALE and ..._OFFSET bits to the next structure field. That field
> was .info_mask_shared_by_type before the _available attributes was added
> by commit 51239600074b ("iio:core: add a callback to allow drivers to
> provide _available attributes") and .info_mask_separate_available
> afterwards, and the regression happened.
> 
> info_mask_shared_by_type is actually a better choice than the originally
> intended info_mask_separate for the ..._SCALE and ..._OFFSET bits since
> a constant is returned from mpl115_read_raw for the scale/offset. Using
> info_mask_shared_by_type also preserves the behavior from before the
> regression and is therefore less likely to cause other interesting side
> effects.
> 
> The above mentioned regression causes unintended sysfs attibutes to
> show up that are not backed by code, in turn causing a NULL pointer
> defererence to happen on access.
> 
> Fixes: 3017d90e8931 ("iio: Add Freescale MPL115A2 pressure / temperature sensor driver")
> Fixes: 51239600074b ("iio:core: add a callback to allow drivers to provide _available attributes")
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/mpl115.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 73f2f0c46e62..8f2bce213248 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -137,6 +137,7 @@ static const struct iio_chan_spec mpl115_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =
>  			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  };
> 

