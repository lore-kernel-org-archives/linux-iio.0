Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44077 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaFNPGh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:06:37 -0400
Message-ID: <539C6572.40805@kernel.org>
Date: Sat, 14 Jun 2014 16:08:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/12] staging:iio: Fix iio_utils.h function prototypes
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>   drivers/staging/iio/Documentation/iio_utils.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index a9cfc06..0973a09 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -633,7 +633,7 @@ error_free:
>
>   int read_sysfs_float(char *filename, char *basedir, float *val)
>   {
> -	float ret = 0;
> +	int ret = 0;
>   	FILE  *sysfsfp;
>   	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>   	if (temp == NULL) {
> @@ -653,9 +653,9 @@ error_free:
>   	return ret;
>   }
>
> -read_sysfs_string(const char *filename, const char *basedir, char *str)
> +int read_sysfs_string(const char *filename, const char *basedir, char *str)
>   {
> -	float ret = 0;
> +	int ret = 0;
>   	FILE  *sysfsfp;
>   	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>   	if (temp == NULL) {
>

