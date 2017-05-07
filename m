Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57475 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdEGV4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:56:06 -0400
Subject: Re: [PATCH 1/2] iio: Documentation: Remove (partially) duplicate line
To: =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
References: <20170501111942.12736-1-stefan.bruens@rwth-aachen.de>
 <075bf6a854ef42dda9078a575084ae72@rwthex-w2-b.rwth-ad.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f60f70d-b0d4-2445-2239-da62fd912185@kernel.org>
Date: Sun, 7 May 2017 14:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <075bf6a854ef42dda9078a575084ae72@rwthex-w2-b.rwth-ad.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/17 12:19, Stefan Brüns wrote:
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied.  These patches are unconnected so shouldn't really
have been sent as a series.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-meas-spec | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
> index 1a6265e92e2f..6d47e548eee5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
> @@ -5,4 +5,3 @@ Description:
>                  Reading returns either '1' or '0'. '1' means that the
>                  battery level supplied to sensor is below 2.25V.
>                  This ABI is available for tsys02d, htu21, ms8607
> -		This ABI is available for htu21, ms8607
> 

