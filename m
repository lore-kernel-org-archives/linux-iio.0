Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934492AbeCGUsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:48:11 -0500
Date: Wed, 7 Mar 2018 20:48:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 08/11] Staging: iio: accel: Use switch statement than
 if-else
Message-ID: <20180307204805.44ae9eac@archlinux>
In-Reply-To: <1520236170-14668-9-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-9-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:27 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use switch statement instead of if-else pair to explicitly match
> the only two channels present.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
I think this is going to generate some warnings in the various static
analysers as they will point out there are lots of values channel can
take that aren't handled by the switch statement..  You should have
a default.

(This is what made Dan less than convinced of whether this was a good
change when I originally suggested it)  I still think it's a marginal
improvement in making it explicit that we only have two valid choices
though - and Dan didn't care strongly about it.

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 1737708..307d4ab 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -114,12 +114,15 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> +			switch (chan->channel) {
> +			case 0:
>  				*val = 1;
>  				*val2 = 220000;
> -			} else {
> +				break;
> +			case 1:
>  				*val = 0;
>  				*val2 = 610000;
> +				break;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:

