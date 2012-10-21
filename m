Return-Path: <marxin.liska@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201209111121.34205.marex@denx.de>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
	<4FFADCC2.6080006@cam.ac.uk>
	<CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
	<201209111121.34205.marex@denx.de>
Date: Sun, 21 Oct 2012 19:02:43 +0200
Message-ID: <CAObPJ3PB0VYNE9vhrwJRA9jpWX6p7_Kw8T2eCMgj0M0zJ9feUA@mail.gmail.com>
Subject: Re: ACPI ambient light sensor
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, platform-driver-x86@vger.kernel.org,
	linux-iio@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Corentin Chary <corentin.chary@gmail.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de, Jonathan Cameron <jic23@kernel.org>,
	Jon Brenner <jbrenner@taosinc.com>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: multipart/alternative; boundary=bcaec54c52fc90ad0504cc94b44e
List-ID: <linux-iio@vger.kernel.org>

--bcaec54c52fc90ad0504cc94b44e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,
   my kernel driver is still unable to start capturing in a proper way.
First step for listening is

* echo 1 >
/sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*
*
*
but

*cat /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*
*-1*
*
*
I tried to decorate all result codes with printf.
Dmesg dump:
*[    0.927335] XXX: trigger init called*
*[    0.928148] XXX: acpi_als_allocate_trigger: 0*
*[    0.928275] XXX: acpi_als_trigger_init: 0*
*[    3.255305] XXX: getting data for filling buffer*
*[    3.255352] XXX: buffer is ready*
*[   27.423650] XXX: getting data for filling buffer*
*[   27.423698] XXX: buffer is ready*
*[   30.444120] XXX: getting data for filling buffer*

Do you have any advices how to figure out where is problem?

Thank you,
Martin


/*
 * ACPI Ambient Light Sensor Driver
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License fo=
r
 * more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <linux/module.h>
#include <linux/interrupt.h>
#include <trace/events/printk.h>
#include <acpi/acpi_bus.h>
#include <acpi/acpi_drivers.h>
#include <linux/err.h>
#include <linux/mutex.h>

#include <linux/iio/iio.h>
#include <linux/iio/buffer.h>
#include <linux/iio/sysfs.h>
#include <linux/iio/trigger.h>
#include <linux/iio/trigger_consumer.h>
#include <linux/iio/triggered_buffer.h>

#define PREFIX "ACPI: "

#define ACPI_ALS_CLASS "als"
#define ACPI_ALS_DEVICE_NAME "acpi-als"
#define ACPI_ALS_NOTIFY_ILLUMINANCE 0x80
#define ACPI_ALS_NOTIFY_COLOR_TEMP 0x81
#define ACPI_ALS_NOTIFY_RESPONSE 0x82

#define ACPI_ALS_OUTPUTS 3

#define _COMPONENT ACPI_ALS_COMPONENT
ACPI_MODULE_NAME("acpi-als");

MODULE_AUTHOR("Martin Liska");
MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
MODULE_LICENSE("GPL");

struct acpi_als_chip {
struct acpi_device *device;
struct acpi_als_device *acpi_als_sys;
struct mutex lock;
struct iio_trigger *trig;

int illuminance;
int temperature;
int chromaticity;
int polling;

int count;
struct acpi_als_mapping *mappings;
};

static int acpi_als_add(struct acpi_device *device);
static int acpi_als_remove(struct acpi_device *device, int type);
static void acpi_als_notify(struct acpi_device *device, u32 event);

static const struct acpi_device_id acpi_als_device_ids[] =3D {
{"ACPI0008", 0},
{"", 0},
};

MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);

static struct acpi_driver acpi_als_driver =3D {
.name =3D "acpi_als",
.class =3D ACPI_ALS_CLASS,
.ids =3D acpi_als_device_ids,
.ops =3D {
.add =3D acpi_als_add,
.remove =3D acpi_als_remove,
.notify =3D acpi_als_notify,
},
};

struct acpi_als_mapping {
int adjustment;
int illuminance;
};

#define ALS_INVALID_VALUE_LOW 0
#define ALS_INVALID_VALUE_HIGH -1

/*
--------------------------------------------------------------------------
Ambient Light Sensor device Management

 --------------------------------------------------------------------------
*/

/*
 * acpi_als_get_illuminance - get the current ambient light illuminance
 */
static int acpi_als_get_illuminance(struct acpi_als_chip *als)
{
acpi_status status;
unsigned long long illuminance;

status =3D acpi_evaluate_integer(als->device->handle,
"_ALI", NULL, &illuminance);

if (ACPI_FAILURE(status)) {
ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS illuminance"));
als->illuminance =3D ALS_INVALID_VALUE_LOW;
return -ENODEV;
}
als->illuminance =3D illuminance;

return 0;
}

/*
 * acpi_als_get_color_chromaticity - get the ambient light color
chromaticity
 */
static int acpi_als_get_color_chromaticity(struct acpi_als_chip *chip)
{
acpi_status status;
unsigned long long chromaticity;

status =3D
    acpi_evaluate_integer(chip->device->handle, "_ALC", NULL,
  &chromaticity);
if (ACPI_FAILURE(status)) {
ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALC not available\n"));
return -ENODEV;
}
chip->chromaticity =3D chromaticity;
return 0;
}

/*
 * acpi_als_get_color_temperature - get the ambient light color temperature
 */
static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)
{
acpi_status status;
unsigned long long temperature;

status =3D
    acpi_evaluate_integer(chip->device->handle, "_ALT", NULL,
  &temperature);
if (ACPI_FAILURE(status)) {
ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALT not available\n"));
return -ENODEV;
}
chip->temperature =3D temperature;
return 0;
}

/*
 * acpi_als_get_mappings - get the ALS illuminance mappings
 *
 * Return a package of ALS illuminance to display adjustment mappings
 * that can be used by OS to calibrate its ambient light policy
 * for a given sensor configuration.
 */
