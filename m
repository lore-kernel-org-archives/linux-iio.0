Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35710 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbFAVQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:44 -0400
Message-ID: <556B356C.4070107@kernel.org>
Date: Sun, 31 May 2015 17:23:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 05/32] tools:iio:iio_utils: fix allocation handling
References: <cover.1433072539.git.knaack.h@gmx.de> <acd603a02e641c09eff81c07a012a44a95b3d5f6.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <acd603a02e641c09eff81c07a012a44a95b3d5f6.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> In build_channel_array(), count needs to be decreased in more places since
> current->name and current->generic_name would be freed on the error path,
> although they have not been allocated, yet.
> This also requires to free current->name, when it is allocated, but
> current->generic_name is not yet allocated.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 6daf98f..1c0ca2f 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -334,6 +334,7 @@ int build_channel_array(const char *device_dir,
>  			if (sysfsfp == NULL) {
>  				free(filename);
>  				ret = -errno;
> +				count--;
>  				goto error_cleanup_array;
>  			}
>  			fscanf(sysfsfp, "%i", &current_enabled);
> @@ -353,6 +354,7 @@ int build_channel_array(const char *device_dir,
>  			if (current->name == NULL) {
>  				free(filename);
>  				ret = -ENOMEM;
> +				count--;
>  				goto error_cleanup_array;
>  			}
>  			/* Get the generic and specific name elements */
> @@ -360,6 +362,8 @@ int build_channel_array(const char *device_dir,
>  						     &current->generic_name);
>  			if (ret) {
>  				free(filename);
> +				free(current->name);
> +				count--;
>  				goto error_cleanup_array;
>  			}
>  			ret = asprintf(&filename,
> 

