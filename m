Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48930 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeJDWPL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Oct 2018 18:15:11 -0400
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7150: use pointer to shorten the
 line length
To: Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
References: <20181001193223.GD24866@x220.localdomain>
 <20181001193305.GE24866@x220.localdomain>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4549c428-bf12-8e5b-0556-f953b22da89c@metafoo.de>
Date: Thu, 4 Oct 2018 17:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181001193305.GE24866@x220.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/2018 09:33 PM, Slawomir Stepien wrote:
> By using the pointer to channel attribute, we can now make the lines
> short enough to eliminate the checkpatch.pl problem:
> 
>     CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

Hi,

Thanks for the patch. This looks good. But maybe a small suggestion further
improvement.

> ---
>  drivers/staging/iio/cdc/ad7150.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index d16084d7068c..5b5b766a0405 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -102,18 +102,19 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> +	const int *channel = &chan->channel;

Instead of taking a pointer, just take the value of the channel index and
use that. The generated code should be very similar but its a bit nicer to read.
