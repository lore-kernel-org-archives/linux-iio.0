Return-Path: <imsaurabhrawat@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54F1A9E8.6060807@kernel.org>
References: <CALwa49sP4Vg_ZNr6UmnZCs7PUxCs=JLDS8nXeBWCGJoJ1QgdoQ@mail.gmail.com>
 <CALwa49uj+e-=fqkppQPd+NfXwG03+joHqBHGYyjvOWgrmvD-4Q@mail.gmail.com>
 <CAEnQRZDY171bYoUKHmxhQ46NGQoW_nRozX1uYuA-d-ksrSRiew@mail.gmail.com>
 <BB876515-98CC-4495-83C1-EB6B03A4BDA0@jic23.retrosnub.co.uk> <54F1A9E8.6060807@kernel.org>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Mon, 2 Mar 2015 10:11:43 +0530
Message-ID: <CALwa49unPG+VSqEWueGo5VL9ppYu_EajGqf7zo9=h0D0D+HOJw@mail.gmail.com>
Subject: Re: Getting error "failed to setup attributes" on Adding Custom
 Fields in accelerometer HID driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a1134f2b8f687fb051046d645
List-ID: <linux-iio@vger.kernel.org>

--001a1134f2b8f687fb051046d645
Content-Type: text/plain; charset=UTF-8

