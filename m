Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36271 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbcGDRTp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:19:45 -0400
Subject: Re: [PATCH] iio: Add iio.git tree to MAINTAINERS
To: linux-iio@vger.kernel.org
References: <20160703091803.20451-1-jic23@kernel.org>
Cc: nicolas.iooss_linux@m4x.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f87b3cef-6640-3d7e-df21-6750b623e9e7@kernel.org>
Date: Mon, 4 Jul 2016 18:19:39 +0100
MIME-Version: 1.0
In-Reply-To: <20160703091803.20451-1-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/16 10:18, Jonathan Cameron wrote:
> The tree has been in the same location for a long time.  Putting it in
> MAINTAINERS makes it easy for those new to, or less familiar with IIO
> to find the correct tree to base patches on.
> 
> Mostly basing on staging-next is fine as well unless working on a very
> active driver.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied - I doubt anyone cares enough to 'review' this ;)

Jonathan
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1e4bf3ea8ec..345e75744439 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5785,6 +5785,7 @@ R:	Hartmut Knaack <knaack.h@gmx.de>
>  R:	Lars-Peter Clausen <lars@metafoo.de>
>  R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:	linux-iio@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/
>  F:	drivers/iio/
> 

