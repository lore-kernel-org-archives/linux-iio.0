Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35750 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbFAVQv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:51 -0400
Message-ID: <556B39D3.6050805@kernel.org>
Date: Sun, 31 May 2015 17:41:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 13/32] tools:iio:iio_utils: check amount of matches
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <88d7a7f972f2ae63457e5dcbfb25306c417715bd.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <88d7a7f972f2ae63457e5dcbfb25306c417715bd.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> fscanf() usually returns the number of input items successfully matched
> and assigned, which can be fewer than provided (or even zero).
> Add a check in iioutils_get_type() to make sure all items are matched.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index f12bc2e..c5b4136 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -144,6 +144,10 @@ int iioutils_get_type(unsigned *is_signed,
>  				ret = -errno;
>  				printf("failed to pass scan type description\n");
>  				goto error_close_sysfsfp;
> +			} else if (ret != 5) {
> +				ret = -EIO;
> +				printf("scan type description didn't match\n");
> +				goto error_close_sysfsfp;
>  			}
>  			*be = (endianchar == 'b');
>  			*bytes = padint / 8;
> 

