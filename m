Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbaGEKTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Jul 2014 06:19:16 -0400
Message-ID: <53B7D1A5.4050102@kernel.org>
Date: Sat, 05 Jul 2014 11:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@samsung.com>, linux-iio@vger.kernel.org
CC: spk.linux@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 7/7] iio: hid-sensors: Fix compilation warning
References: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com> <1404369852-3255-7-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369852-3255-7-git-send-email-sachin.kamat@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 07:44, Sachin Kamat wrote:
> Move the 'static' keyword to beginning of definition to silence the
> following compilation warning:
> drivers/iio/common/hid-sensors/hid-sensor-attributes.c:34:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,


> ---
>   .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 403dd3d..1614340 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -26,12 +26,12 @@
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
>
> -struct {
> +static struct {
>   	u32 usage_id;
>   	int unit; /* 0 for default others from HID sensor spec */
>   	int scale_val0; /* scale, whole number */
>   	int scale_val1; /* scale, fraction in micros */
> -} static unit_conversion[] = {
> +} unit_conversion[] = {
>   	{HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650},
>   	{HID_USAGE_SENSOR_ACCEL_3D,
>   		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
>

