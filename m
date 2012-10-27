Return-Path: <marxin.liska@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5084397D.8050103@kernel.org>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
	<4FFADCC2.6080006@cam.ac.uk>
	<CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
	<201209111121.34205.marex@denx.de>
	<CAObPJ3PB0VYNE9vhrwJRA9jpWX6p7_Kw8T2eCMgj0M0zJ9feUA@mail.gmail.com>
	<5084397D.8050103@kernel.org>
Date: Sat, 27 Oct 2012 18:39:32 +0200
Message-ID: <CAObPJ3MgaVtUHOsUfATdaRGEQ23+GHceoLS0ZU1tCyik00bHpA@mail.gmail.com>
Subject: Re: ACPI ambient light sensor
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Jonathan Cameron <jic23@cam.ac.uk>, platform-driver-x86@vger.kernel.org,
	linux-iio@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Corentin Chary <corentin.chary@gmail.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de, Jon Brenner <jbrenner@taosinc.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: multipart/alternative; boundary=e89a8f6438bcb5459304cd0d14aa
List-ID: <linux-iio@vger.kernel.org>

--e89a8f6438bcb5459304cd0d14aa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,
   I hope being root should not bring any permission issues for the file:

ls -l /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en
*-rw-r--r--* 1 root root 4096 Oct 27 15:54
/sys/bus/iio/devices/iio:device0/scan_elements/in_illuminance1_en

After adding debug print to ii_scan_el_show gives me really *-1* and
***indio_dev->buffer->scan_mask
is *1 *and echo command settings "1" is processed in
*in_scan_el_store*function with ret =3D=3D 0.

Thank you for new ideas,
Martin

On 21 October 2012 20:05, Jonathan Cameron <jic23@kernel.org> wrote:

