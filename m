Return-Path: <SRS0=mZZ1=6U=gmail.com=eballetbo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMHSBOUT2hpcXrSuvRrZfnEXWtN9QfNLqHvM4TCvHPKiokP0Ag@mail.gmail.com>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-2-enric.balletbo@collabora.com> <CAMHSBOUT2hpcXrSuvRrZfnEXWtN9QfNLqHvM4TCvHPKiokP0Ag@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 17 Jul 2017 12:30:30 +0200
Message-ID: <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: cros_ec: Get rid of cros_ec_check_features
 from cros_ec_dev.
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
	Javier Martinez Canillas <martinez.javier@gmail.com>, Guenter Roeck <groeck@chromium.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Gwendal,

2017-07-13 22:33 GMT+02:00 Gwendal Grignou <gwendal@chromium.org>:
> On Wed, Jul 12, 2017 at 3:13 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> The cros_ec_dev driver should be used only to expose the Chrome OS Embedded
>> Controller to user-space and should not be used to add MFD devices by
>> calling mfd_add_devices. This patch moves this logic to the MFD cros_ec
>> driver and removes the MFD bits from the character device driver. Also
>> makes independent the IIO driver from the character device as also has no
>> sense.
>
> cros_ec_dev serves another purpose: it allows to represent an EC that
> does not have a cros_ec structure. It happens when there are several
> EC in a chromebook, and one EC is connected through another EC.
> One example is Samus (Pixel 2): where we have:
>
> (main SOC, Application Processor) AP --> (main Embedded Controller) EC
> ---> (Power Delivery [PD}) EC
>
> We  access to the PD EC via pass-through commands through the main EC.
> Each EC has a cros_ec_dev structure, but only the main EC as a
> cros_ec_device structure (I will forever regret the structure names).
>
> Now form the AP point of view, both ECs use the same protocol. That
> why the sensors and other devcies that are registered by looking at
> the feature fields are registered with cros_ec_dev as their parent.
> Other devices that are registered from the device tree, predating the
> feature field support, are registered with cros_ec_device as their
> parent.
>

Interesting I didn't know that. So are you saying that this patch will
break support for devices like Pixel 2? I tested the patches on
various devices but not on Pixel 2 so could be.

Thanks,
 Enric


