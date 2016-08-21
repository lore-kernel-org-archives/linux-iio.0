Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53201 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcHUTai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:30:38 -0400
Subject: Re: [PATCH] iio: ad5755: fix off-by-one on devnr limit check
To: Colin King <colin.king@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1469486401-17839-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1efdfc25-b13d-c383-2346-75b414b32081@kernel.org>
Date: Sun, 21 Aug 2016 20:30:35 +0100
MIME-Version: 1.0
In-Reply-To: <1469486401-17839-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/16 23:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparison for devnr limits is off-by-one, the current check
> allows 0 to AD5755_NUM_CHANNELS and the limit should be in fact
> 0 to AD5755_NUM_CHANNELS - 1.  This can lead to an out of bounds
> write to pdata->dac[devnr]. Fix this by replacing > with >= on the
> comparison.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Lars? 

Looks correct to me.

I'd also like a fixes tag for this if possible.  Guessing it
might well be the original driver introduction but best to be
sure ;)

Jonathan
> ---
>  drivers/iio/dac/ad5755.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 0fde593..5f79682 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -655,7 +655,7 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
>  
>  	devnr = 0;
>  	for_each_child_of_node(np, pp) {
> -		if (devnr > AD5755_NUM_CHANNELS) {
> +		if (devnr >= AD5755_NUM_CHANNELS) {
>  			dev_err(dev,
>  				"There is to many channels defined in DT\n");
>  			goto error_out;
> 

