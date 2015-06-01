Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbbFAVRA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:00 -0400
Message-ID: <556C0BAC.5030203@kernel.org>
Date: Mon, 01 Jun 2015 08:37:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 27/32] tools:iio:iio_utils: move up reset of sysfsfp
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <564df06b5e0dc5911a68b208eeb0687a772ac5bf.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <564df06b5e0dc5911a68b208eeb0687a772ac5bf.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> In iioutils_get_type() it is logically better fitting to have sysfsfp
> assigned zero right after closing it.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index c83f4df..7c0abb3 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -175,10 +175,10 @@ int iioutils_get_type(unsigned *is_signed,
>  				goto error_free_filename;
>  			}
>  
> +			sysfsfp = 0;
>  			free(filename);
>  
>  			filename = 0;
> -			sysfsfp = 0;
>  		}
>  error_close_sysfsfp:
>  	if (sysfsfp)
> 

