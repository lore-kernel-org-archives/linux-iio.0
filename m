Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35704 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbFAVQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:44 -0400
Message-ID: <556B34CC.40604@kernel.org>
Date: Sun, 31 May 2015 17:20:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 04/32] tools:iio: free channel-array completely
References: <cover.1433072539.git.knaack.h@gmx.de> <7a72ee8343eeb317432204577f4ee8c689674c76.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <7a72ee8343eeb317432204577f4ee8c689674c76.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> In iio_utils.c build_channel_array() dynamically allocates the string
> generic_name in the current iio_channel_info, which doesn't got freed in
> case of an error.
> This dynamically allocated channel-array is used by generic_buffer, and
> needs to be freed on the error/exit path.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/generic_buffer.c | 8 +++++++-
>  tools/iio/iio_utils.c      | 4 +++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 7859ee9..0410948 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -255,7 +255,7 @@ int main(int argc, char **argv)
>  		       "%siio:device%d/buffer", iio_dir, dev_num);
>  	if (ret < 0) {
>  		ret = -ENOMEM;
> -		goto error_free_triggername;
> +		goto error_free_channels;
>  	}
>  
>  	if (!notrigger) {
> @@ -351,6 +351,12 @@ error_free_data:
>  	free(data);
>  error_free_buf_dir_name:
>  	free(buf_dir_name);
> +error_free_channels:
> +	for (i = num_channels - 1; i >= 0; i--) {
> +		free(channels[i].name);
> +		free(channels[i].generic_name);
> +	}
> +	free(channels);
>  error_free_triggername:
>  	if (datardytrigger)
>  		free(trigger_name);
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index f879ad7..6daf98f 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -410,8 +410,10 @@ int build_channel_array(const char *device_dir,
>  	return 0;
>  
>  error_cleanup_array:
> -	for (i = count - 1;  i >= 0; i--)
> +	for (i = count - 1;  i >= 0; i--) {
>  		free((*ci_array)[i].name);
> +		free((*ci_array)[i].generic_name);
> +	}
>  	free(*ci_array);
>  error_close_dir:
>  	closedir(dp);
> 

