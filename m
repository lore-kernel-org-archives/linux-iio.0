Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48308 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1DALOR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2011 07:14:17 -0400
Message-ID: <4D95B3E3.7020109@cam.ac.uk>
Date: Fri, 01 Apr 2011 12:15:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: DAC: New driver for the AD5504 and AD5501 High Voltage
 DACs
References: <1301583417-27010-1-git-send-email-michael.hennerich@analog.com> <4D94A942.7070008@cam.ac.uk> <4D95931D.3060703@analog.com>
In-Reply-To: <4D95931D.3060703@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/11 09:55, Michael Hennerich wrote:
> On 03/31/2011 06:18 PM, Jonathan Cameron wrote:
>> On 03/31/11 15:56, michael.hennerich@analog.com wrote:
>>  =20
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>>
>>>    =20
>> Hi Michael,
>>
>> I wonder if it makes sense to handle an over temp warning
>> as you have done here with a new rather complex threshold type.
>> What do we loose by 'defining' a separate temperature channel?
>> That would have no direct access and only exist for the purposes
>> of the threshold.
>>  =20
> Hi Jonathan,
> I think you know that this threshold event is just an ALARM interrupt=
,
> that signals
> the junction temperature exceeded 110=B0C, and that the part therefor=
e
> automatically
> entered thermal shutdown mode?
> So there is no temperature that can be read...
Sure.
>> Thus we would have
>> temp0_thresh_rising_value
> Always 110000 mDeg C.
>> and temp0_thresh_rising_en (always 1)
>> The event code is then just a standard temperature one.  What
>> you currently have to my mind implies that the threshold is
>> on the output voltage rather than the temperature.
>>  =20
> I see you point here.
> But can you tell me how the standard temperature would look like?
Simply have the event attributes
temp0_thresh_rising_en (always 1)
temp0_thresh_rising_value (always 110,000).

Nothing says we have to be able to read the value of a given channel to
have events for it.  The other approach would be to register the temp
stuff as a hwmon device.  It's basically doing hardware monitoring of t=
he
DAC.=20