> On 10/21/2012 06:02 PM, Martin Li=C5=A1ka wrote:
> > Hello,
> >    my kernel driver is still unable to start capturing in a proper way.
> First step for listening is
> >
> > /* echo 1 >
> /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*/
> > /
> > /
> > but
> >
> > /*cat
> /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_en*/
> > /*-1*/
>
> That is 'odd' to put it lightly.  That should just call iio_scan_el_show
> which
> in turn calls test_bit on a bitmask.  I'm not sure that can return
> anything other
> than 0 or 1. This is then fed directly into an sprintf call.
> Could there be a permissions issue or something similar?
>
> > /*
> > */
> > I tried to decorate all result codes with printf.
> > Dmesg dump:
> > /[    0.927335] XXX: trigger init called/
> > /[    0.928148] XXX: acpi_als_allocate_trigger: 0/
> > /[    0.928275] XXX: acpi_als_trigger_init: 0/
> > /[    3.255305] XXX: getting data for filling buffer/
> > /[    3.255352] XXX: buffer is ready/
> > /[   27.423650] XXX: getting data for filling buffer/
> > /[   27.423698] XXX: buffer is ready/
> > /[   30.444120] XXX: getting data for filling buffer/
> >
> > Do you have any advices how to figure out where is problem?
> Yes, put some printk's into the core code and see what is going wrong.
> Right now that cat giving you -1 is certainly suspicious.
>
> Please do get your email client to handle patches nicely!
> >
> > Thank you,
> > Martin
> >
> >
> > /*
> >  * ACPI Ambient Light Sensor Driver
> >  *
> >  * This program is free software; you can redistribute it and/or modify
> it
> >  * under the terms and conditions of the GNU General Public License,
> >  * version 2, as published by the Free Software Foundation.
> >  *
> >  * This program is distributed in the hope it will be useful, but WITHO=
UT
> >  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY o=
r
> >  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e
> for
> >  * more details.
> >  *
> >  * You should have received a copy of the GNU General Public License
> >  * along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> >  */
> >
> > #include <linux/module.h>
> > #include <linux/interrupt.h>
> > #include <trace/events/printk.h>
> > #include <acpi/acpi_bus.h>
> > #include <acpi/acpi_drivers.h>
> > #include <linux/err.h>
> > #include <linux/mutex.h>
> >
> > #include <linux/iio/iio.h>
> > #include <linux/iio/buffer.h>
> > #include <linux/iio/sysfs.h>
> > #include <linux/iio/trigger.h>
> > #include <linux/iio/trigger_consumer.h>
> > #include <linux/iio/triggered_buffer.h>
> >
> > #define PREFIX "ACPI: "
> >
> > #define ACPI_ALS_CLASS"als"
> > #define ACPI_ALS_DEVICE_NAME"acpi-als"
> > #define ACPI_ALS_NOTIFY_ILLUMINANCE0x80
> > #define ACPI_ALS_NOTIFY_COLOR_TEMP0x81
> > #define ACPI_ALS_NOTIFY_RESPONSE0x82
> >
> > #define ACPI_ALS_OUTPUTS3
> >
> > #define _COMPONENTACPI_ALS_COMPONENT
> > ACPI_MODULE_NAME("acpi-als");
> >
> > MODULE_AUTHOR("Martin Liska");
> > MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
> > MODULE_LICENSE("GPL");
> >
> > struct acpi_als_chip {
> > struct acpi_device*device;
> > struct acpi_als_device*acpi_als_sys;
> > struct mutexlock;
> > struct iio_trigger*trig;
> >
> > int illuminance;
> > int temperature;
> > int chromaticity;
> > int polling;
> >
> > int count;
> > struct acpi_als_mapping *mappings;
> > };
> >
> > static int acpi_als_add(struct acpi_device *device);
> > static int acpi_als_remove(struct acpi_device *device, int type);
> > static void acpi_als_notify(struct acpi_device *device, u32 event);
> >
> > static const struct acpi_device_id acpi_als_device_ids[] =3D {
> > {"ACPI0008", 0},
> > {"", 0},
> > };
> >
> > MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
> >
> > static struct acpi_driver acpi_als_driver =3D {
> > .name =3D "acpi_als",
> > .class =3D ACPI_ALS_CLASS,
> > .ids =3D acpi_als_device_ids,
> > .ops =3D {
> > .add =3D acpi_als_add,
> > .remove =3D acpi_als_remove,
> > .notify =3D acpi_als_notify,
> > },
> > };
> >
> > struct acpi_als_mapping {
> > int adjustment;
> > int illuminance;
> > };
> >
> > #define ALS_INVALID_VALUE_LOW0
> > #define ALS_INVALID_VALUE_HIGH-1
> >
> > /*
> -------------------------------------------------------------------------=
-
> > Ambient Light Sensor device Management
> >
>  ------------------------------------------------------------------------=
--
> */
> >
> > /*
> >  * acpi_als_get_illuminance - get the current ambient light illuminance
> >  */
> > static int acpi_als_get_illuminance(struct acpi_als_chip *als)
> > {
> > acpi_status status;
> > unsigned long long illuminance;
> >
> > status =3D acpi_evaluate_integer(als->device->handle,
> > "_ALI", NULL, &illuminance);
> >
> > if (ACPI_FAILURE(status)) {
> > ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS illuminance"));
> > als->illuminance =3D ALS_INVALID_VALUE_LOW;
> > return -ENODEV;
> > }
> > als->illuminance =3D illuminance;
> >
> > return 0;
> > }
> >
> > /*
> >  * acpi_als_get_color_chromaticity - get the ambient light color
> chromaticity
> >  */
> > static int acpi_als_get_color_chromaticity(struct acpi_als_chip *chip)
> > {
> > acpi_status status;
> > unsigned long long chromaticity;
> >
> > status =3D
> >     acpi_evaluate_integer(chip->device->handle, "_ALC", NULL,
> >   &chromaticity);
> > if (ACPI_FAILURE(status)) {
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALC not available\n"));
> > return -ENODEV;
> > }
> > chip->chromaticity =3D chromaticity;
> > return 0;
> > }
> >
> > /*
> >  * acpi_als_get_color_temperature - get the ambient light color
> temperature
> >  */
> > static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)
> > {
> > acpi_status status;
> > unsigned long long temperature;
> >
> > status =3D
> >     acpi_evaluate_integer(chip->device->handle, "_ALT", NULL,
> >   &temperature);
> > if (ACPI_FAILURE(status)) {
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALT not available\n"));
> > return -ENODEV;
> > }
> > chip->temperature =3D temperature;
> > return 0;
> > }
> >
> > /*
> >  * acpi_als_get_mappings - get the ALS illuminance mappings
> >  *
> >  * Return a package of ALS illuminance to display adjustment mappings
> >  * that can be used by OS to calibrate its ambient light policy
> >  * for a given sensor configuration.
> >  */
> > static int acpi_als_get_mappings(struct acpi_als_chip *chip)
> > {
> > int result =3D 0;
> > acpi_status status;
> > struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > union acpi_object *alr;
> > int i, j;
> >
> > /* Free the old mappings */
> > kfree(chip->mappings);
> > chip->mappings =3D NULL;
> >
> > status =3D
> >     acpi_evaluate_object(chip->device->handle, "_ALR", NULL, &buffer);
> > if (ACPI_FAILURE(status)) {
> > ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS mappings"));
> > return -ENODEV;
> > }
> >
> > alr =3D buffer.pointer;
> > if (!alr || (alr->type !=3D ACPI_TYPE_PACKAGE)) {
> > printk(KERN_ERR PREFIX "Invalid _ALR data\n");
> > result =3D -EFAULT;
> > goto end;
> > }
> >
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d illuminance mappings\n",
> >   alr->package.count));
> >
> > chip->count =3D alr->package.count;
> >
> > if (!chip->count)
> > return 0;
> >
> > chip->mappings =3D
> >     kmalloc(sizeof(struct acpi_als_mapping) * chip->count, GFP_KERNEL);
> > if (!chip->mappings) {
> > result =3D -ENOMEM;
> > goto end;
> > }
> >
> > for (i =3D 0, j =3D 0; i < chip->count; i++) {
> > struct acpi_als_mapping *mapping =3D &(chip->mappings[j]);
> > union acpi_object *element =3D &(alr->package.elements[i]);
> >
> > if (element->type !=3D ACPI_TYPE_PACKAGE)
> > continue;
> >
> > if (element->package.count !=3D 2)
> > continue;
> >
> > if (element->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
> >     element->package.elements[1].type !=3D ACPI_TYPE_INTEGER)
> > continue;
> >
> > mapping->adjustment =3D
> >     element->package.elements[0].integer.value;
> > mapping->illuminance =3D
> >     element->package.elements[1].integer.value;
> > j++;
> >
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Mapping [%d]: "
> >   "adjustment [%d] illuminance[%d]\n",
> >   i, mapping->adjustment,
> >   mapping->illuminance));
> > }
> >
> > end:
> > kfree(buffer.pointer);
> > return result;
> > }
> >
> > /*
> >  * acpi_als_get_polling - get a recommended polling frequency
> >  *   for the Ambient Light Sensor device
> >  */
> > static int acpi_als_get_polling(struct acpi_als_chip *chip)
> > {
> > acpi_status status;
> > unsigned long long polling;
> >
> > status =3D
> >     acpi_evaluate_integer(chip->device->handle, "_ALP", NULL, &polling)=
;
> > if (ACPI_FAILURE(status)) {
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
> > return -ENODEV;
> > }
> >
> > chip->polling =3D polling;
> > return 0;
> > }
> >
> > static int get_illuminance(struct acpi_als_chip *als, int *illuminance)
> > {
> > int result;
> >
> > result =3D acpi_als_get_illuminance(als);
> > if (!result)
> > *illuminance =3D als->illuminance;
> >
> > return result;
> > }
> >
> > static void acpi_als_notify(struct acpi_device *device, u32 event)
> > {
> > int illuminance;
> > struct iio_dev *indio_dev =3D acpi_driver_data(device);
> >         struct iio_buffer *buffer =3D indio_dev->buffer;
> > struct acpi_als_chip *chip =3D iio_priv(indio_dev);
> >         s64 time_ns =3D iio_get_time_ns();
> > int len =3D 2;
> >
> > u8 data[sizeof(s64) + len];
> >
> > printk("XXX: getting data for filling buffer\n");
> > get_illuminance(chip, &illuminance);
> > *(int *)((u8 *)data) =3D illuminance;
> > *(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) =3D time_ns;
> >
> > printk("XXX: buffer is ready\n");
> >
> >         if (iio_buffer_enabled(indio_dev)) {
> > printk("XXX: pushing to buffer\n");
> > iio_push_to_buffer(buffer, data);
> > printk("XXX: push to buffer called\n");
> > }
> > }
> >
> > static int acpi_als_read_raw(struct iio_dev *indio_dev,
> > struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> > {
> > struct acpi_als_chip *chip =3D iio_priv(indio_dev);
> > int ret =3D -EINVAL;
> >
> > mutex_lock(&chip->lock);
> >
> > switch (mask) {
> > case IIO_CHAN_INFO_RAW:
> > case IIO_CHAN_INFO_PROCESSED:
> > switch(chan->type) {
> > case IIO_LIGHT:
> > ret =3D get_illuminance(chip, val);
> > break;
> > default:
> > break;
> > }
> >
> > if(!ret)
> > ret =3D IIO_VAL_INT;
> >
> > break;
> > default:
> > dev_err(&chip->device->dev, "mask value 0x%08lx not supported\n", mask)=
;
> > break;
> > }
> > mutex_unlock(&chip->lock);
> >
> > return ret;
> > }
> >
> > static const struct iio_chan_spec acpi_als_channels[] =3D {
> > {
> > .type =3D IIO_LIGHT,
> > .indexed =3D 1,
> > .channel =3D 1,
> > .scan_type.sign =3D 'u',
> > .scan_type.realbits =3D 10,
> > .scan_type.storagebits =3D 16,
> Doesn't matter as only one channel, but I'd prefer to see
> the scan_index specified here.
> > .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
> > IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> > },
> > };
> >
> > static const struct iio_info acpi_als_info =3D {
> > .driver_module =3D THIS_MODULE,
> > .read_raw =3D &acpi_als_read_raw,
> > .write_raw =3D NULL,
> > };
> >
> > static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> > {
> >
> > struct iio_poll_func *pf =3D p;
> > struct iio_dev *idev =3D pf->indio_dev;
> >
> >
> > struct acpi_als_chip *chip =3D iio_priv(idev);
> > struct iio_buffer *buffer =3D idev->buffer;
> > int i, j =3D 0;
> >
> > printk("XXX: TRIGGER handler called :)");
> > iio_trigger_notify_done(chip->trig);
> > return IRQ_HANDLED;
> >
> >
> > /* TODO: remove */
> > u8 b[64];
> >
> > for (i =3D 0; i < idev->masklength; i++) {
> > if (!test_bit(i, idev->active_scan_mask))
> > continue;
> >
> > // TODO: read
> > j++;
> > }
> >
> > if (idev->scan_timestamp) {
> > s64 *timestamp =3D (s64 *)((u8 *)b +
> > ALIGN(j, sizeof(s64)));
> > *timestamp =3D pf->timestamp;
> > }
> >
> > //buffer->access->store_to(buffer, (u8 *)b, pf->timestamp);
> Well not storing to the buffer is certainly not going to help.
> Also there is a iio_push_to_buffer for this.
> >
> > iio_trigger_notify_done(idev->trig);
> > return IRQ_HANDLED;
> > }
> >
> > /**
> >  * acpi_als_data_rdy_trigger_set_state() set datardy interrupt state
> >  **/
> > static int acpi_als_data_rdy_trigger_set_state(struct iio_trigger *trig=
,
> > bool state)
> > {
> > printk("XXX: set_state called\n");
> >
> > struct iio_dev *indio_dev =3D trig->private_data;
> >
> > dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> >
> > return 0;
> > }
> >
> > static const struct iio_trigger_ops acpi_als_trigger_ops =3D {
> > .owner =3D THIS_MODULE,
> > .set_trigger_state =3D &acpi_als_data_rdy_trigger_set_state
> > };
> >
> > // TODO
> > static const struct iio_buffer_setup_ops acpi_als_buffer_ops =3D {
> > .preenable =3D &iio_sw_buffer_preenable, // TODO ?
> > .postenable =3D &iio_triggered_buffer_postenable,
> > .predisable =3D &iio_triggered_buffer_predisable,
> > };
> >
> > static struct iio_trigger *acpi_als_allocate_trigger(struct iio_dev
> *idev)
> > {
> > printk("XX: allocate trigger called!\n");
> >
> > int ret;
> > struct iio_trigger *trig;
> > struct acpi_als_chip *chip =3D iio_priv(idev);
> >
> > trig =3D iio_trigger_alloc("acpi-als");
> > if (trig =3D=3D NULL)
> > return NULL;
> >
> > trig->dev.parent =3D idev->dev.parent;
> > trig->private_data =3D idev;
> > trig->ops =3D &acpi_als_trigger_ops;
> >
> > ret =3D iio_trigger_register(trig);
> > if (ret)
> > return NULL;
> >
> > printk("XXX: acpi_als_allocate_trigger: %d\n", ret);
> > return trig;
> > }
> >
> > static int acpi_als_trigger_init(struct iio_dev *idev)
> > {
> > printk("XXX: trigger init called\n");
> >
> > struct acpi_als_chip *chip =3D iio_priv(idev);
> > int i, ret;
> >
> > chip->trig =3D devm_kzalloc(&idev->dev, sizeof(chip->trig), GFP_KERNEL)=
;
> >
> > if (chip->trig =3D=3D NULL) {
> > ret =3D -ENOMEM;
> > goto error_ret;
> > }
> >
> > chip->trig =3D acpi_als_allocate_trigger(idev);
> > if (chip->trig =3D=3D NULL) {
> > dev_err(&idev->dev, "Could not allocate trigger %d\n");
> > ret =3D -ENOMEM;
> > goto error_trigger;
> > }
> >
> > printk("XXX: acpi_als_trigger_init: 0\n");
> > return 0;
> >
> > error_trigger:
> > iio_trigger_free(chip->trig);
> > error_ret:
> > return ret;
> > }
> >
> >
> > static int acpi_als_add(struct acpi_device *device)
> > {
> > int result;
> > struct acpi_als_chip *chip;
> > struct iio_dev *indio_dev;
> >
> > /*
> > if (unlikely(als_id >=3D 10)) {
> > printk(KERN_WARNING PREFIX "Too many ALS device found\n");
> > return -ENODEV;
> > }
> > */
> > indio_dev =3D iio_device_alloc(sizeof(*chip));
> > if (!indio_dev) {
> > dev_err(&device->dev, "iio allocation fails\n");
> > return -ENOMEM;
> > }
> >
> > chip =3D iio_priv(indio_dev);
> >
> > device->driver_data =3D indio_dev;
> > chip->device =3D device;
> > mutex_init(&chip->lock);
> >
> > indio_dev->info =3D &acpi_als_info;
> > indio_dev->channels =3D acpi_als_channels;
> > indio_dev->num_channels =3D ARRAY_SIZE(acpi_als_channels);
> > indio_dev->name =3D ACPI_ALS_DEVICE_NAME;
> > indio_dev->dev.parent =3D &device->dev;
> > indio_dev->modes =3D INDIO_DIRECT_MODE;
> >
> > result =3D iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_ti=
me,
> > &acpi_als_trigger_handler, NULL);
> >
> > if(result) {
> > printk("Could not setup buffer for iio device\n");
> > goto exit_iio_free;
> > }
> >
> > result =3D acpi_als_trigger_init(indio_dev);
> > if (result) {
> > printk("Couldn't setup the triggers.\n");
> > // TODO
> > //goto error_unregister_buffer;
> > }
> >
> > result =3D iio_device_register(indio_dev);
> > if (result < 0) {
> > dev_err(&chip->device->dev, "iio registration fails with error %d\n",
> > result);
> > goto exit_iio_free;
> > }
> >
> > printk("ACPI ALS initialized");
> >
> > return 0;
> >
> > exit_iio_free:
> > iio_device_free(indio_dev);
> > return result;
> > }
> >
> > static int acpi_als_remove(struct acpi_device *device, int type)
> > {
> > struct iio_dev *indio_dev;
> >
> > indio_dev =3D acpi_driver_data(device);
> > if(!indio_dev) {
> > dev_err(&device->dev, "could not get indio_dev for ACPI device\n");
> > return -1;
> > }
> >
> > iio_device_unregister(indio_dev);
> Not relevant to your problem, but you need to unregister the buffer.
>
> > iio_device_free(indio_dev);
> >
> > return 0;
> > }
> >
> > static int __init acpi_als_init(void)
> > {
> > return acpi_bus_register_driver(&acpi_als_driver);
> > }
> >
> > static void __exit acpi_als_exit(void)
> > {
> > acpi_bus_unregister_driver(&acpi_als_driver);
> > }
> >
> > module_init(acpi_als_init);
> > module_exit(acpi_als_exit);
> >
> > On 11 September 2012 11:21, Marek Vasut <marex@denx.de <mailto:
> marex@denx.de>> wrote:
> >
> >     Dear Martin Li=C5=A1ka,
> >
> >     [...]
> >
> >     > +static int acpi_als_write_raw(struct iio_dev *indio_dev,
> >     > +     struct iio_chan_spec const *chan, int val, int val2, long
> mask)
> >     > +{
> >     > + return 0;
> >     > +}
> >
> >     Simply set write_raw =3D NULL below (aka. don't put it into the
> structure at all).
> >
> >     > +static const struct iio_chan_spec acpi_als_channels[] =3D {
> >     > + {
> >     > + .type =3D IIO_LIGHT,
> >     > + .indexed =3D 1,
> >     > + .channel =3D 1,
> >     > + .scan_type.sign =3D 'u',
> >     > + .scan_type.realbits =3D 10,
> >     > + .scan_type.storagebits =3D 16,
> >     > + .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
> >     > + IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> >     > + },
> >     > +};
> >     > +
> >     > +static const struct iio_info acpi_als_info =3D {
> >     > + .driver_module =3D THIS_MODULE,
> >     > + .read_raw =3D &acpi_als_read_raw,
> >     > + .write_raw =3D &acpi_als_write_raw,
> >     > +};
> >     [...]
> >     Best regards,
> >     Marek Vasut
> >
> >
>

