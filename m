Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BE1D162.90309@cam.ac.uk>
References: <1273073011-13052-1-git-send-email-jic23@cam.ac.uk>
	<4BE1D162.90309@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 May 2010 17:33:03 +0800
Message-ID: <l2w3c17e3571005060233yf53496f7s7598fcc9ab72be85@mail.gmail.com>
Subject: Re: [PATCH RFC] staging:iio: adis16209 accelerometer driver initial
	import
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Thanks a lot for your review and good comments. I have updated
adis16209 and adis16240(which has been tested too) according to your
comment. I am 100% sure we will pull new iio features to our tree. But
i am busy on testing adis16220/260/350, so if possible, i still need
your help to merge them into 2.6.35 just like adis16300/400 for the
moment.

On Thu, May 6, 2010 at 4:13 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 05/05/10 16:23, Jonathan Cameron wrote:
>> From: Barry Song <Barry.Song@analog.com>
> Hi All,
>
> As stated with the original post, here is some coments from me on this
> driver as it currently stands.
>
> One or two are related to changes to the core that are clearly needed
> (like the ability to have read only scan_element enable attributes for
> devices that are always on). =C2=A0I'll get those done when I have a few
> mins.
>
> Barry, I'm happy to do all the other changes mentioned if you can have
> a quick look at check I'm not actually going to break anything. =C2=A0Or =
if
> you would prefer, we can leave these until after the iio changes hit
> the analog tree.
>
> Jonathan
>>
>> This driver was lifted from the analog devices blackfin tree by
>> Jonathan Cameron. =C2=A0There are currently some over 80 character check=
 patch
