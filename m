Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <5366E298.8050409@linux.intel.com>
Date: Sun, 04 May 2014 18:00:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/16] iio: hid-sensors: Convert units and exponent
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <535AA9C9.10002@kernel.org> <535C0A2D.60207@linux.intel.com> <5365425F.9040309@kernel.org> <53665382.9030906@linux.intel.com> <4102328d-88e0-441f-87c9-0b57cbc33ca5@email.android.com>
In-Reply-To: <4102328d-88e0-441f-87c9-0b57cbc33ca5@email.android.com>
Content-Type: multipart/alternative;
 boundary="------------080304010807030700020202"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080304010807030700020202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

I have just sent you one patch, which can be applied to iio git tree on 
top of the currently applied patches.

Thanks,
Srinivas

On 05/04/2014 07:56 AM, Jonathan Cameron wrote:
> Cool. I will hold them for now then. Had a bored moment and not much 
> else pending so jumped the gun!
>
> On May 4, 2014 3:49:38 PM GMT+01:00, Srinivas Pandruvada 
> <srinivas.pandruvada@linux.intel.com> wrote:
>
>     Hi Jonathan,
>
>     Somebody pointed me some error in magnetometer calculation, I have a
>     correction,
>     I will submit as another patch. I was about to push second version of
>     these patches.
>
>     Thanks,
>     Srinivas
>
>     On 05/03/2014 12:24 PM, Jonathan Cameron wrote:
>
>         On 26/04/14 20:34, Srinivas Pandruvada wrote:
>
>             On 04/25/2014 11:30 AM, Jonathan Cameron wrote:
>
>                 On 19/04/14 00:22, Srinivas Pandruvada wrote:
>
>                     HID sensor hub specify a default unit and
>                     alternative units. This along with unit exponent
>                     can be used adjust scale. This change change HID
>                     sensor data units to IIO defined units for each
>                     sensor type. So in this way user space can use a
>                     simply use: "(data + offset) * scale" to get final
>                     result. Signed-off-by: Srinivas Pandruvada
>                     <srinivas.pandruvada@linux.intel.com> 
>
>                 see inline. 
>
>         Applied to the togreg branch of iio.git with a tweaks to
>         comments as mentioned (please check I didn't mess them up!)
>
>                     ---
>                     .../iio/common/hid-sensors/hid-sensor-attributes.c
>                     | 114 +++++++++++++++++++++
>                     include/linux/hid-sensor-hub.h | 4 + 2 files
>                     changed, 118 insertions(+) diff --git
>                     a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>                     b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>                     index 75b5473..451a95b 100644 ---
>                     a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>                     +++
>                     b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>                     @@ -26,6 +26,40 @@ #include <linux/iio/iio.h>
>                     #include <linux/iio/sysfs.h> +struct { + u32
>                     usage_id; + int unit; /* 0 for default others from
>                     HID sensor spec */ + int scale_val0; /* scale,
>                     whole number */ + int scale_val1; /* scale,
>                     fraction in micros */ +} unit_conversion[] = { +
>                     {HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650}, +
>                     {HID_USAGE_SENSOR_ACCEL_3D, +
>                     HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
>                     + {HID_USAGE_SENSOR_ACCEL_3D, +
>                     HID_USAGE_SENSOR_UNITS_G, 9, 806650}, + +
>                     {HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453}, +
>                     {HID_USAGE_SENSOR_GYRO_3D, +
>                     HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
>                     + {HID_USAGE_SENSOR_GYRO_3D, +
>                     HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0,
>                     17453}, + + {HID_USAGE_SENSOR_COMPASS_3D, 0, 1000,
>                     0}, + {HID_USAGE_SENSOR_COMPASS_3D,
>                     HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0}, + +
>                     {HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 17453, 0}, +
>                     {HID_USAGE_SENSOR_INCLINOMETER_3D, +
>                     HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453}, +
>                     {HID_USAGE_SENSOR_INCLINOMETER_3D, +
>                     HID_USAGE_SENSOR_UNITS_RADIANS, 1, 0}, + +
>                     {HID_USAGE_SENSOR_ALS, 0, 1, 0}, +
>                     {HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX,
>                     1, 0}, + + {HID_USAGE_SENSOR_PRESSURE, 0, 100000,
>                     0}, + {HID_USAGE_SENSOR_PRESSURE,
>                     HID_USAGE_SENSOR_UNITS_PASCAL, 1, 0}, +}; + static
>                     int pow_10(unsigned power) { int i; @@ -209,6
>                     +243,86 @@ int
>                     hid_sensor_write_raw_hyst_value(struct
>                     hid_sensor_common *st, }
>                     EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
>                     +/* + * This fuction applies the unit exponent to
>                     the scale. + * For example: 
>
>                 Function
>
>                     + * 9.806650 ->exp:2-> val0[980]val1[6650] + *
>                     9.000806 ->exp:2-> val0[900]val1[806] + * 0.174535
>                     ->exp:2-> val0[17]val1[4535] + * 1.001745
>                     ->exp:0-> val0[1]val1[1745] + * 1.001745 ->exp:2->
>                     val0[100]val1[1745] + * 1.001745 ->exp:4->
>                     val0[10017]val1[45] + * 9.806650 ->exp:-2->
>                     val0[0]val1[98066] 
>
>                 It took me a while to get what you meant here, perhaps
>                 for the examples it is worth showing the actual value
>                 directly as well. Maybe. 9.806650 exp:2->980.6650 ->
>                 val0[980]val1[665000] (note the above is I think
>                 incorrect due to lack of trailing zeros on val1.
>
>                     + */ +static void adjust_exponent_micro(int *val0,
>                     int *val1, int scale0, + int scale1, int exp) +{ +
>                     int i; + int x; + int res; + int rem; + + if (exp
>                     > 0) { + *val0 = scale0 * pow_10(exp); + res = 0;
>                     + if (exp > 6) { + *val1 = 0; + return; + } 
>
>                 so if example 1 above.. val0 = 900 as desired. i = 0;
>                 sca1e1 = 806650 x = 806650/100000 = 8; res = 80;
>                 scale1 = 06650 i = 1 x = 06650/10000 = 0; res = 80; so
>                 980. Good.
>
>                     + for (i = 0; i < exp; ++i) { + x = scale1 /
>                     pow_10(5 - i); + res += (pow_10(exp - 1 - i) * x);
>                     + scale1 = scale1 % pow_10(5 - i); + } + *val0 +=
>                     res; + *val1 = scale1 * pow_10(exp); 
>
>                 val1 = 665000 which is correct with the trailing zeros
>                 in val2. So your code is good but examples need those
>                 zeros! 
>
>             Impressive, Absolutely great review. I will correct
>             comments in the next version. 
>
>         Given this was the only issue in the patch set I'll just fix
>         it up as I merge it. It's been a couple of weeks an noone else
>         has chipped in on this series, so I'm taking it now.
>
>             Thanks, Srinivas
>
>                     + } else if (exp < 0) { + exp = abs(exp); + if
>                     (exp > 6) { + *val0 = *val1 = 0; + return; + } +
>                     *val0 = scale0 / pow_10(exp); + rem = scale0 %
>                     pow_10(exp); + res = 0; + for (i = 0; i < (6 -
>                     exp); ++i) { + x = scale1 / pow_10(5 - i); + res
>                     += (pow_10(5 - exp - i) * x); + scale1 = scale1 %
>                     pow_10(5 - i); + } + *val1 = rem * pow_10(6 - exp)
>                     + res; + } else { + *val0 = scale0; + *val1 =
>                     scale1; + } +} + +int hid_sensor_format_scale(u32
>                     usage_id, + struct hid_sensor_hub_attribute_info
>                     *attr_info, + int *val0, int *val1) +{ + int i; +
>                     int exp; + + *val0 = 1; + *val1 = 0; + + for (i =
>                     0; ARRAY_SIZE(unit_conversion); ++i) { + if
>                     (unit_conversion[i].usage_id == usage_id && +
>                     unit_conversion[i].unit == attr_info->units) { +
>                     exp = hid_sensor_convert_exponent( +
>                     attr_info->unit_expo); +
>                     adjust_exponent_micro(val0, val1, +
>                     unit_conversion[i].scale_val0, +
>                     unit_conversion[i].scale_val1, exp); + break; + }
>                     + } + + return IIO_VAL_INT_PLUS_MICRO; +}
>                     +EXPORT_SYMBOL(hid_sensor_format_scale); + int
>                     hid_sensor_parse_common_attributes(struct
>                     hid_sensor_hub_device *hsdev, u32 usage_id, struct
>                     hid_sensor_common *st) diff --git
>                     a/include/linux/hid-sensor-hub.h
>                     b/include/linux/hid-sensor-hub.h index
>                     b70cfd7..89626b2 100644 ---
>                     a/include/linux/hid-sensor-hub.h +++
>                     b/include/linux/hid-sensor-hub.h @@ -223,4 +223,8
>                     @@ int hid_sensor_read_samp_freq_value(struct
>                     hid_sensor_common *st, int
>                     hid_sensor_get_usage_index(struct
>                     hid_sensor_hub_device *hsdev, u32 report_id, int
>                     field_index, u32 usage_id); +int
>                     hid_sensor_format_scale(u32 usage_id, + struct
>                     hid_sensor_hub_attribute_info *attr_info, + int
>                     *val0, int *val1); + #endif
>
>                 -- To unsubscribe from this list: send the line
>                 "unsubscribe linux-iio" in the body of a message to
>                 majordomo@vger.kernel.org More majordomo info at
>                 http://vger.kernel.org/majordomo-info.html
>
>
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info athttp://vger.kernel.org/majordomo-info.html
>
>
> -- 
> Sent from my Android phone with K-9 Mail. Please excuse my brevity. 


--------------080304010807030700020202
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Jonathan,<br>
    <br>
    I have just sent you one patch, which can be applied to iio git tree
    on top of the currently applied patches.<br>
    <br>
    Thanks,<br>
    Srinivas<br>
    <br>
    <div class="moz-cite-prefix">On 05/04/2014 07:56 AM, Jonathan
      Cameron wrote:<br>
    </div>
    <blockquote
      cite="mid:4102328d-88e0-441f-87c9-0b57cbc33ca5@email.android.com"
      type="cite">Cool. I will hold them for now then. Had a bored
      moment and not much else pending so jumped the gun!<br>
      <br>
      <div class="gmail_quote">On May 4, 2014 3:49:38 PM GMT+01:00,
        Srinivas Pandruvada <a class="moz-txt-link-rfc2396E" href="mailto:srinivas.pandruvada@linux.intel.com">&lt;srinivas.pandruvada@linux.intel.com&gt;</a>
        wrote:
        <blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt
          0.8ex; border-left: 1px solid rgb(204, 204, 204);
          padding-left: 1ex;">
          <pre class="k9mail">Hi Jonathan,

Somebody pointed me some error in magnetometer calculation, I have a 
correction,
I will submit as another patch. I was about to push second version of 
these patches.

Thanks,
Srinivas

On 05/03/2014 12:24 PM, Jonathan Cameron wrote:
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> On 26/04/14 20:34, Srinivas Pandruvada wrote:
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;">
 On 04/25/2014 11:30 AM, Jonathan Cameron wrote:
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;"> On 19/04/14 00:22, Srinivas Pandruvada wrote:
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> HID sensor hub specify a default
unit and alternative units. This
 along with unit exponent can be used adjust scale. This change
 change HID sensor data units to IIO defined units for each
 sensor type. So in this way user space can use a simply use:
 "(data + offset) * scale" to get final result.

 Signed-off-by: Srinivas Pandruvada 
 <a class="moz-txt-link-rfc2396E" href="mailto:srinivas.pandruvada@linux.intel.com">&lt;srinivas.pandruvada@linux.intel.com&gt;</a>
</blockquote> see inline.
</blockquote></blockquote> Applied to the togreg branch of iio.git with a tweaks to comments as 
 mentioned
 (please check I didn't mess them up!)

<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;"><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> ---
  
.../iio/common/hid-sensors/hid-sensor-attributes.c | 114 
 +++++++++++++++++++++
   include/linux/hid-sensor-hub.h                     |   4 +
   2 files changed, 118 insertions(+)

 diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c 
 b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 index 75b5473..451a95b 100644
 --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 @@ -26,6 +26,40 @@
   #include &lt;linux/iio/iio.h&gt;
   #include &lt;linux/iio/sysfs.h&gt;

 +struct {
 +    u32 usage_id;
 +    int unit; /* 0 for default others from HID sensor spec */
 +    int scale_val0; /* scale, whole number */
 +    int scale_val1; /* scale, fraction in micros */
 +} unit_conversion[] = {
 +    {HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650},
 +    {HID_USAGE_SENSOR_ACCEL_3D,
 +       
HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
 +    {HID_USAGE_SENSOR_ACCEL_3D,
 +        HID_USAGE_SENSOR_UNITS_G, 9, 806650},
 +
 +    {HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453},
 +    {HID_USAGE_SENSOR_GYRO_3D,
 +        HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
 +    {HID_USAGE_SENSOR_GYRO_3D,
 +        HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0, 17453},
 +
 +    {HID_USAGE_SENSOR_COMPASS_3D, 0, 1000, 0},
 +    {HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 
 0},
 +
 +    {HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 17453, 0},
 +    {HID_USAGE_SENSOR_INCLINOMETER_3D,
 +        HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},
 +    {HID_USAGE_SENSOR_INCLINOMETER_3D,
 +        HID_USAGE_SENSOR_UNITS_RADIANS, 1, 0},
 +
 +    {HID_USAGE_SENSOR_ALS, 0, 1, 0},
 +    {HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
 +
 +   
{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
 +    {HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 1, 0},
 +};
 +
   static int pow_10(unsigned power)
   {
       int i;
 @@ -209,6 +243,86 @@ int hid_sensor_write_raw_hyst_value(struct 
 hid_sensor_common *st,
   }
   EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);

 +/*
 + * This fuction applies the unit exponent to the scale.
 + * For example:
</blockquote> Function
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> + * 9.806650 -&gt;exp:2-&gt; val0[980]val1[6650]
 + * 9.000806 -&gt;exp:2-&gt; val0[900]val1[806]
 + * 0.174535 -&gt;exp:2-&gt; val0[17]val1[4535]
 + * 1.001745 -&gt;exp:0-&gt; val0[1]val1[1745]
 + * 1.001745 -&gt;exp:2-&gt; val0[100]val1[1745]
 + * 1.001745 -&gt;exp:4-&gt; val0[10017]val1[45]
 + * 9.806650 -&gt;exp:-2-&gt;
val0[0]val1[98066]
</blockquote> It took me a while to get what you meant here, perhaps for the 
 examples it
 is worth showing the actual value directly as well. Maybe.
 9.806650 exp:2-&gt;980.6650 -&gt; val0[980]val1[665000] (note the above is 
 I think
 incorrect due to lack of trailing zeros on val1.
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> + */
 +static void adjust_exponent_micro(int *val0, int *val1, int scale0,
 +                  int scale1, int exp)
 +{
 +    int i;
 +    int x;
 +    int res;
 +    int rem;
 +
 +    if (exp &gt; 0) {
 +        *val0 = scale0 * pow_10(exp);
 +        res = 0;
 +        if (exp &gt; 6) {
 +            *val1 = 0;
 +            return;
 +        }
</blockquote> so if example 1 above..
 val0 = 900 as desired.
 i  = 0;
 sca1e1 = 806650

x = 806650/100000 = 8;
 res = 80;
 scale1 = 06650
 i = 1
 x = 06650/10000 = 0;
 res = 80;
  so 980. Good.
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> +        for (i = 0; i &lt; exp; ++i) {
 +            x = scale1 / pow_10(5 - i);
 +            res += (pow_10(exp - 1 - i) * x);
 +            scale1 = scale1 % pow_10(5 - i);
 +        }
 +        *val0 += res;
 +            *val1 = scale1 * pow_10(exp);
</blockquote> val1 = 665000 which is correct with the trailing zeros in val2.
 So your code is good but examples need those zeros!
</blockquote> Impressive, Absolutely great review. I will correct comments in the 
 next version.
</blockquote> Given this was the only issue in the patch set I'll just fix it up as 
 I merge
 it.

 It's been a couple of weeks an noone else has chipped in on this 

series, so
 I'm taking it now.


<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;">
 Thanks,
 Srinivas
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;">
<blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #fcaf3e; padding-left: 1ex;"> +    } else if (exp &lt; 0) {
 +        exp = abs(exp);
 +        if (exp &gt; 6) {
 +            *val0 = *val1 = 0;
 +            return;
 +        }
 +        *val0 = scale0 / pow_10(exp);
 +        rem = scale0 % pow_10(exp);
 +        res = 0;
 +        for (i = 0; i &lt; (6 - exp); ++i) {
 +            x = scale1 / pow_10(5 - i);
 +            res += (pow_10(5 - exp - i) * x);
 +            scale1 = scale1 % pow_10(5 - i);
 +        }
 +        *val1 = rem * pow_10(6 -
exp) + res;
 +    } else {
 +        *val0 = scale0;
 +        *val1 = scale1;
 +    }
 +}
 +
 +int hid_sensor_format_scale(u32 usage_id,
 +            struct hid_sensor_hub_attribute_info *attr_info,
 +            int *val0, int *val1)
 +{
 +    int i;
 +    int exp;
 +
 +    *val0 = 1;
 +    *val1 = 0;
 +
 +    for (i = 0; ARRAY_SIZE(unit_conversion); ++i) {
 +        if (unit_conversion[i].usage_id == usage_id &amp;&amp;
 +            unit_conversion[i].unit == attr_info-&gt;units) {
 +            exp  = hid_sensor_convert_exponent(
 +                        attr_info-&gt;unit_expo);
 +            adjust_exponent_micro(val0, val1,
 +                    unit_conversion[i].scale_val0,
 +                    unit_conversion[i].scale_val1, exp);
 +            break;
 +        }
 +    }
 +
 +    return IIO_VAL_INT_PLUS_MICRO;
 +}

+EXPORT_SYMBOL(hid_sensor_format_scale);
 +
   int hid_sensor_parse_common_attributes(struct 
 hid_sensor_hub_device *hsdev,
                       u32 usage_id,
                       struct hid_sensor_common *st)
 diff --git a/include/linux/hid-sensor-hub.h 
 b/include/linux/hid-sensor-hub.h
 index b70cfd7..89626b2 100644
 --- a/include/linux/hid-sensor-hub.h
 +++ b/include/linux/hid-sensor-hub.h
 @@ -223,4 +223,8 @@ int hid_sensor_read_samp_freq_value(struct 
 hid_sensor_common *st,
   int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
                   u32 report_id, int field_index, u32 usage_id);

 +int hid_sensor_format_scale(u32 usage_id,
 +                struct hid_sensor_hub_attribute_info *attr_info,
 +                int *val0, int *val1);
 +
   #endif</blockquote>

 -- 
 To unsubscribe from this list: send the line "unsubscribe linux-iio"
in
 the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a>
 More majordomo info at <a moz-do-not-send="true" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a></blockquote>

</blockquote></blockquote>

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a>
More majordomo info at  <a moz-do-not-send="true" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
</pre>
        </blockquote>
      </div>
      <br>
      -- <br>
      Sent from my Android phone with K-9 Mail. Please excuse my
      brevity.
    </blockquote>
    <br>
  </body>
</html>

--------------080304010807030700020202--
