Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:51192 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbaLRVyI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Dec 2014 16:54:08 -0500
Message-ID: <54934CF8.1090809@gmx.de>
Date: Thu, 18 Dec 2014 22:54:00 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ABI: add clarification for proximity
References: <1418656489-13190-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1418656489-13190-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Vlad Dogaru schrieb am 15.12.2014 um 16:14:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index df5e69e..831db86 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1068,7 +1068,9 @@ Description:
>  		reflectivity of infrared or ultrasound emitted.
>  		Often these sensors are unit less and as such conversion
>  		to SI units is not possible.  Where it is, the units should
> -		be meters.
> +		be meters.  If such a conversion is not possible, the reported
> +		values should behave in the same way as a distance, i.e. lower
> +		values indicate something is closer to the sensor.
>  
>  What:		/sys/.../iio:deviceX/in_illuminanceY_input
>  What:		/sys/.../iio:deviceX/in_illuminanceY_raw
> 

