Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59688 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdCELQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 06:16:35 -0500
Subject: Re: [PATCH v1 1/2] iio: Generalize counting direction modes
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
 <1488379506-23969-2-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fc972f57-3d03-c7b5-f88f-d6e077d17549@kernel.org>
Date: Sun, 5 Mar 2017 11:16:32 +0000
MIME-Version: 1.0
In-Reply-To: <1488379506-23969-2-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/17 14:45, Benjamin Gaignard wrote:
> Move counting direction documentation for 104-quad-8 to sysfs-bus-iio
> to avoid duplicated for other incoming drivers
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Applied to the togreg branch of iio.git and pushed out as testing to
be completely ignored by the autobuilders.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio                    | 14 ++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 |  8 --------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b8f220f..b63723b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1597,3 +1597,17 @@ Description:
>  		provides an absolute positional reference (e.g. a pulse once per
>  		revolution) which may be used to home positional systems as
>  		required.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A list of possible counting directions which are:
> +		- "up"	: counter device is increasing.
> +		- "down": counter device is decreasing.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw counter device counters direction for channel Y.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> index ba67652..322c8da 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> @@ -1,4 +1,3 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count_noise_error_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> @@ -10,13 +9,6 @@ Description:
>  		Discrete set of available values for the respective counter
>  		configuration are listed in this file.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
> -KernelVersion:	4.9
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Read-only attribute that indicates whether the counter for
> -		channel Y is counting up or down.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
>  KernelVersion:	4.9
>  Contact:	linux-iio@vger.kernel.org
> 

