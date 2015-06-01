Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35762 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbFAVRA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:00 -0400
Message-ID: <556C0BD8.6040301@kernel.org>
Date: Mon, 01 Jun 2015 08:38:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 28/32] tools:iio:iio_utils: initialize count during declaration
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <fe981c1a50daa8bd7aef36061cccdd376894fda0.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <fe981c1a50daa8bd7aef36061cccdd376894fda0.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> In build_channel_array(), count can be initialized already during variable
> declaration.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 7c0abb3..dfee1a3 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -312,7 +312,7 @@ int build_channel_array(const char *device_dir,
>  {
>  	DIR *dp;
>  	FILE *sysfsfp;
> -	int count, i;
> +	int count = 0, i;
>  	struct iio_channel_info *current;
>  	int ret;
>  	const struct dirent *ent;
> @@ -370,7 +370,6 @@ int build_channel_array(const char *device_dir,
>  		goto error_close_dir;
>  	}
>  	seekdir(dp, 0);
> -	count = 0;
>  	while (ent = readdir(dp), ent != NULL) {
>  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
>  			   "_en") == 0) {
> 