--e89a8f6438bcb5459304cd0d14aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div><div>=C2=A0 =C2=A0I hope being root should not bring any p=
ermission issues for the file:</div><div><br></div><div>ls -l /sys/bus/iio/=
devices/iio\:device0/scan_elements/in_illuminance1_en=C2=A0</div><div><b>-r=
w-r--r--</b> 1 root root 4096 Oct 27 15:54 /sys/bus/iio/devices/iio:device0=
/scan_elements/in_illuminance1_en</div>

<div><br></div><div>After adding debug print to ii_scan_el_show gives me re=
ally <b>-1</b> and <b>*</b>indio_dev-&gt;buffer-&gt;scan_mask is <b>1 </b>a=
nd echo command settings &quot;1&quot; is processed in <b>in_scan_el_store<=
/b> function with ret =3D=3D 0.</div>

<div><br></div><div>Thank you for new ideas,</div><div>Martin</div><br><div=
 class=3D"gmail_quote">On 21 October 2012 20:05, Jonathan Cameron <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@ke=
rnel.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

<div>On 10/21/2012 06:02 PM, Martin Li=C5=A1ka wrote:<br>
&gt; Hello,<br>
&gt; =C2=A0 =C2=A0my kernel driver is still unable to start capturing in a =
proper way. First step for listening is<br>
&gt;<br>
</div>&gt; /* echo 1 &gt; /sys/bus/iio/devices/iio\:device0/scan_elements/i=
n_illuminance1_en*/<br>
&gt; /<br>
&gt; /<br>
&gt; but<br>
&gt;<br>
&gt; /*cat /sys/bus/iio/devices/iio\:device0/scan_elements/in_illuminance1_=
en*/<br>
&gt; /*-1*/<br>
<br>
That is &#39;odd&#39; to put it lightly. =C2=A0That should just call iio_sc=
an_el_show which<br>
in turn calls test_bit on a bitmask. =C2=A0I&#39;m not sure that can return=
 anything other<br>
