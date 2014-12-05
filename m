Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58710 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbaLEJxK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Dec 2014 04:53:10 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so443618wgh.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2014 01:53:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417024517-7564-4-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
	<1417024517-7564-4-git-send-email-lars@metafoo.de>
Date: Fri, 5 Dec 2014 11:53:07 +0200
Message-ID: <CAEnQRZDFB6jwqrqvqcFNCS0-4nO0LeoHRfOiH1BF-Ot7nOvU-w@mail.gmail.com>
Subject: Re: [PATCH 03/11] iio: Unexport iio_scan_mask_set()
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Individual drivers should not be messing with the scan mask that contains
> the list of enabled channels. This is something that is supposed to be
> managed by the core.
>
> Now that the last few drivers that used it to configure a default scan mask
> have been updated to not do this anymore we can unexport the function.
>
> Note, this patch also requires moving a few functions around so they are all
> declared before the first internal user.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/industrialio-buffer.c | 149 +++++++++++++++++++-------------------
>  include/linux/iio/buffer.h        |   9 ---
>  2 files changed, 74 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index f971f79..f667e4e 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -178,6 +178,80 @@ static ssize_t iio_scan_el_show(struct device *dev,
>         return sprintf(buf, "%d\n", ret);
>  }
>
> +/* Note NULL used as error indicator as it doesn't make sense. */
> +static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
> +                                         unsigned int masklength,
> +                                         const unsigned long *mask)
> +{
> +       if (bitmap_empty(mask, masklength))
> +               return NULL;
> +       while (*av_masks) {
> +               if (bitmap_subset(mask, av_masks, masklength))
> +                       return av_masks;
> +               av_masks += BITS_TO_LONGS(masklength);
> +       }
> +       return NULL;
> +}
> +
> +static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
> +       const unsigned long *mask)
> +{
> +       if (!indio_dev->setup_ops->validate_scan_mask)
> +               return true;
> +
> +       return indio_dev->setup_ops->validate_scan_mask(indio_dev, mask);
> +}
> +
> +/**
> + * iio_scan_mask_set() - set particular bit in the scan mask
> + * @indio_dev: the iio device
> + * @buffer: the buffer whose scan mask we are interested in
> + * @bit: the bit to be set.
> + *
> + * Note that at this point we have no way of knowing what other
> + * buffers might request, hence this code only verifies that the
> + * individual buffers request is plausible.
> + */
> +static int iio_scan_mask_set(struct iio_dev *indio_dev,
> +                     struct iio_buffer *buffer, int bit)
> +{
> +       const unsigned long *mask;
> +       unsigned long *trialmask;
> +
> +       trialmask = kmalloc(sizeof(*trialmask)*
> +                           BITS_TO_LONGS(indio_dev->masklength),
> +                           GFP_KERNEL);
> +
> +       if (trialmask == NULL)
> +               return -ENOMEM;
> +       if (!indio_dev->masklength) {
> +               WARN_ON("Trying to set scanmask prior to registering buffer\n");
> +               goto err_invalid_mask;
> +       }
> +       bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
> +       set_bit(bit, trialmask);
> +
> +       if (!iio_validate_scan_mask(indio_dev, trialmask))
> +               goto err_invalid_mask;
> +
> +       if (indio_dev->available_scan_masks) {
> +               mask = iio_scan_mask_match(indio_dev->available_scan_masks,
> +                                          indio_dev->masklength,
> +                                          trialmask);
> +               if (!mask)
> +                       goto err_invalid_mask;
> +       }
> +       bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
> +
> +       kfree(trialmask);
> +
> +       return 0;
> +
> +err_invalid_mask:
> +       kfree(trialmask);
> +       return -EINVAL;
> +}
> +
>  static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
>  {
>         clear_bit(bit, buffer->scan_mask);
> @@ -455,21 +529,6 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>  }
>  EXPORT_SYMBOL(iio_buffer_show_enable);
>
> -/* Note NULL used as error indicator as it doesn't make sense. */
> -static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
> -                                         unsigned int masklength,
> -                                         const unsigned long *mask)
> -{
> -       if (bitmap_empty(mask, masklength))
> -               return NULL;
> -       while (*av_masks) {
> -               if (bitmap_subset(mask, av_masks, masklength))
> -                       return av_masks;
> -               av_masks += BITS_TO_LONGS(masklength);
> -       }
> -       return NULL;
> -}
> -
>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>                                 const unsigned long *mask, bool timestamp)
>  {
> @@ -808,66 +867,6 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
>
> -static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
> -       const unsigned long *mask)
> -{
> -       if (!indio_dev->setup_ops->validate_scan_mask)
> -               return true;
> -
> -       return indio_dev->setup_ops->validate_scan_mask(indio_dev, mask);
> -}
> -
> -/**
> - * iio_scan_mask_set() - set particular bit in the scan mask
> - * @indio_dev: the iio device
> - * @buffer: the buffer whose scan mask we are interested in
> - * @bit: the bit to be set.
> - *
> - * Note that at this point we have no way of knowing what other
> - * buffers might request, hence this code only verifies that the
> - * individual buffers request is plausible.
> - */
> -int iio_scan_mask_set(struct iio_dev *indio_dev,
> -                     struct iio_buffer *buffer, int bit)
> -{
> -       const unsigned long *mask;
> -       unsigned long *trialmask;
> -
> -       trialmask = kmalloc(sizeof(*trialmask)*
> -                           BITS_TO_LONGS(indio_dev->masklength),
> -                           GFP_KERNEL);
> -
> -       if (trialmask == NULL)
> -               return -ENOMEM;
> -       if (!indio_dev->masklength) {
> -               WARN_ON("Trying to set scanmask prior to registering buffer\n");
> -               goto err_invalid_mask;
> -       }
> -       bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
> -       set_bit(bit, trialmask);
> -
> -       if (!iio_validate_scan_mask(indio_dev, trialmask))
> -               goto err_invalid_mask;
> -
> -       if (indio_dev->available_scan_masks) {
> -               mask = iio_scan_mask_match(indio_dev->available_scan_masks,
> -                                          indio_dev->masklength,
> -                                          trialmask);
> -               if (!mask)
> -                       goto err_invalid_mask;
> -       }
> -       bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
> -
> -       kfree(trialmask);
> -
> -       return 0;
> -
> -err_invalid_mask:
> -       kfree(trialmask);
> -       return -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(iio_scan_mask_set);
> -
>  int iio_scan_mask_query(struct iio_dev *indio_dev,
>                         struct iio_buffer *buffer, int bit)
>  {
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 5193927..8c8ce61 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -117,15 +117,6 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
>                         struct iio_buffer *buffer, int bit);
>
>  /**
> - * iio_scan_mask_set() - set particular bit in the scan mask
> - * @indio_dev          IIO device structure
> - * @buffer:            the buffer whose scan mask we are interested in
> - * @bit:               the bit to be set.
> - **/
> -int iio_scan_mask_set(struct iio_dev *indio_dev,
> -                     struct iio_buffer *buffer, int bit);
> -
> -/**
>   * iio_push_to_buffers() - push to a registered buffer.
>   * @indio_dev:         iio_dev structure for device.
>   * @data:              Full scan.
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
