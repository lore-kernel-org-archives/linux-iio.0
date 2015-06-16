Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34019 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbbFPKeo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2015 06:34:44 -0400
Received: by wicnd19 with SMTP id nd19so49057973wic.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2015 03:34:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a9a11f217224e458d8ffb2741b27f1ad92db1870.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
	<a9a11f217224e458d8ffb2741b27f1ad92db1870.1434404216.git.knaack.h@gmx.de>
Date: Tue, 16 Jun 2015 13:34:42 +0300
Message-ID: <CAE1zotKLuJxTYzJZ84Gzi-dY1HqgGzmh3BheszWeka6Wi9XqtQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio:accel:bmc150-accel: make use of mask definition
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 16, 2015 at 12:48 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> BMC150_ACCEL_SLOPE_THRES_MASK was defined some time ago, but its 'magic'
> value got used instead in bmc150_accel_write_event(). Make use of it for
> improved readability.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Reviewed-by: Octavian Purdila <octavian.purdila@intel.com>

> ---
>  drivers/iio/accel/bmc150-accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index cc5a357..36a9cd5 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -776,7 +776,7 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
>
>         switch (info) {
>         case IIO_EV_INFO_VALUE:
> -               data->slope_thres = val & 0xFF;
> +               data->slope_thres = val & BMC150_ACCEL_SLOPE_THRES_MASK;
>                 break;
>         case IIO_EV_INFO_PERIOD:
>                 data->slope_dur = val & BMC150_ACCEL_SLOPE_DUR_MASK;
> --
> 2.3.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
