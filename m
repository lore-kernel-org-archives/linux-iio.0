Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:51389 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaIXICN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Sep 2014 04:02:13 -0400
Received: by mail-we0-f180.google.com with SMTP id u56so5707239wes.39
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2014 01:02:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1411495448-17941-3-git-send-email-lars@metafoo.de>
References: <1411495448-17941-1-git-send-email-lars@metafoo.de>
	<1411495448-17941-3-git-send-email-lars@metafoo.de>
Date: Wed, 24 Sep 2014 11:02:12 +0300
Message-ID: <CAEnQRZA8t9VbDCe7yUwVTJQNo7fLT9_b6XpxFFjHAfUJojfzMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] staging:iio:ad5933: Report temperature as raw value
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 23, 2014 at 9:04 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> We shouldn't be doing the unit conversion in kernel space. Just report the
> raw value for the property and the scale. Userspace can do the conversion if
> necessary.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index b6bd609..ebff637 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -113,7 +113,8 @@ static const struct iio_chan_spec ad5933_channels[] = {
>                 .type = IIO_TEMP,
>                 .indexed = 1,
>                 .channel = 0,
> -               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                       BIT(IIO_CHAN_INFO_SCALE),
>                 .address = AD5933_REG_TEMP_DATA,
>                 .scan_index = -1,
>                 .scan_type = {
> @@ -522,10 +523,9 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>         __be16 dat;
>         int ret = -EINVAL;
>
> -       mutex_lock(&indio_dev->mlock);
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> -       case IIO_CHAN_INFO_PROCESSED:
> +               mutex_lock(&indio_dev->mlock);
>                 if (iio_buffer_enabled(indio_dev)) {
>                         ret = -EBUSY;
>                         goto out;
> @@ -543,14 +543,13 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>                 if (ret < 0)
>                         goto out;
>                 mutex_unlock(&indio_dev->mlock);
> -               ret = be16_to_cpu(dat);
> -               /* Temp in Milli degrees Celsius */
> -               if (ret < 8192)
> -                       *val = ret * 1000 / 32;
> -               else
> -                       *val = (ret - 16384) * 1000 / 32;
> +               *val = sign_extend32(be16_to_cpu(dat), 13);
>
>                 return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = 1000;
> +               *val2 = 5;
> +               return IIO_VAL_FRACTIONAL_LOG2;
>         }
>
>  out:

Is it possible to reach this line with mutex not acquired?

out:
      mutex_unlock(&indio_dev->mlock);
      return ret;

Daniel.
