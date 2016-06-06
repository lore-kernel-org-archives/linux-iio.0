Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34182 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcFFMdm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2016 08:33:42 -0400
MIME-Version: 1.0
In-Reply-To: <ee0d9476d1312d63f37e73cb65c38fa7dcd3d265.1464978605.git.leonard.crestez@intel.com>
References: <ee0d9476d1312d63f37e73cb65c38fa7dcd3d265.1464978605.git.leonard.crestez@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 6 Jun 2016 15:33:39 +0300
Message-ID: <CAEnQRZBW_aWawJe5VfnOJ0ZwURtRwSNWEiDMcrjPEWCi==XcZg@mail.gmail.com>
Subject: Re: [PATCH] iio: inv_mpu6050: Fix use-after-free in ACPI code
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 3, 2016 at 9:30 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> In some cases this can result in incorrectly returning a negative value
> from asus_acpi_get_sensor_info and the AK8963 magnetometer failing to
> show up.
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>

Looks good to me. I had to look into the code to see that
cpm is an alias for buffer.pointer, perhaps this should have been
mentioned in the commit message.

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 2771106..f770472 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -56,6 +56,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>         int i;
>         acpi_status status;
>         union acpi_object *cpm;
> +       int ret;
>
>         status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
>         if (ACPI_FAILURE(status))
> @@ -82,10 +83,10 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>                         }
>                 }
>         }
> -
> +       ret = cpm->package.count;
>         kfree(buffer.pointer);
>
> -       return cpm->package.count;
> +       return ret;
>  }
>
>  static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
> --
> 2.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