static int acpi_als_get_mappings(struct acpi_als_chip *chip)
{
int result =3D 0;
acpi_status status;
struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
union acpi_object *alr;
int i, j;

/* Free the old mappings */
kfree(chip->mappings);
chip->mappings =3D NULL;

status =3D
    acpi_evaluate_object(chip->device->handle, "_ALR", NULL, &buffer);
if (ACPI_FAILURE(status)) {
ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS mappings"));
return -ENODEV;
}

alr =3D buffer.pointer;
if (!alr || (alr->type !=3D ACPI_TYPE_PACKAGE)) {
printk(KERN_ERR PREFIX "Invalid _ALR data\n");
result =3D -EFAULT;
goto end;
}

ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d illuminance mappings\n",
  alr->package.count));

chip->count =3D alr->package.count;

if (!chip->count)
return 0;

chip->mappings =3D
    kmalloc(sizeof(struct acpi_als_mapping) * chip->count, GFP_KERNEL);
if (!chip->mappings) {
result =3D -ENOMEM;
goto end;
}

for (i =3D 0, j =3D 0; i < chip->count; i++) {
struct acpi_als_mapping *mapping =3D &(chip->mappings[j]);
union acpi_object *element =3D &(alr->package.elements[i]);

if (element->type !=3D ACPI_TYPE_PACKAGE)
continue;

if (element->package.count !=3D 2)
continue;

if (element->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
    element->package.elements[1].type !=3D ACPI_TYPE_INTEGER)
continue;

mapping->adjustment =3D
    element->package.elements[0].integer.value;
mapping->illuminance =3D
    element->package.elements[1].integer.value;
j++;

ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Mapping [%d]: "
  "adjustment [%d] illuminance[%d]\n",
  i, mapping->adjustment,
  mapping->illuminance));
}

end:
kfree(buffer.pointer);
return result;
}

/*
 * acpi_als_get_polling - get a recommended polling frequency
 *    for the Ambient Light Sensor device
 */
static int acpi_als_get_polling(struct acpi_als_chip *chip)
{
acpi_status status;
unsigned long long polling;

status =3D
    acpi_evaluate_integer(chip->device->handle, "_ALP", NULL, &polling);
if (ACPI_FAILURE(status)) {
ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
return -ENODEV;
}

chip->polling =3D polling;
return 0;
}

static int get_illuminance(struct acpi_als_chip *als, int *illuminance)
{
int result;

result =3D acpi_als_get_illuminance(als);
if (!result)
*illuminance =3D als->illuminance;

return result;
}

static void acpi_als_notify(struct acpi_device *device, u32 event)
{
int illuminance;
struct iio_dev *indio_dev =3D acpi_driver_data(device);
        struct iio_buffer *buffer =3D indio_dev->buffer;
struct acpi_als_chip *chip =3D iio_priv(indio_dev);
        s64 time_ns =3D iio_get_time_ns();
int len =3D 2;

u8 data[sizeof(s64) + len];

printk("XXX: getting data for filling buffer\n");
get_illuminance(chip, &illuminance);
 *(int *)((u8 *)data) =3D illuminance;
*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) =3D time_ns;

printk("XXX: buffer is ready\n");

        if (iio_buffer_enabled(indio_dev)) {
printk("XXX: pushing to buffer\n");
iio_push_to_buffer(buffer, data);
printk("XXX: push to buffer called\n");
}
}

static int acpi_als_read_raw(struct iio_dev *indio_dev,
struct iio_chan_spec const *chan, int *val, int *val2, long mask)
{
struct acpi_als_chip *chip =3D iio_priv(indio_dev);
int ret =3D -EINVAL;

mutex_lock(&chip->lock);

switch (mask) {
case IIO_CHAN_INFO_RAW:
case IIO_CHAN_INFO_PROCESSED:
switch(chan->type) {
case IIO_LIGHT:
ret =3D get_illuminance(chip, val);
break;
default:
break;
}

if(!ret)
ret =3D IIO_VAL_INT;

break;
default:
dev_err(&chip->device->dev, "mask value 0x%08lx not supported\n", mask);
break;
}
 mutex_unlock(&chip->lock);

return ret;
}

static const struct iio_chan_spec acpi_als_channels[] =3D {
{
.type =3D IIO_LIGHT,
.indexed =3D 1,
.channel =3D 1,
.scan_type.sign =3D 'u',
.scan_type.realbits =3D 10,
.scan_type.storagebits =3D 16,
.info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
},
};

static const struct iio_info acpi_als_info =3D {
.driver_module =3D THIS_MODULE,
.read_raw =3D &acpi_als_read_raw,
.write_raw =3D NULL,
};

static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
{

struct iio_poll_func *pf =3D p;
struct iio_dev *idev =3D pf->indio_dev;


struct acpi_als_chip *chip =3D iio_priv(idev);
struct iio_buffer *buffer =3D idev->buffer;
int i, j =3D 0;

printk("XXX: TRIGGER handler called :)");
iio_trigger_notify_done(chip->trig);
return IRQ_HANDLED;


/* TODO: remove */
u8 b[64];

for (i =3D 0; i < idev->masklength; i++) {
if (!test_bit(i, idev->active_scan_mask))
continue;

// TODO: read
j++;
}

if (idev->scan_timestamp) {
s64 *timestamp =3D (s64 *)((u8 *)b +
ALIGN(j, sizeof(s64)));
*timestamp =3D pf->timestamp;
}

// buffer->access->store_to(buffer, (u8 *)b, pf->timestamp);

iio_trigger_notify_done(idev->trig);
 return IRQ_HANDLED;
}

/**
 * acpi_als_data_rdy_trigger_set_state() set datardy interrupt state
 **/
