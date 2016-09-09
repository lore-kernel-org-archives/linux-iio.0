Return-Path: <linux@roeck-us.net>
Subject: Re: [PATCH v5 1/3] hwmon: iio_hwmon: defer probe when no channel is
 found
To: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com,
 jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-2-git-send-email-quentin.schulz@free-electrons.com>
Cc: thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c29e256c-7bff-ac45-6ee5-1f21a33f22b2@roeck-us.net>
Date: Thu, 8 Sep 2016 21:26:28 -0700
MIME-Version: 1.0
In-Reply-To: <1473344917-1524-2-git-send-email-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/08/2016 07:28 AM, Quentin Schulz wrote:
> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
> properties in the Device Tree or channels whose consumer_dev_name matches
> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> which might be probed after iio_hwmon.
>
> It is better to defer the probe of iio_hwmon if such error is returned by
> iio_channel_get_all in order to let a chance to iio drivers to expose
> channels in iio_map_list.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> v5:
>  - patch re-inserted,
>
Grumble ... applied to -next anyway.

I'll direct any complaints your way ;-)

Guenter
