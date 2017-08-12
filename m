Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbdHLMDk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:03:40 -0400
Date: Sat, 12 Aug 2017 13:02:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: srf08: add buffered to device mode
Message-ID: <20170812130208.2ed84b76@archlinux>
In-Reply-To: <20170802232609.GA15406@arbeit>
References: <20170802232609.GA15406@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 01:26:09 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add INDIO_BUFFER_TRIGGERED and INDIO_BUFFER_SOFTWARE to device mode
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/proximity/srf08.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index a63c272c3b22..ea238ab1066c 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -437,7 +437,9 @@ static int srf08_probe(struct i2c_client *client,
>  
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE
> +				| INDIO_BUFFER_TRIGGERED
Huh.?  Firstly I think only one of these is relevant and secondly
should be merged back into the original patch that added the support.

Also the triggered_buffer setup already set it for you...

So all in all, drop this patch.

Jonathan
> +				| INDIO_BUFFER_SOFTWARE;
>  
>  	/* srf02 is not using sensitivity nor max_range */
>  	if (id->driver_data == SRF02)