>> issues left to be fixed that I know of.
>>
>> I'd like to move to a more standard review type process for iio drivers =
hence
>> I've posted this one to linux-iio prior to sending it to Greg KH.
>> So if anyone has a chance to take a look (and Barry can you sign off if
>> you are happy with the changes I've made).
>>
>> =C2=A0drivers/staging/iio/accel/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 10 +
>> =C2=A0drivers/staging/iio/accel/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A04 +
>> =C2=A0drivers/staging/iio/accel/adis16209.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0171 +++++++
>> =C2=A0drivers/staging/iio/accel/adis16209_core.c =C2=A0 =C2=A0| =C2=A065=
4 +++++++++++++++++++++++++
>> =C2=A0drivers/staging/iio/accel/adis16209_ring.c =C2=A0 =C2=A0| =C2=A021=
9 +++++++++
>> =C2=A0drivers/staging/iio/accel/adis16209_trigger.c | =C2=A0124 +++++
>> =C2=A06 files changed, 1182 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/acc=
el/Kconfig
>> index 3d3c333..8d7a780 100644
>> --- a/drivers/staging/iio/accel/Kconfig
>> +++ b/drivers/staging/iio/accel/Kconfig
>> @@ -3,6 +3,16 @@
>> =C2=A0#
>> =C2=A0comment "Accelerometers"
>>
>> +config ADIS16209
>> + =C2=A0 =C2=A0 =C2=A0 tristate "Analog Devices ADIS16209 Dual-Axis Digi=
tal Inclinometer and Accelerometer"
>> + =C2=A0 =C2=A0 =C2=A0 depends on SPI
>> + =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER
>> + =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING
> Oops, this one is my fault. =C2=A0The makefile makes it clear that this d=
river can be built
> without ring support. This select should be dependent on CONFIG_IIO_RING_=
BUFFER.
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say yes here to build support for Analog D=
evices adis16209 dual-axis digital inclinometer
>> + =C2=A0 =C2=A0 =C2=A0and accelerometer.
>> +
>> +
>> =C2=A0config KXSD9
>> =C2=A0 =C2=A0 =C2=A0 tristate "Kionix KXSD9 Accelerometer Driver"
>> =C2=A0 =C2=A0 =C2=A0 depends on SPI
>> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/ac=
cel/Makefile
>> index d5335f9..f8f2124 100644
>> --- a/drivers/staging/iio/accel/Makefile
>> +++ b/drivers/staging/iio/accel/Makefile
>> @@ -1,6 +1,10 @@
>> =C2=A0#
>> =C2=A0# Makefile for industrial I/O accelerometer drivers
>> =C2=A0#
>> +adis16209-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D adis16209_co=
re.o
>> +adis16209-$(CONFIG_IIO_RING_BUFFER) +=3D adis16209_ring.o adis16209_tri=
gger.o
>> +obj-$(CONFIG_ADIS16209) +=3D adis16209.o
>> +
>> =C2=A0obj-$(CONFIG_KXSD9) =C2=A0+=3D kxsd9.o
>>
>> =C2=A0lis3l02dq-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=3D lis3l02dq_core.=
o
>> diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio=
/accel/adis16209.h
>> new file mode 100644
>> index 0000000..1e59782
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16209.h
>> @@ -0,0 +1,171 @@
>> +#ifndef SPI_ADIS16209_H_
>> +#define SPI_ADIS16209_H_
>> +
>> +#define ADIS16209_STARTUP_DELAY =C2=A0 =C2=A0 =C2=A0220 /* ms */
>> +
>> +#define ADIS16209_READ_REG(a) =C2=A0 =C2=A0a
>> +#define ADIS16209_WRITE_REG(a) ((a) | 0x80)
>> +
> There are quite a few overlong lines in here. Some of the comments are ra=
ther
> on the obvious side, so some reorganization and removal of unecessary com=
ments
> should get this sorted out.
>> +#define ADIS16209_FLASH_CNT =C2=A0 =C2=A0 =C2=A00x00 /* Flash memory wr=
ite count */
>> +#define ADIS16209_SUPPLY_OUT =C2=A0 =C2=A0 0x02 /* Output, power supply=
 */
>> +#define ADIS16209_XACCL_OUT =C2=A0 =C2=A0 =C2=A00x04 /* Output, x-axis =
accelerometer */
>> +#define ADIS16209_YACCL_OUT =C2=A0 =C2=A0 =C2=A00x06 /* Output, y-axis =
accelerometer */
>> +#define ADIS16209_AUX_ADC =C2=A0 =C2=A0 =C2=A0 =C2=A00x08 /* Output, au=
xiliary ADC input */
>> +#define ADIS16209_TEMP_OUT =C2=A0 =C2=A0 =C2=A0 0x0A /* Output, tempera=
ture */
>> +#define ADIS16209_XINCL_OUT =C2=A0 =C2=A0 =C2=A00x0C /* Output, x-axis =
inclination */
>> +#define ADIS16209_YINCL_OUT =C2=A0 =C2=A0 =C2=A00x0E /* Output, y-axis =
inclination */
>> +#define ADIS16209_ROT_OUT =C2=A0 =C2=A0 =C2=A0 =C2=A00x10 /* Output, +/=
-180 vertical rotational position */
>> +#define ADIS16209_XACCL_NULL =C2=A0 =C2=A0 0x12 /* Calibration, x-axis =
acceleration offset null */
>> +#define ADIS16209_YACCL_NULL =C2=A0 =C2=A0 0x14 /* Calibration, y-axis =
acceleration offset null */
>> +#define ADIS16209_XINCL_NULL =C2=A0 =C2=A0 0x16 /* Calibration, x-axis =
inclination offset null */
>> +#define ADIS16209_YINCL_NULL =C2=A0 =C2=A0 0x18 /* Calibration, y-axis =
inclination offset null */
>> +#define ADIS16209_ROT_NULL =C2=A0 =C2=A0 =C2=A0 0x1A /* Calibration, ve=
rtical rotation offset null */
>> +#define ADIS16209_ALM_MAG1 =C2=A0 =C2=A0 =C2=A0 0x20 /* Alarm 1 amplitu=
de threshold */
>> +#define ADIS16209_ALM_MAG2 =C2=A0 =C2=A0 =C2=A0 0x22 /* Alarm 2 amplitu=
de threshold */
>> +#define ADIS16209_ALM_SMPL1 =C2=A0 =C2=A0 =C2=A00x24 /* Alarm 1, sample=
 period */
>> +#define ADIS16209_ALM_SMPL2 =C2=A0 =C2=A0 =C2=A00x26 /* Alarm 2, sample=
 period */
>> +#define ADIS16209_ALM_CTRL =C2=A0 =C2=A0 =C2=A0 0x28 /* Alarm control *=
/
>> +#define ADIS16209_AUX_DAC =C2=A0 =C2=A0 =C2=A0 =C2=A00x30 /* Auxiliary =
DAC data */
>> +#define ADIS16209_GPIO_CTRL =C2=A0 =C2=A0 =C2=A00x32 /* General-purpose=
 digital input/output control */
>> +#define ADIS16209_MSC_CTRL =C2=A0 =C2=A0 =C2=A0 0x34 /* Miscellaneous c=
ontrol */
>> +#define ADIS16209_SMPL_PRD =C2=A0 =C2=A0 =C2=A0 0x36 /* Internal sample=
 period (rate) control */
>> +#define ADIS16209_AVG_CNT =C2=A0 =C2=A0 =C2=A0 =C2=A00x38 /* Operation,=
 filter configuration */
>> +#define ADIS16209_SLP_CNT =C2=A0 =C2=A0 =C2=A0 =C2=A00x3A /* Operation,=
 sleep mode control */
>> +#define ADIS16209_DIAG_STAT =C2=A0 =C2=A0 =C2=A00x3C /* Diagnostics, sy=
stem status register */
>> +#define ADIS16209_GLOB_CMD =C2=A0 =C2=A0 =C2=A0 0x3E /* Operation, syst=
em command register */
>> +
>> +#define ADIS16209_OUTPUTS =C2=A0 =C2=A0 =C2=A0 =C2=A08
>> +
>> +/* MSC_CTRL */
>> +#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST =C2=A0 (1 << 10) /* Self-tes=
t at power-on: 1 =3D disabled, 0 =3D enabled */
>> +#define ADIS16209_MSC_CTRL_SELF_TEST_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 << 8) =C2=A0/* Self-test enable */
>> +#define ADIS16209_MSC_CTRL_DATA_RDY_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 << 2) =C2=A0/* Data-ready enable: 1 =3D enabled, 0 =3D=
 disabled */
>> +#define ADIS16209_MSC_CTRL_ACTIVE_HIGH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 << 1) =C2=A0/* Data-ready polarity: 1 =3D active high,=
 0 =3D active low */
>> +#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2 =C2=A0 =C2=A0 (1 << 0) =C2=A0/=
* Data-ready line selection: 1 =3D DIO2, 0 =3D DIO1 */
>> +
>> +/* DIAG_STAT */
>> +#define ADIS16209_DIAG_STAT_ALARM2 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1<<9) /*=
 Alarm 2 status: 1 =3D alarm active, 0 =3D alarm inactive */
>> +#define ADIS16209_DIAG_STAT_ALARM1 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1<<8) /*=
 Alarm 1 status: 1 =3D alarm active, 0 =3D alarm inactive */
>> +#define ADIS16209_DIAG_STAT_SELFTEST_FAIL (1<<5) /* Self-test diagnosti=
c error flag: 1 =3D error condition,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0 =3D normal operation */
>> +#define ADIS16209_DIAG_STAT_SPI_FAIL =C2=A0 (1<<3) /* SPI communication=
s failure */
>> +#define ADIS16209_DIAG_STAT_FLASH_UPT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1<<2) /* Flash update failure */
>> +#define ADIS16209_DIAG_STAT_POWER_HIGH =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1<<=
1) /* Power supply above 3.625 V */
>> +#define ADIS16209_DIAG_STAT_POWER_LOW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1<<0) /* Power supply below 3.15 V */
>> +
>> +/* GLOB_CMD */
>> +#define ADIS16209_GLOB_CMD_SW_RESET =C2=A0(1<<7)
>> +#define ADIS16209_GLOB_CMD_CLEAR_STAT =C2=A0 =C2=A0 =C2=A0 =C2=A0(1<<4)
>> +#define ADIS16209_GLOB_CMD_FACTORY_CAL =C2=A0 =C2=A0 =C2=A0 (1<<1)
>> +
>> +#define ADIS16209_MAX_TX 24
>> +#define ADIS16209_MAX_RX 24
>> +
>> +#define ADIS16209_SPI_BURST =C2=A0(u32)(1000 * 1000)
>> +#define ADIS16209_SPI_FAST =C2=A0 (u32)(2000 * 1000)
>> +
>> +/**
>> + * struct adis16209_state - device instance specific data
>> + * @us: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0actual spi_device
>> + * @work_trigger_to_ring: bh for triggered event handling
>> + * @work_cont_thresh: CLEAN
>> + * @inter: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used to check if new inte=
rrupt has been triggered
>> + * @last_timestamp: =C2=A0passing timestamp from th to bh of interrupt =
handler
>> + * @indio_dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 industr=
ial I/O device structure
>> + * @trig: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data ready trigger r=
egistered with iio
>> + * @tx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0transmit buffer
>> + * @rx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0recieve buffer
>> + * @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mu=
tex to protect tx and rx
>> + **/
>> +struct adis16209_state {
>> + =C2=A0 =C2=A0 struct spi_device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *us;
>> + =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0work_trigger_to_ring;
>> + =C2=A0 =C2=A0 struct iio_work_cont =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0work_cont_thresh;
>> + =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
>> + =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*indio_dev;
>> + =C2=A0 =C2=A0 struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*trig;
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
>> + =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
>> + =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
>> +};
>> +
>> +int adis16209_spi_write_reg_8(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 u8 reg_address,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 u8 val);
>> +
>> +int adis16209_spi_read_burst(struct device *dev, u8 *rx);
>> +
>> +int adis16209_spi_read_sequence(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 *tx, u8 *rx, int num);
>> +
>> +int adis16209_set_irq(struct device *dev, bool enable);
>> +
>> +int adis16209_reset(struct device *dev);
>> +
>> +int adis16209_stop_device(struct device *dev);
>> +
>> +int adis16209_check_status(struct device *dev);
>> +
>> +#ifdef CONFIG_IIO_RING_BUFFER
>> +enum adis16209_scan {
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_SUPPLY,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_ACC_X,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_ACC_Y,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_AUX_ADC,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_TEMP,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_INCLI_X,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_INCLI_Y,
>> + =C2=A0 =C2=A0 ADIS16209_SCAN_ROT,
>> +};
>> +
>> +void adis16209_remove_trigger(struct iio_dev *indio_dev);
>> +int adis16209_probe_trigger(struct iio_dev *indio_dev);
>> +
>> +ssize_t adis16209_read_data_from_ring(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *a=
ttr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf);
>> +
>> +int adis16209_configure_ring(struct iio_dev *indio_dev);
>> +void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
>> +
>> +int adis16209_initialize_ring(struct iio_ring_buffer *ring);
>> +void adis16209_uninitialize_ring(struct iio_ring_buffer *ring);
>> +#else /* CONFIG_IIO_RING_BUFFER */
>> +
>> +static inline void adis16209_remove_trigger(struct iio_dev *indio_dev)
>> +{
>> +}
>> +
>> +static inline int adis16209_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static inline ssize_t
>> +adis16209_read_data_from_ring(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int adis16209_configure_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static inline void adis16209_unconfigure_ring(struct iio_dev *indio_dev=
)
>> +{
>> +}
>> +
>> +static inline int adis16209_initialize_ring(struct iio_ring_buffer *rin=
g)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static inline void adis16209_uninitialize_ring(struct iio_ring_buffer *=
ring)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_IIO_RING_BUFFER */
>> +#endif /* SPI_ADIS16209_H_ */
>> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/stagin=
g/iio/accel/adis16209_core.c
>> new file mode 100644
>> index 0000000..fb0e66d
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16209_core.c
>> @@ -0,0 +1,654 @@
>> +/*
>> + * ADIS16209 Programmable Digital Vibration Sensor driver
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "accel.h"
>> +#include "../gyro/gyro.h"
>> +#include "../adc/adc.h"
>> +
>> +#include "adis16209.h"
>> +
>> +#define DRIVER_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16209"
>> +
>> +/**
>> + * adis16209_spi_write_reg_8() - write single byte to a register
>> + * @dev: device associated with child of actual device (iio_dev or iio_=
trig)
>> + * @reg_address: the address of the register to be written
>> + * @val: the value to write
>> + **/
>> +int adis16209_spi_write_reg_8(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 reg_address,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 val)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(indio=
_dev);
>> +
>> + =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
>> + =C2=A0 =C2=A0 st->tx[0] =3D ADIS16209_WRITE_REG(reg_address);
>> + =C2=A0 =C2=A0 st->tx[1] =3D val;
>> +
>> + =C2=A0 =C2=A0 ret =3D spi_write(st->us, st->tx, 2);
>> + =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}