static int acpi_als_data_rdy_trigger_set_state(struct iio_trigger *trig,
bool state)
{
printk("XXX: set_state called\n");

struct iio_dev *indio_dev =3D trig->private_data;

dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);

return 0;
}

static const struct iio_trigger_ops acpi_als_trigger_ops =3D {
.owner =3D THIS_MODULE,
.set_trigger_state =3D &acpi_als_data_rdy_trigger_set_state
};

// TODO
static const struct iio_buffer_setup_ops acpi_als_buffer_ops =3D {
.preenable =3D &iio_sw_buffer_preenable, // TODO ?
.postenable =3D &iio_triggered_buffer_postenable,
.predisable =3D &iio_triggered_buffer_predisable,
};

static struct iio_trigger *acpi_als_allocate_trigger(struct iio_dev *idev)
{
printk("XX: allocate trigger called!\n");

int ret;
struct iio_trigger *trig;
struct acpi_als_chip *chip =3D iio_priv(idev);

trig =3D iio_trigger_alloc("acpi-als");
if (trig =3D=3D NULL)
return NULL;

trig->dev.parent =3D idev->dev.parent;
trig->private_data =3D idev;
trig->ops =3D &acpi_als_trigger_ops;

 ret =3D iio_trigger_register(trig);
if (ret)
return NULL;

printk("XXX: acpi_als_allocate_trigger: %d\n", ret);
return trig;
}

static int acpi_als_trigger_init(struct iio_dev *idev)
{
printk("XXX: trigger init called\n");

struct acpi_als_chip *chip =3D iio_priv(idev);
int i, ret;

chip->trig =3D devm_kzalloc(&idev->dev, sizeof(chip->trig), GFP_KERNEL);

if (chip->trig =3D=3D NULL) {
ret =3D -ENOMEM;
goto error_ret;
}

chip->trig =3D acpi_als_allocate_trigger(idev);
if (chip->trig =3D=3D NULL) {
dev_err(&idev->dev, "Could not allocate trigger %d\n");
ret =3D -ENOMEM;
goto error_trigger;
}

printk("XXX: acpi_als_trigger_init: 0\n");
return 0;

error_trigger:
iio_trigger_free(chip->trig);
error_ret:
return ret;
}


static int acpi_als_add(struct acpi_device *device)
{
int result;
struct acpi_als_chip *chip;
struct iio_dev *indio_dev;

/*
if (unlikely(als_id >=3D 10)) {
printk(KERN_WARNING PREFIX "Too many ALS device found\n");
return -ENODEV;
}
*/
 indio_dev =3D iio_device_alloc(sizeof(*chip));
if (!indio_dev) {
dev_err(&device->dev, "iio allocation fails\n");
return -ENOMEM;
}

chip =3D iio_priv(indio_dev);

device->driver_data =3D indio_dev;
chip->device =3D device;
mutex_init(&chip->lock);

indio_dev->info =3D &acpi_als_info;
indio_dev->channels =3D acpi_als_channels;
indio_dev->num_channels =3D ARRAY_SIZE(acpi_als_channels);
indio_dev->name =3D ACPI_ALS_DEVICE_NAME;
indio_dev->dev.parent =3D &device->dev;
indio_dev->modes =3D INDIO_DIRECT_MODE;

result =3D iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
&acpi_als_trigger_handler, NULL);

if(result) {
printk("Could not setup buffer for iio device\n");
goto exit_iio_free;
}

result =3D acpi_als_trigger_init(indio_dev);
if (result) {
printk("Couldn't setup the triggers.\n");
// TODO
//goto error_unregister_buffer;
}

result =3D iio_device_register(indio_dev);
if (result < 0) {
dev_err(&chip->device->dev, "iio registration fails with error %d\n",
result);
goto exit_iio_free;
}

printk("ACPI ALS initialized");

return 0;

exit_iio_free:
iio_device_free(indio_dev);
return result;
}

static int acpi_als_remove(struct acpi_device *device, int type)
{
struct iio_dev *indio_dev;

indio_dev =3D acpi_driver_data(device);
if(!indio_dev) {
dev_err(&device->dev, "could not get indio_dev for ACPI device\n");
return -1;
}

iio_device_unregister(indio_dev);
iio_device_free(indio_dev);

return 0;
}

static int __init acpi_als_init(void)
{
return acpi_bus_register_driver(&acpi_als_driver);
}

static void __exit acpi_als_exit(void)
{
acpi_bus_unregister_driver(&acpi_als_driver);
}

module_init(acpi_als_init);
module_exit(acpi_als_exit);

On 11 September 2012 11:21, Marek Vasut <marex@denx.de> wrote:

> Dear Martin Li=C5=A1ka,
>
> [...]
>
> > +static int acpi_als_write_raw(struct iio_dev *indio_dev,
> > +     struct iio_chan_spec const *chan, int val, int val2, long mask)
> > +{
> > + return 0;
> > +}
>
> Simply set write_raw =3D NULL below (aka. don't put it into the structure=
 at
> all).
>
> > +static const struct iio_chan_spec acpi_als_channels[] =3D {
> > + {
> > + .type =3D IIO_LIGHT,
> > + .indexed =3D 1,
> > + .channel =3D 1,
> > + .scan_type.sign =3D 'u',
> > + .scan_type.realbits =3D 10,
> > + .scan_type.storagebits =3D 16,
> > + .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
> > + IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> > + },
> > +};
> > +
> > +static const struct iio_info acpi_als_info =3D {
> > + .driver_module =3D THIS_MODULE,
> > + .read_raw =3D &acpi_als_read_raw,
> > + .write_raw =3D &acpi_als_write_raw,
> > +};
> [...]
> Best regards,
> Marek Vasut
>

