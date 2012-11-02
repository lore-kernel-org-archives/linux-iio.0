Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45143 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab2KBJqY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 05:46:24 -0400
Message-ID: <5093966F.5030007@kernel.org>
Date: Fri, 02 Nov 2012 09:46:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Accept a leading '+' sign when parsing fixed
 point numbers
References: <1350904515-696-1-git-send-email-lars@metafoo.de> <1350904515-696-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350904515-696-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2012 12:15 PM, Lars-Peter Clausen wrote:
> If we encounter a leading '+' sign just skip over it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Can't say I care either way on this, but it's helpful to you why not...

Added to togreg branch of iio.git

> ---
>  drivers/iio/industrialio-core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fe593bf..5f8ff0d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -432,6 +432,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	if (buf[0] == '-') {
>  		negative = true;
>  		buf++;
> +	} else if (buf[0] == '+') {
> +		buf++;
>  	}
>  
>  	while (*buf) {
> 
