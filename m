Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdI3Ubn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:31:43 -0400
Date: Sat, 30 Sep 2017 21:31:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v3 4/4] iio: light: vl6180: Correct ALS scale for
 non-default gain/integration time
Message-ID: <20170930213138.5bad87c7@archlinux>
In-Reply-To: <a259e916-781f-4da9-b545-c409f994d013@rwthex-w2-a.rwth-ad.de>
References: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
        <a259e916-781f-4da9-b545-c409f994d013@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Sep 2017 23:59:20 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> The reported scale was only correct for the default settings of 100 ms
> integration time and gain 1.
> 
> This aligns the reported scale with the behaviour of any other IIO driver
> and the documented ABI, but may require userspace changes if someone uses
> non-default settings.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Whilst this is clearly a fix, it isn't a regression.  As such the extent
of the changes mean I've queued this up for the next merge window rather
than going in quicker as a fix.

Thanks,

Jonathan

> 
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/iio/light/vl6180.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 49e9f92cd116..67f8beb84fc3 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -315,9 +315,12 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_LIGHT:
> -			*val = 0; /* one ALS count is 0.32 Lux */
> -			*val2 = 320000;
> -			break;
> +			/* one ALS count is 0.32 Lux @ gain 1, IT 100 ms */
> +			*val = 32000; /* 0.32 * 1000 * 100 */
> +			*val2 = data->als_gain_milli * data->als_it_ms;
> +
> +			return IIO_VAL_FRACTIONAL;
> +
>  		case IIO_DISTANCE:
>  			*val = 0; /* sensor reports mm, scale to meter */
>  			*val2 = 1000;

