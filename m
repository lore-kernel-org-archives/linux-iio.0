Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46620 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3JLKTk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:19:40 -0400
Message-ID: <52593069.2080908@kernel.org>
Date: Sat, 12 Oct 2013 12:20:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: iio: generic_buffer: initialize ret
References: <1381149748-9341-1-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1381149748-9341-1-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 13:42, Sebastian Andrzej Siewior wrote:
> The `ret´ variable is only initialized in the error case. For some reason
> it was always != 0 while I played with generic_buffer so here is a patch.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Thanks,

Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/Documentation/iio_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index cf32ae0..35154d6 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -502,7 +502,7 @@ inline int find_type_by_name(const char *name, const char *type)
>  
>  inline int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
>  {
> -	int ret;
> +	int ret = 0;
>  	FILE *sysfsfp;
>  	int test;
>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> 