>=20
>> Also need documentation for the powerdown attributes.
>> (powerdown_mode seems to be specified, but se haven't had explicit
>> per channel controls on this before).
>>
>>  =20
> There are no channel controls for powerdown_mode.
> There are channel controls for outY_powerdown, but not for the mode.
>=20
> All of them are already documented.
Err. Some how I missed that. Sorry, must have been a typo in my search =
string!
>=20
>> I'm a little confused about what the powerdown attributes do consist=
ent.
>>  Looks like read gives 1 if the relevant bit of pwr_down_mask is set=
=2E
>> If you write a 1 it seems to unset that bit. Thus write 1 and
>> you'll read back a 0.
>>  =20
> Good catch, that's a bug.
>> As ever, pretty clean. Thanks!
>>
>> Jonathan
>>  =20
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> ---
>>>  drivers/staging/iio/dac/Kconfig  |   10 +
>>>  drivers/staging/iio/dac/Makefile |    1 +
>>>  drivers/staging/iio/dac/ad5504.c |  429 ++++++++++++++++++++++++++=
++++++++++++
>>>  drivers/staging/iio/dac/ad5504.h |   74 +++++++
>>>  drivers/staging/iio/sysfs.h      |    1 +
>>>  5 files changed, 515 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/staging/iio/dac/ad5504.c
>>>  create mode 100644 drivers/staging/iio/dac/ad5504.h
>>>
>>> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/=
dac/Kconfig
>>> index 67defcb..1b0188a 100644
>>> --- a/drivers/staging/iio/dac/Kconfig
>>> +++ b/drivers/staging/iio/dac/Kconfig
>>> @@ -21,6 +21,16 @@ config AD5446
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called ad5446.
>>>
>>> +config AD5504
>>> +     tristate "Analog Devices AD5504/AD5501 DAC SPI driver"
>>> +     depends on SPI
>>> +     help
>>> +       Say yes here to build support for Analog Devices AD5504, AD=
5501,
>>>    =20
>> Why reverse numerical order?  (not that I really care, just curious =
;)
>>  =20
> The driver is named after the AD5504, so I thought I list it first.
> Actually I don't really care, too.
>=20
>>> +       High Voltage Digital to Analog Converter.
>>> +
>>> +       To compile this driver as a module, choose M here: the
>>> +       module will be called ad5504.
>>> +
>>>    =20
>> ...
>>  =20
>>> +static ssize_t ad5504_read_powerdown_mode(struct device *dev,
>>> +                                   struct device_attribute *attr, =
char *buf)
>>> +{
>>> +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>>> +     struct ad5504_state *st =3D iio_dev_get_devdata(indio_dev);
>>> +
>>>    =20
>> I count 14 characters needed.  Also, why not const char* for these
>> and share them across multiple driver instances.
>>  =20
> ok
>>> +     char mode[][15] =3D {"20kohm_to_gnd", "three_state"};
>>> +
>>> +     return sprintf(buf, "%s\n", mode[st->pwr_down_mode]);
>>> +}
>>> +
>>>    =20
>> ...
>>
>>
>>  =20
>>> +}
>>> +
>>> +static ssize_t ad5504_read_dac_powerdown(struct device *dev,
>>> +                                        struct device_attribute *a=
ttr,
>>> +                                        char *buf)
>>> +{
>>> +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>>> +     struct ad5504_state *st =3D iio_dev_get_devdata(indio_dev);
>>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> +     return sprintf(buf, "%d\n",
>>>    =20
>> So, if mask is set, the channel is powered down?
>> I wonder if flipping the logic here to have dac0_en etc might be
>> more consistent with everything else?  Perhaps not given it
>> would disassociate this from the powerdown_mode attributes...
>>  =20
> As I said the reversed logic is bug here.
> I don't really like to call it enable. Since it is actually a power
> down, associated with the
> various modes.
=46ine.
>>> +                     !!(st->pwr_down_mask & (1 << this_attr->addre=
ss)));
>>> +}
>>> +
>>> +static ssize_t ad5504_write_dac_powerdown(struct device *dev,
>>> +                                         struct device_attribute *=
attr,
>>> +                                         const char *buf, size_t l=
en)
>>> +{
>>> +     long readin;
>>> +     int ret;
>>> +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>>> +     struct ad5504_state *st =3D iio_dev_get_devdata(indio_dev);
>>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> +     ret =3D strict_strtol(buf, 10, &readin);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (readin =3D=3D 0)
>>> +             st->pwr_down_mask |=3D (1 << this_attr->address);
>>> +     else if (readin =3D=3D 1)
>>> +             st->pwr_down_mask &=3D ~(1 << this_attr->address);
>>>    =20
>> Doesn't this technically mean this is a power up mask?  If we right
>> 1 to power down we unset the bit in this mask.
>>  =20
> Unlike to the other DACs having this feature, it's here used as an po=
wer
> up mask.
>>> +     else
>>> +             ret =3D -EINVAL;
>>> +
>>> +     ret =3D ad5504_spi_write(st->spi, AD5504_ADDR_CTRL,
>>> +                             AD5504_DAC_PWRDWN_MODE(st->pwr_down_m=
ode) |
>>> +                             AD5504_DAC_PWR(st->pwr_down_mask));
>>> +
>>> +     /* writes to the CTRL register must be followed by a NOOP */
>>> +     ad5504_spi_write(st->spi, AD5504_ADDR_NOOP, 0);
>>> +
>>> +     return ret ? ret : len;
>>> +}
>>> +
>>>    =20
>> ...
>>
>>  =20
>>> +static struct attribute *ad5504_attributes[] =3D {
>>> +     &iio_dev_attr_out0_raw.dev_attr.attr,
>>> +     &iio_dev_attr_out1_raw.dev_attr.attr,
>>> +     &iio_dev_attr_out2_raw.dev_attr.attr,
>>> +     &iio_dev_attr_out3_raw.dev_attr.attr,
>>> +     &iio_dev_attr_out0_powerdown.dev_attr.attr,
>>>    =20
>> Not actually documented as yet (I think). Please add that as well.
>>  =20
>=20
> It is -
> +What:        /sys/bus/iio/devices/deviceX/outY_powerdown
> +What:        /sys/bus/iio/devices/deviceX/out_powerdown
> +KernelVersion:    2.6.38
> +Contact:    linux-iio@vger.kernel.org
> +Description:
> +        Writing 1 causes output Y to enter the power down mode speci=
fied
> +        by the corresponding outY_powerdown_mode. Clearing returns t=
o
> +        normal operation. Y may be suppressed if all outputs are
> +        controlled together.
Indeed, sorry for the noise!
>=20
>=20
>>> +     &iio_dev_attr_out1_powerdown.dev_attr.attr,
>>> +     &iio_dev_attr_out2_powerdown.dev_attr.attr,
>>> +     &iio_dev_attr_out3_powerdown.dev_attr.attr,
>>> +     &iio_dev_attr_out_powerdown_mode.dev_attr.attr,
>>> +     &iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
>>> +     &iio_dev_attr_out_scale.dev_attr.attr,
>>> +     &iio_dev_attr_name.dev_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>>    =20
>> Not convinced you are gaining much here vs just having two attribute
>> tables and picking that based on the id...
>>  =20
> ok
>>> +static mode_t ad5504_attr_is_visible(struct kobject *kobj,
>>> +                                  struct attribute *attr, int n)
>>> +{
>>> +     struct device *dev =3D container_of(kobj, struct device, kobj=
);
>>> +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>>> +     struct ad5504_state *st =3D iio_dev_get_devdata(indio_dev);
>>> +
>>> +     mode_t mode =3D attr->mode;
>>> +
>>> +     if (spi_get_device_id(st->spi)->driver_data =3D=3D ID_AD5501 =
&&
>>> +             (attr =3D=3D &iio_dev_attr_out1_raw.dev_attr.attr ||
>>> +             attr =3D=3D &iio_dev_attr_out2_raw.dev_attr.attr ||
>>> +             attr =3D=3D &iio_dev_attr_out3_raw.dev_attr.attr ||
>>> +             attr =3D=3D &iio_dev_attr_out1_powerdown.dev_attr.att=
r ||
>>> +             attr =3D=3D &iio_dev_attr_out2_powerdown.dev_attr.att=
r ||
>>> +             attr =3D=3D &iio_dev_attr_out3_powerdown.dev_attr.att=
r))
>>> +             mode =3D 0;
>>> +
>>> +     return mode;
>>> +}
>>> +
>>> +static const struct attribute_group ad5504_attribute_group =3D {
>>> +     .attrs =3D ad5504_attributes,
>>> +     .is_visible =3D ad5504_attr_is_visible,
>>> +};
>>> +
>>> +static IIO_CONST_ATTR(out_alarm_overtemp_thresh_high_value, "11000=
0");
>>> +
>>> +static struct attribute *ad5504_ev_attributes[] =3D {
>>> +     &iio_const_attr_out_alarm_overtemp_thresh_high_value.dev_attr=
=2Eattr,
>>>    =20
>> For consistency we also want the _en element, (always 1 of course).
>>  =20
> ok
>>  =20
>>> +     NULL,
>>> +};
>>> +
>>> +static struct attribute_group ad5504_ev_attribute_group =3D {
>>> +     .attrs =3D ad5504_ev_attributes,
>>> +};
>>> +
>>> +static void ad5504_interrupt_bh(struct work_struct *work_s)
>>> +{
>>> +     struct ad5504_state *st =3D container_of(work_s,
>>> +             struct ad5504_state, work_alarm);
>>> +
>>> +     iio_push_event(st->indio_dev, 0,
>>> +                     IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_OUT,
>>> +                     0,
>>> +                     IIO_EV_TYPE_THRESH,
>>> +                     IIO_EV_DIR_RISING),
>>> +                     st->last_timestamp);
>>>    =20
>> Not happy with this event type. See intro.
>>  =20
> Please propose a better one.
>=20
>>> +
>>> +     enable_irq(st->spi->irq);
>>> +}
>>> +
>>>    =20
>> ...
>>
>>  =20
>>> +#define AD5504_ADDR_ALL_DAC          5
>>> +#define AD5504_ADDR_CTRL             7
>>> +
>>> +/* Control Register */
>>> +#define AD5504_DAC_PWR(ch)           ((ch) << 2)
>>> +#define AD5504_DAC_PWRDWN_MODE(mode) ((mode) << 6)
>>> +#define AD5504_DAC_PWRDN_20K         0
>>> +#define AD5504_DAC_PWRDN_3STATE              1
>>> +
>>> +/*
>>> + * TODO: struct ad5504_platform_data needs to go into include/linu=
x/iio
>>> + */
>>> +
>>> +struct ad5504_platform_data {
>>> +     u16                             vref_mv;
>>> +};
>>>    =20
>> Would it matter to you if we stopped doing this vref passing in plat=
form
>> data and started insisting on regulator always being queriable?  (ca=
me up in
>> the max1363 discussion of yesterday?) When we first started doing th=
is
>> almost no boards had regulators specified. Is this still true?
>>  =20
> The regulator stuff is not really common.
> I always try to support it as an alternative way, since I know passin=
g
> platform dependent information
> through platform_data is a bit inconvenient on systems using devicetr=
ee.=20
> A bandgap reference directly connected to an ADC or DAC, can be
> considered as a fixed voltage regulator.
> However there is no way to enable or disable it. it's a pretty
> complicated way telling the driver it's reference.
> I would propose to always support the regulator framework, however I
> don't mind having the platform_data approach as well.
Ok, lets leave it for now, but definitely do our best to encourage user=
s
to use the regulator framework where possible.  That way we can hopeful=
ly
stop putting this in new drives at some point in the future!
> =20
> =20
>>> +
>>> +/**
>>> + * struct ad5446_state - driver instance specific data
>>> + * @indio_dev:               the industrial I/O device
>>> + * @us:                      spi_device
>>> + * @reg:             supply regulator
>>> + * @vref_mv:         actual reference voltage used
>>> + * @work_alarm:              bh work structure for event handling
>>> + * @last_timestamp:  timestamp of last event interrupt
>>> + * @pwr_down_mask    power down mask
>>> + * @pwr_down_mode    current power down mode
>>> + */
>>> +
>>> +struct ad5504_state {
>>> +     struct iio_dev                  *indio_dev;
>>> +     struct spi_device               *spi;
>>> +     struct regulator                *reg;
>>> +     unsigned short                  vref_mv;
>>> +     struct work_struct              work_alarm;
>>> +     s64                             last_timestamp;
>>> +     unsigned                        pwr_down_mask;
>>> +     unsigned                        pwr_down_mode;
>>> +};
>>> +
>>> +/**
>>> + * ad5504_supported_device_ids:
>>> + */
>>> +
>>> +enum ad5504_supported_device_ids {
>>> +     ID_AD5504,
>>> +     ID_AD5501,
>>> +};
>>> +
>>> +#endif /* SPI_AD5504_H_ */
>>> diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysf=
s.h
>>> index 24b74dd..9e3b784 100644
>>> --- a/drivers/staging/iio/sysfs.h
>>> +++ b/drivers/staging/iio/sysfs.h
>>> @@ -266,6 +266,7 @@ struct iio_const_attr {
>>>  #define IIO_EV_CLASS_MAGN            4
>>>  #define IIO_EV_CLASS_LIGHT           5
>>>  #define IIO_EV_CLASS_PROXIMITY               6
>>> +#define IIO_EV_CLASS_OUT             7
>>>    =20
>> This is fine but I think shouldn't be used here so shouldn't be in t=
he patch!
>>  =20
> ok
>>>  #define IIO_EV_MOD_X                 0
>>>  #define IIO_EV_MOD_Y                 1
>>>    =20
>>  =20
>=20
>=20