--bcaec54c52fc90ad0504cc94b44e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div><div>=C2=A0 =C2=A0my kernel driver is still unable to star=
t capturing in a proper way. First step for listening is</div><div><br></di=
v><div><i><b>=C2=A0echo 1 &gt; /sys/bus/iio/devices/iio\:device0/scan_eleme=
nts/in_illuminance1_en</b></i></div>
<div><i><br></i></div><div>but</div><div><br></div><div><i><b>cat /sys/bus/=
iio/devices/iio\:device0/scan_elements/in_illuminance1_en</b></i></div><div=
><i><b>-1</b></i></div><div><i><b><br></b></i></div><div>I tried to decorat=
e all result codes with printf.</div>
<div>Dmesg dump:</div><div><div><i>[ =C2=A0 =C2=A00.927335] XXX: trigger in=
it called</i></div><div><i>[ =C2=A0 =C2=A00.928148] XXX: acpi_als_allocate_=
trigger: 0</i></div><div><i>[ =C2=A0 =C2=A00.928275] XXX: acpi_als_trigger_=
init: 0</i></div><div><i>[ =C2=A0 =C2=A03.255305] XXX: getting data for fil=
ling buffer</i></div>
<div><i>[ =C2=A0 =C2=A03.255352] XXX: buffer is ready</i></div><div><i>[ =
=C2=A0 27.423650] XXX: getting data for filling buffer</i></div><div><i>[ =
=C2=A0 27.423698] XXX: buffer is ready</i></div><div><i>[ =C2=A0 30.444120]=
 XXX: getting data for filling buffer</i></div>
</div><div><br></div><div>Do you have any advices how to figure out where i=
s problem?</div><div><br></div><div>Thank you,</div><div>Martin</div><div><=
br></div><div><br></div><div>/*</div><div>=C2=A0* ACPI Ambient Light Sensor=
 Driver=C2=A0</div>
<div>=C2=A0*</div><div>=C2=A0* This program is free software; you can redis=
tribute it and/or modify it</div><div>=C2=A0* under the terms and condition=
s of the GNU General Public License,</div><div>=C2=A0* version 2, as publis=
hed by the Free Software Foundation.</div>
<div>=C2=A0*</div><div>=C2=A0* This program is distributed in the hope it w=
ill be useful, but WITHOUT</div><div>=C2=A0* ANY WARRANTY; without even the=
 implied warranty of MERCHANTABILITY or</div><div>=C2=A0* FITNESS FOR A PAR=
TICULAR PURPOSE. =C2=A0See the GNU General Public License for</div>
<div>=C2=A0* more details.</div><div>=C2=A0*</div><div>=C2=A0* You should h=
ave received a copy of the GNU General Public License</div><div>=C2=A0* alo=
ng with this program. =C2=A0If not, see &lt;<a href=3D"http://www.gnu.org/l=
icenses/">http://www.gnu.org/licenses/</a>&gt;.</div>
<div>=C2=A0*/</div><div><br></div><div>#include &lt;linux/module.h&gt;</div=
><div>#include &lt;linux/interrupt.h&gt;</div><div>#include &lt;trace/event=
s/printk.h&gt;</div><div>#include &lt;acpi/acpi_bus.h&gt;</div><div>#includ=
e &lt;acpi/acpi_drivers.h&gt;</div>
<div>#include &lt;linux/err.h&gt;</div><div>#include &lt;linux/mutex.h&gt;<=
/div><div><br></div><div>#include &lt;linux/iio/iio.h&gt;</div><div>#includ=
e &lt;linux/iio/buffer.h&gt;</div><div>#include &lt;linux/iio/sysfs.h&gt;</=
div>
<div>#include &lt;linux/iio/trigger.h&gt;</div><div>#include &lt;linux/iio/=
trigger_consumer.h&gt;</div><div>#include &lt;linux/iio/triggered_buffer.h&=
gt;</div><div><br></div><div>#define PREFIX &quot;ACPI: &quot;</div><div>
<br></div><div>#define ACPI_ALS_CLASS<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>&quot;als&quot;</div><div>#define ACPI_ALS_D=
EVICE_NAME<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>&quot;acpi-als&quot;</div>
<div>#define ACPI_ALS_NOTIFY_ILLUMINANCE<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>0x80</div><div>#define ACPI_ALS_NOTIFY_COLOR_=
TEMP<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0x81</=
div>
<div>#define ACPI_ALS_NOTIFY_RESPONSE<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>0x82</div><div><br></div><div>#define ACPI_ALS=
_OUTPUTS<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>3<=
/div><div>
<br></div><div>#define _COMPONENT<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">			</span>ACPI_ALS_COMPONENT</div><div>ACPI_MODULE_NAME(&quo=
t;acpi-als&quot;);</div><div><br></div><div>MODULE_AUTHOR(&quot;Martin Lisk=
a&quot;);</div>
<div>MODULE_DESCRIPTION(&quot;ACPI Ambient Light Sensor Driver&quot;);</div=
><div>MODULE_LICENSE(&quot;GPL&quot;);</div><div><br></div><div>struct acpi=
_als_chip {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>struct acpi_device<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>*device;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t acpi_als_device<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>*acpi_als_sys;</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>struct mutex<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>lock;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t iio_trigger<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>*trig;</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>int illuminance;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int t=
emperature;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>int chromaticity;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>int polling;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>int count;</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>struct acpi_als_mapping *mappings;</div><div>};</div><=
div>
<br></div><div>static int acpi_als_add(struct acpi_device *device);</div><d=
iv>static int acpi_als_remove(struct acpi_device *device, int type);</div><=
div>static void acpi_als_notify(struct acpi_device *device, u32 event);</di=
v>
<div><br></div><div>static const struct acpi_device_id acpi_als_device_ids[=
] =3D {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>{&quot;ACPI0008&quot;, 0},</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>{&quot;&quot;, 0},</div>
<div>};</div><div><br></div><div>MODULE_DEVICE_TABLE(acpi, acpi_als_device_=
ids);</div><div><br></div><div>static struct acpi_driver acpi_als_driver =
=3D {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	<=
/span>.name =3D &quot;acpi_als&quot;,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.clas=
s =3D ACPI_ALS_CLASS,</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>.ids =3D acpi_als_device_ids,</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.ops =3D {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.add=
 =3D acpi_als_add,</div><div><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">		</span>.remove =3D acpi_als_remove,</div><div><span class=3D"A=
pple-tab-span" style=3D"white-space:pre">		</span>.notify =3D acpi_als_noti=
fy,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>},</=
div><div>};</div><div><br></div><div>struct acpi_als_mapping {</div><div><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int adjustme=
nt;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int i=
lluminance;</div><div>};</div><div><br></div><div>#define ALS_INVALID_VALUE=
_LOW<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>0</di=
v><div>
#define ALS_INVALID_VALUE_HIGH<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">		</span>-1</div><div><br></div><div>/* -----------------------=
---------------------------------------------------</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Ambient Light Sensor=
 device Management</div>
