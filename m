Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38392 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbcA0JeZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2016 04:34:25 -0500
Received: by mail-wm0-f48.google.com with SMTP id p63so16886308wmp.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Jan 2016 01:34:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453814201-31557-1-git-send-email-lars@metafoo.de>
References: <1453814201-31557-1-git-send-email-lars@metafoo.de>
Date: Wed, 27 Jan 2016 11:34:24 +0200
Message-ID: <CAEnQRZAwM8R0QeFz_R-ACYPX6sxjSGqNyA3CLOTndhAXDFE6NQ@mail.gmail.com>
Subject: Re: [PATCH] iio: Add helper function for calculating scan index
 storage size
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 26, 2016 at 3:16 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> We have the same code for computing the scan index storage size in bytes
> all over the place. Factor this out into a helper function. makes the code
> a bit shorter and makes it easier to do future modifications to the
> implementation.

Nice patch. Few comments below:

Running checkpatch I get some warnings like this:

$ ./scripts/checkpatch.pl --strict x.patch
CHECK: Alignment should match open parenthesis

One of them can be fixed, for the others there's not much to be done.

>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/industrialio-buffer.c | 52 ++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 139ae91..e026a09 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -512,33 +512,35 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
>         return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
>  }
>
> +static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
> +       unsigned int scan_index)

This can be fixed. Second line doesn't go beyond 80 chars limit after alignment.

> +{
> +       const struct iio_chan_spec *ch;
> +       unsigned int bytes;
> +
> +       ch = iio_find_channel_from_si(indio_dev, scan_index);
> +       bytes = ch->scan_type.storagebits / 8;
> +       if (ch->scan_type.repeat > 1)
> +               bytes *= ch->scan_type.repeat;
> +       return bytes;
> +}
> +
>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>                                 const unsigned long *mask, bool timestamp)
>  {
> -       const struct iio_chan_spec *ch;
>         unsigned bytes = 0;
>         int length, i;
>
>         /* How much space will the demuxed element take? */
>         for_each_set_bit(i, mask,
>                          indio_dev->masklength) {

While at it you can move this on the previous line. It makes code
easier to read.

> -               ch = iio_find_channel_from_si(indio_dev, i);
> -               if (ch->scan_type.repeat > 1)
> -                       length = ch->scan_type.storagebits / 8 *
> -                               ch->scan_type.repeat;
> -               else
> -                       length = ch->scan_type.storagebits / 8;
> +               length = iio_storage_bytes_for_si(indio_dev, i);
>                 bytes = ALIGN(bytes, length);
>                 bytes += length;
>         }
>         if (timestamp) {
> -               ch = iio_find_channel_from_si(indio_dev,
> -                                             indio_dev->scan_index_timestamp);
> -               if (ch->scan_type.repeat > 1)
> -                       length = ch->scan_type.storagebits / 8 *
> -                               ch->scan_type.repeat;
> -               else
> -                       length = ch->scan_type.storagebits / 8;
> +               length = iio_storage_bytes_for_si(indio_dev,
> +                       indio_dev->scan_index_timestamp);


<snip>

thanks,
Daniel.