than 0 or 1. This is then fed directly into an sprintf call.<br>
Could there be a permissions issue or something similar?<br>
<br>
&gt; /*<br>
&gt; */<br>
<div>&gt; I tried to decorate all result codes with printf.<br>
&gt; Dmesg dump:<br>
</div>&gt; /[ =C2=A0 =C2=A00.927335] XXX: trigger init called/<br>
&gt; /[ =C2=A0 =C2=A00.928148] XXX: acpi_als_allocate_trigger: 0/<br>
&gt; /[ =C2=A0 =C2=A00.928275] XXX: acpi_als_trigger_init: 0/<br>
&gt; /[ =C2=A0 =C2=A03.255305] XXX: getting data for filling buffer/<br>
&gt; /[ =C2=A0 =C2=A03.255352] XXX: buffer is ready/<br>
&gt; /[ =C2=A0 27.423650] XXX: getting data for filling buffer/<br>
&gt; /[ =C2=A0 27.423698] XXX: buffer is ready/<br>
&gt; /[ =C2=A0 30.444120] XXX: getting data for filling buffer/<br>
<div>&gt;<br>
&gt; Do you have any advices how to figure out where is problem?<br>
</div>Yes, put some printk&#39;s into the core code and see what is going w=
rong.<br>
Right now that cat giving you -1 is certainly suspicious.<br>
<br>
Please do get your email client to handle patches nicely!<br>
<div><div>&gt;<br>
&gt; Thank you,<br>
&gt; Martin<br>
&gt;<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* ACPI Ambient Light Sensor Driver<br>
&gt; =C2=A0*<br>
&gt; =C2=A0* This program is free software; you can redistribute it and/or =
modify it<br>
&gt; =C2=A0* under the terms and conditions of the GNU General Public Licen=
se,<br>
&gt; =C2=A0* version 2, as published by the Free Software Foundation.<br>
&gt; =C2=A0*<br>
&gt; =C2=A0* This program is distributed in the hope it will be useful, but=
 WITHOUT<br>
