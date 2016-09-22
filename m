Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47858 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031982AbcIVRrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 13:47:13 -0400
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: fix argument '?' option
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
References: <20160921165758.8471-1-mugunthanvnm@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <053fef10-8371-1a94-b4d4-675db99e55e7@kernel.org>
Date: Thu, 22 Sep 2016 18:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <20160921165758.8471-1-mugunthanvnm@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/09/16 17:57, Mugunthan V N wrote:
> When help ('?') option is passed to the command, the help text
> printed but not from '?' switch case of getopt_long() but as a
> invalid argument as below. Fix this by adding '?' to opt_String
> of getopt_long().
> 
> root@am437x-evm:~# ./iio_generic_buffer -?
> ./iio_generic_buffer: invalid option -- '?'
> Usage: generic_buffer [options]...
> Capture, convert and output data from IIO device buffer
>   -a         Auto-activate all available channels
> ...
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Thanks,

Applied to the togreg branch of iio.git, initially pushed
out as testing.

Jonathan
> ---
>  tools/iio/iio_generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index f39c0e9..85e2329 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -352,7 +352,7 @@ int main(int argc, char **argv)
>  
>  	register_cleanup();
>  
> -	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:?", longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
>  			autochannels = AUTOCHANNELS_ENABLED;
> 

