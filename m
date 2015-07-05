Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59768 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbGENYl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:24:41 -0400
Message-ID: <55993017.9090003@kernel.org>
Date: Sun, 05 Jul 2015 14:24:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: tmp006: Check channel info on write
References: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 22:50, Peter Meerwald wrote:
> only SAMP_FREQ is writable
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-for-4.2 branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/temperature/tmp006.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 84a0789..7a80509 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -132,6 +132,9 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
>  	struct tmp006_data *data = iio_priv(indio_dev);
>  	int i;
>  
> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
>  	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
>  		if ((val == tmp006_freqs[i][0]) &&
>  		    (val2 == tmp006_freqs[i][1])) {
> 

