Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:41591 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbBZNYV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Feb 2015 08:24:21 -0500
Received: by wevm14 with SMTP id m14so10639017wev.8
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2015 05:24:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALwa49s2icVTEvBiTzW9D_aE0Y0_qhWhggRb5ZNKJ-FOZ=Hj-g@mail.gmail.com>
References: <CALwa49s2icVTEvBiTzW9D_aE0Y0_qhWhggRb5ZNKJ-FOZ=Hj-g@mail.gmail.com>
Date: Thu, 26 Feb 2015 15:24:20 +0200
Message-ID: <CAEnQRZDHJNigK-79AABuXbenyp4SyM8OHFuYg8aH_qet2Ty+8Q@mail.gmail.com>
Subject: Re: Getting error "failed to setup attributes" on Adding Custom
 Fields in accelerometer HID driver
From: Daniel Baluta <daniel.baluta@gmail.com>
To: "s.rawat" <imsaurabhrawat@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

+ linux-iio list.

On Thu, Feb 26, 2015 at 8:04 AM, s.rawat <imsaurabhrawat@gmail.com> wrote:
> I have modified the hid-sensor-accel_3d.c driver to add the custom fields -
> CHANNEL_SCAN_DATA_MOTION and HID_USAGE_SENSOR_DATA_CUSTOM_VALUEX ( X =
> 2,3,4).
> Below are my modifications :
>
> enum accel_3d_channel {
> CHANNEL_SCAN_INDEX_X,
> CHANNEL_SCAN_INDEX_Y,
> CHANNEL_SCAN_INDEX_Z,
> CHANNEL_SCAN_DATA_MOTION,
> CHANNEL_CUSTOM_VALUE_2,
> CHANNEL_CUSTOM_VALUE_3,
>         CHANNEL_CUSTOM_VALUE_4,
> ACCEL_3D_CHANNEL_MAX,
>
> static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
> HID_USAGE_SENSOR_ACCEL_X_AXIS,
> HID_USAGE_SENSOR_ACCEL_Y_AXIS,
> HID_USAGE_SENSOR_ACCEL_Z_AXIS,
> HID_USAGE_SENSOR_DATA_MOTION_STATE,
> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2,
> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3,
> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4
> };
>
>
>
> /* Channel definitions */
> static const struct iio_chan_spec accel_3d_channels[] = {
> {
> ..
> ..
> ..
> {
> .type = IIO_ACCEL,
> .modified = 1,
> .channel2 = IIO_MOD_X,
> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> BIT(IIO_CHAN_INFO_SCALE) |
> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> BIT(IIO_CHAN_INFO_HYSTERESIS),
> .scan_index = CHANNEL_SCAN_DATA_MOTION,
> },
> {
> .type = IIO_ACCEL,
> .modified = 1,
> .channel2 = IIO_MOD_X,
> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> BIT(IIO_CHAN_INFO_SCALE) |
> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> BIT(IIO_CHAN_INFO_HYSTERESIS),
> .scan_index = CHANNEL_CUSTOM_VALUE_2,
> },
> {
> .type = IIO_ACCEL,
> .modified = 1,
> .channel2 = IIO_MOD_X,
> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> BIT(IIO_CHAN_INFO_SCALE) |
> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> BIT(IIO_CHAN_INFO_HYSTERESIS),
> .scan_index = CHANNEL_CUSTOM_VALUE_3,
> },
> {
> .type = IIO_ACCEL,
> .modified = 1,
> .channel2 = IIO_MOD_X,
> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> BIT(IIO_CHAN_INFO_SCALE) |
> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> BIT(IIO_CHAN_INFO_HYSTERESIS),
> .scan_index = CHANNEL_CUSTOM_VALUE_4,
> }
>
>
>
> /* Capture samples in local storage */
> static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> unsigned usage_id,
> size_t raw_len, char *raw_data,
> void *priv)
> {
> struct iio_dev *indio_dev = platform_get_drvdata(priv);
> struct accel_3d_state *accel_state = iio_priv(indio_dev);
> int offset;
> int ret = -EINVAL;
>
> switch (usage_id) {
> case HID_USAGE_SENSOR_ACCEL_X_AXIS:
> case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
> case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
> case HID_USAGE_SENSOR_DATA_MOTION_STATE:
>         case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2:
>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3:
>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4:
> offset = usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
>
>
>
> /* Parse report which is specific to an usage id*/
> static int accel_3d_parse_report(struct platform_device *pdev,
> struct hid_sensor_hub_device *hsdev,
> struct iio_chan_spec *channels,
> unsigned usage_id,
> struct accel_3d_state *st)
> {
> int ret;
> int i;
>
> for (i = 0; i <= CHANNEL_CUSTOM_VALUE_4; ++i) {  //previously <
> CHANNEL_SCAN_INDEX_Z
> ret = sensor_hub_input_get_attribute_info(hsdev,
>
>
>
> After build /insmod i get the following dmesg :
>
> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto : failed to setup attributes
> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto.failed with error -1
>
>
> I am not getting what else I have to modify to avoid this error .If i remove
> the portion in bold(and use this original code
> :http://lxr.free-electrons.com/source/drivers/iio/accel/hid-sensor-accel-3d.c)
> I can happily insert the module without any error and can interact with the
> driver using my application.
>
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
