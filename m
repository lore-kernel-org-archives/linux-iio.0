Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbdJNRTg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 13:19:36 -0400
Date: Sat, 14 Oct 2017 18:19:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iio: Clarify meaning of IIO_DISTANCE
 channel type
Message-ID: <20171014181931.44390c11@archlinux>
In-Reply-To: <20171010134847.2175-1-pmeerw@pmeerw.net>
References: <20171010134847.2175-1-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Oct 2017 15:48:46 +0200
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> IIO_DISTANCE is used for two purposes: for pedometers to record the
> distance covered by a walker, and to measure the distance to an object
> 
> IIO_DISTANCE is in meters while IIO_PROXIMITY is a unitless measure
> indirectly proportional to distance (higher value relates to a closer
> object)
> 
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

Hmm. This is clearly an issue for at least one existing driver - in that
the lightening sensor uses proximity for distance to lightening.

However, this is the most common interpretation now.  I would suggest
our best way forward is to add a distance channel to the lightening
driver, but keep the proximity channel there to avoid breaking userspace.

Anyhow, this patch itself is fine.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to completely ignore.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 7eead5f97e02..3fc79185cc56 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1242,9 +1242,9 @@ What:		/sys/.../iio:deviceX/in_distance_raw
>  KernelVersion:	4.0
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		This attribute is used to read the distance covered by the user
> -		since the last reboot while activated. Units after application
> -		of scale are meters.
> +		This attribute is used to read the measured distance to an object
> +		or the distance covered by the user since the last reboot while
> +		activated. Units after application of scale are meters.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
>  KernelVersion:	3.4.0

