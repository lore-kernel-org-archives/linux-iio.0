Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbbFAVQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:44 -0400
Message-ID: <556B342A.4050700@kernel.org>
Date: Sun, 31 May 2015 17:17:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 02/32] tools:iio:generic_buffer: free dev_dir_name on
 exit
References: <cover.1433072539.git.knaack.h@gmx.de> <b8a6d2c4d9671026a3386e2d05008a33a0ba87c6.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <b8a6d2c4d9671026a3386e2d05008a33a0ba87c6.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> Make sure to free dev_dir_name in case of an error or regular exit.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/generic_buffer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 15f2a40..7859ee9 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -220,7 +220,7 @@ int main(int argc, char **argv)
>  				       "%s-dev%d", device_name, dev_num);
>  			if (ret < 0) {
>  				ret = -ENOMEM;
> -				goto error_ret;
> +				goto error_free_dev_dir_name;
>  			}
>  		}
>  
> @@ -354,6 +354,8 @@ error_free_buf_dir_name:
>  error_free_triggername:
>  	if (datardytrigger)
>  		free(trigger_name);
> +error_free_dev_dir_name:
> +	free(dev_dir_name);
>  error_ret:
>  	return ret;
>  }
> 