On Sat, Feb 28, 2015 at 5:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 27/02/15 15:14, Jonathan Cameron wrote:
> >
> >
> > On 27 February 2015 14:30:13 GMT+00:00, Daniel Baluta <
> daniel.baluta@gmail.com> wrote:
> >> On Fri, Feb 27, 2015 at 3:18 PM, s.rawat <imsaurabhrawat@gmail.com>
> >> wrote:
> >>> Hi Daniel,
> >>> I got a failure in sending last mail to iio mailing list.Can you
> >> please fwd
> >>> it to that chain while i subscribe my self to it.
> >>> Many thanks.
> >>
> >> Not sure if you need to be subscribed in order to post there.
> >>
> >> Cc'ed linux-iio, anyway.
> > You don't I am forever emailling from random accounts.  If it bounced
> for a non obvious reason we probably want to check with the vger admins!
> >
> > J
> Anyhow, now to actually look at the question!
> >>
> >>>
> >>> On Fri, Feb 27, 2015 at 6:45 PM, s.rawat <imsaurabhrawat@gmail.com>
> >> wrote:
> >>>>
> >>>> Do I need to define the all the Usage Tags in the input report of a
> >> sensor
> >>>> to retrieve minimum any one field or Only a Usage Tag which I wanted
> >> to
> >>>> retrieve is enough.
> >>>> e.g for an input report of an accelerometer which has the below
> >>>> fields(added new one in Bold),
> >>>>
> >>>> HID_USAGE_SENSOR_ACCEL_X_AXIS
> >>>> HID_USAGE_SENSOR_ACCEL_Y_AXIS
> >>>> HID_USAGE_SENSOR_ACCEL_Z_AXIS
> >>>> HID_USAGE_SENSOR_DATA_MOTION_STATE,
> >>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2
> >>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_3
> >>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_4
> >>>>
> >>>>  I want to retrieve Custom_Value_4 do I also need to define
> >> parameters for
> >>>> Data_Motion_state, Custom_Value2,Custom_Value3 as well apart from
> >>>> Custom_Value4 in the below structure.
> >>>>
> >>>> enum accel_3d_channel {.. }
> >>>> struct accel_3d_state {.. }
> >>>> static const struct iio_chan_spec accel_3d_channels[] = { ..}
> >>>>
> >>>> I did so but was getting error - "failed to setup attributes" but
> >> after I
> >>>> modified the code in the function : accel_3d_parse_report() like
> >> below to
> >>>> accommodate all the non Contigous Usage Tags and associated them
> >> with their
> >>>> channels - *_SCAN_INDEX_* .  I did not get this error but some other
> >> error
> >>>> (listed at the end of the mail)
> >>>>
> >>>>
> >>>> //First Three channel X,Y and Z whose Usage Tags are contionus -
> >>>> 0x200453/54/55
> >>>> for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
> >>>>
> >>>> ret = sensor_hub_input_get_attribute_info(hsdev,
> >>>> HID_INPUT_REPORT,
> >>>> usage_id,
> >>>> HID_USAGE_SENSOR_ACCEL_X_AXIS + i,
> >>>> &st->accel[CHANNEL_SCAN_INDEX_X + i]);
> >>>>           accel_3d_adjust_channel_bit_mask(channels,
> >>>> CHANNEL_SCAN_INDEX_X + i,
> >>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> >>>> }
> >>>>
> >>>> //Fourth channel For Data Motion - 0x200451
> >>>> ret = sensor_hub_input_get_attribute_info(hsdev,
> >>>> HID_INPUT_REPORT,
> >>>> usage_id,
> >>>> HID_USAGE_SENSOR_DATA_MOTION_STATE, // For CHANNEL_SCAN_DATA_MOTION
> >>>> &st->accel[CHANNEL_SCAN_INDEX_X + i]);
> >>>> accel_3d_adjust_channel_bit_mask(channels,
> >>>> CHANNEL_SCAN_INDEX_X + i,
> >>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> >>>>
> >>>> //Last Three Channel for Custom Value 2,3,4 - 0x200545/46/47
> >>>> for (i = 0; i <= 2; ++i) {
> >>>>
> >>>> ret = sensor_hub_input_get_attribute_info(hsdev,
> >>>> HID_INPUT_REPORT,
> >>>> usage_id,
> >>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2 + i,
> >>>> &st->accel[CHANNEL_SCAN_INDEX_X + i + 4]); //start after
> >>>> CHANNEL_SCAN_DATA_MOTION Channel
> >>>> accel_3d_adjust_channel_bit_mask(channels,
> >>>> CHANNEL_SCAN_INDEX_X + i + 4,
> >>>> st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> >>>> }
> >>>>
> >>>>
> >>>>
> >>>> But now I am getting a different error :
> >>>>
> >>>> [13778.127716] iio iio:device4: tried to double register :
> >>>> in_accel_x_index
> >>>> [13778.127899] hid_sensor_accel_3d HID-SENSOR-200073.3.auto: failed
> >> to
> >>>> initialize trigger buffer
> >>>> [13778.143676] hid_sensor_accel_3d: probe of
> >> HID-SENSOR-200073.3.auto
> >>>> failed with error -16
> >>>>
> >>>> I am still figuring out where else Do I have to modify the code in
> >> order
> >>>> to receive the above custom values ..
> >>>> Thanks,
> >>>> S
> >>>>
> >>>>
> >>>>
> >>>> On Thu, Feb 26, 2015 at 6:54 PM, Daniel Baluta
> >> <daniel.baluta@gmail.com>
> >>>> wrote:
> >>>>>
> >>>>> + linux-iio list.
> >>>>>
> >>>>> On Thu, Feb 26, 2015 at 8:04 AM, s.rawat <imsaurabhrawat@gmail.com>
> >>>>> wrote:
> >>>>>> I have modified the hid-sensor-accel_3d.c driver to add the
> >> custom
> >>>>>> fields -
> >>>>>> CHANNEL_SCAN_DATA_MOTION and HID_USAGE_SENSOR_DATA_CUSTOM_VALUEX
> >> ( X =
> >>>>>> 2,3,4).
> >>>>>> Below are my modifications :
> >>>>>>
> >>>>>> enum accel_3d_channel {
> >>>>>> CHANNEL_SCAN_INDEX_X,
> >>>>>> CHANNEL_SCAN_INDEX_Y,
> >>>>>> CHANNEL_SCAN_INDEX_Z,
> >>>>>> CHANNEL_SCAN_DATA_MOTION,
> >>>>>> CHANNEL_CUSTOM_VALUE_2,
> >>>>>> CHANNEL_CUSTOM_VALUE_3,
> >>>>>>         CHANNEL_CUSTOM_VALUE_4,
> >>>>>> ACCEL_3D_CHANNEL_MAX,
> >>>>>>
> >>>>>> static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
> >>>>>> HID_USAGE_SENSOR_ACCEL_X_AXIS,
> >>>>>> HID_USAGE_SENSOR_ACCEL_Y_AXIS,
> >>>>>> HID_USAGE_SENSOR_ACCEL_Z_AXIS,
> >>>>>> HID_USAGE_SENSOR_DATA_MOTION_STATE,
> >>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2,
> >>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3,
> >>>>>> HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4
> >>>>>> };
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> /* Channel definitions */
> >>>>>> static const struct iio_chan_spec accel_3d_channels[] = {
> >>>>>> {
> >>>>>> ..
> >>>>>> ..
> >>>>>> ..
> >>>>>> {
> >>>>>> .type = IIO_ACCEL,
> >>>>>> .modified = 1,
> >>>>>> .channel2 = IIO_MOD_X,
> >>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> >>>>>> BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>> .scan_index = CHANNEL_SCAN_DATA_MOTION,
> >>>>>> },
> >>>>>> {
> >>>>>> .type = IIO_ACCEL,
> >>>>>> .modified = 1,
> >>>>>> .channel2 = IIO_MOD_X,
> >>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> >>>>>> BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_2,
> >>>>>> },
> >>>>>> {
> >>>>>> .type = IIO_ACCEL,
> >>>>>> .modified = 1,
> >>>>>> .channel2 = IIO_MOD_X,
> >>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> >>>>>> BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_3,
> >>>>>> },
> >>>>>> {
> >>>>>> .type = IIO_ACCEL,
> >>>>>> .modified = 1,
> >>>>>> .channel2 = IIO_MOD_X,
> >>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>>>> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> >>>>>> BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>> BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>> BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>> .scan_index = CHANNEL_CUSTOM_VALUE_4,
> >>>>>> }
>

Jonathan Cameron wrote :

> This channel array will attempt to create a whole load of identical
> attributes.
> in_accel_x_raw for each entry.
>
> I suspect you want is to have
> in_accel0_x_raw
> in_accel1_x_raw etc?  In which case you'll need to also specify
> .indexed = 1,
> .index = N
>
> That is probably the cause of the error you saw
> (it'll also clash on the attribute for the index as seen above!)
>


This channel array will attempt to create a whole load of identical
attributes.
in_accel_x_raw for each entry.


Saurabh :
>>But Now I didn't get any such error like "failed to setup attributes" , I
think attributes has been set fine .Now the problem is in the
initialization of trigger buffer.Is the reason same as you said above.

I still get the same error :

[13778.127716] iio iio:device4: tried to double register : in_accel_x_index
[13778.127899] hid_sensor_accel_3d HID-SENSOR-200073.3.auto: failed to
initialize trigger buffer
[13778.143676] hid_sensor_accel_3d: probe of HID-SENSOR-200073.3.auto
failed with error -16

After I modified like this(in *bold*) for the below channel attributes:

{
 .type = IIO_ACCEL,
 .modified = 1,
*.indexed = 1,*
 .channel2 = IIO_MOD_X,
 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 BIT(IIO_CHAN_INFO_SCALE) |
 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 BIT(IIO_CHAN_INFO_HYSTERESIS),
 .scan_index = CHANNEL_SCAN_DATA_MOTION,
 },
 {
.type = IIO_ACCEL,
 .modified = 1,
*.indexed = 2,*
 .channel2 = IIO_MOD_X,
 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 BIT(IIO_CHAN_INFO_SCALE) |
BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 BIT(IIO_CHAN_INFO_HYSTERESIS),
.scan_index = CHANNEL_CUSTOM_VALUE_2,
 },
 {
 .type = IIO_ACCEL,
 .modified = 1,
*.indexed = 3,*
 .channel2 = IIO_MOD_X,
 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 BIT(IIO_CHAN_INFO_SCALE) |
 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 BIT(IIO_CHAN_INFO_HYSTERESIS),
 .scan_index = CHANNEL_CUSTOM_VALUE_3,
 },
 {
 .type = IIO_ACCEL,
 .modified = 1,
*.indexed = 4,*
 .channel2 = IIO_MOD_X,
 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
BIT(IIO_CHAN_INFO_SCALE) |
 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 BIT(IIO_CHAN_INFO_HYSTERESIS),
 .scan_index = CHANNEL_CUSTOM_VALUE_4,
 }


>From the firmware in the accel input report I sent data_motion, custom
value2,3 and 4 apart from usual x,y and z values.I want to retrieve the
 custom value 2 , 3 and 4 .Once the driver is loaded fine I will modify the
generic_buffer.c application in the drivers/staging/iio/Documentation.




> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> /* Capture samples in local storage */
> >>>>>> static int accel_3d_capture_sample(struct hid_sensor_hub_device
> >> *hsdev,
> >>>>>> unsigned usage_id,
> >>>>>> size_t raw_len, char *raw_data,
> >>>>>> void *priv)
> >>>>>> {
> >>>>>> struct iio_dev *indio_dev = platform_get_drvdata(priv);
> >>>>>> struct accel_3d_state *accel_state = iio_priv(indio_dev);
> >>>>>> int offset;
> >>>>>> int ret = -EINVAL;
> >>>>>>
> >>>>>> switch (usage_id) {
> >>>>>> case HID_USAGE_SENSOR_ACCEL_X_AXIS:
> >>>>>> case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
> >>>>>> case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
> >>>>>> case HID_USAGE_SENSOR_DATA_MOTION_STATE:
> >>>>>>         case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2:
> >>>>>>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3:
> >>>>>>   case HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4:
> >>>>>> offset = usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> /* Parse report which is specific to an usage id*/
> >>>>>> static int accel_3d_parse_report(struct platform_device *pdev,
> >>>>>> struct hid_sensor_hub_device *hsdev,
> >>>>>> struct iio_chan_spec *channels,
> >>>>>> unsigned usage_id,
> >>>>>> struct accel_3d_state *st)
> >>>>>> {
> >>>>>> int ret;
> >>>>>> int i;
> >>>>>>
> >>>>>> for (i = 0; i <= CHANNEL_CUSTOM_VALUE_4; ++i) {  //previously <
> >>>>>> CHANNEL_SCAN_INDEX_Z
> >>>>>> ret = sensor_hub_input_get_attribute_info(hsdev,
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> After build /insmod i get the following dmesg :
> >>>>>>
> >>>>>> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto : failed to setup
> >>>>>> attributes
> >>>>>> hid_sensor_accel_3d:HID-SENSOR-200073.3 auto.failed with error -1
> >>>>>>
> >>>>>>
> >>>>>> I am not getting what else I have to modify to avoid this error
> >> .If i
> >>>>>> remove
> >>>>>> the portion in bold(and use this original code
> >>>>>>
> >>>>>>
> >> :
> http://lxr.free-electrons.com/source/drivers/iio/accel/hid-sensor-accel-3d.c
> )
> >>>>>> I can happily insert the module without any error and can
> >> interact with
> >>>>>> the
> >>>>>> driver using my application.
> >>>>>>
> >>>>>>
> >>>>>> _______________________________________________
> >>>>>> Kernelnewbies mailing list
> >>>>>> Kernelnewbies@kernelnewbies.org
> >>>>>> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
> >>>>>>
> >>>>
> >>>>
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>

--001a1134f2b8f687fb051046d645
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Feb 28, 2015 at 5:13 PM, Jonathan Cameron <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><span class=3D"">On 27/02/15 15:14, =
Jonathan Cameron wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 27 February 2015 14:30:13 GMT+00:00, Daniel Baluta &lt;<a href=3D"m=
ailto:daniel.baluta@gmail.com">daniel.baluta@gmail.com</a>&gt; wrote:<br>
&gt;&gt; On Fri, Feb 27, 2015 at 3:18 PM, s.rawat &lt;<a href=3D"mailto:ims=
aurabhrawat@gmail.com">imsaurabhrawat@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt; Hi Daniel,<br>
&gt;&gt;&gt; I got a failure in sending last mail to iio mailing list.Can y=
ou<br>
&gt;&gt; please fwd<br>
&gt;&gt;&gt; it to that chain while i subscribe my self to it.<br>
&gt;&gt;&gt; Many thanks.<br>
&gt;&gt;<br>
&gt;&gt; Not sure if you need to be subscribed in order to post there.<br>
&gt;&gt;<br>
&gt;&gt; Cc&#39;ed linux-iio, anyway.<br>
&gt; You don&#39;t I am forever emailling from random accounts.=C2=A0 If it=
 bounced for a non obvious reason we probably want to check with the vger a=
dmins!<br>
&gt;<br>
&gt; J<br>
</span>Anyhow, now to actually look at the question!<br>
<div><div class=3D"h5">&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Fri, Feb 27, 2015 at 6:45 PM, s.rawat &lt;<a href=3D"mailto=
:imsaurabhrawat@gmail.com">imsaurabhrawat@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Do I need to define the all the Usage Tags in the input re=
port of a<br>
&gt;&gt; sensor<br>
&gt;&gt;&gt;&gt; to retrieve minimum any one field or Only a Usage Tag whic=
h I wanted<br>
&gt;&gt; to<br>
&gt;&gt;&gt;&gt; retrieve is enough.<br>
&gt;&gt;&gt;&gt; e.g for an input report of an accelerometer which has the =
below<br>
&gt;&gt;&gt;&gt; fields(added new one in Bold),<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_X_AXIS<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_Y_AXIS<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_Z_AXIS<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_MOTION_STATE,<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_3<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_4<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 I want to retrieve Custom_Value_4 do I also need to =
define<br>
&gt;&gt; parameters for<br>
&gt;&gt;&gt;&gt; Data_Motion_state, Custom_Value2,Custom_Value3 as well apa=
rt from<br>
&gt;&gt;&gt;&gt; Custom_Value4 in the below structure.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; enum accel_3d_channel {.. }<br>
&gt;&gt;&gt;&gt; struct accel_3d_state {.. }<br>
&gt;&gt;&gt;&gt; static const struct iio_chan_spec accel_3d_channels[] =3D =
{ ..}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I did so but was getting error - &quot;failed to setup att=
ributes&quot; but<br>
&gt;&gt; after I<br>
&gt;&gt;&gt;&gt; modified the code in the function : accel_3d_parse_report(=
) like<br>
&gt;&gt; below to<br>
&gt;&gt;&gt;&gt; accommodate all the non Contigous Usage Tags and associate=
d them<br>
&gt;&gt; with their<br>
&gt;&gt;&gt;&gt; channels - *_SCAN_INDEX_* .=C2=A0 I did not get this error=
 but some other<br>
&gt;&gt; error<br>
&gt;&gt;&gt;&gt; (listed at the end of the mail)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; //First Three channel X,Y and Z whose Usage Tags are conti=
onus -<br>
&gt;&gt;&gt;&gt; 0x200453/54/55<br>
&gt;&gt;&gt;&gt; for (i =3D 0; i &lt;=3D CHANNEL_SCAN_INDEX_Z; ++i) {<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ret =3D sensor_hub_input_get_attribute_info(hsdev,<br>
&gt;&gt;&gt;&gt; HID_INPUT_REPORT,<br>
&gt;&gt;&gt;&gt; usage_id,<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_X_AXIS + i,<br>
&gt;&gt;&gt;&gt; &amp;st-&gt;accel[CHANNEL_SCAN_INDEX_X + i]);<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_3d_adjust_ch=
annel_bit_mask(channels,<br>
&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_X + i,<br>
&gt;&gt;&gt;&gt; st-&gt;accel[CHANNEL_SCAN_INDEX_X + i].size);<br>
&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; //Fourth channel For Data Motion - 0x200451<br>
&gt;&gt;&gt;&gt; ret =3D sensor_hub_input_get_attribute_info(hsdev,<br>
&gt;&gt;&gt;&gt; HID_INPUT_REPORT,<br>
&gt;&gt;&gt;&gt; usage_id,<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_MOTION_STATE, // For CHANNEL_SCAN_DA=
TA_MOTION<br>
&gt;&gt;&gt;&gt; &amp;st-&gt;accel[CHANNEL_SCAN_INDEX_X + i]);<br>
&gt;&gt;&gt;&gt; accel_3d_adjust_channel_bit_mask(channels,<br>
&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_X + i,<br>
&gt;&gt;&gt;&gt; st-&gt;accel[CHANNEL_SCAN_INDEX_X + i].size);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; //Last Three Channel for Custom Value 2,3,4 - 0x200545/46/=
47<br>
&gt;&gt;&gt;&gt; for (i =3D 0; i &lt;=3D 2; ++i) {<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ret =3D sensor_hub_input_get_attribute_info(hsdev,<br>
&gt;&gt;&gt;&gt; HID_INPUT_REPORT,<br>
&gt;&gt;&gt;&gt; usage_id,<br>
&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2 + i,<br>
&gt;&gt;&gt;&gt; &amp;st-&gt;accel[CHANNEL_SCAN_INDEX_X + i + 4]); //start =
after<br>
&gt;&gt;&gt;&gt; CHANNEL_SCAN_DATA_MOTION Channel<br>
&gt;&gt;&gt;&gt; accel_3d_adjust_channel_bit_mask(channels,<br>
&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_X + i + 4,<br>
&gt;&gt;&gt;&gt; st-&gt;accel[CHANNEL_SCAN_INDEX_X + i].size);<br>
&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; But now I am getting a different error :<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [13778.127716] iio iio:device4: tried to double register :=
<br>
&gt;&gt;&gt;&gt; in_accel_x_index<br>
&gt;&gt;&gt;&gt; [13778.127899] hid_sensor_accel_3d HID-SENSOR-200073.3.aut=
o: failed<br>
&gt;&gt; to<br>
&gt;&gt;&gt;&gt; initialize trigger buffer<br>
&gt;&gt;&gt;&gt; [13778.143676] hid_sensor_accel_3d: probe of<br>
&gt;&gt; HID-SENSOR-200073.3.auto<br>
&gt;&gt;&gt;&gt; failed with error -16<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I am still figuring out where else Do I have to modify the=
 code in<br>
&gt;&gt; order<br>
&gt;&gt;&gt;&gt; to receive the above custom values ..<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; S<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, Feb 26, 2015 at 6:54 PM, Daniel Baluta<br>
&gt;&gt; &lt;<a href=3D"mailto:daniel.baluta@gmail.com">daniel.baluta@gmail=
.com</a>&gt;<br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; + linux-iio list.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Thu, Feb 26, 2015 at 8:04 AM, s.rawat &lt;<a href=
=3D"mailto:imsaurabhrawat@gmail.com">imsaurabhrawat@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; I have modified the hid-sensor-accel_3d.c driver t=
o add the<br>
&gt;&gt; custom<br>
&gt;&gt;&gt;&gt;&gt;&gt; fields -<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_DATA_MOTION and HID_USAGE_SENSOR_DATA=
_CUSTOM_VALUEX<br>
&gt;&gt; ( X =3D<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2,3,4).<br>
&gt;&gt;&gt;&gt;&gt;&gt; Below are my modifications :<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; enum accel_3d_channel {<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_X,<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_Y,<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_Z,<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_DATA_MOTION,<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_CUSTOM_VALUE_2,<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_CUSTOM_VALUE_3,<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CHANNEL_CUSTOM_VA=
LUE_4,<br>
&gt;&gt;&gt;&gt;&gt;&gt; ACCEL_3D_CHANNEL_MAX,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; static const u32 accel_3d_addresses[ACCEL_3D_CHANN=
EL_MAX] =3D {<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_X_AXIS,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_Y_AXIS,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_ACCEL_Z_AXIS,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_MOTION_STATE,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE2,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE3,<br>
&gt;&gt;&gt;&gt;&gt;&gt; HID_USAGE_SENSOR_DATA_CUSTOM_VALUE4<br>
&gt;&gt;&gt;&gt;&gt;&gt; };<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; /* Channel definitions */<br>
&gt;&gt;&gt;&gt;&gt;&gt; static const struct iio_chan_spec accel_3d_channel=
s[] =3D {<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; ..<br>
&gt;&gt;&gt;&gt;&gt;&gt; ..<br>
&gt;&gt;&gt;&gt;&gt;&gt; ..<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; .type =3D IIO_ACCEL,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .modified =3D 1,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .channel2 =3D IIO_MOD_X,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OF=
FSET) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SCALE) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SAMP_FREQ) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_HYSTERESIS),<br>
&gt;&gt;&gt;&gt;&gt;&gt; .scan_index =3D CHANNEL_SCAN_DATA_MOTION,<br>
&gt;&gt;&gt;&gt;&gt;&gt; },<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; .type =3D IIO_ACCEL,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .modified =3D 1,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .channel2 =3D IIO_MOD_X,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OF=
FSET) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SCALE) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SAMP_FREQ) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_HYSTERESIS),<br>
&gt;&gt;&gt;&gt;&gt;&gt; .scan_index =3D CHANNEL_CUSTOM_VALUE_2,<br>
&gt;&gt;&gt;&gt;&gt;&gt; },<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; .type =3D IIO_ACCEL,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .modified =3D 1,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .channel2 =3D IIO_MOD_X,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OF=
FSET) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SCALE) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SAMP_FREQ) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_HYSTERESIS),<br>
&gt;&gt;&gt;&gt;&gt;&gt; .scan_index =3D CHANNEL_CUSTOM_VALUE_3,<br>
&gt;&gt;&gt;&gt;&gt;&gt; },<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; .type =3D IIO_ACCEL,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .modified =3D 1,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .channel2 =3D IIO_MOD_X,<br>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OF=
FSET) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SCALE) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_SAMP_FREQ) |<br>
&gt;&gt;&gt;&gt;&gt;&gt; BIT(IIO_CHAN_INFO_HYSTERESIS),<br>
&gt;&gt;&gt;&gt;&gt;&gt; .scan_index =3D CHANNEL_CUSTOM_VALUE_4,<br>
&gt;&gt;&gt;&gt;&gt;&gt; }<br></div></div></blockquote><div>=C2=A0</div><di=
v>Jonathan Cameron wrote :=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex"><div><div class=3D"h=
5">
</div></div>This channel array will attempt to create a whole load of ident=
ical attributes.<br>
in_accel_x_raw for each entry.<br>
<br>
I suspect you want is to have<br>
in_accel0_x_raw<br>
in_accel1_x_raw etc?=C2=A0 In which case you&#39;ll need to also specify<br=
>
.indexed =3D 1,<br>
.index =3D N<br>
<br>
That is probably the cause of the error you saw<br>
(it&#39;ll also clash on the attribute for the index as seen above!)<br></b=
lockquote><div><br></div><div><div><br></div><div>This channel array will a=
ttempt to create a whole load of identical attributes.</div><div>in_accel_x=
_raw for each entry.</div><div><br></div><div><br></div><div>Saurabh :=C2=
=A0</div><div>&gt;&gt;But Now I didn&#39;t get any such error like &quot;fa=
iled to setup attributes&quot; , I think attributes has been set fine .Now =
the problem is in the initialization of trigger buffer.Is the reason same a=
s you said above.</div><div><br></div><div>I still get the same error :</di=
v><div><br></div><div>[13778.127716] iio iio:device4: tried to double regis=
ter : in_accel_x_index</div><div>[13778.127899] hid_sensor_accel_3d HID-SEN=
SOR-200073.3.auto: failed to initialize trigger buffer</div><div>[13778.143=
676] hid_sensor_accel_3d: probe of HID-SENSOR-200073.3.auto failed with err=
or -16</div><div><br></div><div>After I modified like this(in <b>bold</b>) =
for the below channel attributes:=C2=A0</div><div><br></div><div>{</div><di=
v>=C2=A0.type =3D IIO_ACCEL,</div><div>=C2=A0.modified =3D 1,</div><div><b>=
.indexed =3D 1,</b></div><div>=C2=A0.channel2 =3D IIO_MOD_X,</div><div>=C2=
=A0.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),</div><div>=C2=A0.info_ma=
sk_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |</div><div>=C2=A0BIT(IIO_C=
HAN_INFO_SCALE) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_SAMP_FREQ) |</div><div>=
=C2=A0BIT(IIO_CHAN_INFO_HYSTERESIS),</div><div>=C2=A0.scan_index =3D CHANNE=
L_SCAN_DATA_MOTION,</div><div>=C2=A0},</div><div>=C2=A0{</div><div>.type =
=3D IIO_ACCEL,</div><div>=C2=A0.modified =3D 1,</div><div><b>.indexed =3D 2=
,</b></div><div>=C2=A0.channel2 =3D IIO_MOD_X,</div><div>=C2=A0.info_mask_s=
eparate =3D BIT(IIO_CHAN_INFO_RAW),</div><div>=C2=A0.info_mask_shared_by_ty=
pe =3D BIT(IIO_CHAN_INFO_OFFSET) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_SCALE)=
 |</div><div>BIT(IIO_CHAN_INFO_SAMP_FREQ) |</div><div>=C2=A0BIT(IIO_CHAN_IN=
FO_HYSTERESIS),</div><div>.scan_index =3D CHANNEL_CUSTOM_VALUE_2,</div><div=
>=C2=A0},</div><div>=C2=A0{</div><div>=C2=A0.type =3D IIO_ACCEL,</div><div>=
=C2=A0.modified =3D 1,</div><div><b>.indexed =3D 3,</b></div><div>=C2=A0.ch=
annel2 =3D IIO_MOD_X,</div><div>=C2=A0.info_mask_separate =3D BIT(IIO_CHAN_=
INFO_RAW),</div><div>=C2=A0.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_=
OFFSET) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_SCALE) |</div><div>=C2=A0BIT(II=
O_CHAN_INFO_SAMP_FREQ) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_HYSTERESIS),</di=
v><div>=C2=A0.scan_index =3D CHANNEL_CUSTOM_VALUE_3,</div><div>=C2=A0},</di=
v><div>=C2=A0{</div><div>=C2=A0.type =3D IIO_ACCEL,</div><div>=C2=A0.modifi=
ed =3D 1,</div><div><b>.indexed =3D 4,</b></div><div>=C2=A0.channel2 =3D II=
O_MOD_X,</div><div>=C2=A0.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),</d=
iv><div>=C2=A0.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |</di=
v><div>BIT(IIO_CHAN_INFO_SCALE) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_SAMP_FR=
EQ) |</div><div>=C2=A0BIT(IIO_CHAN_INFO_HYSTERESIS),</div><div>=C2=A0.scan_=
index =3D CHANNEL_CUSTOM_VALUE_4,</div><div>=C2=A0}</div><div><br></div><di=
v><br></div><div>From the firmware in the accel input report I sent data_mo=
tion, custom value2,3 and 4 apart from usual x,y and z values.I want to ret=
rieve the =C2=A0custom value 2 , 3 and 4 .Once the driver is loaded fine I =
will modify the generic_buffer.c application in the drivers/staging/iio/Doc=
umentation.</div></div><div><br></div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddin=
g-left:1ex">
<div class=3D""><div class=3D"h5">&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; /* Capture samples in local storage */<br>
&gt;&gt;&gt;&gt;&gt;&gt; static int accel_3d_capture_sample(struct hid_sens=
or_hub_device<br>
&gt;&gt; *hsdev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; unsigned usage_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; size_t raw_len, char *raw_data,<br>
&gt;&gt;&gt;&gt;&gt;&gt; void *priv)<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; struct iio_dev *indio_dev =3D platform_get_drvdata=
(priv);<br>
&gt;&gt;&gt;&gt;&gt;&gt; struct accel_3d_state *accel_state =3D iio_priv(in=
dio_dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; int offset;<br>
&gt;&gt;&gt;&gt;&gt;&gt; int ret =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; switch (usage_id) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; case HID_USAGE_SENSOR_ACCEL_X_AXIS:<br>
&gt;&gt;&gt;&gt;&gt;&gt; case HID_USAGE_SENSOR_ACCEL_Y_AXIS:<br>
&gt;&gt;&gt;&gt;&gt;&gt; case HID_USAGE_SENSOR_ACCEL_Z_AXIS:<br>
&gt;&gt;&gt;&gt;&gt;&gt; case HID_USAGE_SENSOR_DATA_MOTION_STATE:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case HID_USAGE_SE=
NSOR_DATA_CUSTOM_VALUE2:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0case HID_USAGE_SENSOR_DATA_CUSTOM_VALU=
E3:<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0case HID_USAGE_SENSOR_DATA_CUSTOM_VALU=
E4:<br>
&gt;&gt;&gt;&gt;&gt;&gt; offset =3D usage_id - HID_USAGE_SENSOR_ACCEL_X_AXI=
S;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; /* Parse report which is specific to an usage id*/=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; static int accel_3d_parse_report(struct platform_d=
evice *pdev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; struct hid_sensor_hub_device *hsdev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; struct iio_chan_spec *channels,<br>
&gt;&gt;&gt;&gt;&gt;&gt; unsigned usage_id,<br>
&gt;&gt;&gt;&gt;&gt;&gt; struct accel_3d_state *st)<br>
&gt;&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; int ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; int i;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; for (i =3D 0; i &lt;=3D CHANNEL_CUSTOM_VALUE_4; ++=
i) {=C2=A0 //previously &lt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; CHANNEL_SCAN_INDEX_Z<br>
&gt;&gt;&gt;&gt;&gt;&gt; ret =3D sensor_hub_input_get_attribute_info(hsdev,=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; After build /insmod i get the following dmesg :<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; hid_sensor_accel_3d:HID-SENSOR-200073.3 auto : fai=
led to setup<br>
&gt;&gt;&gt;&gt;&gt;&gt; attributes<br>
&gt;&gt;&gt;&gt;&gt;&gt; hid_sensor_accel_3d:HID-SENSOR-200073.3 auto.faile=
d with error -1<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I am not getting what else I have to modify to avo=
id this error<br>
&gt;&gt; .If i<br>
&gt;&gt;&gt;&gt;&gt;&gt; remove<br>
&gt;&gt;&gt;&gt;&gt;&gt; the portion in bold(and use this original code<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; :<a href=3D"http://lxr.free-electrons.com/source/drivers/iio/accel=
/hid-sensor-accel-3d.c" target=3D"_blank">http://lxr.free-electrons.com/sou=
rce/drivers/iio/accel/hid-sensor-accel-3d.c</a>)<br>
&gt;&gt;&gt;&gt;&gt;&gt; I can happily insert the module without any error =
and can<br>
&gt;&gt; interact with<br>
&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt; driver using my application.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; _______________________________________________<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; Kernelnewbies mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:Kernelnewbies@kernelnewbies.org"=
>Kernelnewbies@kernelnewbies.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.kernelnewbies.org/mailman/=
listinfo/kernelnewbies" target=3D"_blank">http://lists.kernelnewbies.org/ma=
ilman/listinfo/kernelnewbies</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; To unsubscribe from this list: send the line &quot;unsubscribe lin=
ux-iio&quot; in<br>
&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.o=
rg">majordomo@vger.kernel.org</a><br>
&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/maj=
ordomo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.h=
tml</a><br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a1134f2b8f687fb051046d645--
