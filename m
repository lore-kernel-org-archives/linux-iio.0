Return-Path: <SRS0=goi+=EB=martingkelly.com=martin@kernel.org>
Subject: Re: [PATCH] iio: gyro: st_gyro: add support for the LSM9DS1
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Denis Ciocca <denis.ciocca@st.com>, Linus Walleij <linus.walleij@linaro.org>
References: <20171231210652.18820-1-martin@martingkelly.com>
 <20180101104245.694a76fa@archlinux>
 <5259dcaa-0606-5094-3505-9c6a790d7488@martingkelly.com>
 <20180102123041.00000971@huawei.com>
 <92903d89-f3f6-38ce-845a-a88fa1297b50@martingkelly.com>
 <CAA2SeNLvXPh-JP5HPam0zn=LpS2DM30s1baMQc-s1PnFq+cS6Q@mail.gmail.com>
 <2f194bf5-ab73-91ac-ff8c-3b039b074468@martingkelly.com>
 <CAA2SeNLzs+EDD024qf=LirFYp=T6VR7qPNko2L+hKmxA9vXV2A@mail.gmail.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <cabb6b7a-6ad0-88ad-04df-9bbec2eff398@martingkelly.com>
Date: Sat, 6 Jan 2018 12:24:00 -0800
MIME-Version: 1.0
In-Reply-To: <CAA2SeNLzs+EDD024qf=LirFYp=T6VR7qPNko2L+hKmxA9vXV2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/05/2018 01:07 AM, Lorenzo Bianconi wrote:
>> On 01/04/2018 01:22 AM, Lorenzo Bianconi wrote:
>>>>
>>>> On 01/02/2018 04:30 AM, Jonathan Cameron wrote:
>>>>>
>>>>>
>>>>> On Mon, 1 Jan 2018 11:32:21 -0800
>>>>> Martin Kelly <martin@martingkelly.com> wrote:
>>>>>
>>>>>> On 01/01/2018 02:42 AM, Jonathan Cameron wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Sun, 31 Dec 2017 13:06:52 -0800
>>>>>>> Martin Kelly <martin@martingkelly.com> wrote:
>>>>>>>
>>>>>>>>
>>>>>>>> From: Martin Kelly <martin@martingkelly.com>
>>>>>>>>
>>>>>>>> Update the sensor settings to support the LSM9DS1 sensor.
>>>>>>>>
>>>>>>>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi Martin,
>>>>>>>
>>>>>>> I'm rather unsure if we should be adding more gyro only
>>>>>>> support for these devices.  Ths lsm9ds0 was in theory
>>>>>>> a stop gap whilst support was properly sorted out.
>>>>>>>
>>>>>>> Looking back Crestez did post an RFC for each of the
>>>>>>> parts as well for reference but made the point that this was
>>>>>>> the wrong way to do things.
>>>>>>>
>>>>>>> This part (and the ds0) really need to be supported by a proper
>>>>>>> gyro/accel
>>>>>>> driver rather than just cherry picking out the gyro part.
>>>>>>>
>>>>>>> We are stuck having to maintain precise backwards compatibility
>>>>>>> for the ds0 part by the fact it is upstream already.  I'm not
>>>>>>> particularly keen to make things worse.
>>>>>>>
>>>>>>> https://patchwork.kernel.org/patch/8824981/
>>>>>>> https://marc.info/?t=146057421800001&r=1&w=4
>>>>>>>
>>>>>>> Looking at the datasheet this is a mess of a device.
>>>>>>>
>>>>>>> The accel and gyro feed one fifo, the magnetometer only supports
>>>>>>> direct access. The magnetometer is effectively a separate part
>>>>>>> so supporting that should be easy enough.
>>>>>>>
>>>>>>> Denis, did your rework of the st driver to support these dual
>>>>>>> devices get anywhere?
>>>>>>>
>>>>>>> Anyhow, lets hold this one for now until we hear from Denis or
>>>>>>> someone else at ST on the current status of supporting these
>>>>>>> properly.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Sure, I'll wait for Denis. It seems to me we have two possible
>>>>>> situations:
>>>>>>
>>>>>> (1) A proper combo driver is ready soon, or can be made to work with
>>>>>> not
>>>>>> much more effort than extending the current driver. In this case, I
>>>>>> should rewrite the patch to use the combo driver, or wait until the
>>>>>> combo driver is available. I'm not sure if the proper combo driver is
>>>>>> something Denis is working on or if it's Lorenzo's driver.
>>>>>>
>>>>>> (2) The combo driver won't be ready for a while, or it takes a large
>>>>>> refactor to make it work with the LSM9X combo devices. In this case, it
>>>>>> seems to me that adding another device should not significantly
>>>>>> increase
>>>>>> maintenance burden, as the main maintenance is in maintaining the
>>>>>> infrastructure rather than the settings struct for each device itself.
>>>>>> We still need to solve the need for a proper combo driver, but in the
>>>>>> meantime (which could be a while), we'll have support for a new device,
>>>>>> which is good for everyone.
>>>>>
>>>>>
>>>>>
>>>>> The issue is not so much code maintenance but rather the fact that any
>>>>> new driver that supports the combo modes will inherently add some
>>>>> degree of ABI change to userspace (even if it is just the name of the
>>>>> device changing).  Definitely less than ideal given in theory we
>>>>> guarantee never to break userspace - however fragile that userspace
>>>>> is...  Honestly I should never have taken the first part that does
>>>>> this but clearly had a weak moment.
>>>>>
>>>>> Jonathan
>>>>>
>>>>
>>>> OK, makes sense. It sounds like if I want to get the LSM9DS1 supported, I
>>>> should help out with the combo driver work and get it supported properly
>>>> with accel+gyro. Is that right?
>>>
>>>
>>> I have a couple of trivial st_lsm6dsx queued patches that would help
>>> Martin to add  LSM9DS{0,1}
>>> support to st_lsm6dsx (they are not related to LSM9DS{0,1}, just
>>> modify the driver to be more general respect to FIFO parsing).
>>> I will send them as soon as regmap patchset has been reviewed.
>>>
>>> Regards,
>>> Lorenzo
>>>
>>
>> Thanks Lorenzo. Is the st_lsm6dsx the right place to add support for an
>> LSM9DSX combo driver, or is Dennis working on something as well? If the
>> st_lsm6dsx is the right place, could you give me a high-level overview of
>> what's needed to make that support possible?
>>
> 
> st_lsm6dsx has been done to support new ST combo devices (accel + gyro) like
> LSM6DSM (starting from LSM6DS3), so theoretically yes, but I do not know
> how LSM9DSx FIFO management and register map are different respect to
> newer combo devices (and so the effort to support them).
> I need to carefully review the ds first.
> 
> Regards,
> Lorenzo
> 

