Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932401AbeCJQSm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 11:18:42 -0500
Date: Sat, 10 Mar 2018 16:18:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tom Lebreux <tomlebreux@cock.li>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio:ad7150: Align arguments to match open
 parenthesis
Message-ID: <20180310161837.626dcf6a@archlinux>
In-Reply-To: <20180308235607.11503-1-tomlebreux@cock.li>
References: <20180308235607.11503-1-tomlebreux@cock.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  8 Mar 2018 18:56:07 -0500
Tom Lebreux <tomlebreux@cock.li> wrote:

> This fixes the following checkpatch.pl CHECK: Alignment should match
> open parenthesis
> 
> Signed-off-by: Tom Lebreux <tomlebreux@cock.li>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Added Signed-off-by.
>  drivers/staging/iio/cdc/ad7150.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 2fe916c48848..d16084d7068c 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -124,8 +124,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int ad7150_read_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir)
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
>  {
>  	int ret;
>  	u8 threshtype;