adis16209_spi_write_reg_8 has been "static".

>> +
>> +/**
>> + * adis16209_spi_write_reg_16() - write 2 bytes to a pair of registers
>> + * @dev: device associated with child of actual device (iio_dev or iio_=
trig)
>> + * @reg_address: the address of the lower of the two registers. Second =
register
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to have =
address one greater.
>> + * @val: value to be written
>> + **/
>> +static int adis16209_spi_write_reg_16(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_address,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 value)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct spi_message msg;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(indio=
_dev);
>> + =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.tx_buf =3D st->tx,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.bits_per_word =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.len =3D 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.cs_change =3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.tx_buf =3D st->tx + 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.bits_per_word =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.len =3D 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.cs_change =3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 };
>> +
>> + =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
>> + =C2=A0 =C2=A0 st->tx[0] =3D ADIS16209_WRITE_REG(lower_reg_address);
>> + =C2=A0 =C2=A0 st->tx[1] =3D value & 0xFF;
>> + =C2=A0 =C2=A0 st->tx[2] =3D ADIS16209_WRITE_REG(lower_reg_address + 1)=
;
>> + =C2=A0 =C2=A0 st->tx[3] =3D (value >> 8) & 0xFF;
>> +
>> + =C2=A0 =C2=A0 spi_message_init(&msg);
>> + =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
>> + =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
>> + =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
>> + =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +/**
>> + * adis16209_spi_read_reg_16() - read 2 bytes from a 16-bit register
>> + * @dev: device associated with child of actual device (iio_dev or iio_=
trig)
>> + * @reg_address: the address of the lower of the two registers. Second =
register
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to have =
address one greater.
>> + * @val: somewhere to pass back the value read
>> + **/
>> +static int adis16209_spi_read_reg_16(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_address,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 *val)
>> +{
>> + =C2=A0 =C2=A0 struct spi_message msg;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(indio=
_dev);
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.tx_buf =3D st->tx,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.bits_per_word =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.len =3D 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.cs_change =3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.delay_usecs =3D 20,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.rx_buf =3D st->rx,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.bits_per_word =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.len =3D 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.cs_change =3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.delay_usecs =3D 20,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 };
>> +
>> + =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
>> + =C2=A0 =C2=A0 st->tx[0] =3D ADIS16209_READ_REG(lower_reg_address);
>> + =C2=A0 =C2=A0 st->tx[1] =3D 0;
>> +
>> + =C2=A0 =C2=A0 spi_message_init(&msg);
>> + =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
>> + =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
>> + =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->dev, "probl=
em when reading 16 bit register 0x%02X",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lower_reg_address);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 *val =3D (st->rx[0] << 8) | st->rx[1];
>> +
>> +error_ret:
>> + =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>
> I do wonder if this function shouldn't really be in the adis16209_ring.c
> as it is only used there and hence is just bloat if the buffering isn't e=
nabled.
> The disadvantage is it means one single read function is in a different p=
lace
> from all the others.
it has been movied to adis16209_ring.c and given a new name
adis16209_read_ring_data
>> +/**
>> + * adis16209_spi_read_burst() - read all data registers
>> + * @dev: device associated with child of actual device (iio_dev or iio_=
trig)
>> + * @rx: somewhere to pass back the value read
>> + **/
>> +int adis16209_spi_read_burst(struct device *dev, u8 *rx)
>> +{
>> + =C2=A0 =C2=A0 struct spi_message msg;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(indio=
_dev);
>> + =C2=A0 =C2=A0 struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
>> +
>> + =C2=A0 =C2=A0 spi_message_init(&msg);
>> +
>> + =C2=A0 =C2=A0 memset(xfers, 0, sizeof(xfers));
>> + =C2=A0 =C2=A0 for (i =3D 0; i <=3D ADIS16209_OUTPUTS; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].bits_per_word =3D 8=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].cs_change =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].len =3D 2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].delay_usecs =3D 20;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].tx_buf =3D st->tx +=
 2 * i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[2 * i] =3D ADIS16209_=
