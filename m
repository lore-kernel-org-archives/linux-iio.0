Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58105 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbB1Lni (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Feb 2015 06:43:38 -0500
Message-ID: <54F1A9E8.6060807@kernel.org>
Date: Sat, 28 Feb 2015 11:43:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"s.rawat" <imsaurabhrawat@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Getting error "failed to setup attributes" on Adding Custom Fields
 in accelerometer HID driver
References: <CALwa49sP4Vg_ZNr6UmnZCs7PUxCs=JLDS8nXeBWCGJoJ1QgdoQ@mail.gmail.com> <CALwa49uj+e-=fqkppQPd+NfXwG03+joHqBHGYyjvOWgrmvD-4Q@mail.gmail.com> <CAEnQRZDY171bYoUKHmxhQ46NGQoW_nRozX1uYuA-d-ksrSRiew@mail.gmail.com> <BB876515-98CC-4495-83C1-EB6B03A4BDA0@jic23.retrosnub.co.uk>
In-Reply-To: <BB876515-98CC-4495-83C1-EB6B03A4BDA0@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/02/15 15:14, Jonathan Cameron wrote:
> 
> 
> On 27 February 2015 14:30:13 GMT+00:00, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>> On Fri, Feb 27, 2015 at 3:18 PM, s.rawat <imsaurabhrawat@gmail.com>
>> wrote:
>>> Hi Daniel,
>>> I got a failure in sending last mail to iio mailing list.Can you
>> please fwd
>>> it to that chain while i subscribe my self to it.
>>> Many thanks.
>>
>> Not sure if you need to be subscribed in order to post there.
>>
>> Cc'ed linux-iio, anyway.
> You don't I am forever emailling from random accounts.  If it bounced for a non obvious reason we probably want to check with the vger admins!
> 
> J
Anyhow, now to actually look at the question!
>>
>>>
>>> On Fri, Feb 27, 2015 at 6:45 PM, s.rawat <imsaurabhrawat@gmail.com>
>> wrote:
>>>>
>>>> Do I need to define the all the Usage Tags in the input report of a
>> sensor
>>>> to retrieve minimum any one field or Only a Usage Tag which I wanted
>> to
>>>> retrieve is enough.
>>>> e.g for an input report of an accelerometer which has the below
>>>> fields(added new one in Bold),
>>>>
>>>> HID_USAGE_SENSOR_ACCEL_X_AXIS
>>>> HID_USAGE_SENSOR_ACCEL_Y_AXIS
>>>> HID_USAGE_SENSOR_ACCEL_Z_AXIS
>>>> HID_USAGE_SENSOR_DATA_MOTION_STATE,
>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2
>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_3
>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_4
>>>>
>>>>  I want to retrieve Custom_Value_4 do I also need to define
>> parameters for
>>>> Data_Motion_state, Custom_Value2,Custom_Value3 as well apart from
>>>> Custom_Value4 in the below structure.
>>>>
>>>> enum accel_3d_channel {.. }
>>>> struct accel_3d_state {.. }
>>>> static const struct iio_chan_spec accel_3d_channels[] = { ..}
>>>>
>>>> I did so but was getting error - "failed to setup attributes" but
>> after I
>>>> modified the code in the function : accel_3d_parse_report() like
>> below to
>>>> accommodate all the non Contigous Usage Tags and associated them
>> with their
>>>> channels - *_SCAN_INDEX_* .  I did not get this error but some other
>> error
>>>> (listed at the end of the mail)
>>>>
>>>>
>>>> //First Three channel X,Y and Z whose Usage Tags are contionus -
>>>> 0x200453/54/55
>>>> for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
>>>>
>>>> ret = sensor_hub_input_get_attribute_info(hsdev,
>>>> HID_INPUT_REPORT,
>>>> usage_id,
>>>> HID_USAGE_SENSOR_ACCEL_X_AXIS + i,
>>>> &st->accel[CHANNEL_SCAN_INDEX_X + i]);
>>>>           accel_3d_adjust_channel_bit_mask(channels,
>>>> CHANNEL_SCAN_INDEX_X + i,
>>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
>>>> }
>>>>
>>>> //Fourth channel For Data Motion - 0x200451
>>>> ret = sensor_hub_input_get_attribute_info(hsdev,
>>>> HID_INPUT_REPORT,
>>>> usage_id,
>>>> HID_USAGE_SENSOR_DATA_MOTION_STATE, // For CHANNEL_SCAN_DATA_MOTION
>>>> &st->accel[CHANNEL_SCAN_INDEX_X + i]);
>>>> accel_3d_adjust_channel_bit_mask(channels,
>>>> CHANNEL_SCAN_INDEX_X + i,
>>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
>>>>
>>>> //Last Three Channel for Custom Value 2,3,4 - 0x200545/46/47
>>>> for (i = 0; i <= 2; ++i) {
>>>>
>>>> ret = sensor_hub_input_get_attribute_info(hsdev,
>>>> HID_INPUT_REPORT,
>>>> usage_id,
>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2 + i,
>>>> &st->accel[CHANNEL_SCAN_INDEX_X + i + 4]); //start after
>>>> CHANNEL_SCAN_DATA_MOTION Channel
>>>> accel_3d_adjust_channel_bit_mask(channels,
>>>> CHANNEL_SCAN_INDEX_X + i + 4,
>>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
>>>> }
>>>>
>>>>
>>>>
>>>> But now I am getting a different error :
>>>>
>>>> [13778.127716] iio iio:device4: tried to double register :
>>>> in_accel_x_index
>>>> [13778.127899] hid_sensor_accel_3d HID-SENSOR-200073.3.auto: failed
>> to
>>>> initialize trigger buffer
>>>> [13778.143676] hid_sensor_accel_3d: probe of
>> HID-SENSOR-200073.3.auto
>>>> failed with error -16
>>>>
>>>> I am still figuring out where else Do I have to modify the code in
>> order
>>>> to receive the above custom values ..
>>>> Thanks,
>>>> S
>>>>
>>>>
>>>>
>>>> On Thu, Feb 26, 2015 at 6:54 PM, Daniel Baluta
>> <daniel.baluta@gmail.com>
>>>> wrote:
>>>>>
>>>>> + linux-iio list.
>>>>>
>>>>> On Thu, Feb 26, 2015 at 8:04 AM, s.rawat <imsaurabhrawat@gmail.com>
>>>>> wrote:
>>>>>> I have modified the hid-sensor-accel_3d.c driver to add the
>> custom
>>>>>> fields -
>>>>>> CHANNEL_SCAN_DATA_MOTION and HID_USAGE_SENSOR_DATA_CUSTOM_VALUEX
>> ( X =
>>>>>> 2,3,4).
>>>>>> Below are my modifications :
>>>>>>
>>>>>> enum accel_3d_channel {
>>>>>> CHANNEL_SCAN_INDEX_X,
>>>>>> CHANNEL_SCAN_INDEX_Y,
>>>>>> CHANNEL_SCAN_INDEX_Z,
>>>>>> CHANNEL_SCAN_DATA_MOTION,
>>>>>> CHANNEL_CUSTOM_VALUE_2,
>>>>>> CHANNEL_CUSTOM_VALUE_3,
>>>>>>         CHANNEL_CUSTOM_VALUE_4,
>>>>>> ACCEL_3D_CHANNEL_MAX,
>>>>>>
>>>>>> static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
>>>>>> HID_USAGE_SENSOR_ACCEL_X_AXIS,
>>>>>> HID_USAGE_SENSOR_ACCEL_Y_AXIS,
>>>>>> HID_USAGE_SENSOR_ACCEL_Z_AXIS,
>>>>>> HID_USAGE_SENSOR_DATA_MOTION_STATE,
>>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2,
>>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3,
>>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4
>>>>>> };
>>>>>>
>>>>>>
>>>>>>
>>>>>> /* Channel definitions */
>>>>>> static const struct iio_chan_spec accel_3d_channels[] = {
>>>>>> {
>>>>>> ..
>>>>>> ..
>>>>>> ..
>>>>>> {
>>>>>> .type = IIO_ACCEL,
>>>>>> .modified = 1,
>>>>>> .channel2 = IIO_MOD_X,
>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>> BIT(IIO_CHAN_INFO_SCALE) |
>>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
>>>>>> .scan_index = CHANNEL_SCAN_DATA_MOTION,
>>>>>> },
>>>>>> {
>>>>>> .type = IIO_ACCEL,
>>>>>> .modified = 1,
>>>>>> .channel2 = IIO_MOD_X,
>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>> BIT(IIO_CHAN_INFO_SCALE) |
>>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
>>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_2,
>>>>>> },
>>>>>> {
>>>>>> .type = IIO_ACCEL,
>>>>>> .modified = 1,
>>>>>> .channel2 = IIO_MOD_X,
>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>> BIT(IIO_CHAN_INFO_SCALE) |
>>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
>>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_3,
>>>>>> },
>>>>>> {
>>>>>> .type = IIO_ACCEL,
>>>>>> .modified = 1,
>>>>>> .channel2 = IIO_MOD_X,
>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>> BIT(IIO_CHAN_INFO_SCALE) |
>>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
>>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_4,
>>>>>> }
This channel array will attempt to create a whole load of identical attributes.
in_accel_x_raw for each entry.

I suspect you want is to have
in_accel0_x_raw
in_accel1_x_raw etc?  In which case you'll need to also specify 
.indexed = 1,
.index = N 

That is probably the cause of the error you saw
(it'll also clash on the attribute for the index as seen above!)
>>>>>>
>>>>>>
>>>>>>
>>>>>> /* Capture samples in local storage */
>>>>>> static int accel_3d_capture_sample(struct hid_sensor_hub_device
>> *hsdev,
>>>>>> unsigned usage_id,
>>>>>> size_t raw_len, char *raw_data,
>>>>>> void *priv)
>>>>>> {
>>>>>> struct iio_dev *indio_dev = platform_get_drvdata(priv);
>>>>>> struct accel_3d_state *accel_state = iio_priv(indio_dev);
>>>>>> int offset;
>>>>>> int ret = -EINVAL;
>>>>>>
>>>>>> switch (usage_id) {
>>>>>> case HID_USAGE_SENSOR_ACCEL_X_AXIS:
>>>>>> case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
>>>>>> case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
>>>>>> case HID_USAGE_SENSOR_DATA_MOTION_STATE:
>>>>>>         case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2:
>>>>>>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3:
>>>>>>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4:
>>>>>> offset = usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
>>>>>>
>>>>>>
>>>>>>
>>>>>> /* Parse report which is specific to an usage id*/
>>>>>> static int accel_3d_parse_report(struct platform_device *pdev,
>>>>>> struct hid_sensor_hub_device *hsdev,
>>>>>> struct iio_chan_spec *channels,
>>>>>> unsigned usage_id,
>>>>>> struct accel_3d_state *st)
>>>>>> {
>>>>>> int ret;
>>>>>> int i;
>>>>>>
>>>>>> for (i = 0; i <= CHANNEL_CUSTOM_VALUE_4; ++i) {  //previously <
>>>>>> CHANNEL_SCAN_INDEX_Z
>>>>>> ret = sensor_hub_input_get_attribute_info(hsdev,
>>>>>>
>>>>>>
>>>>>>
>>>>>> After build /insmod i get the following dmesg :
>>>>>>
>>>>>> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto : failed to setup
>>>>>> attributes
>>>>>> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto.failed with error -1
>>>>>>
>>>>>>
>>>>>> I am not getting what else I have to modify to avoid this error
>> .If i
>>>>>> remove
>>>>>> the portion in bold(and use this original code
>>>>>>
>>>>>>
>> :http://lxr.free-electrons.com/source/drivers/iio/accel/hid-sensor-accel-3d.c)
>>>>>> I can happily insert the module without any error and can
>> interact with
>>>>>> the
>>>>>> driver using my application.
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Kernelnewbies mailing list
>>>>>> Kernelnewbies@kernelnewbies.org
>>>>>> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>>>>>>
>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

