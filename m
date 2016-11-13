Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40395 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbcKMMQL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:16:11 -0500
Subject: Re: [PATCH v4 12/26] staging: iio: tsl2583: combine sysfs
 documentation
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-13-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aa7fd4c1-4800-ce30-0558-ab04f03c145b@kernel.org>
Date: Sun, 13 Nov 2016 12:16:09 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-13-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> There are two separate files describing the tsl2583 sysfs attributes.
> Combine the two files into one. Updated the name of the sysfs attributes
> to match the current ABI.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Applied.
> ---
>  .../Documentation/light/sysfs-bus-iio-light-tsl2583  | 16 +++++++++++++++-
>  .../iio/Documentation/sysfs-bus-iio-light-tsl2583    | 20 --------------------
>  2 files changed, 15 insertions(+), 21 deletions(-)
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> 
> diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> index 470f7ad..a2e1996 100644
> --- a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> +++ b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> @@ -1,6 +1,20 @@
> -What:		/sys/bus/iio/devices/device[n]/in_illuminance0_calibrate
> +What:		/sys/bus/iio/devices/device[n]/in_illuminance_calibrate
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This property causes an internal calibration of the als gain trim
>  		value which is later used in calculating illuminance in lux.
> +
> +What:		/sys/bus/iio/devices/device[n]/in_illuminance_lux_table
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This property gets/sets the table of coefficients
> +		used in calculating illuminance in lux.
> +
> +What:		/sys/bus/iio/devices/device[n]/in_illuminance_input_target
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This property is the known externally illuminance (in lux).
> +		It is used in the process of calibrating the device accuracy.
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> deleted file mode 100644
> index 660781d..0000000
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -What:		/sys/bus/iio/devices/device[n]/lux_table
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property gets/sets the table of coefficients
> -		used in calculating illuminance in lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/illuminance0_calibrate
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property causes an internal calibration of the als gain trim
> -		value which is later used in calculating illuminance in lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/illuminance0_input_target
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property is the known externally illuminance (in lux).
> -		It is used in the process of calibrating the device accuracy.
> 

