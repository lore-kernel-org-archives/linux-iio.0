Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35698 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbbFAVQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:44 -0400
Message-ID: <556B348F.3030202@kernel.org>
Date: Sun, 31 May 2015 17:19:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 03/32] tools:iio:iio_utils: free scan_el_dir on exit
References: <cover.1433072539.git.knaack.h@gmx.de> <86123bc570f6eff3b6a0a033cc17a296b3107d45.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <86123bc570f6eff3b6a0a033cc17a296b3107d45.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> In the error path, the string scan_el_dir got freed, while it was missing when
> build_channel_array() finished without errors.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
applied.
> ---
>  tools/iio/iio_utils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 6f64521..f879ad7 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -403,6 +403,7 @@ int build_channel_array(const char *device_dir,
>  	}
>  
>  	closedir(dp);
> +	free(scan_el_dir);
>  	/* reorder so that the array is in index order */
>  	bsort_channel_array_by_index(ci_array, *counter);
>  
> 

