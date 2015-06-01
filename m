Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35762 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbFAVQ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:59 -0400
Message-ID: <556C0B4A.8070707@kernel.org>
Date: Mon, 01 Jun 2015 08:35:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 26/32] tools:iio:iio_utils: refactor assignment of is_signed
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <85426b9fbf8cdaafa602984df5d9d1889aeab261.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <85426b9fbf8cdaafa602984df5d9d1889aeab261.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Change the assignment of *is_signed in iioutils_get_type() to a one-liner,
> as already done with *be.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 0524725..c83f4df 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -168,10 +168,7 @@ int iioutils_get_type(unsigned *is_signed,
>  				*mask = ~0;
>  			else
>  				*mask = (1 << *bits_used) - 1;
> -			if (signchar == 's')
> -				*is_signed = 1;
> -			else
> -				*is_signed = 0;
> +			*is_signed = (signchar == 's');
>  			if (fclose(sysfsfp)) {
>  				ret = -errno;
>  				printf("Failed to close %s\n", filename);
> 

