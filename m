Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41414 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHOPND (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 11:13:03 -0400
Subject: Re: [PATCH] iio: light: us5182d: Add missing error code assignment
 before test
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1470806296-8739-1-git-send-email-christophe.jaillet@wanadoo.fr>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eb543108-e601-6c8b-4158-51b9298d4e5e@kernel.org>
Date: Mon, 15 Aug 2016 16:13:00 +0100
MIME-Version: 1.0
In-Reply-To: <1470806296-8739-1-git-send-email-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/08/16 06:18, Christophe JAILLET wrote:
> It is likely that checking the result of 'pm_runtime_set_active' is
> expected here.
> 
> Fixes: f0e5f57d3ac2 ("iio: light: us8152d: Add power management support")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git. Initially pushed out as testing
for the autobuilders to play with it.

Whilst the fix is obviously correct, the missing assignment just results in
a particular error not being handled rather than a 'bug' as such. Hence
I'm sending this the slow route and it'll hit in the next merge window.

Thanks,

Jonathan
> ---
>  drivers/iio/light/us5182d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 20c40f780964..18cf2e29e4d5 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -894,7 +894,7 @@ static int us5182d_probe(struct i2c_client *client,
>  		goto out_err;
>  
>  	if (data->default_continuous) {
> -		pm_runtime_set_active(&client->dev);
> +		ret = pm_runtime_set_active(&client->dev);
>  		if (ret < 0)
>  			goto out_err;
>  	}
> 

