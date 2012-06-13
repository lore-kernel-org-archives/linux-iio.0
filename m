Return-Path: <pmeerw@pmeerw.net>
Date: Thu, 14 Jun 2012 00:09:14 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jon Brenner <jbrenner@taosinc.com>
cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] IIO channel type and modifiers for CCT and RGBC
 data
In-Reply-To: <1337183202.6344.1.camel@jonz-ub2>
Message-ID: <alpine.DEB.2.01.1206140006370.29697@pmeerw.net>
References: <1337183202.6344.1.camel@jonz-ub2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add iio channel type and modifiers for Correlated Color Temperature (CCT)
> and RGBC (red/green/blue/clear) data.

> +What:		/sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
> +What:		/sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
> +What:		/sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
> +What:		/sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
> +KernelVersion:	3.4.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This property is supported by sensors that have a RGBC
> +		sensing mode. This value should be the output from a reading
> +		and if expressed in SI units, should include _input. If this
> +		value is not in SI units (irradiance, uW/mm), then it should
> +		include _raw.

should the irradiance unit be uW/mm^2 ??

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
