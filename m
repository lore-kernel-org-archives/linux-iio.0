Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34541 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbcG2R5f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 13:57:35 -0400
Received: by mail-qk0-f170.google.com with SMTP id o67so97601554qke.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2016 10:57:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469713776-5062-5-git-send-email-enric.balletbo@collabora.com>
References: <1469713776-5062-1-git-send-email-enric.balletbo@collabora.com> <1469713776-5062-5-git-send-email-enric.balletbo@collabora.com>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 29 Jul 2016 10:57:33 -0700
Message-ID: <CABXOdTeogjV+Bc9oJ=iwaEkP9uE5GDvuKstf5pzPpKUVWNRQHw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] platform/chrome: cros_ec_dev - Register cros-ec sensors
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Olof Johansson <olof@lixom.net>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 28, 2016 at 6:49 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Check whether the ChromeOS Embedded Controller is a sensor hub and in
> such case issue a command to get the number of sensors and register them
> all.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

With one nitpick (see below):

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_dev.c | 122 ++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
> index fa5f060..0bec60e 100644
> --- a/drivers/platform/chrome/cros_ec_dev.c
> +++ b/drivers/platform/chrome/cros_ec_dev.c
> @@ -18,6 +18,7 @@
>   */
>
>  #include <linux/fs.h>
> +#include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -265,6 +266,123 @@ static void __remove(struct device *dev)
>         kfree(ec);
>  }
>
> +static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> +{
> +       /*
> +        * Issue a command to get the number of sensor reported.
> +        * Build an array of sensors driver and register them all.
> +        */
> +       int ret, i, id, sensor_num;
> +       struct mfd_cell *sensor_cells;
> +       struct cros_ec_sensor_platform *sensor_platforms;
> +       int sensor_type[MOTIONSENSE_TYPE_MAX];
> +       struct ec_params_motion_sense *params;
> +       struct ec_response_motion_sense *resp;
> +       struct cros_ec_command *msg;
> +
> +       msg = kzalloc(sizeof(struct cros_ec_command) +
> +                     max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> +       if (msg == NULL)
> +               return;
> +
> +       msg->version = 2;
> +       msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +       msg->outsize = sizeof(*params);
> +       msg->insize = sizeof(*resp);
> +
> +       params = (struct ec_params_motion_sense *)msg->data;
> +       params->cmd = MOTIONSENSE_CMD_DUMP;
> +
> +       ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> +       if (ret < 0 || msg->result != EC_RES_SUCCESS) {
> +               dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
> +                        ret, msg->result);
> +               goto error;
> +       }
> +
> +       resp = (struct ec_response_motion_sense *)msg->data;
> +       sensor_num = resp->dump.sensor_count;
> +       /* Allocate 2 extra sensors in case lid angle or FIFO are needed */
> +       sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
> +                              GFP_KERNEL);
> +       if (sensor_cells == NULL)
> +               goto error;
> +
> +       sensor_platforms = kzalloc(sizeof(struct cros_ec_sensor_platform) *
> +                 (sensor_num + 1), GFP_KERNEL);
> +       if (sensor_platforms == NULL)
> +               goto error_platforms;
> +
> +       memset(sensor_type, 0, sizeof(sensor_type));
> +       id = 0;
> +       for (i = 0; i < sensor_num; i++) {
> +               params->cmd = MOTIONSENSE_CMD_INFO;
> +               params->info.sensor_num = i;
> +               ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> +               if ((ret < 0) || msg->result != EC_RES_SUCCESS) {

Unnecessary ( ) around 'ret < 0'.

> +                       dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
> +                                i, ret, msg->result);
> +                       continue;
> +               }
> +               switch (resp->info.type) {
> +               case MOTIONSENSE_TYPE_ACCEL:
> +                       sensor_cells[id].name = "cros-ec-accel";
> +                       break;
> +               case MOTIONSENSE_TYPE_GYRO:
> +                       sensor_cells[id].name = "cros-ec-gyro";
> +                       break;
> +               case MOTIONSENSE_TYPE_MAG:
> +                       sensor_cells[id].name = "cros-ec-mag";
> +                       break;
> +               case MOTIONSENSE_TYPE_PROX:
> +                       sensor_cells[id].name = "cros-ec-prox";
> +                       break;
> +               case MOTIONSENSE_TYPE_LIGHT:
> +                       sensor_cells[id].name = "cros-ec-light";
> +                       break;
> +               case MOTIONSENSE_TYPE_ACTIVITY:
> +                       sensor_cells[id].name = "cros-ec-activity";
> +                       break;
> +               default:
> +                       dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
> +                       continue;
> +               }
> +               sensor_platforms[id].sensor_num = i;
> +               sensor_cells[id].id = sensor_type[resp->info.type];
> +               sensor_cells[id].platform_data = &sensor_platforms[id];
> +               sensor_cells[id].pdata_size =
> +                       sizeof(struct cros_ec_sensor_platform);
> +
> +               sensor_type[resp->info.type]++;
> +               id++;
> +       }
> +       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
> +               sensor_platforms[id].sensor_num = sensor_num;
> +
> +               sensor_cells[id].name = "cros-ec-angle";
> +               sensor_cells[id].id = 0;
> +               sensor_cells[id].platform_data = &sensor_platforms[id];
> +               sensor_cells[id].pdata_size =
> +                       sizeof(struct cros_ec_sensor_platform);
> +               id++;
> +       }
> +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +               sensor_cells[id].name = "cros-ec-ring";
> +               id++;
> +       }
> +
> +       ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> +                             NULL, 0, NULL);
> +       if (ret)
> +               dev_err(ec->dev, "failed to add EC sensors\n");
> +
> +       kfree(sensor_platforms);
> +error_platforms:
> +       kfree(sensor_cells);
> +error:
> +       kfree(msg);
> +}
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>         int retval = -ENOMEM;
> @@ -319,6 +437,10 @@ static int ec_device_probe(struct platform_device *pdev)
>                 goto dev_reg_failed;
>         }
>
> +       /* check whether this EC is a sensor hub. */
> +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> +               cros_ec_sensors_register(ec);
> +
>         return 0;
>
>  dev_reg_failed:
> --
> 2.1.0
>