> Gwendal.
>
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   8 -
>>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   8 +-
>>  drivers/iio/light/cros_ec_light_prox.c             |   8 -
>>  drivers/iio/pressure/cros_ec_baro.c                |   8 -
>>  drivers/mfd/cros_ec.c                              | 160 ++++++++++++++++++++
>>  drivers/platform/chrome/cros_ec_dev.c              | 161 ---------------------
>>  include/linux/mfd/cros_ec.h                        |   6 +-
>>  7 files changed, 170 insertions(+), 189 deletions(-)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> index 38e8783..9b53a01 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>> @@ -191,19 +191,11 @@ static const struct iio_info ec_sensors_info = {
>>  static int cros_ec_sensors_probe(struct platform_device *pdev)
>>  {
>>         struct device *dev = &pdev->dev;
>> -       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>> -       struct cros_ec_device *ec_device;
>>         struct iio_dev *indio_dev;
>>         struct cros_ec_sensors_state *state;
>>         struct iio_chan_spec *channel;
>>         int ret, i;
>>
>> -       if (!ec_dev || !ec_dev->ec_dev) {
>> -               dev_warn(&pdev->dev, "No CROS EC device found.\n");
>> -               return -EINVAL;
>> -       }
>> -       ec_device = ec_dev->ec_dev;
>> -
>>         indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
>>         if (!indio_dev)
>>                 return -ENOMEM;
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index 416cae5..0cdb64a 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -41,12 +41,13 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  {
>>         struct device *dev = &pdev->dev;
>>         struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>> -       struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>> +       struct cros_ec_device *ec_dev = dev_get_drvdata(pdev->dev.parent);
>>         struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>>
>>         platform_set_drvdata(pdev, indio_dev);
>>
>> -       state->ec = ec->ec_dev;
>> +       state->ec = ec_dev;
>> +
>>         state->msg = devm_kzalloc(&pdev->dev,
>>                                 max((u16)sizeof(struct ec_params_motion_sense),
>>                                 state->ec->max_response), GFP_KERNEL);
>> @@ -59,7 +60,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>
>>         /* Set up the host command structure. */
>>         state->msg->version = 2;
>> -       state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>> +       state->msg->command = EC_CMD_MOTION_SENSE_CMD +
>> +                               sensor_platform->cmd_offset;
>>         state->msg->outsize = sizeof(struct ec_params_motion_sense);
>>
>>         indio_dev->dev.parent = &pdev->dev;
>> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
>> index 7217223..2133ddc 100644
>> --- a/drivers/iio/light/cros_ec_light_prox.c
>> +++ b/drivers/iio/light/cros_ec_light_prox.c
>> @@ -181,19 +181,11 @@ static const struct iio_info cros_ec_light_prox_info = {
>>  static int cros_ec_light_prox_probe(struct platform_device *pdev)
>>  {
>>         struct device *dev = &pdev->dev;
>> -       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>> -       struct cros_ec_device *ec_device;
>>         struct iio_dev *indio_dev;
>>         struct cros_ec_light_prox_state *state;
>>         struct iio_chan_spec *channel;
>>         int ret;
>>
>> -       if (!ec_dev || !ec_dev->ec_dev) {
>> -               dev_warn(dev, "No CROS EC device found.\n");
>> -               return -EINVAL;
>> -       }
>> -       ec_device = ec_dev->ec_dev;
>> -
>>         indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>>         if (!indio_dev)
>>                 return -ENOMEM;
>> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
>> index 48b2a30..dbea18b 100644
>> --- a/drivers/iio/pressure/cros_ec_baro.c
>> +++ b/drivers/iio/pressure/cros_ec_baro.c
>> @@ -126,19 +126,11 @@ static const struct iio_info cros_ec_baro_info = {
>>  static int cros_ec_baro_probe(struct platform_device *pdev)
>>  {
>>         struct device *dev = &pdev->dev;
>> -       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>> -       struct cros_ec_device *ec_device;
>>         struct iio_dev *indio_dev;
>>         struct cros_ec_baro_state *state;
>>         struct iio_chan_spec *channel;
>>         int ret;
>>
>> -       if (!ec_dev || !ec_dev->ec_dev) {
>> -               dev_warn(dev, "No CROS EC device found.\n");
>> -               return -EINVAL;
>> -       }
>> -       ec_device = ec_dev->ec_dev;
>> -
>>         indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>>         if (!indio_dev)
>>                 return -ENOMEM;
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index b0ca5a4c..75a27a6 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -91,6 +91,160 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>>         return cros_ec_cmd_xfer(ec_dev, &buf.msg);
>>  }
>>
>> +static int cros_ec_check_features(struct cros_ec_device *ec_dev, int feature)
>> +{
>> +       struct cros_ec_command *msg;
>> +       int ret;
>> +
>> +       if (ec_dev->features[0] == -1U && ec_dev->features[1] == -1U) {
>> +               /* features bitmap not read yet */
>> +
>> +               msg = kmalloc(sizeof(*msg) + sizeof(ec_dev->features),
>> +                             GFP_KERNEL);
>> +               if (!msg)
>> +                       return -ENOMEM;
>> +
>> +               msg->version = 0;
>> +               msg->command = EC_CMD_GET_FEATURES + ec_p.cmd_offset;
>> +               msg->insize = sizeof(ec_dev->features);
>> +               msg->outsize = 0;
>> +
>> +               ret = cros_ec_cmd_xfer(ec_dev, msg);
>> +               if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> +                       dev_warn(ec_dev->dev, "cannot get EC features: %d/%d\n",
>> +                                ret, msg->result);
>> +                       memset(ec_dev->features, 0, sizeof(ec_dev->features));
>> +               }
>> +
>> +               memcpy(ec_dev->features, msg->data, sizeof(ec_dev->features));
>> +
>> +               dev_dbg(ec_dev->dev, "EC features %08x %08x\n",
>> +                       ec_dev->features[0], ec_dev->features[1]);
>> +
>> +               kfree(msg);
>> +       }
>> +
>> +       return ec_dev->features[feature / 32] & EC_FEATURE_MASK_0(feature);
>> +}
>> +
>> +static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
>> +{
>> +       /*
>> +        * Issue a command to get the number of sensor reported.
>> +        * Build an array of sensors driver and register them all.
>> +        */
>> +       int ret, i, id, sensor_num;
>> +       struct mfd_cell *sensor_cells;
>> +       struct cros_ec_sensor_platform *sensor_platforms;
>> +       int sensor_type[MOTIONSENSE_TYPE_MAX];
>> +       struct ec_params_motion_sense *params;
>> +       struct ec_response_motion_sense *resp;
>> +       struct cros_ec_command *msg;
>> +
>> +       msg = kzalloc(sizeof(struct cros_ec_command) +
>> +                     max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
>> +       if (msg == NULL)
>> +               return;
>> +
>> +       msg->version = 2;
>> +       msg->command = EC_CMD_MOTION_SENSE_CMD + ec_p.cmd_offset;
>> +       msg->outsize = sizeof(*params);
>> +       msg->insize = sizeof(*resp);
>> +
>> +       params = (struct ec_params_motion_sense *)msg->data;
>> +       params->cmd = MOTIONSENSE_CMD_DUMP;
>> +
>> +       ret = cros_ec_cmd_xfer(ec_dev, msg);
>> +       if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> +               dev_warn(ec_dev->dev, "cannot get EC sensor information: %d/%d\n",
>> +                        ret, msg->result);
>> +               goto error;
>> +       }
>> +
>> +       resp = (struct ec_response_motion_sense *)msg->data;
>> +       sensor_num = resp->dump.sensor_count;
>> +       /* Allocate 2 extra sensors in case lid angle or FIFO are needed */
>> +       sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
>> +                              GFP_KERNEL);
>> +       if (sensor_cells == NULL)
>> +               goto error;
>> +
>> +       sensor_platforms = kzalloc(sizeof(struct cros_ec_sensor_platform) *
>> +                 (sensor_num + 1), GFP_KERNEL);
>> +       if (sensor_platforms == NULL)
>> +               goto error_platforms;
>> +
>> +       memset(sensor_type, 0, sizeof(sensor_type));
>> +       id = 0;
>> +       for (i = 0; i < sensor_num; i++) {
>> +               params->cmd = MOTIONSENSE_CMD_INFO;
>> +               params->info.sensor_num = i;
>> +               ret = cros_ec_cmd_xfer(ec_dev, msg);
>> +               if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> +                       dev_warn(ec_dev->dev, "no info for EC sensor %d : %d/%d\n",
>> +                                i, ret, msg->result);
>> +                       continue;
>> +               }
>> +               switch (resp->info.type) {
>> +               case MOTIONSENSE_TYPE_ACCEL:
>> +                       sensor_cells[id].name = "cros-ec-accel";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_BARO:
>> +                       sensor_cells[id].name = "cros-ec-baro";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_GYRO:
>> +                       sensor_cells[id].name = "cros-ec-gyro";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_MAG:
>> +                       sensor_cells[id].name = "cros-ec-mag";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_PROX:
>> +                       sensor_cells[id].name = "cros-ec-prox";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_LIGHT:
>> +                       sensor_cells[id].name = "cros-ec-light";
>> +                       break;
>> +               case MOTIONSENSE_TYPE_ACTIVITY:
>> +                       sensor_cells[id].name = "cros-ec-activity";
>> +                       break;
>> +               default:
>> +                       dev_warn(ec_dev->dev, "unknown type %d\n",
>> +                                resp->info.type);
>> +                       continue;
>> +               }
>> +               sensor_platforms[id].sensor_num = i;
>> +               sensor_platforms[id].cmd_offset = ec_p.cmd_offset;
>> +               sensor_cells[id].id = sensor_type[resp->info.type];
>> +               sensor_cells[id].platform_data = &sensor_platforms[id];
>> +               sensor_cells[id].pdata_size =
>> +                       sizeof(struct cros_ec_sensor_platform);
>> +
>> +               sensor_type[resp->info.type]++;
>> +               id++;
>> +       }
>> +       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
>> +               sensor_platforms[id].sensor_num = sensor_num;
>> +
>> +               sensor_cells[id].name = "cros-ec-angle";
>> +               sensor_cells[id].id = 0;
>> +               sensor_cells[id].platform_data = &sensor_platforms[id];
>> +               sensor_cells[id].pdata_size =
>> +                       sizeof(struct cros_ec_sensor_platform);
>> +               id++;
>> +       }
>> +
>> +       ret = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, sensor_cells,
>> +                             id, NULL, 0, NULL);
>> +       if (ret)
>> +               dev_err(ec_dev->dev, "failed to add EC sensors\n");
>> +
>> +       kfree(sensor_platforms);
>> +error_platforms:
>> +       kfree(sensor_cells);
>> +error:
>> +       kfree(msg);
>> +}
>> +
>>  int cros_ec_register(struct cros_ec_device *ec_dev)
>>  {
>>         struct device *dev = ec_dev->dev;
>> @@ -101,6 +255,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>         ec_dev->max_request = sizeof(struct ec_params_hello);
>>         ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
>>         ec_dev->max_passthru = 0;
>> +       ec_dev->features[0] = -1U; /* Not cached yet */
>> +       ec_dev->features[1] = -1U; /* Not cached yet */
>>
>>         ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
>>         if (!ec_dev->din)
>> @@ -134,6 +290,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>                 goto fail_mfd;
>>         }
>>
>> +       /* Check whether this EC is a sensor hub. */
>> +       if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
>> +               cros_ec_sensors_register(ec_dev);
>> +
>>         if (ec_dev->max_passthru) {
>>                 /*
>>                  * Register a PD device as well on top of this device.
>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
>> index cf6c4f0..bd07df5 100644
>> --- a/drivers/platform/chrome/cros_ec_dev.c
>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>> @@ -90,41 +90,6 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
>>         return ret;
>>  }
>>
>> -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>> -{
>> -       struct cros_ec_command *msg;
>> -       int ret;
>> -
>> -       if (ec->features[0] == -1U && ec->features[1] == -1U) {
>> -               /* features bitmap not read yet */
>> -
>> -               msg = kmalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
>> -               if (!msg)
>> -                       return -ENOMEM;
>> -
>> -               msg->version = 0;
>> -               msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
>> -               msg->insize = sizeof(ec->features);
>> -               msg->outsize = 0;
>> -
>> -               ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>> -               if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> -                       dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
>> -                                ret, msg->result);
>> -                       memset(ec->features, 0, sizeof(ec->features));
>> -               }
>> -
>> -               memcpy(ec->features, msg->data, sizeof(ec->features));
>> -
>> -               dev_dbg(ec->dev, "EC features %08x %08x\n",
>> -                       ec->features[0], ec->features[1]);
>> -
>> -               kfree(msg);
>> -       }
>> -
>> -       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
>> -}
>> -
>>  /* Device file ops */
>>  static int ec_device_open(struct inode *inode, struct file *filp)
>>  {
>> @@ -268,126 +233,6 @@ static void __remove(struct device *dev)
>>         kfree(ec);
>>  }
>>
>> -static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>> -{
>> -       /*
>> -        * Issue a command to get the number of sensor reported.
>> -        * Build an array of sensors driver and register them all.
>> -        */
>> -       int ret, i, id, sensor_num;
>> -       struct mfd_cell *sensor_cells;
>> -       struct cros_ec_sensor_platform *sensor_platforms;
>> -       int sensor_type[MOTIONSENSE_TYPE_MAX];
>> -       struct ec_params_motion_sense *params;
>> -       struct ec_response_motion_sense *resp;
>> -       struct cros_ec_command *msg;
>> -
>> -       msg = kzalloc(sizeof(struct cros_ec_command) +
>> -                     max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
>> -       if (msg == NULL)
>> -               return;
>> -
>> -       msg->version = 2;
>> -       msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>> -       msg->outsize = sizeof(*params);
>> -       msg->insize = sizeof(*resp);
>> -
>> -       params = (struct ec_params_motion_sense *)msg->data;
>> -       params->cmd = MOTIONSENSE_CMD_DUMP;
>> -
>> -       ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>> -       if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> -               dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
>> -                        ret, msg->result);
>> -               goto error;
>> -       }
>> -
>> -       resp = (struct ec_response_motion_sense *)msg->data;
>> -       sensor_num = resp->dump.sensor_count;
>> -       /* Allocate 2 extra sensors in case lid angle or FIFO are needed */
>> -       sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
>> -                              GFP_KERNEL);
>> -       if (sensor_cells == NULL)
>> -               goto error;
>> -
>> -       sensor_platforms = kzalloc(sizeof(struct cros_ec_sensor_platform) *
>> -                 (sensor_num + 1), GFP_KERNEL);
>> -       if (sensor_platforms == NULL)
>> -               goto error_platforms;
>> -
>> -       memset(sensor_type, 0, sizeof(sensor_type));
>> -       id = 0;
>> -       for (i = 0; i < sensor_num; i++) {
>> -               params->cmd = MOTIONSENSE_CMD_INFO;
>> -               params->info.sensor_num = i;
>> -               ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>> -               if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>> -                       dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
>> -                                i, ret, msg->result);
>> -                       continue;
>> -               }
>> -               switch (resp->info.type) {
>> -               case MOTIONSENSE_TYPE_ACCEL:
>> -                       sensor_cells[id].name = "cros-ec-accel";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_BARO:
>> -                       sensor_cells[id].name = "cros-ec-baro";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_GYRO:
>> -                       sensor_cells[id].name = "cros-ec-gyro";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_MAG:
>> -                       sensor_cells[id].name = "cros-ec-mag";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_PROX:
>> -                       sensor_cells[id].name = "cros-ec-prox";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_LIGHT:
>> -                       sensor_cells[id].name = "cros-ec-light";
>> -                       break;
>> -               case MOTIONSENSE_TYPE_ACTIVITY:
>> -                       sensor_cells[id].name = "cros-ec-activity";
>> -                       break;
>> -               default:
>> -                       dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
>> -                       continue;
>> -               }
>> -               sensor_platforms[id].sensor_num = i;
>> -               sensor_cells[id].id = sensor_type[resp->info.type];
>> -               sensor_cells[id].platform_data = &sensor_platforms[id];
>> -               sensor_cells[id].pdata_size =
>> -                       sizeof(struct cros_ec_sensor_platform);
>> -
>> -               sensor_type[resp->info.type]++;
>> -               id++;
>> -       }
>> -       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
>> -               sensor_platforms[id].sensor_num = sensor_num;
>> -
>> -               sensor_cells[id].name = "cros-ec-angle";
>> -               sensor_cells[id].id = 0;
>> -               sensor_cells[id].platform_data = &sensor_platforms[id];
>> -               sensor_cells[id].pdata_size =
>> -                       sizeof(struct cros_ec_sensor_platform);
>> -               id++;
>> -       }
>> -       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
>> -               sensor_cells[id].name = "cros-ec-ring";
>> -               id++;
>> -       }
>> -
>> -       ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
>> -                             NULL, 0, NULL);
>> -       if (ret)
>> -               dev_err(ec->dev, "failed to add EC sensors\n");
>> -
>> -       kfree(sensor_platforms);
>> -error_platforms:
>> -       kfree(sensor_cells);
>> -error:
>> -       kfree(msg);
>> -}
>> -
>>  static int ec_device_probe(struct platform_device *pdev)
>>  {
>>         int retval = -ENOMEM;
>> @@ -402,8 +247,6 @@ static int ec_device_probe(struct platform_device *pdev)
>>         ec->ec_dev = dev_get_drvdata(dev->parent);
>>         ec->dev = dev;
>>         ec->cmd_offset = ec_platform->cmd_offset;
>> -       ec->features[0] = -1U; /* Not cached yet */
>> -       ec->features[1] = -1U; /* Not cached yet */
>>         device_initialize(&ec->class_dev);
>>         cdev_init(&ec->cdev, &fops);
>>
>> @@ -432,10 +275,6 @@ static int ec_device_probe(struct platform_device *pdev)
>>         if (cros_ec_debugfs_init(ec))
>>                 dev_warn(dev, "failed to create debugfs directory\n");
>>
>> -       /* check whether this EC is a sensor hub. */
>> -       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>> -               cros_ec_sensors_register(ec);
>> -
>>         /* Take control of the lightbar from the EC. */
>>         lb_manual_suspend_ctrl(ec, 1);
>>
>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>> index 4e887ba..a4138a5 100644
>> --- a/include/linux/mfd/cros_ec.h
>> +++ b/include/linux/mfd/cros_ec.h
>> @@ -115,6 +115,7 @@ struct cros_ec_command {
>>   * @event_notifier: interrupt event notifier for transport devices.
>>   * @event_data: raw payload transferred with the MKBP event.
>>   * @event_size: size in bytes of the event data.
>> + * @features: stores the EC features.
>>   */
>>  struct cros_ec_device {
>>
>> @@ -150,15 +151,19 @@ struct cros_ec_device {
>>         struct ec_response_get_next_event event_data;
>>         int event_size;
>>         u32 host_event_wake_mask;
>> +       u32 features[2];
>>  };
>>
>>  /**
>>   * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information
>>   *
>>   * @sensor_num: Id of the sensor, as reported by the EC.
>> + * @cmd_offset: offset to apply for each command. Set when
>> + * registering a devicde behind another one.
>>   */
>>  struct cros_ec_sensor_platform {
>>         u8 sensor_num;
>> +       u16 cmd_offset;
>>  };
>>
>>  /* struct cros_ec_platform - ChromeOS EC platform information
>> @@ -192,7 +197,6 @@ struct cros_ec_dev {
>>         struct device *dev;
>>         struct cros_ec_debugfs *debug_info;
>>         u16 cmd_offset;
>> -       u32 features[2];
>>  };
>>
>>  /**
>> --
>> 2.9.3
>>