Thanks, let me know if you reach a conclusion either way. If I get the 
time (this is my hobby project), I would like to help add support for 
LSM9DSX, whether that means a new combo driver or generalizing the 
existing LSM6DSX driver.

>>
>>>>
>>>>
>>>>>>
>>>>>>> Jonathan
>>>>>>>
>>>>>>>>
>>>>>>>> ---
>>>>>>>>      .../devicetree/bindings/iio/st-sensors.txt         |  1 +
>>>>>>>>      drivers/iio/gyro/Kconfig                           |  3 +-
>>>>>>>>      drivers/iio/gyro/st_gyro.h                         |  1 +
>>>>>>>>      drivers/iio/gyro/st_gyro_core.c                    | 95
>>>>>>>> ++++++++++++++++++++++
>>>>>>>>      drivers/iio/gyro/st_gyro_i2c.c                     |  5 ++
>>>>>>>>      drivers/iio/gyro/st_gyro_spi.c                     |  5 ++
>>>>>>>>      6 files changed, 109 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt
>>>>>>>> b/Documentation/devicetree/bindings/iio/st-sensors.txt
>>>>>>>> index 6f626f73417e..e3d2b5d5d707 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
>>>>>>>> @@ -59,6 +59,7 @@ Gyroscopes:
>>>>>>>>      - st,l3g4is-gyro
>>>>>>>>      - st,lsm330-gyro
>>>>>>>>      - st,lsm9ds0-gyro
>>>>>>>> +- st,lsm9ds1-gyro
>>>>>>>>         Magnetometers:
>>>>>>>>      - st,lsm303agr-magn
>>>>>>>> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
>>>>>>>> index 3126cf05e6b9..0d63c84c5312 100644
>>>>>>>> --- a/drivers/iio/gyro/Kconfig
>>>>>>>> +++ b/drivers/iio/gyro/Kconfig
>>>>>>>> @@ -111,7 +111,8 @@ config IIO_ST_GYRO_3AXIS
>>>>>>>>           select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>>>>>>>>           help
>>>>>>>>             Say yes here to build support for STMicroelectronics
>>>>>>>> gyroscopes:
>>>>>>>> -         L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330,
>>>>>>>> LSM9DS0.
>>>>>>>> +         L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330,
>>>>>>>> LSM9DS0,
>>>>>>>> +          LSM9DS1.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Please copy the spaces vs tabs in Kconfig >
>>>>>>
>>>>>>
>>>>>>
>>>>>> Ooops, will do if we go forward with the patch as-is.
>>>>>>
>>>>>>>>             This driver can also be built as a module. If so, these
>>>>>>>> modules
>>>>>>>>             will be created:
>>>>>>>> diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
>>>>>>>> index 48923ae6ac3b..f89de446d066 100644
>>>>>>>> --- a/drivers/iio/gyro/st_gyro.h
>>>>>>>> +++ b/drivers/iio/gyro/st_gyro.h
>>>>>>>> @@ -23,6 +23,7 @@
>>>>>>>>      #define L3G4IS_GYRO_DEV_NAME         "l3g4is_ui"
>>>>>>>>      #define LSM330_GYRO_DEV_NAME         "lsm330_gyro"
>>>>>>>>      #define LSM9DS0_GYRO_DEV_NAME                "lsm9ds0_gyro"
>>>>>>>> +#define LSM9DS1_GYRO_DEV_NAME          "lsm9ds1_gyro"
>>>>>>>>         /**
>>>>>>>>       * struct st_sensors_platform_data - gyro platform data
>>>>>>>> diff --git a/drivers/iio/gyro/st_gyro_core.c
>>>>>>>> b/drivers/iio/gyro/st_gyro_core.c
>>>>>>>> index b31064ba37b9..ebfce311e855 100644
>>>>>>>> --- a/drivers/iio/gyro/st_gyro_core.c
>>>>>>>> +++ b/drivers/iio/gyro/st_gyro_core.c
>>>>>>>> @@ -56,6 +56,23 @@ static const struct iio_chan_spec
>>>>>>>> st_gyro_16bit_channels[] = {
>>>>>>>>           IIO_CHAN_SOFT_TIMESTAMP(3)
>>>>>>>>      };
>>>>>>>>      +/* The LSM9DS1 uses different output registers that the other
>>>>>>>> chips. */
>>>>>>>> +static const struct iio_chan_spec st_gyro_lsm9ds1_16bit_channels[] =
>>>>>>>> {
>>>>>>>> +       ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
>>>>>>>> +                       BIT(IIO_CHAN_INFO_RAW) |
>>>>>>>> BIT(IIO_CHAN_INFO_SCALE),
>>>>>>>> +                       ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE,
>>>>>>>> 16, 16,
>>>>>>>> +                       0x18),
>>>>>>>> +       ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
>>>>>>>> +                       BIT(IIO_CHAN_INFO_RAW) |
>>>>>>>> BIT(IIO_CHAN_INFO_SCALE),
>>>>>>>> +                       ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE,
>>>>>>>> 16, 16,
>>>>>>>> +                       0x1a),
>>>>>>>> +       ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
>>>>>>>> +                       BIT(IIO_CHAN_INFO_RAW) |
>>>>>>>> BIT(IIO_CHAN_INFO_SCALE),
>>>>>>>> +                       ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE,
>>>>>>>> 16, 16,
>>>>>>>> +                       0x1c),
>>>>>>>> +       IIO_CHAN_SOFT_TIMESTAMP(3)
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>      static const struct st_sensor_settings st_gyro_sensors_settings[]
>>>>>>>> =
>>>>>>>> {
>>>>>>>>           {
>>>>>>>>                   .wai = 0xd3,
>>>>>>>> @@ -285,6 +302,84 @@ static const struct st_sensor_settings
>>>>>>>> st_gyro_sensors_settings[] = {
>>>>>>>>                   .multi_read_bit = true,
>>>>>>>>                   .bootime = 2,
>>>>>>>>           },
>>>>>>>> +       {
>>>>>>>> +               .wai = 0x68,
>>>>>>>> +               .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>>>>>>> +               .sensors_supported = {
>>>>>>>> +                       [0] = LSM9DS1_GYRO_DEV_NAME,
>>>>>>>> +               },
>>>>>>>> +               .ch = (struct iio_chan_spec
>>>>>>>> *)st_gyro_lsm9ds1_16bit_channels,
>>>>>>>> +               .odr = {
>>>>>>>> +                       .addr = 0x10,
>>>>>>>> +                       .mask = 0xe0,
>>>>>>>> +                       .odr_avl = {
>>>>>>>> +                               { .hz = 15, .value = 0x01, },
>>>>>>>> +                               { .hz = 60, .value = 0x02, },
>>>>>>>> +                               { .hz = 119, .value = 0x03, },
>>>>>>>> +                               { .hz = 238, .value = 0x04, },
>>>>>>>> +                               { .hz = 476, .value = 0x05, },
>>>>>>>> +                               { .hz = 952, .value = 0x06, },
>>>>>>>> +                       },
>>>>>>>> +               },
>>>>>>>> +               .pw = {
>>>>>>>> +                       .addr = 0x10,
>>>>>>>> +                       .mask = 0xe0,
>>>>>>>> +                       .value_on =
>>>>>>>> ST_SENSORS_DEFAULT_POWER_ON_VALUE,
>>>>>>>> +                       .value_off =
>>>>>>>> ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
>>>>>>>> +               },
>>>>>>>> +               .enable_axis = {
>>>>>>>> +                       .addr = 0x1e,
>>>>>>>> +                       .mask = 0x38,
>>>>>>>> +               },
>>>>>>>> +               .fs = {
>>>>>>>> +                       .addr = 0x10,
>>>>>>>> +                       .mask = 0x38,
>>>>>>>> +                       .fs_avl = {
>>>>>>>> +                               [0] = {
>>>>>>>> +                                       .num = ST_GYRO_FS_AVL_250DPS,
>>>>>>>> +                                       .value = 0x00,
>>>>>>>> +                                       .gain =
>>>>>>>> IIO_DEGREE_TO_RAD(8750),
>>>>>>>> +                               },
>>>>>>>> +                               [1] = {
>>>>>>>> +                                       .num = ST_GYRO_FS_AVL_500DPS,
>>>>>>>> +                                       .value = 0x01,
>>>>>>>> +                                       .gain =
>>>>>>>> IIO_DEGREE_TO_RAD(17500),
>>>>>>>> +                               },
>>>>>>>> +                               [2] = {
>>>>>>>> +                                       .num =
>>>>>>>> ST_GYRO_FS_AVL_2000DPS,
>>>>>>>> +                                       /* 2 is "Not Available". */
>>>>>>>> +                                       .value = 0x03,
>>>>>>>> +                                       .gain =
>>>>>>>> IIO_DEGREE_TO_RAD(70000),
>>>>>>>> +                               },
>>>>>>>> +                       },
>>>>>>>> +               },
>>>>>>>> +               .bdu = {
>>>>>>>> +                       .addr = 0x22,
>>>>>>>> +                       .mask = 0x40,
>>>>>>>> +               },
>>>>>>>> +               .drdy_irq = {
>>>>>>>> +                       .int1 = {
>>>>>>>> +                               .addr = 0x0c,
>>>>>>>> +                               .mask = 0x02,
>>>>>>>> +                       },
>>>>>>>> +                       .int2 = {
>>>>>>>> +                               .addr = 0x0d,
>>>>>>>> +                               .mask = 0x02,
>>>>>>>> +                       },
>>>>>>>> +                       .addr_ihl = 0x22,
>>>>>>>> +                       .mask_ihl = 0x20,
>>>>>>>> +                       .stat_drdy = {
>>>>>>>> +                               .addr = ST_SENSORS_DEFAULT_STAT_ADDR,
>>>>>>>> +                               .mask = 0x02,
>>>>>>>> +                       },
>>>>>>>> +               },
>>>>>>>> +               .sim = {
>>>>>>>> +                       .addr = 0x22,
>>>>>>>> +                       .value = BIT(3),
>>>>>>>> +               },
>>>>>>>> +               .multi_read_bit = false,
>>>>>>>> +               .bootime = 2,
>>>>>>>> +       },
>>>>>>>>      };
>>>>>>>>         static int st_gyro_read_raw(struct iio_dev *indio_dev,
>>>>>>>> diff --git a/drivers/iio/gyro/st_gyro_i2c.c
>>>>>>>> b/drivers/iio/gyro/st_gyro_i2c.c
>>>>>>>> index b405b82b9177..97faa3ddac17 100644
>>>>>>>> --- a/drivers/iio/gyro/st_gyro_i2c.c
>>>>>>>> +++ b/drivers/iio/gyro/st_gyro_i2c.c
>>>>>>>> @@ -56,6 +56,10 @@ static const struct of_device_id
>>>>>>>> st_gyro_of_match[]
>>>>>>>> = {
>>>>>>>>                   .compatible = "st,lsm9ds0-gyro",
>>>>>>>>                   .data = LSM9DS0_GYRO_DEV_NAME,
>>>>>>>>           },
>>>>>>>> +       {
>>>>>>>> +               .compatible = "st,lsm9ds1-gyro",
>>>>>>>> +               .data = LSM9DS1_GYRO_DEV_NAME,
>>>>>>>> +       },
>>>>>>>>           {},
>>>>>>>>      };
>>>>>>>>      MODULE_DEVICE_TABLE(of, st_gyro_of_match);
>>>>>>>> @@ -104,6 +108,7 @@ static const struct i2c_device_id
>>>>>>>> st_gyro_id_table[] = {
>>>>>>>>           { L3G4IS_GYRO_DEV_NAME },
>>>>>>>>           { LSM330_GYRO_DEV_NAME },
>>>>>>>>           { LSM9DS0_GYRO_DEV_NAME },
>>>>>>>> +       { LSM9DS1_GYRO_DEV_NAME },
>>>>>>>>           {},
>>>>>>>>      };
>>>>>>>>      MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
>>>>>>>> diff --git a/drivers/iio/gyro/st_gyro_spi.c
>>>>>>>> b/drivers/iio/gyro/st_gyro_spi.c
>>>>>>>> index 0b52ed577dc2..7d4661cc260c 100644
>>>>>>>> --- a/drivers/iio/gyro/st_gyro_spi.c
>>>>>>>> +++ b/drivers/iio/gyro/st_gyro_spi.c
>>>>>>>> @@ -61,6 +61,10 @@ static const struct of_device_id
>>>>>>>> st_gyro_of_match[]
>>>>>>>> = {
>>>>>>>>                   .compatible = "st,lsm9ds0-gyro",
>>>>>>>>                   .data = LSM9DS0_GYRO_DEV_NAME,
>>>>>>>>           },
>>>>>>>> +       {
>>>>>>>> +               .compatible = "st,lsm9ds1-gyro",
>>>>>>>> +               .data = LSM9DS1_GYRO_DEV_NAME,
>>>>>>>> +       },
>>>>>>>>           {},
>>>>>>>>      };
>>>>>>>>      MODULE_DEVICE_TABLE(of, st_gyro_of_match);
>>>>>>>> @@ -108,6 +112,7 @@ static const struct spi_device_id
>>>>>>>> st_gyro_id_table[] = {
>>>>>>>>           { L3G4IS_GYRO_DEV_NAME },
>>>>>>>>           { LSM330_GYRO_DEV_NAME },
>>>>>>>>           { LSM9DS0_GYRO_DEV_NAME },
>>>>>>>> +       { LSM9DS1_GYRO_DEV_NAME },
>>>>>>>>           {},
>>>>>>>>      };
>>>>>>>>      MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>>>
>>>
>>
> 
> 
>