READ_REG(ADIS16209_SUPPLY_OUT + 2 * i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[2 * i + 1] =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i >=3D 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
xfers[i].rx_buf =3D rx + 2 * (i - 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[=
i], &msg);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->dev, "probl=
em when burst reading");
>> +
>> + =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
> I only see one size of signed read. =C2=A0Hence why does this nice genera=
l function
> exist? =C2=A0Admittedly the compiler probably squashes it, but it does ad=
d unecessary
> code. =C2=A0Not to mention it results in the mlock being held longer than=
 strictly
> necessary.

it has been merged into adis16209_read_14bit_signed()
>
>> +static ssize_t adis16209_spi_read_signed(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned bits)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 s16 val =3D 0;
>> + =C2=A0 =C2=A0 unsigned shift =3D 16 - bits;
>> + =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr)=
;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, this_attr->addres=
s, (u16 *)&val);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 val =3D ((s16)(val << shift) >> shift);
>> + =C2=A0 =C2=A0 return sprintf(buf, "%d\n", val);
>> +}
>> +
>> +static ssize_t adis16209_read_12bit_unsigned(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 u16 val =3D 0;
>> + =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr)=
;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, this_attr->addres=
s, &val);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u\n", val & 0x0FFF);
>> +}
>> +
>> +static ssize_t adis16209_read_14bit_unsigned(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 u16 val =3D 0;
>> + =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr)=
;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, this_attr->addres=
s, &val);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u\n", val & 0x3FFF);
>> +}
>> +
>> +static ssize_t adis16209_read_temp(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 ssize_t ret;
>> + =C2=A0 =C2=A0 s16 val;
>> +
>> + =C2=A0 =C2=A0 /* Take the iio_dev status lock */
>> + =C2=A0 =C2=A0 mutex_lock(&indio_dev->mlock);
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, ADIS16209_TEMP_OU=
T, (u16 *)&val);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> +
> I'm not sure on this. The datasheet doesn't list the temp as a 2's comp
> number? =C2=A0If it is please add a comment here to explain that!
datasheet shows  "Output at 25=C2=B0C :  1278   Scale Factor: =E2=88=920.47=
=C2=B0C/LSB. "
Then suppose output is 0, temp will be 625=C2=B0C, if it is 2047(2^11),
temp will -937=C2=B0C. I believe the value is only effective in a small
area since the chips only work  from =E2=88=9240=C2=B0C to +85=C2=B0C. So l=
ooking it as
signed /unsigned is not important at all. But i think it will be
better to leave it alone here without (<< 4) >> 4, but use &0xFFF.

