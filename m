Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:43938 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab2FOMsa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:48:30 -0400
Message-ID: <4FDB2F1C.3080500@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:48:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: sysfs-bus-iio typo
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/14/2012 11:50 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   Documentation/ABI/testing/sysfs-bus-iio |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 05449c6..a3774a7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -122,7 +122,7 @@ Description:
>   		If an axis is specified it generally means that the temperature
>   		sensor is associated with one part of a compound device (e.g.
>   		a gyroscope axis). Units after application of scale and offset
> -		are milli degrees Celsuis.
> +		are milli degrees Celsius.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
>   KernelVersion:	2.6.38

