Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56230 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925AbaJXIfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 24 Oct 2014 04:35:07 -0400
Message-ID: <544A0F47.5070605@intel.com>
Date: Fri, 24 Oct 2014 11:35:19 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	opw-kernel@googlegroups.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add ABI documentation for offset and scaled humidity
References: <1414064661-4645-1-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1414064661-4645-1-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/23/2014 02:44 PM, Roberta Dobrescu wrote:
> This patch adds ABI documentation entries for in_humidityrelative_offset
> and in_humidityrelative_scale, since there is at least one user for these,
> Si7005 humidity and temperature sensor driver.
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..ffcadca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -231,6 +231,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
>   What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
>   What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
>   What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> @@ -266,6 +267,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_rot_from_north_magnetic_tilt_comp_sca
>   What:		/sys/bus/iio/devices/iio:deviceX/in_rot_from_north_true_tilt_comp_scale
>   What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
>   What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
>