>> + =C2=A0 =C2=A0 val =3D ((s16)(val << 4) >> 4);
>> + =C2=A0 =C2=A0 ret =3D sprintf(buf, "%d\n", val);
>> +
>> +error_ret:
>> + =C2=A0 =C2=A0 mutex_unlock(&indio_dev->mlock);
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
> As stated above, this might as well be rolled together with
> read_signed as this is the only user.
>
>> +static ssize_t adis16209_read_14bit_signed(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 ssize_t ret;
>> +
>> + =C2=A0 =C2=A0 /* Take the iio_dev status lock */
>> + =C2=A0 =C2=A0 mutex_lock(&indio_dev->mlock);
>> + =C2=A0 =C2=A0 ret =3D =C2=A0adis16209_spi_read_signed(dev, attr, buf, =
14);
>> + =C2=A0 =C2=A0 mutex_unlock(&indio_dev->mlock);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static ssize_t adis16209_write_16bit(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)
>> +{
>> + =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr)=
;
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 long val;
>> +
>> + =C2=A0 =C2=A0 ret =3D strict_strtol(buf, 10, &val);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_write_reg_16(dev, this_attr->addre=
ss, val);
>> +
>> +error_ret:
>> + =C2=A0 =C2=A0 return ret ? ret : len;
>> +}
>> +
>> +static ssize_t adis16209_write_reset(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *att=
r,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_t len)
>> +{
>> + =C2=A0 =C2=A0 if (len < 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> + =C2=A0 =C2=A0 switch (buf[0]) {
>> + =C2=A0 =C2=A0 case '1':
>> + =C2=A0 =C2=A0 case 'y':
>> + =C2=A0 =C2=A0 case 'Y':
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return adis16209_reset(dev);
>> + =C2=A0 =C2=A0 }
> Proper error please. -EINVAL seems the most sensible to me.
>
>> + =C2=A0 =C2=A0 return -1;
>> +}
>> +
> Whilst there is currently only one non probe user of this (and I don't th=
ink
> that multiple concurrent calls to that can occur), I'm a little dubious t=
hat
> no lock is taken to ensure msc isn't changed by someone else between the
> read and the write. =C2=A0Perhaps a comment to ensure that this is revist=
ed if
> event interupts are added?
>> +int adis16209_set_irq(struct device *dev, bool enable)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 u16 msc;
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, ADIS16209_MSC_CTR=
L, &msc);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> +
>> + =C2=A0 =C2=A0 msc |=3D ADIS16209_MSC_CTRL_ACTIVE_HIGH;
>> + =C2=A0 =C2=A0 msc &=3D ~ADIS16209_MSC_CTRL_DATA_RDY_DIO2;
>> + =C2=A0 =C2=A0 if (enable)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msc |=3D ADIS16209_MSC_CTRL_=
DATA_RDY_EN;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msc &=3D ~ADIS16209_MSC_CTRL=
_DATA_RDY_EN;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_write_reg_16(dev, ADIS16209_MSC_CT=
RL, msc);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> +
>> +error_ret:
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +int adis16209_reset(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_write_reg_8(dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ADIS16209_GLOB_CMD,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ADIS16209_GLOB_CMD_SW_RESET);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem resett=
ing device");
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static int adis16209_self_test(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_write_reg_16(dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ADIS16209_MSC_CTRL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ADIS16209_MSC_CTRL_SELF_TEST_EN);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem starti=
ng self test");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
>> + =C2=A0 =C2=A0 }
>> +
> check status can return an error code under some circumstances.
> It isn't currently handled.
>> + =C2=A0 =C2=A0 adis16209_check_status(dev);
>> +
>> +err_ret:
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +int adis16209_check_status(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 u16 status;
>> + =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_spi_read_reg_16(dev, ADIS16209_DIAG_ST=
AT, &status);
>> + =C2=A0 =C2=A0 if (ret < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Reading status=
 failed\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 ret =3D status & 0x1F;
>> +
>> + =C2=A0 =C2=A0 if (status & ADIS16209_DIAG_STAT_SELFTEST_FAIL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Self test fail=
ure\n");
>> + =C2=A0 =C2=A0 if (status & ADIS16209_DIAG_STAT_SPI_FAIL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "SPI failure\n"=
);
>> + =C2=A0 =C2=A0 if (status & ADIS16209_DIAG_STAT_FLASH_UPT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Flash update f=
ailed\n");
>> + =C2=A0 =C2=A0 if (status & ADIS16209_DIAG_STAT_POWER_HIGH)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Power supply a=
bove 3.625V\n");
>> + =C2=A0 =C2=A0 if (status & ADIS16209_DIAG_STAT_POWER_LOW)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Power supply b=
elow 3.15V\n");
>> +
>> +error_ret:
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static int adis16209_initial_setup(struct adis16209_state *st)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct device *dev =3D &st->indio_dev->dev;
>> +
>> + =C2=A0 =C2=A0 /* Disable IRQ */
>> + =C2=A0 =C2=A0 ret =3D adis16209_set_irq(dev, false);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "disable irq fa=
iled");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* Do self test */
>> + =C2=A0 =C2=A0 ret =3D adis16209_self_test(dev);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "self test fail=
ure");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
>> + =C2=A0 =C2=A0 }
> The result of the logic here is to clear other errors
> (by reading status). =C2=A0It won't even fail if the self
> test fails, just print an error. =C2=A0Now if the next read
> occurs fast enough (before next sample cycle) any other
> errors will not have been re asserted. (particularly
> important if we have power supply problems!).
Yes. but not sure what we should do after finding an error. It
probably means a hardware error.
I'd like to handle this as enhancement with more information from
hardware team later.
>> +
>> + =C2=A0 =C2=A0 /* Read status register to check the result */
>> + =C2=A0 =C2=A0 ret =3D adis16209_check_status(dev);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_reset(dev);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "device not pla=
ying ball -> reset");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(ADIS16209_STARTUP_DEL=
AY);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_check_stat=
us(dev);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dev_err(dev, "giving up");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto err_ret;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
st->us->chip_select, st->us->irq);
>> +
>> +err_ret:
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16209_read_14bit_unsigned,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_SUPPLY_OUT);
>> +static IIO_CONST_ATTR(in_supply_scale, "0.30518 mV");
>> +static IIO_DEV_ATTR_IN_RAW(0, adis16209_read_12bit_unsigned,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_AUX_ADC);
> In the abi doc these should be scalling to volts (and no unit is needed).
>> +static IIO_CONST_ATTR(in0_scale, "0.6105 mV");
>> +
>> +static IIO_DEV_ATTR_ACCEL_X(adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_XACCL_OUT);
>> +static IIO_DEV_ATTR_ACCEL_Y(adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_YACCL_OUT);
>> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_write_16bit,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_XACCL_NULL);
>> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_write_16bit,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_YACCL_NULL);
>> +static IIO_CONST_ATTR(accel_scale, "0.24414 mg");
>> +
>
> I've only just noticed (as I lifted it without a close enough read)
> that gyro.h include inclinometer readings. =C2=A0Given they are accelerat=
ion
> based we can either move them to accel.h or given they might be establish=
ed
> in some other way, create an incli.h file to contain them.
>
> These (along with the rest of gyro.h) need updating to the _raw naming.
> Whether that happens before or after this patch depends on what other
> people want to say about this!
>
>> +static IIO_DEV_ATTR_INCLI_X(adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_XINCL_OUT);
>> +static IIO_DEV_ATTR_INCLI_Y(adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_YINCL_OUT);
>> +static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_write_16bit,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_XACCL_NULL);
>> +static IIO_DEV_ATTR_INCLI_Y_OFFSET(S_IWUSR | S_IRUGO,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_write_16bit,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_YACCL_NULL);
> Again, no units plase.
>> +static IIO_CONST_ATTR(incli_scale, "0.025 D");
>> +
> Hmm.. This one is a bit device specific to my mind. =C2=A0What do
> people think? In a sense it is just a signed version of inclination.
> Perhaps this is something for documentation rather than in the naming
> itself. =C2=A0I'll try and bash out an explanation (the diagrams on the d=
ata
> sheet are pretty good for the curious) and add that to the abi spec.
>
>> +static IIO_DEV_ATTR_ROT(adis16209_read_14bit_signed,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16209_ROT_OUT);
>> +
> I admit to being somewhat confused by the temp part of the
> data sheet. =C2=A0As written here, I would expect the example
> reading of 0x04FE as given on the datasheet (as 25 degrees C)
> to be 25 - 0.47* 0x4FE Kelvin which I make -898.66 degrees C
>
> As 4FE even if assumed to be 2's complement 12 bit is a positive
> number. =C2=A0Can someone with the magic abilities to understand that bit
> of the data sheet explain how it is meant to work!
>
> Whilst we are here, the intent is to have all readings in standard
> units (and hence not supply the units in sysfs - just like hwmon
> does it). =C2=A0However we can clean these out and standardise everything
> in a later patch set (along with documenting the choices).
ok
>> +static IIO_DEV_ATTR_TEMP(adis16209_read_temp);
>> +static IIO_CONST_ATTR(temp_offset, "25 K");
>> +static IIO_CONST_ATTR(temp_scale, "-0.47 K");
>> +
>> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16209_write_reset, 0);
>> +
>> +static IIO_CONST_ATTR(name, "adis16209");
>> +
> If we need to have this defined as empty I've got a bug in the core code.
> I have a couple of drivers without event lines so I think this is definit=
ely
> unecessary. I guess there might be an interaction with the trigger code I
> haven't handled right. Please poke me if there
kernel will panic when register interrupt in iio after deleting this.
There should be some unnecessary couple in core.

