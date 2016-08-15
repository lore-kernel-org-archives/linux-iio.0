Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42270 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcHORdi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:33:38 -0400
Subject: Re: [PATCH] tools: iio: lsiio: enumerate processed channels
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1470105591-1006-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e691d6e0-5957-f476-5ee1-ce45bb406cd2@kernel.org>
Date: Mon, 15 Aug 2016 18:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <1470105591-1006-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/16 03:39, Matt Ranostay wrote:
> Enumerate the processed channels (e.g. *_input) as well the raw channels.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  tools/iio/lsiio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index 3d650e668252..ab0f5cf16025 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -51,7 +51,8 @@ static int dump_channels(const char *dev_dir_name)
>  
>  	while (ent = readdir(dp), ent)
>  		if (check_prefix(ent->d_name, "in_") &&
> -		    check_postfix(ent->d_name, "_raw"))
> +		   (check_postfix(ent->d_name, "_raw") ||
> +		    check_postfix(ent->d_name, "_input")))
>  			printf("   %-10s\n", ent->d_name);
>  
>  	return (closedir(dp) == -1) ? -errno : 0;
> 

