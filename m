Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51361 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdANM6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 07:58:14 -0500
Subject: Re: [PATCHv2 1/2] iio: Documentation: Add proximity unit
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20170111155139.6559-1-enric.balletbo@collabora.com>
Cc: lars@metafoo.de, Matt Ranostay <mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2571c4a3-8fec-14e1-5fed-072c1f3c7d44@kernel.org>
Date: Sat, 14 Jan 2017 12:58:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170111155139.6559-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/17 15:51, Enric Balletbo i Serra wrote:
> To follow iio guidelines Where possible we stick to the raw SI unit, so
> specify meters for proximity.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Please remember to add a change log to later versions of patch sets.
Saves reviewers who typically have the memory of goldfish (well I do
anyway) having to read old emails to check what they found last time!

This patch is fine on it's own.  Effectively allows us to drop the
custom attribute description in sysfs-bus-iio-proximit-as3935 as well.
(Matt cc'd)

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b8f220f..1bd8ed1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1245,7 +1245,8 @@ Description:
>  		reflectivity of infrared or ultrasound emitted.
>  		Often these sensors are unit less and as such conversion
>  		to SI units is not possible. Higher proximity measurements
> -		indicate closer objects, and vice versa.
> +		indicate closer objects, and vice versa. Units after
> +		application of scale and offset are meters.
>  
>  What:		/sys/.../iio:deviceX/in_illuminance_input
>  What:		/sys/.../iio:deviceX/in_illuminance_raw
> 

