Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42097 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1HSMnD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2011 08:43:03 -0400
Message-ID: <4E4E5C3F.6040008@cam.ac.uk>
Date: Fri, 19 Aug 2011 13:51:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/3] iio: capfun: fix typo
References: <1313757716-20557-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1313757716-20557-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/11 13:41, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
Thanks will apply.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio_core.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
> index edc295e..d7eb0d8 100644
> --- a/drivers/staging/iio/iio_core.h
> +++ b/drivers/staging/iio/iio_core.h
> @@ -6,7 +6,7 @@
>   * under the terms of the GNU General Public License version 2 as published by
>   * the Free Software Foundation.
>   *
> - * These definitions are meant for use only within the IIO core, not indvidual
> + * These definitions are meant for use only within the IIO core, not individual
>   * drivers.
>   */
>  

