Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Tue, 26 Jul 2016 09:48:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with
 late_initcall
Message-ID: <20160726094858.3aa96e18@free-electrons.com>
In-Reply-To: <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
	<1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

On Tue, 26 Jul 2016 09:43:44 +0200, Quentin Schulz wrote:

> -module_platform_driver(iio_hwmon_driver);
> +static struct platform_driver * const drivers[] = {
> +	&iio_hwmon_driver,
> +};
> +
> +static int __init iio_hwmon_late_init(void)
> +{
> +	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));

Why not platform_register_driver() ?

This would avoid the need to declare an array with just one entry.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
