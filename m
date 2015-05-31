Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35716 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbFAVQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:47 -0400
Message-ID: <556B384B.2040703@kernel.org>
Date: Sun, 31 May 2015 17:35:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 10/32] tools:iio:generic_buffer: fix check of errno
References: <cover.1433072539.git.knaack.h@gmx.de> <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> Since errno contains the value of any of the defined error names, a
> negation will not lead to the desired match.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Darn these pesky userspace conventions!

Thanks ;)

Applied.
> ---
>  tools/iio/generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index d52a55a..7e6f3f1 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -321,7 +321,7 @@ int main(int argc, char **argv)
>  				 data,
>  				 toread*scan_size);
>  		if (read_size < 0) {
> -			if (errno == -EAGAIN) {
> +			if (errno == EAGAIN) {
>  				printf("nothing available\n");
>  				continue;
>  			} else
> 

