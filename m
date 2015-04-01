Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37609 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbbDAOEa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 10:04:30 -0400
Received: by wiaa2 with SMTP id a2so67832336wia.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 07:04:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 1 Apr 2015 17:04:28 +0300
Message-ID: <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 1, 2015 at 5:55 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Added rate control support for ALS and proximity
> threshold interrupts.
>
> Setting <n> to ALS intr_persist sysfs node would
> generate interrupt whenever ALS data cross either
> upper or lower threshold limits <n> number of times.
> Similarly setting <m> to proximity intr_persist sysfs
> node would genere interrupt whenever proximity data falls
> outside threshold limit <m> number of times.
>

<snip>

> +static ssize_t ltr501_read_intr_prst(struct iio_dev *indio_dev,
> +                                  uintptr_t private,
> +                                  const struct iio_chan_spec *chan,
> +                                  char *buf)
> +{
> +       struct ltr501_data *data = iio_priv(indio_dev);
> +       int ret = -EINVAL;
> +
> +       switch (chan->type) {
> +       case IIO_INTENSITY:
> +               mutex_lock(&data->lock_als);
> +               ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
> +               mutex_unlock(&data->lock_als);

I am not sure I understand why is the mutex needed here? AFAIK I2C transactions
are serialized.

<snip>

> +static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
> +       {
> +               .name = "intr_persist",
> +               .read = ltr501_read_intr_prst,
> +               .write = ltr501_write_intr_prst,
> +               .shared = IIO_SHARED_BY_TYPE,
> +       },
> +       {},
> +};
> +
Would be nice to standardize persistence attribute (IIO_CHAN_INFO_PERSISTENCE).

thanks,
Daniel.
