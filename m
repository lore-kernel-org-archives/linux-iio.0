Return-Path: <oleksandr.kozaruk@ti.com>
From: "Kozaruk, Oleksandr" <oleksandr.kozaruk@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "tony@atomide.com" <tony@atomide.com>,
        "benoit.cousson@linaro.org"
	<benoit.cousson@linaro.org>,
        "Nayak, Rajendra" <rnayak@ti.com>,
        "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>,
        "ABRAHAM, KISHON VIJAY" <kishon@ti.com>,
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "grant.likely@linaro.org"
	<grant.likely@linaro.org>,
        "rob.herring@calxeda.com"
	<rob.herring@calxeda.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "ch.naveen@samsung.com"
	<ch.naveen@samsung.com>,
        "poeschel@lemonage.de" <poeschel@lemonage.de>,
        "Kim, Milo" <Milo.Kim@ti.com>,
        "Krishnamoorthy, Balaji T" <balajitk@ti.com>,
        "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
        "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Mon, 15 Jul 2013 13:30:25 +0000
Message-ID: <2A7ABDFCE21540479A5AEB0244A684D5E3D0E3@DNCE04.ent.ti.com>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,<51E05C0B.5050009@kernel.org>
In-Reply-To: <51E05C0B.5050009@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,=0A=
Thanks for the review.=0A=
=0A=
>Couple of things:=0A=
>=0A=
>1) It looks from the driver that a lot of the channels are not measuring=
=0A=
>voltages but rather temperature or currents etc.  If so then their=0A=
>types in the channel mask should be appropriately set.  Also if some=0A=
>of the channels are entirely internal test networks, what is the benefit=
=0A=
>of exposing them to userspace as readable channels?=0A=
>If channels are merely 'suggested' as being used for temperatures etc=0A=
>then it is fine to keep them as voltages.=0A=
There are two kinds of channel for measuring temperature: die temperature=
=0A=
and those that measure temperature indirectly measuring voltage on resistiv=
e=0A=
load(NTC sensor).=0A=
die temperature is calculated by some formulas which convert ADC code to=0A=
temperature. This is not implemented in the driver.=0A=
Channels intended to measure temperature with NTC sensor have inbuilt curre=
nt=0A=
sources. Voltage measured by this channels and specific NTC could be conver=
ted=0A=
to temperature.=0A=
This is the reason they chosen to be voltage channels.=0A=
As for test network I'll remove them from exposing to userspace.=0A=
[...]=0A=
=0A=
>> +static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,=0A=
>> +             int channel, int *res)=0A=
>> +{=0A=
>> +     u8 reg =3D gpadc->pdata->channel_to_reg(channel);=0A=
>> +     u8 val[2];=0A=
>=0A=
>le16 val;=0A=
>> +     int ret;=0A=
>> +=0A=
>ret =3D twl6030_gpadc_read(val, reg);=0A=
>(note that (reg, val) ordering of parameters would be a more common choice=
)=0A=
>=0A=
>> +     ret =3D twl6030_gpadc_read(val, reg);=0A=
>> +     if (ret) {=0A=
>> +             dev_dbg(gpadc->dev, "unable to read register 0x%X\n", reg)=
;=0A=
>> +             return ret;=0A=
>> +     }=0A=
>> +=0A=
>res =3D le16_to_cpup(val);=0A=
>=0A=
>> +     *res =3D (val[1] << 8) | val[0];=0A=
>> +=0A=
>> +     return ret;=0A=
>> +}=0A=
>> +=0A=
You mean something like this:=0A=
static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,         =
                                                                           =
                                                              =0A=
						int channel, int *res)                                               =
                                                                           =
                                                    =0A=
{                                                                          =
                                                                           =
                                                              =0A=
	u8 reg =3D gpadc->pdata->channel_to_reg(channel);                         =
                                                                           =
                                                         =0A=
	__le16 val;                                                               =
                                                                           =
                                                       =0A=
	int ret;                                                                  =
                                                                           =
                                                       =0A=
=0A=
	ret =3D twl6030_gpadc_read(reg, (u8 *)&val);                              =
                                                                           =
                                                         =0A=
	if (ret) {                                                                =
                                                                           =
                                                       =0A=
		dev_dbg(gpadc->dev, "unable to read register 0x%X\n", reg);              =
                                                                           =
                                                =0A=
		return ret;                                                              =
                                                                           =
                                                =0A=
	}                                                                         =
                                                                           =
                                                       =0A=
=0A=
	*res =3D le16_to_cpup(&val);                                              =
                                                                           =
                                                         =0A=
=0A=
	return ret;                                                               =
                                                                           =
                                                       =0A=
}=0A=
Note, that twl6030_gpadc_read() is just wrapper for twl_i2c_read() which ta=
kes=0A=
"an array of num_bytes containing data to be read"=0A=
I like the original implementation better then this(if I did it correctly)=
=0A=
Do you insist on this change?=0A=
[...]=0A=
=0A=
>> +static int twl6030_gpadc_get_processed(struct twl6030_gpadc_data *gpadc=
,=0A=
>> +             int channel, int *val)=0A=
>> +{=0A=
>> +     int raw_code;=0A=
>> +     int corrected_code;=0A=
>> +     int channel_value;=0A=
>> +     int ret;=0A=
>> +=0A=
>> +     ret =3D twl6030_gpadc_get_raw(gpadc, channel, &raw_code);=0A=
>> +     if (ret)=0A=
>> +             return ret;=0A=
>> +=0A=
>=0A=
>Might first thought on seeing this is that it would be better to return=0A=
>raw for all channels and provide the scale and offset info_mask elements=
=0A=
>where possible rather than doing the conversion in the kernel.  Note we=0A=
=0A=
In our custom kernel branch battery driver needs battery voltage and=0A=
temperature.  Thus the conversion anyway is done in the kernel, either=0A=
in ADC driver or battery driver.=0A=
=0A=
>allow really quite a bit of precision on those values so I doubt it=0A=
>will be a problem.=0A=
>=0A=
>If nothing else it would make everything rather more consistent.=0A=
>=0A=
[...]=0A=
=0A=
>> +static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)=0A=
>> +{=0A=
>> +     int chn, d1 =3D 0, d2 =3D 0, temp;=0A=
>> +     u8 trim_regs[17];=0A=
>> +     int ret;=0A=
>> +=0A=
>> +     ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs + 1,=0A=
>> +                     TWL6030_GPADC_TRIM1, 16);=0A=
>> +     if (ret < 0) {=0A=
>> +             dev_err(gpadc->dev, "calibration failed\n");=0A=
>> +             return ret;=0A=
>> +     }=0A=
>> +=0A=
>/*=0A=
>* Loop=0A=
>please for kernel code.=0A=
>> +     /* Loop to calculate the value needed for returning voltages from=
=0A=
>> +      * GPADC not values.=0A=
>> +      *=0A=
>> +      * gain is calculated to 3 decimal places fixed point.=0A=
>> +      */=0A=
>> +     for (chn =3D 0; chn < TWL6032_GPADC_MAX_CHANNELS; chn++) {=0A=
>> +=0A=
>> +             switch (chn) {=0A=
>> +             case 0:=0A=
>> +             case 1:=0A=
>> +             case 2:=0A=
>> +             case 3:=0A=
>> +             case 4:=0A=
>> +             case 5:=0A=
>> +             case 6:=0A=
>> +             case 11:=0A=
>> +             case 12:=0A=
>> +             case 13:=0A=
>> +             case 14:=0A=
>> +                     /* D1 */=0A=
>> +                     d1 =3D (trim_regs[3] & 0x1F) << 2;=0A=
>> +                     d1 |=3D (trim_regs[1] & 0x06) >> 1;=0A=
>> +                     if (trim_regs[1] & 0x01)=0A=
>> +                             d1 =3D -d1;=0A=
>> +=0A=
>> +                     /* D2 */=0A=
>> +                     d2 =3D (trim_regs[4] & 0x3F) << 2;=0A=
>> +                     d2 |=3D (trim_regs[2] & 0x06) >> 1;=0A=
>> +                     if (trim_regs[2] & 0x01)=0A=
>> +                             d2 =3D -d2;=0A=
>> +                     break;=0A=
>> +             case 8:=0A=
>No coment on your code, but this is an 'interesting' bit=0A=
>of bit packing...=0A=
>I did vaguely wonder if this could be mapped to a big lookup table,=0A=
>but having tried it I think I end up with something almost as tricky=0A=
>to read.. Oh well that was a fun 10 minute diversion ;)=0A=
This is inherited code from Graeme - original author of implementation=0A=
for twl6032.=0A=
[...]=0A=
=0A=
Regards,=0A=
OK.=0A=
