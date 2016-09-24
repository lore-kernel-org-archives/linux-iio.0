Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59744 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758922AbcIXQtP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:49:15 -0400
Subject: Re: [PATCH] drivers: iio: mma7660: Fix sparse warning
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
References: <20160922204443.GA5786@localhost.localdomain>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5121a1f7-6b8d-c7a9-79f9-fdd64fb4af4f@kernel.org>
Date: Sat, 24 Sep 2016 17:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <20160922204443.GA5786@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/09/16 21:44, Sandhya Bankar wrote:
> Fixing belows sparse warning :
> 
> drivers/iio/accel/mma7660.c:42:11: warning: symbol 'mma7660_nscale' 
> was not declared. Should it be static?
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Sorry, I just applied an alternative (later :( ) patch that makes
the same change. I'm afraid I tend to read my emails backwards in
time to pick up new versions of patches first, so whilst I'd
normally apply the first poster's version for this sort of patch
I came across the other one and applied it first.

Jonathan
> ---
>  drivers/iio/accel/mma7660.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 03beadf..3a40774 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -39,7 +39,7 @@
>  
>  #define MMA7660_SCALE_AVAIL	"0.467142857"
>  
> -const int mma7660_nscale = 467142857;
> +static const int mma7660_nscale = 467142857;
>  
>  #define MMA7660_CHANNEL(reg, axis) {	\
>  	.type = IIO_ACCEL,	\
> 

