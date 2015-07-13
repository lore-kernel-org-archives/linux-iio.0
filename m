Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:51446 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbbGMStm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jul 2015 14:49:42 -0400
Message-ID: <55A4083C.6030107@gmx.de>
Date: Mon, 13 Jul 2015 20:49:32 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: Re: [PATCH 3/3] tools: iio: Add ARRAY_SIZE macro
References: <cover.1436789446.git.cristina.opriceana@gmail.com> <d636b387c2cee14901733a3d768d10f9cb6782b9.1436789446.git.cristina.opriceana@gmail.com>
In-Reply-To: <d636b387c2cee14901733a3d768d10f9cb6782b9.1436789446.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cristina Opriceana schrieb am 13.07.2015 um 15:20:
> Calculation of the length of an array can be done with the ARRAY_SIZE
> macro to make code more abstract and remove the associated
> checkpatch.pl warning.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/iio_utils.c | 2 +-
>  tools/iio/iio_utils.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 4a7e480..e177f40 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -39,7 +39,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
>  	char *working, *prefix = "";
>  	int i, ret;
>  
> -	for (i = 0; i < sizeof(iio_direction) / sizeof(iio_direction[0]); i++)
> +	for (i = 0; i < ARRAY_SIZE(iio_direction); i++)
>  		if (!strncmp(full_name, iio_direction[i],
>  			     strlen(iio_direction[i]))) {
>  			prefix = iio_direction[i];
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 0866101..f30a109 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -18,6 +18,8 @@
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
>  #define FORMAT_TYPE_FILE "%s_type"
>  
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
> +
>  extern const char *iio_dir;
>  
>  /**
> 

