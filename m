Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35721 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbbFAVQp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:45 -0400
Message-ID: <556B3732.90808@kernel.org>
Date: Sun, 31 May 2015 17:30:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 07/32] tools:iio:lsiio: add closedir before exit
References: <cover.1433072539.git.knaack.h@gmx.de> <9fc774508b30727ae7576cbc4cae11fa6bfcd93b.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <9fc774508b30727ae7576cbc4cae11fa6bfcd93b.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> In dump_channels() the DIR *dp was left open on exit. Close it and check
> for errors.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/lsiio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index c585440..65a2385 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -56,7 +56,7 @@ static int dump_channels(const char *dev_dir_name)
>  			printf("   %-10s\n", ent->d_name);
>  		}
>  
> -	return 0;
> +	return (closedir(dp) == -1) ? -errno : 0;
>  }
>  
>  static int dump_one_device(const char *dev_dir_name)
> 

