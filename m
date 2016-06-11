Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52340 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcFKQie (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:38:34 -0400
Subject: Re: [PATCH] iio: generic_buffer: Fix --trigger-num option
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <d3181955589a6b6745cb008edbc24d2a1b8b0892.1464980098.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aca4a66a-e317-c727-5980-df75671bdd90@kernel.org>
Date: Sat, 11 Jun 2016 17:38:32 +0100
MIME-Version: 1.0
In-Reply-To: <d3181955589a6b6745cb008edbc24d2a1b8b0892.1464980098.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 19:56, Crestez Dan Leonard wrote:
> Initialize trig_num to -1 and handle trig_num=0 as a valid id.
Good spot.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> Fixes: 7c7e9dad (iio: iio_generic_buffer: Add --trigger-num option)
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  tools/iio/iio_generic_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index e8c3052..0e8a1f7 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -341,7 +341,7 @@ int main(int argc, char **argv)
>  
>  	char *data = NULL;
>  	ssize_t read_size;
> -	int dev_num = -1, trig_num;
> +	int dev_num = -1, trig_num = -1;
>  	char *buffer_access = NULL;
>  	int scan_size;
>  	int noevents = 0;
> @@ -456,7 +456,7 @@ int main(int argc, char **argv)
>  
>  	if (notrigger) {
>  		printf("trigger-less mode selected\n");
> -	} if (trig_num > 0) {
> +	} if (trig_num >= 0) {
>  		char *trig_dev_name;
>  		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
>  		if (ret < 0) {
> 