>> +static struct attribute *adis16209_event_attributes[] =3D {
>> + =C2=A0 =C2=A0 NULL
>> +};
>> +
>> +static struct attribute_group adis16209_event_attribute_group =3D {
>> + =C2=A0 =C2=A0 .attrs =3D adis16209_event_attributes,
>> +};
>> +
>> +static struct attribute *adis16209_attributes[] =3D {
>> + =C2=A0 =C2=A0 &iio_dev_attr_in_supply_raw.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_in_supply_scale.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_temp.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_temp_offset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_temp_scale.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_reset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_name.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_in0_raw.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_in0_scale.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_accel_x_raw.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_accel_y_raw.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_accel_x_offset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_accel_y_offset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_accel_scale.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_incli_x.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_incli_y.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_incli_x_offset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_incli_y_offset.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_const_attr_incli_scale.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_dev_attr_rot.dev_attr.attr,
>> + =C2=A0 =C2=A0 NULL
>> +};
>> +
>> +static const struct attribute_group adis16209_attribute_group =3D {
>> + =C2=A0 =C2=A0 .attrs =3D adis16209_attributes,
>> +};
>> +
>> +static int __devinit adis16209_probe(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 int ret, regdone =3D 0;
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D kzalloc(sizeof *st, GFP_K=
ERNEL);
>> + =C2=A0 =C2=A0 if (!st) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0-ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 /* this is only used for removal purposes */
>> + =C2=A0 =C2=A0 spi_set_drvdata(spi, st);
>> +
>> + =C2=A0 =C2=A0 /* Allocate the comms buffers */
>> + =C2=A0 =C2=A0 st->rx =3D kzalloc(sizeof(*st->rx)*ADIS16209_MAX_RX, GFP=
_KERNEL);
>> + =C2=A0 =C2=A0 if (st->rx =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_st;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 st->tx =3D kzalloc(sizeof(*st->tx)*ADIS16209_MAX_TX, GFP=
_KERNEL);
>> + =C2=A0 =C2=A0 if (st->tx =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_rx;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 st->us =3D spi;
>> + =C2=A0 =C2=A0 mutex_init(&st->buf_lock);
>> + =C2=A0 =C2=A0 /* setup the industrialio driver allocated elements */
>> + =C2=A0 =C2=A0 st->indio_dev =3D iio_allocate_device();
>> + =C2=A0 =C2=A0 if (st->indio_dev =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_tx;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 st->indio_dev->dev.parent =3D &spi->dev;
>> + =C2=A0 =C2=A0 st->indio_dev->num_interrupt_lines =3D 1;
>> + =C2=A0 =C2=A0 st->indio_dev->event_attrs =3D &adis16209_event_attribut=
e_group;
> As per the above comment, I think the two lines above can go away for
> now.
>
>> + =C2=A0 =C2=A0 st->indio_dev->attrs =3D &adis16209_attribute_group;
>> + =C2=A0 =C2=A0 st->indio_dev->dev_data =3D (void *)(st);
>> + =C2=A0 =C2=A0 st->indio_dev->driver_module =3D THIS_MODULE;
>> + =C2=A0 =C2=A0 st->indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_configure_ring(st->indio_dev);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_dev;
>> +
>> + =C2=A0 =C2=A0 ret =3D iio_device_register(st->indio_dev);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_unreg_ring_funcs;
>> + =C2=A0 =C2=A0 regdone =3D 1;
>> +
>> + =C2=A0 =C2=A0 ret =3D adis16209_initialize_ring(st->indio_dev->ring);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "failed to i=
nitialize the ring\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_unreg_ring_funcs;
>> + =C2=A0 =C2=A0 }
>> +
> I'm guessing this might actually have come out of some of my code, but
> then I'm still learning :) Do we actually need the gpio_is_valid call?
> At the end of the day, if the interrupt is specified do we care about
> the gpio bit? =C2=A0If we do, can we have a comment as its not obvious to=
 me!
gpio_is_valid call is not necessary here. request_irq will fail if the
external irq number is invalid.

>
>> + =C2=A0 =C2=A0 if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0=
) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D iio_register_interru=
pt_line(spi->irq,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 st->indio_dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_TRIGGER_RISING,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "adis16209");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto error_uninitialize_ring;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_probe_trig=
ger(st->indio_dev);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto error_unregister_line;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* Get the device into a sane initial state */
>> + =C2=A0 =C2=A0 ret =3D adis16209_initial_setup(st);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_remove_trigger;
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +error_remove_trigger:
>> + =C2=A0 =C2=A0 if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16209_remove_trigger(st-=
>indio_dev);
>> +error_unregister_line:
>> + =C2=A0 =C2=A0 if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_interrupt_lin=
e(st->indio_dev, 0);
>> +error_uninitialize_ring:
>> + =C2=A0 =C2=A0 adis16209_uninitialize_ring(st->indio_dev->ring);
>> +error_unreg_ring_funcs:
>> + =C2=A0 =C2=A0 adis16209_unconfigure_ring(st->indio_dev);
>> +error_free_dev:
>> + =C2=A0 =C2=A0 if (regdone)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(st->in=
dio_dev);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_free_device(st->indio_de=
v);
>> +error_free_tx:
>> + =C2=A0 =C2=A0 kfree(st->tx);
>> +error_free_rx:
>> + =C2=A0 =C2=A0 kfree(st->rx);
>> +error_free_st:
>> + =C2=A0 =C2=A0 kfree(st);
>> +error_ret:
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
> Has this been confirmed? =C2=A0 I'm guessing not, so perhaps
> I pinched this one from your tree to early!
>> +/* fixme, confirm ordering in this function */
>> +static int adis16209_remove(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D spi_get_drvdata(spi);
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
>> +
>> + =C2=A0 =C2=A0 flush_scheduled_work();
>> +
> I think this should be in the if statement below. (to match the probe).

Here i think if statement is useless in probe, there has been an empty
adis16209_remove_trigger() function for non-ring.
iio_unregister_interrupt_line should always be called if spi->irq is
valid:
error_remove_trigger:
-        if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
                adis16209_remove_trigger(st->indio_dev);
error_unregister_line:
-        if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+       if (spi->irq)
                iio_unregister_interrupt_line(st->indio_dev, 0);

>> + =C2=A0 =C2=A0 adis16209_remove_trigger(indio_dev);
>> + =C2=A0 =C2=A0 if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0=
)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_interrupt_lin=
e(indio_dev, 0);
>> +
>> + =C2=A0 =C2=A0 adis16209_uninitialize_ring(indio_dev->ring);
>
> I think the next two are in the wrong order. Probably doesn't matter, but
> it'll read more coherently the other way round (as they reverse what
> goes on in probe).
It should be
iio_device_unregister(indio_dev);
adis16209_unconfigure_ring(indio_dev);
for the moment.

>> + =C2=A0 =C2=A0 adis16209_unconfigure_ring(indio_dev);
>> + =C2=A0 =C2=A0 iio_device_unregister(indio_dev);
>> + =C2=A0 =C2=A0 kfree(st->tx);
>> + =C2=A0 =C2=A0 kfree(st->rx);
>> + =C2=A0 =C2=A0 kfree(st);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static struct spi_driver adis16209_driver =3D {
>> + =C2=A0 =C2=A0 .driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "adis16209",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE,
>> + =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 .probe =3D adis16209_probe,
>> + =C2=A0 =C2=A0 .remove =3D __devexit_p(adis16209_remove),
>> +};
>> +
>> +static __init int adis16209_init(void)
>> +{
>> + =C2=A0 =C2=A0 return spi_register_driver(&adis16209_driver);
>> +}
>> +module_init(adis16209_init);
>> +
>> +static __exit void adis16209_exit(void)
>> +{
>> + =C2=A0 =C2=A0 spi_unregister_driver(&adis16209_driver);
>> +}
>> +module_exit(adis16209_exit);
>> +
>> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Programmable Digital Vibra=
tion Sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/stagin=
g/iio/accel/adis16209_ring.c
>> new file mode 100644
>> index 0000000..9e2073f
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16209_ring.c
>> @@ -0,0 +1,219 @@
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../ring_sw.h"
>> +#include "accel.h"
>> +#include "../trigger.h"
>> +#include "adis16209.h"
>> +
>> +/**
>> + * combine_8_to_16() utility function to munge to u8s into u16
>> + **/
>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>> +{
>> + =C2=A0 =C2=A0 u16 _lower =3D lower;
>> + =C2=A0 =C2=A0 u16 _upper =3D upper;
>> + =C2=A0 =C2=A0 return _lower | (_upper << 8);
>> +}
>> +
> Hmm. before the recent abi change, there was no point in having read only
> scan elements. =C2=A0Now we need that ability. =C2=A0I'll add the functio=
nality to the
> core and update drivers appropriately. As things currently stand I think
> this will change the scan_count, without actually changing what is incomm=
ing
> as we never disable channels.
>> +static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_SUPPLY_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_XACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_YACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(aux_adc, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_AUX_ADC, NULL);
>> +static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_SIGNED(12),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_TEMP_OUT, NULL);
>> +static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_XINCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_YINCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS1620=
9_ROT_OUT, NULL);
>> +
>> +static IIO_SCAN_EL_TIMESTAMP(8);
>> +
>> +static struct attribute *adis16209_scan_el_attrs[] =3D {
>> + =C2=A0 =C2=A0 &iio_scan_el_supply.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_accel_x.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_accel_y.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_aux_adc.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_temp.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_incli_x.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_incli_y.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_rot.dev_attr.attr,
>> + =C2=A0 =C2=A0 &iio_scan_el_timestamp.dev_attr.attr,
>> + =C2=A0 =C2=A0 NULL,
>> +};
>> +
>> +static struct attribute_group adis16209_scan_el_group =3D {
>> + =C2=A0 =C2=A0 .attrs =3D adis16209_scan_el_attrs,
>> + =C2=A0 =C2=A0 .name =3D "scan_elements",
>> +};
>> +
>> +/**
>> + * adis16209_poll_func_th() top half interrupt handler called by trigge=
r
>> + * @private_data: =C2=A0 =C2=A0iio_dev
>> + **/
>> +static void adis16209_poll_func_th(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(indio=
_dev);
>> + =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
>> + =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
>> +}
>> +
>> +/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to=
 device
