Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1417024517-7564-5-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
	<1417024517-7564-5-git-send-email-lars@metafoo.de>
Date: Fri, 5 Dec 2014 00:56:32 +0200
Message-ID: <CAEnQRZATBCrfMiW=oxj2BE2xELnoDGdOrP7MPBFicep-djtjFA@mail.gmail.com>
Subject: Re: [PATCH 04/11] staging:iio:sca3000: Register same channels for
 device and buffer
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Minor comment inline.

On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> In preparation for moving the buffer registration to the core make sure to
> register the same channel array for the device and the buffer. Currently
> the temperature channel is not registered for the buffer, setting its scan
> index to -1 will make sure that it is skipped for the buffer.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index cd46a61..9eedb93 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -459,6 +459,7 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>                         BIT(IIO_CHAN_INFO_OFFSET),
> +               .scan_index = -1,

Would be nice to have  /* No buffer support */ comment as in 5/11 patch.

Otherwise, it looks good to me.

Daniel.
