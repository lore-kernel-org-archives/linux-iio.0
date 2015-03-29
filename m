Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59622 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbbC2AOW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 28 Mar 2015 20:14:22 -0400
Message-ID: <551743D1.90808@gmx.de>
Date: Sun, 29 Mar 2015 01:14:09 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 01/10] iio: core: Introduce ENERGY channel type
References: <1421003416-27557-1-git-send-email-irina.tirdea@intel.com> <1421003416-27557-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1421003416-27557-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb am 11.01.2015 um 20:10:
> Human activity sensors report the energy burnt by the user.
> One of this devices is Freescale's MMA9553L
> (http://www.freescale.com/files/sensors/doc/ref_manual/MMA9553LSWRM.pdf)
> that computes the number of calories based on weight and step rate.
> 
> Introduce a new channel type ENERGY to export these values.
> 

Hi Irina,
annoyingly, some people decided to increase the major version number of the
kernel. Could you take care of updating your introduced instances from 3.20
to 4.0?
Thanks,

Hartmut

> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/linux/iio/types.h               |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 831db86..3311886 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -282,6 +282,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_energy_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_scale
> @@ -1049,6 +1050,15 @@ Description:
>  		For a list of available output power modes read
>  		in_accel_power_mode_available.
>  
> +What:		/sys/.../iio:deviceX/in_energy_input
> +What:		/sys/.../iio:deviceX/in_energy_raw
> +KernelVersion:	3.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the energy value reported by the
> +		device (e.g.: human activity sensors report energy burnt by the
> +		user). Units after application of scale are Joules.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
>  KernelVersion:	3.4.0
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 69feb91..8d2c9ba 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -72,6 +72,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>  	[IIO_ACTIVITY] = "activity",
>  	[IIO_STEPS] = "steps",
> +	[IIO_ENERGY] = "energy",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 904dcbb..26b8a1c 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -32,6 +32,7 @@ enum iio_chan_type {
>  	IIO_HUMIDITYRELATIVE,
>  	IIO_ACTIVITY,
>  	IIO_STEPS,
> +	IIO_ENERGY,
>  };
>  
>  enum iio_modifier {
> 