>> + * specific to be rolled into the core.
>> + */
>> +static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_s, str=
uct adis16209_state,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0work_trigger_to_ring);
>> +
>> + =C2=A0 =C2=A0 int i =3D 0;
>> + =C2=A0 =C2=A0 s16 *data;
>> + =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd(st->i=
ndio_dev->ring);
>> +
>> + =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (data =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->dev, "memor=
y alloc failed in ring bh");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
> As things currently stand (I think all scan elements are read only) this =
could
> be greatly simplified. (afterall scan count etc are fixed). =C2=A0However=
 this is
> good initial work for moving to scan element selection should anyone want=
 to
> in the future (this certainly is not a requirement until someone actually=
 cares!).
>> + =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adis16209_spi_read_burst=
(&st->indio_dev->dev, st->rx) >=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
for (; i < st->indio_dev->scan_count; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[i*2+1],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}
>> +
>> + =C2=A0 =C2=A0 /* Guaranteed to be aligned with 8 byte boundary */
>> + =C2=A0 =C2=A0 if (st->indio_dev->scan_timestamp)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((s64 *)(data + ((i + 3)/4)=
*4)) =3D st->last_timestamp;
>> +
>> + =C2=A0 =C2=A0 st->indio_dev->ring->access.store_to(st->indio_dev->ring=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u8 *=
)data,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->l=
ast_timestamp);
>> +
>> + =C2=A0 =C2=A0 iio_trigger_notify_done(st->indio_dev->trig);
>> + =C2=A0 =C2=A0 kfree(data);
>> +
>> + =C2=A0 =C2=A0 return;
>> +}
> Hehe. That looks suspiciously like something I would have writen a long t=
ime
> back. Oh. It's still in the lis3l02dq as well. For reference I decided th=
at no,
> aligned data is much simpler. =C2=A0If anyone prefers unalighted they can=
 figure out
