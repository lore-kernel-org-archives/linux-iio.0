Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49486 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbcJDIwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2016 04:52:43 -0400
Subject: Re: [PATCH 11/18] staging:iio:accel:sca3000: Fix off by one error in
 axis due to IIO_NO_MOD
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20161003192702.24361-1-jic23@kernel.org>
 <20161003192702.24361-12-jic23@kernel.org>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <90f0dc98-edb6-7651-74f2-d9bfc9ea4030@metafoo.de>
Date: Tue, 4 Oct 2016 10:52:41 +0200
MIME-Version: 1.0
In-Reply-To: <20161003192702.24361-12-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/2016 09:26 PM, Jonathan Cameron wrote:
> Given the introduction of IIO_NO_MOD was prior to the first submission
> prior to IIO entering staging this has been broken for a while.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/accel/sca3000.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
> index 24685a2f224e..e8f43df65142 100644
> --- a/drivers/staging/iio/accel/sca3000.c
> +++ b/drivers/staging/iio/accel/sca3000.c
> @@ -933,16 +933,17 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
>  {
>  	int ret, i;
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	int num = chan->channel2;
> +
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
>  		mutex_lock(&st->lock);
> -		ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
> +		ret = sca3000_read_ctrl_reg(st,
> +					    sca3000_addresses[chan->channel2 - IIO_MOD_X][1]);

How about using channel address? Same comment for similar cases later on.