<div>=C2=A0 =C2=A0---------------------------------------------------------=
----------------- */</div><div><br></div><div>/*</div><div>=C2=A0* acpi_als=
_get_illuminance - get the current ambient light illuminance</div><div>=C2=
=A0*/</div><div>static int acpi_als_get_illuminance(struct acpi_als_chip *a=
ls)</div>
<div>{</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>acpi_status status;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>unsigned long long illuminance;</div><div><br>=
</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>statu=
s =3D acpi_evaluate_integer(als-&gt;device-&gt;handle,</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">		</span>&quot;_ALI&quot;, N=
ULL, &amp;illuminance);</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>if (ACPI_FAILURE(status)) {</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">		</span>ACPI_EXCEPTION((AE_INFO, status, &qu=
ot;Error reading ALS illuminance&quot;));</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>als-=
&gt;illuminance =3D ALS_INVALID_VALUE_LOW;</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">		</span>return -ENODEV;</div><div><span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>als-&=
gt;illuminance =3D illuminance;</div><div><br></div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">	</span>return 0;</div><div>}</div><=
div><br>
</div><div>/*</div><div>=C2=A0* acpi_als_get_color_chromaticity - get the a=
mbient light color chromaticity</div><div>=C2=A0*/</div><div>static int acp=
i_als_get_color_chromaticity(struct acpi_als_chip *chip)</div><div>{</div><=
div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>acpi_s=
tatus status;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsig=
ned long long chromaticity;</div><div><br></div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>status =3D</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=C2=A0=C2=A0 =C2=A0ac=
pi_evaluate_integer(chip-&gt;device-&gt;handle, &quot;_ALC&quot;, NULL,</di=
v>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>=
=C2=A0=C2=A0&amp;chromaticity);</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>if (ACPI_FAILURE(status)) {</div><div><span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACPI_DEBUG_PRI=
NT((ACPI_DB_INFO, &quot;_ALC not available\n&quot;));</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>retu=
rn -ENODEV;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>}</div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>chip-&gt;chromaticity =3D chromaticity;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n 0;</div><div>}</div><div><br></div><div>/*</div><div>=C2=A0* acpi_als_get=
_color_temperature - get the ambient light color temperature</div><div>=C2=
=A0*/</div>
<div>static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)<=
/div><div>{</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>acpi_status status;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>unsigned long long temperature;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>status =3D</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>=C2=A0=C2=A0 =C2=A0acpi_evaluate_integer(chip-&gt;devi=
ce-&gt;handle, &quot;_ALT&quot;, NULL,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>=
=C2=A0=C2=A0&amp;temperature);</div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>if (ACPI_FAILURE(status)) {</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACPI_DEBUG_PRIN=
T((ACPI_DB_INFO, &quot;_ALT not available\n&quot;));</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>retu=
rn -ENODEV;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>}</div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>chip-&gt;temperature =3D temperature;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n 0;</div><div>}</div><div><br></div><div>/*</div><div>=C2=A0* acpi_als_get=
_mappings - get the ALS illuminance mappings</div><div>=C2=A0*</div><div>=
=C2=A0* Return a package of ALS illuminance to display adjustment mappings<=
/div>
<div>=C2=A0* that can be used by OS to calibrate its ambient light policy</=
div><div>=C2=A0* for a given sensor configuration.</div><div>=C2=A0*/</div>=
<div>static int acpi_als_get_mappings(struct acpi_als_chip *chip)</div><div=
>{</div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int result=
 =3D 0;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>acpi_status status;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>struct acpi_buffer buffer =3D { ACPI_ALLOCATE_=
BUFFER, NULL };</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>union=
 acpi_object *alr;</div><div><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>int i, j;</div><div><br></div><div><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>/* Free the old mappings */</di=
v>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kfree=
(chip-&gt;mappings);</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>chip-&gt;mappings =3D NULL;</div><div><br></div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>status =3D<=
/div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=C2=
=A0=C2=A0 =C2=A0acpi_evaluate_object(chip-&gt;device-&gt;handle, &quot;_ALR=
&quot;, NULL, &amp;buffer);</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>if (ACPI_FAILURE(status)) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACPI=
_EXCEPTION((AE_INFO, status, &quot;Error reading ALS mappings&quot;));</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -ENODEV;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</di=
v><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>alr =3D buffer.pointer;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>if (!alr || (alr-&gt;type !=3D ACPI_TYP=
E_PACKAGE)) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>prin=
tk(KERN_ERR PREFIX &quot;Invalid _ALR data\n&quot;);</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>result =3D -EFAULT;<=
/div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>goto end;=
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>}</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Found %d illuminanc=
e mappings\n&quot;,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>=C2=
=A0=C2=A0alr-&gt;package.count));</div><div><br></div><div><span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>chip-&gt;count =3D alr-&gt=
;package.count;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>if (!chip-&gt;count)</div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">		</span>return 0;</div><div><br></div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>chip-&gt;mappings =
=3D</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=C2=
=A0=C2=A0 =C2=A0kmalloc(sizeof(struct acpi_als_mapping) * chip-&gt;count, G=
FP_KERNEL);</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>if (!chip-&gt;mappings) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>resu=
lt =3D -ENOMEM;</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>goto end;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>}</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>for (i =3D 0, j =3D 0; i &lt; chip-&gt;count; i++) {</div><div><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>struct acpi=
_als_mapping *mapping =3D &amp;(chip-&gt;mappings[j]);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>unio=
n acpi_object *element =3D &amp;(alr-&gt;package.elements[i]);</div><div><b=
r></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</s=
pan>if (element-&gt;type !=3D ACPI_TYPE_PACKAGE)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>con=
tinue;</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>if (element-&gt;package.count !=3D 2)</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>continue;</d=
iv>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span>if (element-&gt;package.elements[0].type !=3D ACPI_TYPE_INTEGER =
||</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</s=
pan>=C2=A0=C2=A0 =C2=A0element-&gt;package.elements[1].type !=3D ACPI_TYPE_=
INTEGER)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>con=
tinue;</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>mapping-&gt;adjustment =3D</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">		</span>=C2=A0=C2=A0 =C2=A0eleme=
nt-&gt;package.elements[0].integer.value;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>mapp=
ing-&gt;illuminance =3D</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>=C2=A0=C2=A0 =C2=A0element-&gt;package.elements[1]=
.integer.value;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>j++;=
</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Mapping [%d]: &quot;=
</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>=
=C2=A0=C2=A0&quot;adjustment [%d] illuminance[%d]\n&quot;,</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>=C2=A0=C2=A0i=
, mapping-&gt;adjustment,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>=
=C2=A0=C2=A0mapping-&gt;illuminance));</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>}</div><div><br></div><div>end:</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kfre=
e(buffer.pointer);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n result;</div><div>}</div><div><br></div><div>/*</div><div>=C2=A0* acpi_al=
s_get_polling - get a recommended polling frequency</div><div>=C2=A0*=C2=A0=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>=C2=A0=
=C2=A0for the Ambient Light Sensor device</div>
<div>=C2=A0*/</div><div>static int acpi_als_get_polling(struct acpi_als_chi=
p *chip)</div><div>{</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>acpi_status status;</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>unsigned long long polling;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>status =3D</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>=C2=A0=C2=A0 =C2=A0acpi_evaluate_integer(chip-&gt;devi=
ce-&gt;handle, &quot;_ALP&quot;, NULL, &amp;polling);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (A=
CPI_FAILURE(status)) {</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;_ALP not avai=
lable\n&quot;));</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>retu=
rn -ENODEV;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>}</div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>chip-&gt;polling =3D polling;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n 0;</div><div>}</div><div><br></div><div>static int get_illuminance(struct=
 acpi_als_chip *als, int *illuminance)</div><div>{</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>int result;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>result =3D acpi_als_get_illuminance(als);</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (!result)</div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>*illumi=
nance =3D als-&gt;illuminance;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>return result;</div><div>}</div><div><br></div><div>static void a=
cpi_als_notify(struct acpi_device *device, u32 event)</div><div>{</div><div=
>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int illumi=
nance;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>struct iio_dev *indio_dev =3D acpi_driver_data(device);</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_buffer *buffer =3D indio_dev-&gt;buf=
fer;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t acpi_als_chip *chip =3D iio_priv(indio_dev);</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s64 time_ns =3D iio_get_time_ns();</div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>int len =3D 2;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>u8 data[sizeof(s64) + len];</div><div><br></div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>printk(&quot;XXX: get=
ting data for filling buffer\n&quot;);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>get_i=
lluminance(chip, &amp;illuminance);</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span></div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>*(int *)((u8 *)data) =3D illuminance;<=
/div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>*(s64=
 *)((u8 *)data + ALIGN(len, sizeof(s64))) =3D time_ns;</div><div><br></div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>print=
k(&quot;XXX: buffer is ready\n&quot;);</div>
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iio_buffer_enabled(indi=
o_dev)) {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span>printk(&quot;XXX: pushing to buffer\n&quot;);</div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>iio_push_to_buffe=
r(buffer, data);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>prin=
tk(&quot;XXX: push to buffer called\n&quot;);</div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>}</div><div>}</div><div><br><=
/div>
<div>static int acpi_als_read_raw(struct iio_dev *indio_dev,</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct iio_cha=
n_spec const *chan, int *val, int *val2, long mask)</div><div>{</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct acpi=
_als_chip *chip =3D iio_priv(indio_dev);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int r=
et =3D -EINVAL;</div><div><br></div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>mutex_lock(&amp;chip-&gt;lock);</div><div><b=
r></div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>switc=
h (mask) {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>case IIO_CHAN_INFO_RAW:</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>case IIO_CHAN_INFO_PROCESSED:</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>swit=
ch(chan-&gt;type) {</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">		</span>case IIO_LIGHT:</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">			</span>ret =3D get_illuminance(chip, val);<=
/div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>bre=
ak;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</=
span>default:</div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">			</span>break;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>}</d=
iv><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">		</span>if(!ret)</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">			</span>ret =3D IIO_VAL_INT;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span>break;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>default:</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>dev_err(&amp;chip-&gt;device-&gt;dev, &quot;m=
ask value 0x%08lx not supported\n&quot;, mask);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>brea=
k;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>}</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span></div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>mutex=
_unlock(&amp;chip-&gt;lock);</div><div><br></div><div><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>return ret;</div><div>}</div><d=
iv><br>
</div><div>static const struct iio_chan_spec acpi_als_channels[] =3D {</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>{</d=
iv><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.=
type =3D IIO_LIGHT,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.ind=
exed =3D 1,</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">		</span>.channel =3D 1,</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>.scan_type.sign =3D &#39;u&#39;,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.sca=
n_type.realbits =3D 10,</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>.scan_type.storagebits =3D 16,</div><div><span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.info_mask =3D IIO=
_CHAN_INFO_PROCESSED_SEPARATE_BIT |</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>IIO_=
CHAN_INFO_SCALE_SEPARATE_BIT,</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>},</div><div>};</div><div><br></div><div>stat=
ic const struct iio_info acpi_als_info =3D {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.driv=
er_module =3D THIS_MODULE,</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>.read_raw =3D &amp;acpi_als_read_raw,</div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.write_r=
aw =3D NULL,</div>
<div>};</div><div><br></div><div>static irqreturn_t acpi_als_trigger_handle=
r(int irq, void *p)</div><div>{</div><div><br></div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">	</span>struct iio_poll_func *pf =3D=
 p;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t iio_dev *idev =3D pf-&gt;indio_dev;</div><div><br></div><div><br></div><d=
iv><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct =
acpi_als_chip *chip =3D iio_priv(idev);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t iio_buffer *buffer =3D idev-&gt;buffer;</div><div><span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>int i, j =3D 0;</div><div><br></d=
iv><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>printk(&qu=
ot;XXX: TRIGGER handler called :)&quot;);</div><div><span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>iio_trigger_notify_done(chip-&gt;=
trig);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n IRQ_HANDLED;</div><div><br></div><div><br></div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">	</span>/* TODO: remove */</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>u8 b[64];</=
div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>for (i =3D 0; i &lt; idev-&gt;masklength; i++) {</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>if (!test_bit(i=
, idev-&gt;active_scan_mask))</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>con=
tinue;</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>// TODO: read</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">		</span>j++;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</di=
v><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>if (idev-&gt;scan_timestamp) {</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">		</span>s64 *timestamp =3D (s64 *)((u8 =
*)b +</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>A=
LIGN(j, sizeof(s64)));</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>*timestamp =3D pf-&gt;timestamp;</div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div>
<div><br></div><div>//<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>buffer-&gt;access-&gt;store_to(buffer, (u8 *)b, pf-&gt;timestam=
p);</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>iio_trigger_notify_done(idev-&gt;trig);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn IRQ_HANDLED;</div><div>}</div><div><br></div><div>/**</div><div>=C2=A0* =
acpi_als_data_rdy_trigger_set_state() set datardy interrupt state</div>
<div>=C2=A0**/</div><div>static int acpi_als_data_rdy_trigger_set_state(str=
uct iio_trigger *trig,</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">						</span>bool state)</div><div>{</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>printk(&quot;XXX: set=
_state called\n&quot;);</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>struct iio_dev *indio_dev =3D trig-&gt;private_data;</div><div><b=
r></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>dev_dbg(&amp;indio_dev-&gt;dev, &quot;%s (%d)\n&quot;, __func__, state);=
</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>return 0;=C2=A0</div><div>}</div><div><br></div><div>static const=
 struct iio_trigger_ops acpi_als_trigger_ops =3D {</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>.owner =3D THIS_MODULE,<=
/div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.set_=
trigger_state =3D &amp;acpi_als_data_rdy_trigger_set_state</div><div>};</di=
v><div><br></div><div>// TODO</div><div>static const struct iio_buffer_setu=
p_ops acpi_als_buffer_ops =3D {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.pree=
nable =3D &amp;iio_sw_buffer_preenable, // TODO ?</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span>.postenable =3D &amp;iio_=
triggered_buffer_postenable,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.pred=
isable =3D &amp;iio_triggered_buffer_predisable,</div><div>};</div><div><br=
></div><div>static struct iio_trigger *acpi_als_allocate_trigger(struct iio=
_dev *idev)</div>
<div>{</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>printk(&quot;XX: allocate trigger called!\n&quot;);</div><div><br></=
div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>i=
nt ret;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t iio_trigger *trig;</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>struct acpi_als_chip *chip =3D iio_priv(idev);</div><d=
iv><br>
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>trig =3D iio_trigger_alloc(&quot;acpi-als&quot;);</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>if (trig =3D=3D NULL)</d=
iv><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>r=
eturn NULL;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>trig-&gt;dev.parent =3D idev-&gt;dev.parent;</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>trig-&gt;private_dat=
a =3D idev;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>trig-=
&gt;ops =3D &amp;acpi_als_trigger_ops;</div><div><br></div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span></div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =3D iio_trigger_=
register(trig);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (r=
et)</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</=
span>return NULL;</div><div><br></div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>printk(&quot;XXX: acpi_als_allocate_trigge=
r: %d\n&quot;, ret);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n trig;</div><div>}</div><div><br></div><div>static int acpi_als_trigger_in=
it(struct iio_dev *idev)</div><div>{</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>printk(&quot;XXX: trigger init called\=
n&quot;);</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>struct acpi_als_chip *chip =3D iio_priv(idev);</div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int i, ret;</div><=
div><br>
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>chip-&gt;trig =3D devm_kzalloc(&amp;idev-&gt;dev, sizeof(chip-&gt;trig), G=
FP_KERNEL);</div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>if (chip-&gt;trig =3D=3D NULL) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret =
=3D -ENOMEM;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">		</span>goto error_ret;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>}</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>chip-&gt;trig =3D acpi_als_allocate_trigger(idev);</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (chip-&gt;t=
rig =3D=3D NULL) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev_=
err(&amp;idev-&gt;dev, &quot;Could not allocate trigger %d\n&quot;);</div><=
div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret =
=3D -ENOMEM;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>goto=
 error_trigger;</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>}</div><div><br></div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>printk(&quot;XXX: acpi_als_trigger_init: 0=
\n&quot;);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retur=
n 0;</div><div><br></div><div>error_trigger:</div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">	</span>iio_trigger_free(chip-&gt;trig=
);</div>
<div>error_ret:</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>return ret;</div><div>}</div><div><br></div><div><br></div>=
<div>static int acpi_als_add(struct acpi_device *device)</div><div>{</div><=
div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int result=
;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>struct acpi_als_chip *chip;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>struct iio_dev *indio_dev;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>/*</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>if (unlikely(als_id &gt;=3D 10)) {</div><div><span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">		</span>printk(KERN_WARNING PREFIX=
 &quot;Too many ALS device found\n&quot;);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>retu=
rn -ENODEV;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>}</div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>*/</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indi=
o_dev =3D iio_device_alloc(sizeof(*chip));</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>if (!indio_dev) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev_=
err(&amp;device-&gt;dev, &quot;iio allocation fails\n&quot;);</div><div><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>return -ENOM=
EM;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</di=
v><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>chip =3D iio_priv(indio_dev);</div><div><br></div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>device-&gt;driver_=
data =3D indio_dev;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>chip-=
&gt;device =3D device;</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>mutex_init(&amp;chip-&gt;lock);</div><div><br></div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indio=
_dev-&gt;info =3D &amp;acpi_als_info;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indio=
_dev-&gt;channels =3D acpi_als_channels;</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>indio_dev-&gt;num_channels =3D ARR=
AY_SIZE(acpi_als_channels);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indio=
_dev-&gt;name =3D ACPI_ALS_DEVICE_NAME;</div><div><span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>indio_dev-&gt;dev.parent =3D &amp;d=
evice-&gt;dev;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indio=
_dev-&gt;modes =3D INDIO_DIRECT_MODE;</div><div><br></div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>result =3D iio_trigge=
red_buffer_setup(indio_dev, &amp;iio_pollfunc_store_time,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>&a=
mp;acpi_als_trigger_handler, NULL);</div><div><br></div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>if(result) {</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>printk(&qu=
ot;Could not setup buffer for iio device\n&quot;);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>goto=
 exit_iio_free;</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>}</div><div><br></div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>result =3D acpi_als_trigger_init(indio_dev=
);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (r=
esult) {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>		</span>printk(&quot;Couldn&#39;t setup the triggers.\n&quot;);</div><div=
><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>// TODO<=
/div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>//go=
to error_unregister_buffer;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>}</div><div><br></div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>result =3D iio_device_registe=
r(indio_dev);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (r=
esult &lt; 0) {</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>dev_err(&amp;chip-&gt;device-&gt;dev, &quot;iio registrati=
on fails with error %d\n&quot;,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>res=
ult);</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>goto exit_iio_free;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>}</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>printk(&quot;ACPI ALS initialized&quot;);</div><div><br></div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return 0=
;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>exit_iio_free:</div><div><span class=3D"Apple-tab-span" style=3D"=
white-space:pre">		</span>iio_device_free(indio_dev);</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>return result;</div>
<div>}</div><div><br></div><div>static int acpi_als_remove(struct acpi_devi=
ce *device, int type)</div><div>{</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct iio_dev *indio_dev;</div><div><br>
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>indio_dev =3D acpi_driver_data(device);</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>if(!indio_dev) {</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev_err(&amp;dev=
ice-&gt;dev, &quot;could not get indio_dev for ACPI device\n&quot;);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>retu=
rn -1;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>iio_device_unregister(indio_dev);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>iio_d=
evice_free(indio_dev);</div><div><br></div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>return 0;</div><div>}</div><div><br><=
/div>
<div>static int __init acpi_als_init(void)</div><div>{</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return acpi_bus_regi=
ster_driver(&amp;acpi_als_driver);</div><div>}</div><div><br></div><div>sta=
tic void __exit acpi_als_exit(void)</div>
<div>{</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>acpi_bus_unregister_driver(&amp;acpi_als_driver);</div><div>}</div><=
div><br></div><div>module_init(acpi_als_init);</div><div>module_exit(acpi_a=
ls_exit);</div>
<br><div class=3D"gmail_quote">On 11 September 2012 11:21, Marek Vasut <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:marex@denx.de" target=3D"_blank">marex@=
denx.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Dear Martin Li=C5=A1ka,<br>
<br>
[...]<br>
<div class=3D"im"><br>
&gt; +static int acpi_als_write_raw(struct iio_dev *indio_dev,<br>
&gt; + =C2=A0 =C2=A0 struct iio_chan_spec const *chan, int val, int val2, l=
ong mask)<br>
&gt; +{<br>
&gt; + return 0;<br>
&gt; +}<br>
<br>
</div>Simply set write_raw =3D NULL below (aka. don&#39;t put it into the s=
tructure at all).<br>
<div class=3D"im HOEnZb"><br>
&gt; +static const struct iio_chan_spec acpi_als_channels[] =3D {<br>
&gt; + {<br>
&gt; + .type =3D IIO_LIGHT,<br>
&gt; + .indexed =3D 1,<br>
&gt; + .channel =3D 1,<br>
&gt; + .scan_type.sign =3D &#39;u&#39;,<br>
&gt; + .scan_type.realbits =3D 10,<br>
&gt; + .scan_type.storagebits =3D 16,<br>
&gt; + .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |<br>
&gt; + IIO_CHAN_INFO_SCALE_SEPARATE_BIT,<br>
&gt; + },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_info acpi_als_info =3D {<br>
&gt; + .driver_module =3D THIS_MODULE,<br>
&gt; + .read_raw =3D &amp;acpi_als_read_raw,<br>
&gt; + .write_raw =3D &amp;acpi_als_write_raw,<br>
&gt; +};<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">[...]<br>
Best regards,<br>
Marek Vasut<br>
</div></div></blockquote></div><br>

--bcaec54c52fc90ad0504cc94b44e--