&gt; =C2=A0* ANY WARRANTY; without even the implied warranty of MERCHANTABI=
LITY or<br>
&gt; =C2=A0* FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the GNU General Pu=
blic License for<br>
&gt; =C2=A0* more details.<br>
&gt; =C2=A0*<br>
&gt; =C2=A0* You should have received a copy of the GNU General Public Lice=
nse<br>
&gt; =C2=A0* along with this program. =C2=A0If not, see &lt;<a href=3D"http=
://www.gnu.org/licenses/" target=3D"_blank">http://www.gnu.org/licenses/</a=
>&gt;.<br>
&gt; =C2=A0*/<br>
&gt;<br>
&gt; #include &lt;linux/module.h&gt;<br>
&gt; #include &lt;linux/interrupt.h&gt;<br>
&gt; #include &lt;trace/events/printk.h&gt;<br>
&gt; #include &lt;acpi/acpi_bus.h&gt;<br>
&gt; #include &lt;acpi/acpi_drivers.h&gt;<br>
&gt; #include &lt;linux/err.h&gt;<br>
&gt; #include &lt;linux/mutex.h&gt;<br>
&gt;<br>
&gt; #include &lt;linux/iio/iio.h&gt;<br>
&gt; #include &lt;linux/iio/buffer.h&gt;<br>
&gt; #include &lt;linux/iio/sysfs.h&gt;<br>
&gt; #include &lt;linux/iio/trigger.h&gt;<br>
&gt; #include &lt;linux/iio/trigger_consumer.h&gt;<br>
&gt; #include &lt;linux/iio/triggered_buffer.h&gt;<br>
&gt;<br>
&gt; #define PREFIX &quot;ACPI: &quot;<br>
&gt;<br>
&gt; #define ACPI_ALS_CLASS&quot;als&quot;<br>
&gt; #define ACPI_ALS_DEVICE_NAME&quot;acpi-als&quot;<br>
&gt; #define ACPI_ALS_NOTIFY_ILLUMINANCE0x80<br>
&gt; #define ACPI_ALS_NOTIFY_COLOR_TEMP0x81<br>
&gt; #define ACPI_ALS_NOTIFY_RESPONSE0x82<br>
&gt;<br>
&gt; #define ACPI_ALS_OUTPUTS3<br>
&gt;<br>
&gt; #define _COMPONENTACPI_ALS_COMPONENT<br>
&gt; ACPI_MODULE_NAME(&quot;acpi-als&quot;);<br>
&gt;<br>
&gt; MODULE_AUTHOR(&quot;Martin Liska&quot;);<br>
&gt; MODULE_DESCRIPTION(&quot;ACPI Ambient Light Sensor Driver&quot;);<br>
&gt; MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt;<br>
&gt; struct acpi_als_chip {<br>
&gt; struct acpi_device*device;<br>
&gt; struct acpi_als_device*acpi_als_sys;<br>
&gt; struct mutexlock;<br>
&gt; struct iio_trigger*trig;<br>
&gt;<br>
&gt; int illuminance;<br>
&gt; int temperature;<br>
&gt; int chromaticity;<br>
&gt; int polling;<br>
&gt;<br>
&gt; int count;<br>
&gt; struct acpi_als_mapping *mappings;<br>
&gt; };<br>
&gt;<br>
&gt; static int acpi_als_add(struct acpi_device *device);<br>
&gt; static int acpi_als_remove(struct acpi_device *device, int type);<br>
&gt; static void acpi_als_notify(struct acpi_device *device, u32 event);<br=
>
&gt;<br>
&gt; static const struct acpi_device_id acpi_als_device_ids[] =3D {<br>
&gt; {&quot;ACPI0008&quot;, 0},<br>
&gt; {&quot;&quot;, 0},<br>
&gt; };<br>
&gt;<br>
&gt; MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);<br>
&gt;<br>
&gt; static struct acpi_driver acpi_als_driver =3D {<br>
&gt; .name =3D &quot;acpi_als&quot;,<br>
&gt; .class =3D ACPI_ALS_CLASS,<br>
&gt; .ids =3D acpi_als_device_ids,<br>
&gt; .ops =3D {<br>
&gt; .add =3D acpi_als_add,<br>
&gt; .remove =3D acpi_als_remove,<br>
&gt; .notify =3D acpi_als_notify,<br>
&gt; },<br>
&gt; };<br>
&gt;<br>
&gt; struct acpi_als_mapping {<br>
&gt; int adjustment;<br>
&gt; int illuminance;<br>
&gt; };<br>
&gt;<br>
&gt; #define ALS_INVALID_VALUE_LOW0<br>
&gt; #define ALS_INVALID_VALUE_HIGH-1<br>
&gt;<br>
&gt; /* -------------------------------------------------------------------=
-------<br>
&gt; Ambient Light Sensor device Management<br>
&gt; =C2=A0 =C2=A0---------------------------------------------------------=
----------------- */<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* acpi_als_get_illuminance - get the current ambient light illum=
inance<br>
&gt; =C2=A0*/<br>
&gt; static int acpi_als_get_illuminance(struct acpi_als_chip *als)<br>
&gt; {<br>
&gt; acpi_status status;<br>
&gt; unsigned long long illuminance;<br>
&gt;<br>
&gt; status =3D acpi_evaluate_integer(als-&gt;device-&gt;handle,<br>
&gt; &quot;_ALI&quot;, NULL, &amp;illuminance);<br>
&gt;<br>
&gt; if (ACPI_FAILURE(status)) {<br>
&gt; ACPI_EXCEPTION((AE_INFO, status, &quot;Error reading ALS illuminance&q=
uot;));<br>
&gt; als-&gt;illuminance =3D ALS_INVALID_VALUE_LOW;<br>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt; als-&gt;illuminance =3D illuminance;<br>
&gt;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* acpi_als_get_color_chromaticity - get the ambient light color =
chromaticity<br>
&gt; =C2=A0*/<br>
&gt; static int acpi_als_get_color_chromaticity(struct acpi_als_chip *chip)=
<br>
&gt; {<br>
&gt; acpi_status status;<br>
&gt; unsigned long long chromaticity;<br>
&gt;<br>
&gt; status =3D<br>
&gt; =C2=A0 =C2=A0 acpi_evaluate_integer(chip-&gt;device-&gt;handle, &quot;=
_ALC&quot;, NULL,<br>
&gt; =C2=A0 &amp;chromaticity);<br>
&gt; if (ACPI_FAILURE(status)) {<br>
&gt; ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;_ALC not available\n&quot;));<br=
>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt; chip-&gt;chromaticity =3D chromaticity;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* acpi_als_get_color_temperature - get the ambient light color t=
emperature<br>
&gt; =C2=A0*/<br>
&gt; static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)<=
br>
&gt; {<br>
&gt; acpi_status status;<br>
&gt; unsigned long long temperature;<br>
&gt;<br>
&gt; status =3D<br>
&gt; =C2=A0 =C2=A0 acpi_evaluate_integer(chip-&gt;device-&gt;handle, &quot;=
_ALT&quot;, NULL,<br>
&gt; =C2=A0 &amp;temperature);<br>
&gt; if (ACPI_FAILURE(status)) {<br>
&gt; ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;_ALT not available\n&quot;));<br=
>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt; chip-&gt;temperature =3D temperature;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* acpi_als_get_mappings - get the ALS illuminance mappings<br>
&gt; =C2=A0*<br>
&gt; =C2=A0* Return a package of ALS illuminance to display adjustment mapp=
ings<br>
&gt; =C2=A0* that can be used by OS to calibrate its ambient light policy<b=
r>
&gt; =C2=A0* for a given sensor configuration.<br>
&gt; =C2=A0*/<br>
&gt; static int acpi_als_get_mappings(struct acpi_als_chip *chip)<br>
&gt; {<br>
&gt; int result =3D 0;<br>
&gt; acpi_status status;<br>
&gt; struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };<br>
&gt; union acpi_object *alr;<br>
&gt; int i, j;<br>
&gt;<br>
&gt; /* Free the old mappings */<br>
&gt; kfree(chip-&gt;mappings);<br>
&gt; chip-&gt;mappings =3D NULL;<br>
&gt;<br>
&gt; status =3D<br>
&gt; =C2=A0 =C2=A0 acpi_evaluate_object(chip-&gt;device-&gt;handle, &quot;_=
ALR&quot;, NULL, &amp;buffer);<br>
&gt; if (ACPI_FAILURE(status)) {<br>
&gt; ACPI_EXCEPTION((AE_INFO, status, &quot;Error reading ALS mappings&quot=
;));<br>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt;<br>
&gt; alr =3D buffer.pointer;<br>
&gt; if (!alr || (alr-&gt;type !=3D ACPI_TYPE_PACKAGE)) {<br>
&gt; printk(KERN_ERR PREFIX &quot;Invalid _ALR data\n&quot;);<br>
&gt; result =3D -EFAULT;<br>
&gt; goto end;<br>
&gt; }<br>
&gt;<br>
&gt; ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Found %d illuminance mappings\n&=
quot;,<br>
&gt; =C2=A0 alr-&gt;package.count));<br>
&gt;<br>
&gt; chip-&gt;count =3D alr-&gt;package.count;<br>
&gt;<br>
&gt; if (!chip-&gt;count)<br>
&gt; return 0;<br>
&gt;<br>
&gt; chip-&gt;mappings =3D<br>
&gt; =C2=A0 =C2=A0 kmalloc(sizeof(struct acpi_als_mapping) * chip-&gt;count=
, GFP_KERNEL);<br>
&gt; if (!chip-&gt;mappings) {<br>
&gt; result =3D -ENOMEM;<br>
&gt; goto end;<br>
&gt; }<br>
&gt;<br>
&gt; for (i =3D 0, j =3D 0; i &lt; chip-&gt;count; i++) {<br>
&gt; struct acpi_als_mapping *mapping =3D &amp;(chip-&gt;mappings[j]);<br>
&gt; union acpi_object *element =3D &amp;(alr-&gt;package.elements[i]);<br>
&gt;<br>
&gt; if (element-&gt;type !=3D ACPI_TYPE_PACKAGE)<br>
&gt; continue;<br>
&gt;<br>
&gt; if (element-&gt;package.count !=3D 2)<br>
&gt; continue;<br>
&gt;<br>
&gt; if (element-&gt;package.elements[0].type !=3D ACPI_TYPE_INTEGER ||<br>
&gt; =C2=A0 =C2=A0 element-&gt;package.elements[1].type !=3D ACPI_TYPE_INTE=
GER)<br>
&gt; continue;<br>
&gt;<br>
&gt; mapping-&gt;adjustment =3D<br>
&gt; =C2=A0 =C2=A0 element-&gt;package.elements[0].integer.value;<br>
&gt; mapping-&gt;illuminance =3D<br>
&gt; =C2=A0 =C2=A0 element-&gt;package.elements[1].integer.value;<br>
&gt; j++;<br>
&gt;<br>
&gt; ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Mapping [%d]: &quot;<br>
&gt; =C2=A0 &quot;adjustment [%d] illuminance[%d]\n&quot;,<br>
&gt; =C2=A0 i, mapping-&gt;adjustment,<br>
&gt; =C2=A0 mapping-&gt;illuminance));<br>
&gt; }<br>
&gt;<br>
&gt; end:<br>
&gt; kfree(buffer.pointer);<br>
&gt; return result;<br>
&gt; }<br>
&gt;<br>
&gt; /*<br>
&gt; =C2=A0* acpi_als_get_polling - get a recommended polling frequency<br>
&gt; =C2=A0* =C2=A0 for the Ambient Light Sensor device<br>
&gt; =C2=A0*/<br>
&gt; static int acpi_als_get_polling(struct acpi_als_chip *chip)<br>
&gt; {<br>
&gt; acpi_status status;<br>
&gt; unsigned long long polling;<br>
&gt;<br>
&gt; status =3D<br>
&gt; =C2=A0 =C2=A0 acpi_evaluate_integer(chip-&gt;device-&gt;handle, &quot;=
_ALP&quot;, NULL, &amp;polling);<br>
&gt; if (ACPI_FAILURE(status)) {<br>
&gt; ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;_ALP not available\n&quot;));<br=
>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt;<br>
&gt; chip-&gt;polling =3D polling;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; static int get_illuminance(struct acpi_als_chip *als, int *illuminance=
)<br>
&gt; {<br>
&gt; int result;<br>
&gt;<br>
&gt; result =3D acpi_als_get_illuminance(als);<br>
&gt; if (!result)<br>
&gt; *illuminance =3D als-&gt;illuminance;<br>
&gt;<br>
&gt; return result;<br>
&gt; }<br>
&gt;<br>
&gt; static void acpi_als_notify(struct acpi_device *device, u32 event)<br>
&gt; {<br>
&gt; int illuminance;<br>
&gt; struct iio_dev *indio_dev =3D acpi_driver_data(device);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_buffer *buffer =3D indio_dev-&g=
t;buffer;<br>
&gt; struct acpi_als_chip *chip =3D iio_priv(indio_dev);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 s64 time_ns =3D iio_get_time_ns();<br>
&gt; int len =3D 2;<br>
&gt;<br>
&gt; u8 data[sizeof(s64) + len];<br>
&gt;<br>
&gt; printk(&quot;XXX: getting data for filling buffer\n&quot;);<br>
&gt; get_illuminance(chip, &amp;illuminance);<br>
&gt; *(int *)((u8 *)data) =3D illuminance;<br>
&gt; *(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) =3D time_ns;<br>
&gt;<br>
&gt; printk(&quot;XXX: buffer is ready\n&quot;);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iio_buffer_enabled(indio_dev)) {<br>
&gt; printk(&quot;XXX: pushing to buffer\n&quot;);<br>
&gt; iio_push_to_buffer(buffer, data);<br>
&gt; printk(&quot;XXX: push to buffer called\n&quot;);<br>
&gt; }<br>
&gt; }<br>
&gt;<br>
&gt; static int acpi_als_read_raw(struct iio_dev *indio_dev,<br>
&gt; struct iio_chan_spec const *chan, int *val, int *val2, long mask)<br>
&gt; {<br>
&gt; struct acpi_als_chip *chip =3D iio_priv(indio_dev);<br>
&gt; int ret =3D -EINVAL;<br>
&gt;<br>
&gt; mutex_lock(&amp;chip-&gt;lock);<br>
&gt;<br>
&gt; switch (mask) {<br>
&gt; case IIO_CHAN_INFO_RAW:<br>
&gt; case IIO_CHAN_INFO_PROCESSED:<br>
&gt; switch(chan-&gt;type) {<br>
&gt; case IIO_LIGHT:<br>
&gt; ret =3D get_illuminance(chip, val);<br>
&gt; break;<br>
&gt; default:<br>
&gt; break;<br>
&gt; }<br>
&gt;<br>
&gt; if(!ret)<br>
&gt; ret =3D IIO_VAL_INT;<br>
&gt;<br>
&gt; break;<br>
&gt; default:<br>
&gt; dev_err(&amp;chip-&gt;device-&gt;dev, &quot;mask value 0x%08lx not sup=
ported\n&quot;, mask);<br>
&gt; break;<br>
&gt; }<br>
&gt; mutex_unlock(&amp;chip-&gt;lock);<br>
&gt;<br>
&gt; return ret;<br>
&gt; }<br>
&gt;<br>
&gt; static const struct iio_chan_spec acpi_als_channels[] =3D {<br>
&gt; {<br>
&gt; .type =3D IIO_LIGHT,<br>
&gt; .indexed =3D 1,<br>
&gt; .channel =3D 1,<br>
&gt; .scan_type.sign =3D &#39;u&#39;,<br>
&gt; .scan_type.realbits =3D 10,<br>
&gt; .scan_type.storagebits =3D 16,<br>
</div></div>Doesn&#39;t matter as only one channel, but I&#39;d prefer to s=
ee<br>
the scan_index specified here.<br>
<div><div>&gt; .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |<br>
&gt; IIO_CHAN_INFO_SCALE_SEPARATE_BIT,<br>
&gt; },<br>
&gt; };<br>
&gt;<br>
&gt; static const struct iio_info acpi_als_info =3D {<br>
&gt; .driver_module =3D THIS_MODULE,<br>
&gt; .read_raw =3D &amp;acpi_als_read_raw,<br>
&gt; .write_raw =3D NULL,<br>
&gt; };<br>
&gt;<br>
&gt; static irqreturn_t acpi_als_trigger_handler(int irq, void *p)<br>
&gt; {<br>
&gt;<br>
&gt; struct iio_poll_func *pf =3D p;<br>
&gt; struct iio_dev *idev =3D pf-&gt;indio_dev;<br>
&gt;<br>
&gt;<br>
&gt; struct acpi_als_chip *chip =3D iio_priv(idev);<br>
&gt; struct iio_buffer *buffer =3D idev-&gt;buffer;<br>
&gt; int i, j =3D 0;<br>
&gt;<br>
&gt; printk(&quot;XXX: TRIGGER handler called :)&quot;);<br>
&gt; iio_trigger_notify_done(chip-&gt;trig);<br>
&gt; return IRQ_HANDLED;<br>
&gt;<br>
&gt;<br>
&gt; /* TODO: remove */<br>
&gt; u8 b[64];<br>
&gt;<br>
&gt; for (i =3D 0; i &lt; idev-&gt;masklength; i++) {<br>
&gt; if (!test_bit(i, idev-&gt;active_scan_mask))<br>
&gt; continue;<br>
&gt;<br>
&gt; // TODO: read<br>
&gt; j++;<br>
&gt; }<br>
&gt;<br>
&gt; if (idev-&gt;scan_timestamp) {<br>
&gt; s64 *timestamp =3D (s64 *)((u8 *)b +<br>
&gt; ALIGN(j, sizeof(s64)));<br>
&gt; *timestamp =3D pf-&gt;timestamp;<br>
&gt; }<br>
&gt;<br>
</div></div>&gt; //buffer-&gt;access-&gt;store_to(buffer, (u8 *)b, pf-&gt;t=
imestamp);<br>
Well not storing to the buffer is certainly not going to help.<br>
Also there is a iio_push_to_buffer for this.<br>
<div><div>&gt;<br>
&gt; iio_trigger_notify_done(idev-&gt;trig);<br>
&gt; return IRQ_HANDLED;<br>
&gt; }<br>
&gt;<br>
&gt; /**<br>
&gt; =C2=A0* acpi_als_data_rdy_trigger_set_state() set datardy interrupt st=
ate<br>
&gt; =C2=A0**/<br>
&gt; static int acpi_als_data_rdy_trigger_set_state(struct iio_trigger *tri=
g,<br>
&gt; bool state)<br>
&gt; {<br>
&gt; printk(&quot;XXX: set_state called\n&quot;);<br>
&gt;<br>
&gt; struct iio_dev *indio_dev =3D trig-&gt;private_data;<br>
&gt;<br>
&gt; dev_dbg(&amp;indio_dev-&gt;dev, &quot;%s (%d)\n&quot;, __func__, state=
);<br>
&gt;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; static const struct iio_trigger_ops acpi_als_trigger_ops =3D {<br>
&gt; .owner =3D THIS_MODULE,<br>
&gt; .set_trigger_state =3D &amp;acpi_als_data_rdy_trigger_set_state<br>
&gt; };<br>
&gt;<br>
&gt; // TODO<br>
&gt; static const struct iio_buffer_setup_ops acpi_als_buffer_ops =3D {<br>
&gt; .preenable =3D &amp;iio_sw_buffer_preenable, // TODO ?<br>
&gt; .postenable =3D &amp;iio_triggered_buffer_postenable,<br>
&gt; .predisable =3D &amp;iio_triggered_buffer_predisable,<br>
&gt; };<br>
&gt;<br>
&gt; static struct iio_trigger *acpi_als_allocate_trigger(struct iio_dev *i=
dev)<br>
&gt; {<br>
&gt; printk(&quot;XX: allocate trigger called!\n&quot;);<br>
&gt;<br>
&gt; int ret;<br>
&gt; struct iio_trigger *trig;<br>
&gt; struct acpi_als_chip *chip =3D iio_priv(idev);<br>
&gt;<br>
&gt; trig =3D iio_trigger_alloc(&quot;acpi-als&quot;);<br>
&gt; if (trig =3D=3D NULL)<br>
&gt; return NULL;<br>
&gt;<br>
&gt; trig-&gt;dev.parent =3D idev-&gt;dev.parent;<br>
&gt; trig-&gt;private_data =3D idev;<br>
&gt; trig-&gt;ops =3D &amp;acpi_als_trigger_ops;<br>
&gt;<br>
&gt; ret =3D iio_trigger_register(trig);<br>
&gt; if (ret)<br>
&gt; return NULL;<br>
&gt;<br>
&gt; printk(&quot;XXX: acpi_als_allocate_trigger: %d\n&quot;, ret);<br>
&gt; return trig;<br>
&gt; }<br>
&gt;<br>
&gt; static int acpi_als_trigger_init(struct iio_dev *idev)<br>
&gt; {<br>
&gt; printk(&quot;XXX: trigger init called\n&quot;);<br>
&gt;<br>
&gt; struct acpi_als_chip *chip =3D iio_priv(idev);<br>
&gt; int i, ret;<br>
&gt;<br>
&gt; chip-&gt;trig =3D devm_kzalloc(&amp;idev-&gt;dev, sizeof(chip-&gt;trig=
), GFP_KERNEL);<br>
&gt;<br>
&gt; if (chip-&gt;trig =3D=3D NULL) {<br>
&gt; ret =3D -ENOMEM;<br>
&gt; goto error_ret;<br>
&gt; }<br>
&gt;<br>
&gt; chip-&gt;trig =3D acpi_als_allocate_trigger(idev);<br>
&gt; if (chip-&gt;trig =3D=3D NULL) {<br>
&gt; dev_err(&amp;idev-&gt;dev, &quot;Could not allocate trigger %d\n&quot;=
);<br>
&gt; ret =3D -ENOMEM;<br>
&gt; goto error_trigger;<br>
&gt; }<br>
&gt;<br>
&gt; printk(&quot;XXX: acpi_als_trigger_init: 0\n&quot;);<br>
&gt; return 0;<br>
&gt;<br>
&gt; error_trigger:<br>
&gt; iio_trigger_free(chip-&gt;trig);<br>
&gt; error_ret:<br>
&gt; return ret;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; static int acpi_als_add(struct acpi_device *device)<br>
&gt; {<br>
&gt; int result;<br>
&gt; struct acpi_als_chip *chip;<br>
&gt; struct iio_dev *indio_dev;<br>
&gt;<br>
&gt; /*<br>
&gt; if (unlikely(als_id &gt;=3D 10)) {<br>
&gt; printk(KERN_WARNING PREFIX &quot;Too many ALS device found\n&quot;);<b=
r>
&gt; return -ENODEV;<br>
&gt; }<br>
&gt; */<br>
&gt; indio_dev =3D iio_device_alloc(sizeof(*chip));<br>
&gt; if (!indio_dev) {<br>
&gt; dev_err(&amp;device-&gt;dev, &quot;iio allocation fails\n&quot;);<br>
&gt; return -ENOMEM;<br>
&gt; }<br>
&gt;<br>
&gt; chip =3D iio_priv(indio_dev);<br>
&gt;<br>
&gt; device-&gt;driver_data =3D indio_dev;<br>
&gt; chip-&gt;device =3D device;<br>
&gt; mutex_init(&amp;chip-&gt;lock);<br>
&gt;<br>
&gt; indio_dev-&gt;info =3D &amp;acpi_als_info;<br>
&gt; indio_dev-&gt;channels =3D acpi_als_channels;<br>
&gt; indio_dev-&gt;num_channels =3D ARRAY_SIZE(acpi_als_channels);<br>
&gt; indio_dev-&gt;name =3D ACPI_ALS_DEVICE_NAME;<br>
&gt; indio_dev-&gt;dev.parent =3D &amp;device-&gt;dev;<br>
&gt; indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt;<br>
&gt; result =3D iio_triggered_buffer_setup(indio_dev, &amp;iio_pollfunc_sto=
re_time,<br>
&gt; &amp;acpi_als_trigger_handler, NULL);<br>
&gt;<br>
&gt; if(result) {<br>
&gt; printk(&quot;Could not setup buffer for iio device\n&quot;);<br>
&gt; goto exit_iio_free;<br>
&gt; }<br>
&gt;<br>
&gt; result =3D acpi_als_trigger_init(indio_dev);<br>
&gt; if (result) {<br>
&gt; printk(&quot;Couldn&#39;t setup the triggers.\n&quot;);<br>
&gt; // TODO<br>
&gt; //goto error_unregister_buffer;<br>
&gt; }<br>
&gt;<br>
&gt; result =3D iio_device_register(indio_dev);<br>
&gt; if (result &lt; 0) {<br>
&gt; dev_err(&amp;chip-&gt;device-&gt;dev, &quot;iio registration fails wit=
h error %d\n&quot;,<br>
&gt; result);<br>
&gt; goto exit_iio_free;<br>
&gt; }<br>
&gt;<br>
&gt; printk(&quot;ACPI ALS initialized&quot;);<br>
&gt;<br>
&gt; return 0;<br>
&gt;<br>
&gt; exit_iio_free:<br>
&gt; iio_device_free(indio_dev);<br>
&gt; return result;<br>
&gt; }<br>
&gt;<br>
&gt; static int acpi_als_remove(struct acpi_device *device, int type)<br>
&gt; {<br>
&gt; struct iio_dev *indio_dev;<br>
&gt;<br>
&gt; indio_dev =3D acpi_driver_data(device);<br>
&gt; if(!indio_dev) {<br>
&gt; dev_err(&amp;device-&gt;dev, &quot;could not get indio_dev for ACPI de=
vice\n&quot;);<br>
&gt; return -1;<br>
&gt; }<br>
&gt;<br>
&gt; iio_device_unregister(indio_dev);<br>
</div></div>Not relevant to your problem, but you need to unregister the bu=
ffer.<br>
<div><br>
&gt; iio_device_free(indio_dev);<br>
&gt;<br>
&gt; return 0;<br>
&gt; }<br>
&gt;<br>
&gt; static int __init acpi_als_init(void)<br>
&gt; {<br>
&gt; return acpi_bus_register_driver(&amp;acpi_als_driver);<br>
&gt; }<br>
&gt;<br>
&gt; static void __exit acpi_als_exit(void)<br>
&gt; {<br>
&gt; acpi_bus_unregister_driver(&amp;acpi_als_driver);<br>
&gt; }<br>
&gt;<br>
&gt; module_init(acpi_als_init);<br>
&gt; module_exit(acpi_als_exit);<br>
&gt;<br>
</div><div><div>&gt; On 11 September 2012 11:21, Marek Vasut &lt;<a href=3D=
"mailto:marex@denx.de" target=3D"_blank">marex@denx.de</a> &lt;mailto:<a hr=
ef=3D"mailto:marex@denx.de" target=3D"_blank">marex@denx.de</a>&gt;&gt; wro=
te:<br>


&gt;<br>
&gt; =C2=A0 =C2=A0 Dear Martin Li=C5=A1ka,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 [...]<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; +static int acpi_als_write_raw(struct iio_dev *indi=
o_dev,<br>
&gt; =C2=A0 =C2=A0 &gt; + =C2=A0 =C2=A0 struct iio_chan_spec const *chan, i=
nt val, int val2, long mask)<br>
&gt; =C2=A0 =C2=A0 &gt; +{<br>
&gt; =C2=A0 =C2=A0 &gt; + return 0;<br>
&gt; =C2=A0 =C2=A0 &gt; +}<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Simply set write_raw =3D NULL below (aka. don&#39;t put =
it into the structure at all).<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; +static const struct iio_chan_spec acpi_als_channel=
s[] =3D {<br>
&gt; =C2=A0 =C2=A0 &gt; + {<br>
&gt; =C2=A0 =C2=A0 &gt; + .type =3D IIO_LIGHT,<br>
&gt; =C2=A0 =C2=A0 &gt; + .indexed =3D 1,<br>
&gt; =C2=A0 =C2=A0 &gt; + .channel =3D 1,<br>
&gt; =C2=A0 =C2=A0 &gt; + .scan_type.sign =3D &#39;u&#39;,<br>
&gt; =C2=A0 =C2=A0 &gt; + .scan_type.realbits =3D 10,<br>
&gt; =C2=A0 =C2=A0 &gt; + .scan_type.storagebits =3D 16,<br>
&gt; =C2=A0 =C2=A0 &gt; + .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_B=
IT |<br>
&gt; =C2=A0 =C2=A0 &gt; + IIO_CHAN_INFO_SCALE_SEPARATE_BIT,<br>
&gt; =C2=A0 =C2=A0 &gt; + },<br>
&gt; =C2=A0 =C2=A0 &gt; +};<br>
&gt; =C2=A0 =C2=A0 &gt; +<br>
&gt; =C2=A0 =C2=A0 &gt; +static const struct iio_info acpi_als_info =3D {<b=
r>
&gt; =C2=A0 =C2=A0 &gt; + .driver_module =3D THIS_MODULE,<br>
&gt; =C2=A0 =C2=A0 &gt; + .read_raw =3D &amp;acpi_als_read_raw,<br>
&gt; =C2=A0 =C2=A0 &gt; + .write_raw =3D &amp;acpi_als_write_raw,<br>
&gt; =C2=A0 =C2=A0 &gt; +};<br>
&gt; =C2=A0 =C2=A0 [...]<br>
&gt; =C2=A0 =C2=A0 Best regards,<br>
&gt; =C2=A0 =C2=A0 Marek Vasut<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br>

--e89a8f6438bcb5459304cd0d14aa--
