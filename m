Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35547 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbbKHGkP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 01:40:15 -0500
MIME-Version: 1.0
In-Reply-To: <1446963015-17828-2-git-send-email-mranostay@gmail.com>
References: <1446963015-17828-1-git-send-email-mranostay@gmail.com>
	<1446963015-17828-2-git-send-email-mranostay@gmail.com>
Date: Sun, 8 Nov 2015 15:40:14 +0900
Message-ID: <CAJKOXPe+qoD3=rmxZpHCFdue9EHNjO5NCGk_m+gbMhX8kiYBHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] iio: pulsedlight-lidar-lite: add runtime PM
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2015-11-08 15:10 GMT+09:00 Matt Ranostay <mranostay@gmail.com>:
> Add runtime PM support for the lidar-lite module to enable low power
> mode when last device requested reading is over a second.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 53 ++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 961f9f99..768b944 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -13,7 +13,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
>   *
> - * TODO: runtime pm, interrupt mode, and signal strength reporting
> + * TODO: interrupt mode, and signal strength reporting
>   */
>
>  #include <linux/err.h>
> @@ -21,6 +21,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -37,6 +38,7 @@
>
>  #define LIDAR_REG_DATA_HBYTE   0x0f
>  #define LIDAR_REG_DATA_LBYTE   0x10
> +#define LIDAR_REG_PWR_CONTROL  0x65
>
>  #define LIDAR_DRV_NAME "lidar"
>
> @@ -90,6 +92,12 @@ static inline int lidar_write_control(struct lidar_data *data, int val)
>         return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
>  }
>
> +static inline int lidar_write_power(struct lidar_data *data, int val)
> +{
> +       return i2c_smbus_write_byte_data(data->client,
> +                                        LIDAR_REG_PWR_CONTROL, val);
> +}
> +
>  static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>  {
>         int ret;
> @@ -116,6 +124,8 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>         int tries = 10;
>         int ret;
>
> +       pm_runtime_get_sync(&client->dev);
> +
>         /* start sample */
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>         if (ret < 0) {
> @@ -144,6 +154,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>                 }
>                 ret = -EIO;
>         }
> +       pm_runtime_put_autosuspend(&client->dev);

Now you lost pm_runtime_mark_last_busy() which was present in last version.

Rest looks good.

Best regards,
Krzysztof
