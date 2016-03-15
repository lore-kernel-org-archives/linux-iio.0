Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35317 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbcCOWFs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2016 18:05:48 -0400
Subject: Re: [PATCH 1/2] iio: mma8452: add i2c_device_id for mma8451
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1457954789-4885-1-git-send-email-martink@posteo.de>
 <1457955194-6222-1-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E88739.6070204@kernel.org>
Date: Tue, 15 Mar 2016 22:05:45 +0000
MIME-Version: 1.0
In-Reply-To: <1457955194-6222-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/16 11:33, Martin Kepplinger wrote:
> This was forgotten about and is added for consistency now
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> I'm sorry, I messed up the first patch. Understandable though, given
> it's complexity.
Took me a disturbingly long time to notice what was wrong.

Applied to the togreg branch of iio.git - pushed out as testing
for the autobuilders to play with it.

Jonathan
> 
> 
>  drivers/iio/accel/mma8452.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 305ed0e..6aa2517 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1535,6 +1535,7 @@ static const struct dev_pm_ops mma8452_pm_ops = {
>  };
>  
>  static const struct i2c_device_id mma8452_id[] = {
> +	{ "mma8451", mma8451 },
>  	{ "mma8452", mma8452 },
>  	{ "mma8453", mma8453 },
>  	{ "mma8652", mma8652 },
> 

