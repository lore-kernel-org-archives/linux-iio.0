Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932345AbdJZQVj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:21:39 -0400
Date: Thu, 26 Oct 2017 17:18:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/proximity/srf08: Improve unlocking of a mutex in
 srf08_read_ranging()
Message-ID: <20171026171831.3e8018d2@archlinux>
In-Reply-To: <62f61dbd-b106-1d3f-fb75-3fa87251e6ef@users.sourceforge.net>
References: <62f61dbd-b106-1d3f-fb75-3fa87251e6ef@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 17:00:07 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Oct 2017 16:51:08 +0200
> 
> Add a jump target so that a call of the function "mutex_unlock" is stored
> only once at the end of this function implementation.
> Replace two calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

This simple case is a reasonable change.  A few minor points though.
Firstly, for a given subsystem please look at other patches to identify
the standard formatting used in patch titles.

Secondly make sure you don't make unconnected changes.  Here there
is a whitespace change that should not be here.

Jonathan
> ---
>  drivers/iio/proximity/srf08.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index f2bf783f829a..85957550195b 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -135,8 +135,7 @@ static int srf08_read_ranging(struct srf08_data *data)
>  			SRF08_WRITE_COMMAND, SRF08_CMD_RANGING_CM);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "write command - err: %d\n", ret);
> -		mutex_unlock(&data->lock);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	/*
> @@ -163,20 +162,17 @@ static int srf08_read_ranging(struct srf08_data *data)
>  
>  	if (ret >= 255 || ret <= 0) {
>  		dev_err(&client->dev, "device not ready\n");
> -		mutex_unlock(&data->lock);
> -		return -EIO;
> +		ret = -EIO;
> +		goto unlock;
>  	}
>  
>  	ret = i2c_smbus_read_word_swapped(data->client,
>  						SRF08_READ_ECHO_1_HIGH);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(&client->dev, "cannot read distance: ret=%d\n", ret);
> -		mutex_unlock(&data->lock);
> -		return ret;
> -	}
>  
> +unlock:
>  	mutex_unlock(&data->lock);
> -

Please don't make unconnected white space changes.

>  	return ret;
>  }
>  