> how to do it.
>
>> +/* in these circumstances is it better to go with unaligned packing and
>> + * deal with the cost?*/
>> +static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 size_t size;
>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> + =C2=A0 =C2=A0 /* Check if there are any scan elements enabled, if not =
fail*/
>> + =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan_timestamp=
))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->scan_timestam=
p)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (indio_dev->scan_count) /* Timestamp and data */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 3*sizeof(s64);
> That is nasty. =C2=A0 Please change to something based on actual sizes. =
=C2=A0It would
> actually be preferable to hard code them to this random looking 3 *.
It is replaced by:
size =3D (((indio_dev->scan_count * sizeof(s16)) + sizeof(s64) - 1) &
~(sizeof(s64) - 1))
                                        + sizeof(s64);
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
else /* Timestamp only =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
size =3D indio_dev->scan_count*sizeof(s16);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->access.set_=
bpd(indio_dev->ring, size);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int adis16209_data_rdy_ring_postenable(struct iio_dev *indio_dev=
)
>> +{
>> + =C2=A0 =C2=A0 return indio_dev->trig
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_attach_poll_fu=
nc(indio_dev->trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0indio_dev->pollfunc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
>> +}
>> +
>> +static int adis16209_data_rdy_ring_predisable(struct iio_dev *indio_dev=
)
>> +{
>> + =C2=A0 =C2=A0 return indio_dev->trig
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dettach_poll_f=
unc(indio_dev->trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 indio_dev->pollfunc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
>> +}
>> +
>> +void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>> +}
>> +
>> +int adis16209_configure_ring(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D indio_dev->dev_data;
>> + =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
>> + =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_b=
h_to_ring);
>> + =C2=A0 =C2=A0 /* Set default scan mode */
>> +
> Don't know who did this first, but I rather like it. I was just writing
> directly to the relevant mask. This is much clearer.
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_rot.number);
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number)=
;
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number)=
;
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number)=
;
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number)=
;
>> + =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number)=
;
>> + =C2=A0 =C2=A0 indio_dev->scan_timestamp =3D true;
>> +
>> + =C2=A0 =C2=A0 indio_dev->scan_el_attrs =3D &adis16209_scan_el_group;
>> +
>> + =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
>> + =C2=A0 =C2=A0 if (!ring) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 indio_dev->ring =3D ring;
>> + =C2=A0 =C2=A0 /* Effectively select the ring buffer implementation */
>> + =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
>> + =C2=A0 =C2=A0 ring->preenable =3D &adis16209_data_rdy_ring_preenable;
>> + =C2=A0 =C2=A0 ring->postenable =3D &adis16209_data_rdy_ring_postenable=
;
>> + =C2=A0 =C2=A0 ring->predisable =3D &adis16209_data_rdy_ring_predisable=
;
>> + =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
>> +
>> + =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollf=
unc), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_rb_free;;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis16209_poll_=
func_th;
>> + =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_dev;
>> + =C2=A0 =C2=A0 indio_dev->modes |=3D INDIO_RING_TRIGGERED;
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +error_iio_sw_rb_free:
>> + =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +int adis16209_initialize_ring(struct iio_ring_buffer *ring)
>> +{
>> + =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
>> +}
>> +
>> +void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
>> +{
>> + =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
>> +}
>> diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/sta=
ging/iio/accel/adis16209_trigger.c
>> new file mode 100644
>> index 0000000..4a0507c
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16209_trigger.c
>> @@ -0,0 +1,124 @@
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../trigger.h"
>> +#include "adis16209.h"
>> +
>> +/**
>> + * adis16209_data_rdy_trig_poll() the event handler for the data rdy tr=
ig
>> + **/
>> +static int adis16209_data_rdy_trig_poll(struct iio_dev *dev_info,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64 timestamp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no_test)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata(dev_i=
nfo);
>> + =C2=A0 =C2=A0 struct iio_trigger *trig =3D st->trig;
>> +
>> + =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
>> + =C2=A0 =C2=A0 iio_trigger_poll(trig);
>> +
>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +IIO_EVENT_SH(data_rdy_trig, &adis16209_data_rdy_trig_poll);
>> +
>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>> +
>> +static struct attribute *adis16209_trigger_attrs[] =3D {
>> + =C2=A0 =C2=A0 &dev_attr_name.attr,
>> + =C2=A0 =C2=A0 NULL,
>> +};
>> +
>> +static const struct attribute_group adis16209_trigger_attr_group =3D {
>> + =C2=A0 =C2=A0 .attrs =3D adis16209_trigger_attrs,
>> +};
>> +
>> +/**
>> + * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
>> + **/
>> +static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *tri=
g,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool state)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>> + =C2=A0 =C2=A0 ret =3D adis16209_set_irq(&st->indio_dev->dev, state);
>> + =C2=A0 =C2=A0 if (state =3D=3D false) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_remove_event_from_list(&=
iio_event_data_rdy_trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&indio=
_dev->interrupts[0]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0->ev_l=
ist);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_add_event_to_list(&iio_e=
vent_data_rdy_trig,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->interrupts[0]-=
>ev_list);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +/**
>> + * adis16209_trig_try_reen() try renabling irq for data rdy trigger
>> + * @trig: =C2=A0 =C2=A0the datardy trigger
>> + **/
>> +static int adis16209_trig_try_reen(struct iio_trigger *trig)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D trig->private_data;
>> + =C2=A0 =C2=A0 enable_irq(st->us->irq);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +int adis16209_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 struct adis16209_state *st =3D indio_dev->dev_data;
>> +
>> + =C2=A0 =C2=A0 st->trig =3D iio_allocate_trigger();
>> + =C2=A0 =C2=A0 st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_=
KERNEL);
>> + =C2=A0 =C2=A0 if (!st->trig->name) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 snprintf((char *)st->trig->name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_TRIGGER_NAME_LENGT=
H,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16209-dev%d", ind=
io_dev->id);
>> + =C2=A0 =C2=A0 st->trig->dev.parent =3D &st->us->dev;
>> + =C2=A0 =C2=A0 st->trig->owner =3D THIS_MODULE;
>> + =C2=A0 =C2=A0 st->trig->private_data =3D st;
>> + =C2=A0 =C2=A0 st->trig->set_trigger_state =3D &adis16209_data_rdy_trig=
ger_set_state;
>> + =C2=A0 =C2=A0 st->trig->try_reenable =3D &adis16209_trig_try_reen;
>> + =C2=A0 =C2=A0 st->trig->control_attrs =3D &adis16209_trigger_attr_grou=
p;
>> + =C2=A0 =C2=A0 ret =3D iio_trigger_register(st->trig);
>> +
>> + =C2=A0 =C2=A0 /* select default trigger */
>> + =C2=A0 =C2=A0 indio_dev->trig =3D st->trig;
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_trig_name;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +
>> +error_free_trig_name:
>> + =C2=A0 =C2=A0 kfree(st->trig->name);
>> +error_free_trig:
>> + =C2=A0 =C2=A0 iio_free_trigger(st->trig);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +void adis16209_remove_trigger(struct iio_dev *indio_dev)
>> +{
>> + =C2=A0 =C2=A0 struct adis16209_state *state =3D indio_dev->dev_data;
>> +
>> + =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
>> + =C2=A0 =C2=A0 kfree(state->trig->name);
>> + =C2=A0 =C2=A0 iio_free_trigger(state->trig);
>> +}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
