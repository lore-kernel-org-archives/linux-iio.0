Return-Path: <marxin.liska@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4FFADCC2.6080006@cam.ac.uk>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
	<201207082228.14318.marex@denx.de>
	<4FFADCC2.6080006@cam.ac.uk>
Date: Tue, 11 Sep 2012 09:48:30 +0200
Message-ID: <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
Subject: Re: ACPI ambient light sensor
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Marek Vasut <marex@denx.de>, platform-driver-x86@vger.kernel.org,
	linux-iio@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Corentin Chary <corentin.chary@gmail.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de, Jonathan Cameron <jic23@kernel.org>,
	Jon Brenner <jbrenner@taosinc.com>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: multipart/alternative; boundary=f46d044472f3df534504c9684c4d
List-ID: <linux-iio@vger.kernel.org>

--f46d044472f3df534504c9684c4d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Following patch introduces support for trigger function in cooperation with
a kfifo buffer. Problem that I need to help with is calling *
iio_trigger_poll* in *acpi_notify* handler. From the following callstack
you can see that acpi_notify is called from workQ:

[  250.046289] Call Trace:
[  250.046307]  [<c14d3d69>] acpi_als_notify+0x69/0xb0
[  250.046321]  [<c12c88a8>] ? acpi_evaluate_object+0x1b4/0x1c1
[  250.046332]  [<c12b2aa2>] acpi_device_notify+0x12/0x15
[  250.046344]  [<c12bd11a>] acpi_ev_notify_dispatch+0x2e/0x45
[  250.046352]  [<c12b035f>] acpi_os_execute_deferred+0x1b/0x26
[  250.046361]  [<c104a15d>] process_one_work+0xfd/0x370
[  250.046368]  [<c1049060>] ? do_work_for_cpu+0x20/0x20
[  250.046375]  [<c12b0344>] ? acpi_os_wait_events_complete+0x19/0x19
[  250.046383]  [<c104b92d>] worker_thread+0x12d/0x2c0
[  250.046391]  [<c104b800>] ? manage_workers.clone.19+0x200/0x200
[  250.046400]  [<c104fa34>] kthread+0x74/0x80
[  250.046408]  [<c104f9c0>] ? flush_kthread_worker+0xa0/0xa0
[  250.046416]  [<c16c20f6>] kernel_thread_helper+0x6/0xd
[  250.046424] ------------[ cut here ]------------

After calling iio_trigger_poll following output could be found in dmesg:

[  250.046433] WARNING: at kernel/irq/handle.c:146
handle_irq_event_percpu+0x198/0x1b0()
[  250.046437] Hardware name: ICONIA Tab W500
[  250.046447] irq 20 handler iio_pollfunc_store_time+0x0/0x50 enabled
interrupts
[  250.046450] Modules linked in:
[  250.046458] Pid: 4, comm: kworker/0:0 Not tainted
3.5.0-rc5-next-20120705+ #86
[  250.046461] Call Trace:
[  250.046469]  [<c1031c1d>] warn_slowpath_common+0x6d/0xa0
[  250.046476]  [<c1098f28>] ? handle_irq_event_percpu+0x198/0x1b0
[  250.046483]  [<c1098f28>] ? handle_irq_event_percpu+0x198/0x1b0
[  250.046490]  [<c1031cce>] warn_slowpath_fmt+0x2e/0x30
[  250.046497]  [<c1098f28>] handle_irq_event_percpu+0x198/0x1b0
[  250.046504]  [<c14d8990>] ? iio_trig_release+0x90/0x90
[  250.046511]  [<c1098f70>] handle_irq_event+0x30/0x60
[  250.046519]  [<c109af1c>] handle_simple_irq+0x3c/0x60
[  250.046526]  [<c10987cd>] generic_handle_irq+0x1d/0x30
[  250.046533]  [<c14d8a7d>] iio_trigger_poll+0x3d/0x60
[  250.046540]  [<c14d3da0>] acpi_als_notify+0xa0/0xb0
[  250.046547]  [<c12b2aa2>] acpi_device_notify+0x12/0x15
[  250.046555]  [<c12bd11a>] acpi_ev_notify_dispatch+0x2e/0x45
[  250.046561]  [<c12b035f>] acpi_os_execute_deferred+0x1b/0x26
[  250.046568]  [<c104a15d>] process_one_work+0xfd/0x370
[  250.046574]  [<c1049060>] ? do_work_for_cpu+0x20/0x20
[  250.046581]  [<c12b0344>] ? acpi_os_wait_events_complete+0x19/0x19
[  250.046588]  [<c104b92d>] worker_thread+0x12d/0x2c0
[  250.046596]  [<c104b800>] ? manage_workers.clone.19+0x200/0x200
[  250.046603]  [<c104fa34>] kthread+0x74/0x80
[  250.046611]  [<c104f9c0>] ? flush_kthread_worker+0xa0/0xa0
[  250.046617]  [<c16c20f6>] kernel_thread_helper+0x6/0xd
[  250.046622] ---[ end trace b07487a0fd2a6c56 ]---

*Patch:*
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6bf9d05..fd7a2d1 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -6,6 +6,7 @@
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/sched.h>

 struct iio_kfifo {
  struct iio_buffer buffer;
@@ -22,7 +23,8 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo
*buf,
  return -EINVAL;

  __iio_update_buffer(&buf->buffer, bytes_per_datum, length);
- return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
+ return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
+     bytes_per_datum, GFP_KERNEL);
 }

 static int iio_request_update_kfifo(struct iio_buffer *r)
@@ -33,8 +35,11 @@ static int iio_request_update_kfifo(struct iio_buffer *r=
)
  if (!buf->update_needed)
  goto error_ret;
  kfifo_free(&buf->kf);
+
  ret =3D __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
    buf->buffer.length);
+
+ r->stufftoread =3D false;
 error_ret:
  return ret;
 }
@@ -81,6 +86,9 @@ static int iio_set_bytes_per_datum_kfifo(struct
iio_buffer *r, size_t bpd)

 static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 {
+ /* Avoid an invalid state */
+ if (length < 2)
+ length =3D 2;
  if (r->length !=3D length) {
  r->length =3D length;
  iio_mark_update_needed_kfifo(r);
@@ -94,9 +102,12 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 {
  int ret;
  struct iio_kfifo *kf =3D iio_to_kfifo(r);
- ret =3D kfifo_in(&kf->kf, data, r->bytes_per_datum);
- if (ret !=3D r->bytes_per_datum)
+ ret =3D kfifo_in(&kf->kf, data, 1);
+ if (ret !=3D 1)
  return -EBUSY;
+ r->stufftoread =3D true;
+ wake_up_interruptible(&r->pollq);
+
  return 0;
 }

@@ -106,11 +117,18 @@ static int iio_read_first_n_kfifo(struct iio_buffer
*r,
  int ret, copied;
  struct iio_kfifo *kf =3D iio_to_kfifo(r);

- if (n < r->bytes_per_datum)
+ if (n < r->bytes_per_datum || r->bytes_per_datum =3D=3D 0)
  return -EINVAL;

- n =3D rounddown(n, r->bytes_per_datum);
  ret =3D kfifo_to_user(&kf->kf, buf, n, &copied);
+ if (ret < 0)
+ return ret;
+
+ if (kfifo_is_empty(&kf->kf))
+ r->stufftoread =3D false;
+ /* verify it is still empty to avoid race */
+ if (!kfifo_is_empty(&kf->kf))
+ r->stufftoread =3D true;

  return copied;
 }
@@ -136,7 +154,7 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev
*indio_dev)
  iio_buffer_init(&kf->buffer);
  kf->buffer.attrs =3D &iio_kfifo_attribute_group;
  kf->buffer.access =3D &kfifo_access_funcs;
-
+ kf->buffer.length =3D 2;
  return &kf->buffer;
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
diff --git a/drivers/staging/iio/light/Kconfig
b/drivers/staging/iio/light/Kconfig
index 4bed30e..a164ecc 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -50,4 +50,10 @@ config TSL2x7x
  tmd2672, tsl2772, tmd2772 devices.
  Provides iio_events and direct access via sysfs.

+config ACPI_ALS
+ tristate "ACPI Ambient Light Sensor"
+ help
+ Support for ACPI0008 Light Sensor.
+ Provides direct access via sysfs.
+
 endmenu
diff --git a/drivers/staging/iio/light/Makefile
b/drivers/staging/iio/light/Makefile
index 141af1e..13090e6 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018) +=3D isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028) +=3D isl29028.o
 obj-$(CONFIG_TSL2583) +=3D tsl2583.o
 obj-$(CONFIG_TSL2x7x) +=3D tsl2x7x_core.o
+obj-$(CONFIG_ACPI_ALS) +=3D acpi-als.o
diff --git a/drivers/staging/iio/light/acpi-als.c
b/drivers/staging/iio/light/acpi-als.c
new file mode 100644
index 0000000..a2cf9bb
--- /dev/null
+++ b/drivers/staging/iio/light/acpi-als.c
@@ -0,0 +1,546 @@
+/*
+ * ACPI Ambient Light Sensor Driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <trace/events/printk.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define PREFIX "ACPI: "
+
+#define ACPI_ALS_CLASS "als"
+#define ACPI_ALS_DEVICE_NAME "acpi-als"
+#define ACPI_ALS_NOTIFY_ILLUMINANCE 0x80
+#define ACPI_ALS_NOTIFY_COLOR_TEMP 0x81
+#define ACPI_ALS_NOTIFY_RESPONSE 0x82
+
+#define ACPI_ALS_OUTPUTS 3
+
+#define _COMPONENT ACPI_ALS_COMPONENT
+ACPI_MODULE_NAME("acpi-als");
+
+MODULE_AUTHOR("Martin Liska");
+MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
+MODULE_LICENSE("GPL");
+
+struct acpi_als_chip {
+ struct acpi_device *device;
+ struct acpi_als_device *acpi_als_sys;
+ struct mutex lock;
+ struct iio_trigger *trig;
+
+ int illuminance;
+ int temperature;
+ int chromaticity;
+ int polling;
+
+ int count;
+ struct acpi_als_mapping *mappings;
+};
+
+static int acpi_als_add(struct acpi_device *device);
+static int acpi_als_remove(struct acpi_device *device, int type);
+static void acpi_als_notify(struct acpi_device *device, u32 event);
+
+static const struct acpi_device_id acpi_als_device_ids[] =3D {
+ {"ACPI0008", 0},
+ {"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
+
+static struct acpi_driver acpi_als_driver =3D {
+ .name =3D "acpi_als",
+ .class =3D ACPI_ALS_CLASS,
+ .ids =3D acpi_als_device_ids,
+ .ops =3D {
+ .add =3D acpi_als_add,
+ .remove =3D acpi_als_remove,
+ .notify =3D acpi_als_notify,
+ },
+};
+
+struct acpi_als_mapping {
+ int adjustment;
+ int illuminance;
+};
+
+#define ALS_INVALID_VALUE_LOW 0
+#define ALS_INVALID_VALUE_HIGH -1
+
+/*
--------------------------------------------------------------------------
+ Ambient Light Sensor device Management
+
--------------------------------------------------------------------------
*/
+
+/*
+ * acpi_als_get_illuminance - get the current ambient light illuminance
+ */
+static int acpi_als_get_illuminance(struct acpi_als_chip *als)
+{
+ acpi_status status;
+ unsigned long long illuminance;
+
+ status =3D acpi_evaluate_integer(als->device->handle,
+ "_ALI", NULL, &illuminance);
+
+ if (ACPI_FAILURE(status)) {
+ ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS illuminance"));
+ als->illuminance =3D ALS_INVALID_VALUE_LOW;
+ return -ENODEV;
+ }
+ als->illuminance =3D illuminance;
+
+ return 0;
+}
+
+/*
+ * acpi_als_get_color_chromaticity - get the ambient light color
chromaticity
+ */
+static int acpi_als_get_color_chromaticity(struct acpi_als_chip *chip)
+{
+ acpi_status status;
+ unsigned long long chromaticity;
+
+ status =3D
+    acpi_evaluate_integer(chip->device->handle, "_ALC", NULL,
+  &chromaticity);
+ if (ACPI_FAILURE(status)) {
+ ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALC not available\n"));
+ return -ENODEV;
+ }
+ chip->chromaticity =3D chromaticity;
+ return 0;
+}
+
+/*
+ * acpi_als_get_color_temperature - get the ambient light color temperatur=
e
+ */
+static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)
+{
+ acpi_status status;
+ unsigned long long temperature;
+
+ status =3D
+    acpi_evaluate_integer(chip->device->handle, "_ALT", NULL,
+  &temperature);
+ if (ACPI_FAILURE(status)) {
+ ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALT not available\n"));
+ return -ENODEV;
+ }
+ chip->temperature =3D temperature;
+ return 0;
+}
+
+/*
+ * acpi_als_get_mappings - get the ALS illuminance mappings
+ *
+ * Return a package of ALS illuminance to display adjustment mappings
+ * that can be used by OS to calibrate its ambient light policy
+ * for a given sensor configuration.
+ */
+static int acpi_als_get_mappings(struct acpi_als_chip *chip)
+{
+ int result =3D 0;
+ acpi_status status;
+ struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+ union acpi_object *alr;
+ int i, j;
+
+ /* Free the old mappings */
+ kfree(chip->mappings);
+ chip->mappings =3D NULL;
+
+ status =3D
+    acpi_evaluate_object(chip->device->handle, "_ALR", NULL, &buffer);
+ if (ACPI_FAILURE(status)) {
+ ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS mappings"));
+ return -ENODEV;
+ }
+
+ alr =3D buffer.pointer;
+ if (!alr || (alr->type !=3D ACPI_TYPE_PACKAGE)) {
+ printk(KERN_ERR PREFIX "Invalid _ALR data\n");
+ result =3D -EFAULT;
+ goto end;
+ }
+
+ ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d illuminance mappings\n",
+  alr->package.count));
+
+ chip->count =3D alr->package.count;
+
+ if (!chip->count)
+ return 0;
+
+ chip->mappings =3D
+    kmalloc(sizeof(struct acpi_als_mapping) * chip->count, GFP_KERNEL);
+ if (!chip->mappings) {
+ result =3D -ENOMEM;
+ goto end;
+ }
+
+ for (i =3D 0, j =3D 0; i < chip->count; i++) {
+ struct acpi_als_mapping *mapping =3D &(chip->mappings[j]);
+ union acpi_object *element =3D &(alr->package.elements[i]);
+
+ if (element->type !=3D ACPI_TYPE_PACKAGE)
+ continue;
+
+ if (element->package.count !=3D 2)
+ continue;
+
+ if (element->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
+    element->package.elements[1].type !=3D ACPI_TYPE_INTEGER)
+ continue;
+
+ mapping->adjustment =3D
+    element->package.elements[0].integer.value;
+ mapping->illuminance =3D
+    element->package.elements[1].integer.value;
+ j++;
+
+ ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Mapping [%d]: "
+  "adjustment [%d] illuminance[%d]\n",
+  i, mapping->adjustment,
+  mapping->illuminance));
+ }
+
+end:
+ kfree(buffer.pointer);
+ return result;
+}
+
+/*
+ * acpi_als_get_polling - get a recommended polling frequency
+ *   for the Ambient Light Sensor device
+ */
+static int acpi_als_get_polling(struct acpi_als_chip *chip)
+{
+ acpi_status status;
+ unsigned long long polling;
+
+ status =3D
+    acpi_evaluate_integer(chip->device->handle, "_ALP", NULL, &polling);
+ if (ACPI_FAILURE(status)) {
+ ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
+ return -ENODEV;
+ }
+
+ chip->polling =3D polling;
+ return 0;
+}
+
+static int get_illuminance(struct acpi_als_chip *als, int *illuminance)
+{
+ int result;
+
+ result =3D acpi_als_get_illuminance(als);
+ if (!result)
+ *illuminance =3D als->illuminance;
+
+ return result;
+}
+
+static void acpi_als_notify(struct acpi_device *device, u32 event)
+{
+ struct iio_dev *indio_dev;
+ struct acpi_als_chip *chip;
+ int illuminance;
+
+ printk("XXXX: notification: %u\n", event);
+
+ indio_dev =3D acpi_driver_data(device);
+ chip =3D iio_priv(indio_dev);
+
+ get_illuminance(chip, &illuminance);
+
+        if (iio_buffer_enabled(indio_dev))
+ {
+ printk("XXXX: calling trigger poll: %p\n", indio_dev->trig);
+
+ dump_stack();
+ iio_trigger_poll(indio_dev->trig, iio_get_time_ns());
+ }
+}
+
+static int acpi_als_read_raw(struct iio_dev *indio_dev,
+ struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+ struct acpi_als_chip *chip =3D iio_priv(indio_dev);
+ int ret =3D -EINVAL;
+
+ mutex_lock(&chip->lock);
+
+ switch (mask) {
+ case IIO_CHAN_INFO_RAW:
+ case IIO_CHAN_INFO_PROCESSED:
+ switch(chan->type) {
+ case IIO_LIGHT:
+ ret =3D get_illuminance(chip, val);
+ break;
+ default:
+ break;
+ }
+
+ if(!ret)
+ ret =3D IIO_VAL_INT;
+
+ break;
+ default:
+ dev_err(&chip->device->dev, "mask value 0x%08lx not supported\n", mask);
+ break;
+ }
+
+ mutex_unlock(&chip->lock);
+
+ return ret;
+}
+
+static int acpi_als_write_raw(struct iio_dev *indio_dev,
+     struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+ return 0;
+}
+
+static const struct iio_chan_spec acpi_als_channels[] =3D {
+ {
+ .type =3D IIO_LIGHT,
+ .indexed =3D 1,
+ .channel =3D 1,
+ .scan_type.sign =3D 'u',
+ .scan_type.realbits =3D 10,
+ .scan_type.storagebits =3D 16,
+ .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
+ IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+ },
+};
+
+static const struct iio_info acpi_als_info =3D {
+ .driver_module =3D THIS_MODULE,
+ .read_raw =3D &acpi_als_read_raw,
+ .write_raw =3D &acpi_als_write_raw,
+};
+
+static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
+{
+ printk("XXXX: TRIGGER handler called :)");
+
+ return IRQ_HANDLED;
+
+ struct iio_poll_func *pf =3D p;
+ struct iio_dev *idev =3D pf->indio_dev;
+ struct acpi_als_chip *chip =3D iio_priv(idev);
+ struct iio_buffer *buffer =3D idev->buffer;
+ int i, j =3D 0;
+
+ /* TODO: remove */
+ u8 b[64];
+
+ for (i =3D 0; i < idev->masklength; i++) {
+ if (!test_bit(i, idev->active_scan_mask))
+ continue;
+
+ // TODO: read
+ j++;
+ }
+
+ if (idev->scan_timestamp) {
+ s64 *timestamp =3D (s64 *)((u8 *)b +
+ ALIGN(j, sizeof(s64)));
+ *timestamp =3D pf->timestamp;
+ }
+
+ buffer->access->store_to(buffer, (u8 *)b, pf->timestamp);
+
+ iio_trigger_notify_done(idev->trig);
+
+ return IRQ_HANDLED;
+}
+
+/**
+ * acpi_als_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int acpi_als_data_rdy_trigger_set_state(struct iio_trigger *trig,
+ bool state)
+{
+ struct iio_dev *indio_dev =3D trig->private_data;
+
+ dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+
+ return 0;
+}
+
+static const struct iio_trigger_ops acpi_als_trigger_ops =3D {
+ .owner =3D THIS_MODULE,
+};
+
+static const struct iio_buffer_setup_ops acpi_als_buffer_ops =3D {
+ .preenable =3D &iio_sw_buffer_preenable,
+ .postenable =3D &iio_triggered_buffer_postenable,
+ .predisable =3D &iio_triggered_buffer_predisable,
+};
+
+static struct iio_trigger *acpi_als_allocate_trigger(struct iio_dev *idev)
+{
+ int ret;
+ struct iio_trigger *trig;
+ struct acpi_als_chip *chip =3D iio_priv(idev);
+
+ trig =3D iio_trigger_alloc("acpi-als");
+ if (trig =3D=3D NULL)
+ return NULL;
+
+ trig->dev.parent =3D idev->dev.parent;
+ trig->private_data =3D idev;
+ trig->ops =3D &acpi_als_trigger_ops;
+
+ ret =3D iio_trigger_register(trig);
+ if (ret)
+ return NULL;
+
+ return trig;
+}
+
+static int acpi_als_trigger_init(struct iio_dev *idev)
+{
+ struct acpi_als_chip *chip =3D iio_priv(idev);
+ int i, ret;
+
+ chip->trig =3D devm_kzalloc(&idev->dev, sizeof(chip->trig), GFP_KERNEL);
+
+ if (chip->trig =3D=3D NULL) {
+ ret =3D -ENOMEM;
+ goto error_ret;
+ }
+
+
+ chip->trig =3D acpi_als_allocate_trigger(idev);
+ if (chip->trig =3D=3D NULL) {
+ dev_err(&idev->dev, "Could not allocate trigger %d\n");
+ ret =3D -ENOMEM;
+ goto error_trigger;
+ }
+
+ return 0;
+
+error_trigger:
+ iio_trigger_free(chip->trig);
+error_ret:
+ return ret;
+}
+
+
+static int acpi_als_add(struct acpi_device *device)
+{
+ int result;
+ struct acpi_als_chip *chip;
+ struct iio_dev *indio_dev;
+
+ /*
+ if (unlikely(als_id >=3D 10)) {
+ printk(KERN_WARNING PREFIX "Too many ALS device found\n");
+ return -ENODEV;
+ }
+ */
+
+ indio_dev =3D iio_device_alloc(sizeof(*chip));
+ if (!indio_dev) {
+ dev_err(&device->dev, "iio allocation fails\n");
+ return -ENOMEM;
+ }
+
+ chip =3D iio_priv(indio_dev);
+
+ device->driver_data =3D indio_dev;
+ chip->device =3D device;
+ mutex_init(&chip->lock);
+
+ indio_dev->info =3D &acpi_als_info;
+ indio_dev->channels =3D acpi_als_channels;
+ indio_dev->num_channels =3D ARRAY_SIZE(acpi_als_channels);
+ indio_dev->name =3D ACPI_ALS_DEVICE_NAME;
+ indio_dev->dev.parent =3D &device->dev;
+ indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+ result =3D iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time=
,
+ &acpi_als_trigger_handler, &acpi_als_buffer_ops);
+
+ if(result) {
+ printk("Could not setup buffer for iio device\n");
+ goto exit_iio_free;
+ }
+
+ result =3D acpi_als_trigger_init(indio_dev);
+ if (result) {
+ printk("Couldn't setup the triggers.\n");
+ // TODO
+ //goto error_unregister_buffer;
+ }
+
+ result =3D iio_device_register(indio_dev);
+ if (result < 0) {
+ dev_err(&chip->device->dev, "iio registration fails with error %d\n",
+ result);
+ goto exit_iio_free;
+ }
+
+ printk("ACPI ALS initialized");
+
+ return 0;
+
+ exit_iio_free:
+ iio_device_free(indio_dev);
+ return result;
+}
+
+static int acpi_als_remove(struct acpi_device *device, int type)
+{
+ struct iio_dev *indio_dev;
+
+ indio_dev =3D acpi_driver_data(device);
+ if(!indio_dev) {
+ dev_err(&device->dev, "could not get indio_dev for ACPI device\n");
+ return -1;
+ }
+
+ iio_device_unregister(indio_dev);
+ iio_device_free(indio_dev);
+
+ return 0;
+}
+
+static int __init acpi_als_init(void)
+{
+ return acpi_bus_register_driver(&acpi_als_driver);
+}
+
+static void __exit acpi_als_exit(void)
+{
+ acpi_bus_unregister_driver(&acpi_als_driver);
+}
+
+module_init(acpi_als_init);
+module_exit(acpi_als_exit);



On 9 July 2012 15:29, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> cc'd Jon Brenner and Peter Meerwald.
>
>
>>  Hello,
>>>     Iconia Tab W500 contains Ambient Light Sensor (hid 0008), I started
>>> implementing IIO device drive having following questions:
>>>
>>>     - chip could offer following variables: illuminance, color
>>> chromaticity
>>>     and color temperature, how should I connect last 2 vars to any of I=
IO
>>>     CHANNEL types?
>>>
>> Jon's recent proposed additional modifiers cover temperature.
> Chromaticity is a new one I think though?
>
>      - I'm not sure how to connect an illuminance mapping to IIO
>>>     infrastructure?
>>>
>> When you say mapping, what do you mean? That term tends to get used
> for quite a few different things...
>
>>
>> See IIO_DEVICE_ATTR() maybe ?
>>
>>  Thank you,
>>> Martin Li=C5=A1ka
>>>
>>
>> Best regards,
>> Marek Vasut
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/**majordomo-info.html<htt=
p://vger.kernel.org/majordomo-info.html>
>>
>>
>
>

--f46d044472f3df534504c9684c4d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Following patch introduces support for trigger function in cooperation with=
 a kfifo buffer. Problem that I need to help with is calling <b>iio_trigger=
_poll</b> in <b>acpi_notify</b> handler. From the following callstack you c=
an see that acpi_notify is called from workQ:<div>
<br></div><div><div>[ =C2=A0250.046289] Call Trace:</div><div>[ =C2=A0250.0=
46307] =C2=A0[&lt;c14d3d69&gt;] acpi_als_notify+0x69/0xb0</div><div>[ =C2=
=A0250.046321] =C2=A0[&lt;c12c88a8&gt;] ? acpi_evaluate_object+0x1b4/0x1c1<=
/div><div>[ =C2=A0250.046332] =C2=A0[&lt;c12b2aa2&gt;] acpi_device_notify+0=
x12/0x15</div>
<div>[ =C2=A0250.046344] =C2=A0[&lt;c12bd11a&gt;] acpi_ev_notify_dispatch+0=
x2e/0x45</div><div>[ =C2=A0250.046352] =C2=A0[&lt;c12b035f&gt;] acpi_os_exe=
cute_deferred+0x1b/0x26</div><div>[ =C2=A0250.046361] =C2=A0[&lt;c104a15d&g=
t;] process_one_work+0xfd/0x370</div>
<div>[ =C2=A0250.046368] =C2=A0[&lt;c1049060&gt;] ? do_work_for_cpu+0x20/0x=
20</div><div>[ =C2=A0250.046375] =C2=A0[&lt;c12b0344&gt;] ? acpi_os_wait_ev=
ents_complete+0x19/0x19</div><div>[ =C2=A0250.046383] =C2=A0[&lt;c104b92d&g=
t;] worker_thread+0x12d/0x2c0</div>
<div>[ =C2=A0250.046391] =C2=A0[&lt;c104b800&gt;] ? manage_workers.clone.19=
+0x200/0x200</div><div>[ =C2=A0250.046400] =C2=A0[&lt;c104fa34&gt;] kthread=
+0x74/0x80</div><div>[ =C2=A0250.046408] =C2=A0[&lt;c104f9c0&gt;] ? flush_k=
thread_worker+0xa0/0xa0</div>
<div>[ =C2=A0250.046416] =C2=A0[&lt;c16c20f6&gt;] kernel_thread_helper+0x6/=
0xd</div><div>[ =C2=A0250.046424] ------------[ cut here ]------------</div=
><div><br></div><div>After calling iio_trigger_poll following output could =
be found in dmesg:</div>
<div><br></div><div><div>[ =C2=A0250.046433] WARNING: at kernel/irq/handle.=
c:146 handle_irq_event_percpu+0x198/0x1b0()</div><div>[ =C2=A0250.046437] H=
ardware name: ICONIA Tab W500</div><div>[ =C2=A0250.046447] irq 20 handler =
iio_pollfunc_store_time+0x0/0x50 enabled interrupts</div>
<div>[ =C2=A0250.046450] Modules linked in:</div><div>[ =C2=A0250.046458] P=
id: 4, comm: kworker/0:0 Not tainted 3.5.0-rc5-next-20120705+ #86</div><div=
>[ =C2=A0250.046461] Call Trace:</div><div>[ =C2=A0250.046469] =C2=A0[&lt;c=
1031c1d&gt;] warn_slowpath_common+0x6d/0xa0</div>
<div>[ =C2=A0250.046476] =C2=A0[&lt;c1098f28&gt;] ? handle_irq_event_percpu=
+0x198/0x1b0</div><div>[ =C2=A0250.046483] =C2=A0[&lt;c1098f28&gt;] ? handl=
e_irq_event_percpu+0x198/0x1b0</div><div>[ =C2=A0250.046490] =C2=A0[&lt;c10=
31cce&gt;] warn_slowpath_fmt+0x2e/0x30</div>
<div>[ =C2=A0250.046497] =C2=A0[&lt;c1098f28&gt;] handle_irq_event_percpu+0=
x198/0x1b0</div><div>[ =C2=A0250.046504] =C2=A0[&lt;c14d8990&gt;] ? iio_tri=
g_release+0x90/0x90</div><div>[ =C2=A0250.046511] =C2=A0[&lt;c1098f70&gt;] =
handle_irq_event+0x30/0x60</div>
<div>[ =C2=A0250.046519] =C2=A0[&lt;c109af1c&gt;] handle_simple_irq+0x3c/0x=
60</div><div>[ =C2=A0250.046526] =C2=A0[&lt;c10987cd&gt;] generic_handle_ir=
q+0x1d/0x30</div><div>[ =C2=A0250.046533] =C2=A0[&lt;c14d8a7d&gt;] iio_trig=
ger_poll+0x3d/0x60</div><div>
[ =C2=A0250.046540] =C2=A0[&lt;c14d3da0&gt;] acpi_als_notify+0xa0/0xb0</div=
><div>[ =C2=A0250.046547] =C2=A0[&lt;c12b2aa2&gt;] acpi_device_notify+0x12/=
0x15</div><div>[ =C2=A0250.046555] =C2=A0[&lt;c12bd11a&gt;] acpi_ev_notify_=
dispatch+0x2e/0x45</div><div>
[ =C2=A0250.046561] =C2=A0[&lt;c12b035f&gt;] acpi_os_execute_deferred+0x1b/=
0x26</div><div>[ =C2=A0250.046568] =C2=A0[&lt;c104a15d&gt;] process_one_wor=
k+0xfd/0x370</div><div>[ =C2=A0250.046574] =C2=A0[&lt;c1049060&gt;] ? do_wo=
rk_for_cpu+0x20/0x20</div>
<div>[ =C2=A0250.046581] =C2=A0[&lt;c12b0344&gt;] ? acpi_os_wait_events_com=
plete+0x19/0x19</div><div>[ =C2=A0250.046588] =C2=A0[&lt;c104b92d&gt;] work=
er_thread+0x12d/0x2c0</div><div>[ =C2=A0250.046596] =C2=A0[&lt;c104b800&gt;=
] ? manage_workers.clone.19+0x200/0x200</div>
<div>[ =C2=A0250.046603] =C2=A0[&lt;c104fa34&gt;] kthread+0x74/0x80</div><d=
iv>[ =C2=A0250.046611] =C2=A0[&lt;c104f9c0&gt;] ? flush_kthread_worker+0xa0=
/0xa0</div><div>[ =C2=A0250.046617] =C2=A0[&lt;c16c20f6&gt;] kernel_thread_=
helper+0x6/0xd</div><div>[ =C2=A0250.046622] ---[ end trace b07487a0fd2a6c5=
6 ]---</div>
</div><div><br></div><div><b>Patch:</b></div><div><div>diff --git a/drivers=
/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c</div><div>index 6bf9d05..fd7a2d1=
 100644</div><div>--- a/drivers/iio/kfifo_buf.c</div><div>+++ b/drivers/iio=
/kfifo_buf.c</div>
<div>@@ -6,6 +6,7 @@</div><div>=C2=A0#include &lt;linux/kfifo.h&gt;</div><d=
iv>=C2=A0#include &lt;linux/mutex.h&gt;</div><div>=C2=A0#include &lt;linux/=
iio/kfifo_buf.h&gt;</div><div>+#include &lt;linux/sched.h&gt;</div><div>=C2=
=A0</div><div>=C2=A0struct iio_kfifo {</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>struct iio_buffer buffer;</div><div>@@ -22,7 +23,8 @@ static inline int __=
iio_allocate_kfifo(struct iio_kfifo *buf,</div><div>=C2=A0<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">		</span>return -EINVAL;</div>
<div>=C2=A0</div><div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>__iio_update_buffer(&amp;buf-&gt;buffer, bytes_per_datum,=
 length);</div><div>-<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>return kfifo_alloc(&amp;buf-&gt;kf, bytes_per_datum*length, GFP_=
KERNEL);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn __kfifo_alloc((struct __kfifo *)&amp;buf-&gt;kf, length,</div><div>+<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =C2=A0 =C2=
=A0 bytes_per_datum, GFP_KERNEL);</div>
<div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0static int iio_request_update=
_kfifo(struct iio_buffer *r)</div><div>@@ -33,8 +35,11 @@ static int iio_re=
quest_update_kfifo(struct iio_buffer *r)</div><div>=C2=A0<span class=3D"App=
le-tab-span" style=3D"white-space:pre">	</span>if (!buf-&gt;update_needed)<=
/div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</spa=
n>goto error_ret;</div><div>=C2=A0<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>kfifo_free(&amp;buf-&gt;kf);</div><div>+</div><div>=
=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =
=3D __iio_allocate_kfifo(buf, buf-&gt;buffer.bytes_per_datum,</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</s=
pan> =C2=A0 buf-&gt;buffer.length);</div><div>+</div><div>+<span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>r-&gt;stufftoread =3D fals=
e;</div><div>=C2=A0error_ret:</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>return ret;</div><div>=C2=A0}</div><div>@@ -81,6 +86,9 @@ static int iio_s=
et_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)</div><div>=C2=A0=
</div><div>=C2=A0static int iio_set_length_kfifo(struct iio_buffer *r, int =
length)</div>
<div>=C2=A0{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>/* Avoid an invalid state */</div><div>+<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>if (length &lt; 2)</div><div>+<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>length =3D=
 2;</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>if (r-&gt;length !=3D length) {</div><div>=C2=A0<span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">		</span>r-&gt;length =3D length;</div><div>=
=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>iio=
_mark_update_needed_kfifo(r);</div>
<div>@@ -94,9 +102,12 @@ static int iio_store_to_kfifo(struct iio_buffer *r=
,</div><div>=C2=A0{</div><div>=C2=A0<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>int ret;</div><div>=C2=A0<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>struct iio_kfifo *kf =3D iio_to_kf=
ifo(r);</div>
<div>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =
=3D kfifo_in(&amp;kf-&gt;kf, data, r-&gt;bytes_per_datum);</div><div>-<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (ret !=3D r-=
&gt;bytes_per_datum)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =
=3D kfifo_in(&amp;kf-&gt;kf, data, 1);</div><div>+<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>if (ret !=3D 1)</div><div>=C2=A0<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>return -EBUS=
Y;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>r-&g=
t;stufftoread =3D true;</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>wake_up_interruptible(&amp;r-&gt;pollq);</div><div=
>+</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>return 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>@@ -106,11 +117,18 =
@@ static int iio_read_first_n_kfifo(struct iio_buffer *r,</div><div>=C2=A0=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int ret, c=
opied;</div>
<div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>struct iio_kfifo *kf =3D iio_to_kfifo(r);</div><div>=C2=A0</div><div>-<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (n &lt; r-&=
gt;bytes_per_datum)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
n &lt; r-&gt;bytes_per_datum || r-&gt;bytes_per_datum =3D=3D 0)</div><div>=
=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -EINVAL;</div>
<div>=C2=A0</div><div>-<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>n =3D rounddown(n, r-&gt;bytes_per_datum);</div><div>=C2=A0<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =3D kfifo=
_to_user(&amp;kf-&gt;kf, buf, n, &amp;copied);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
ret &lt; 0)</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">		</span>return ret;</div><div>+</div><div>+<span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>if (kfifo_is_empty(&amp;kf-&gt;kf))<=
/div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>r-&=
gt;stufftoread =3D false;</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>/* verify it is still empty to avoid race */</=
div><div>
+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (!kfif=
o_is_empty(&amp;kf-&gt;kf))</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>r-&gt;stufftoread =3D true;</div><div>=C2=A0<=
/div><div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	<=
/span>return copied;</div>
<div>=C2=A0}</div><div>@@ -136,7 +154,7 @@ struct iio_buffer *iio_kfifo_all=
ocate(struct iio_dev *indio_dev)</div><div>=C2=A0<span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span>iio_buffer_init(&amp;kf-&gt;buffer);=
</div><div>
=C2=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kf-&=
gt;buffer.attrs =3D &amp;iio_kfifo_attribute_group;</div><div>=C2=A0<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kf-&gt;buffer.acc=
ess =3D &amp;kfifo_access_funcs;</div>
<div>-</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>kf-&gt;buffer.length =3D 2;</div><div>=C2=A0<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>return &amp;kf-&gt;buffer;</div><=
div>=C2=A0}</div>
<div>=C2=A0EXPORT_SYMBOL(iio_kfifo_allocate);</div><div>diff --git a/driver=
s/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig</div><div>i=
ndex 4bed30e..a164ecc 100644</div><div>--- a/drivers/staging/iio/light/Kcon=
fig</div>
<div>+++ b/drivers/staging/iio/light/Kconfig</div><div>@@ -50,4 +50,10 @@ c=
onfig TSL2x7x</div><div>=C2=A0<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span> tmd2672, tsl2772, tmd2772 devices.</div><div>=C2=A0<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> Provides iio=
_events and direct access via sysfs.</div>
<div>=C2=A0</div><div>+config ACPI_ALS</div><div>+<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>tristate &quot;ACPI Ambient Light S=
ensor&quot;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>help</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> Sup=
port for ACPI0008 Light Sensor.</div><div>+<span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span> Provides direct access via sysfs.</div><d=
iv>+</div>
<div>=C2=A0endmenu</div><div>diff --git a/drivers/staging/iio/light/Makefil=
e b/drivers/staging/iio/light/Makefile</div><div>index 141af1e..13090e6 100=
644</div><div>--- a/drivers/staging/iio/light/Makefile</div><div>+++ b/driv=
ers/staging/iio/light/Makefile</div>
<div>@@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>+=3D isl29018.o</div><div>=C2=A0ob=
j-$(CONFIG_SENSORS_ISL29028)<span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>+=3D isl29028.o</div>
<div>=C2=A0obj-$(CONFIG_TSL2583)<span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>+=3D tsl2583.o</div><div>=C2=A0obj-$(CONFIG_TSL2x7x)<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>+=3D tsl2x7=
x_core.o</div><div>
+obj-$(CONFIG_ACPI_ALS)<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>+=3D acpi-als.o</div><div>diff --git a/drivers/staging/iio/lig=
ht/acpi-als.c b/drivers/staging/iio/light/acpi-als.c</div><div>new file mod=
e 100644</div>
<div>index 0000000..a2cf9bb</div><div>--- /dev/null</div><div>+++ b/drivers=
/staging/iio/light/acpi-als.c</div><div>@@ -0,0 +1,546 @@</div><div>+/*</di=
v><div>+ * ACPI Ambient Light Sensor Driver=C2=A0</div><div>+ *</div><div>+=
 * This program is free software; you can redistribute it and/or modify it<=
/div>
<div>+ * under the terms and conditions of the GNU General Public License,<=
/div><div>+ * version 2, as published by the Free Software Foundation.</div=
><div>+ *</div><div>+ * This program is distributed in the hope it will be =
useful, but WITHOUT</div>
<div>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or</div><div>+ * FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the GNU Gener=
al Public License for</div><div>+ * more details.</div><div>+ *</div><div>+=
 * You should have received a copy of the GNU General Public License</div>
<div>+ * along with this program. =C2=A0If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/">http://www.gnu.org/licenses/</a>&gt;.</div><div>+ */<=
/div><div>+</div><div>+#include &lt;linux/module.h&gt;</div><div>+#include =
&lt;linux/interrupt.h&gt;</div>
<div>+#include &lt;trace/events/printk.h&gt;</div><div>+#include &lt;acpi/a=
cpi_bus.h&gt;</div><div>+#include &lt;acpi/acpi_drivers.h&gt;</div><div>+#i=
nclude &lt;linux/err.h&gt;</div><div>+#include &lt;linux/mutex.h&gt;</div>
<div>+</div><div>+#include &lt;linux/iio/iio.h&gt;</div><div>+#include &lt;=
linux/iio/buffer.h&gt;</div><div>+#include &lt;linux/iio/sysfs.h&gt;</div><=
div>+#include &lt;linux/iio/trigger.h&gt;</div><div>+#include &lt;linux/iio=
/trigger_consumer.h&gt;</div>
<div>+#include &lt;linux/iio/triggered_buffer.h&gt;</div><div>+</div><div>+=
#define PREFIX &quot;ACPI: &quot;</div><div>+</div><div>+#define ACPI_ALS_C=
LASS<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>&quo=
t;als&quot;</div>
<div>+#define ACPI_ALS_DEVICE_NAME<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>&quot;acpi-als&quot;</div><div>+#define ACPI_ALS_N=
OTIFY_ILLUMINANCE<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0x80</div>
<div>+#define ACPI_ALS_NOTIFY_COLOR_TEMP<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>0x81</div><div>+#define ACPI_ALS_NOTIFY_RESPO=
NSE<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0x82</d=
iv><div>
+</div><div>+#define ACPI_ALS_OUTPUTS<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>3</div><div>+</div><div>+#define _COMPONENT<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>ACPI_ALS_CO=
MPONENT</div>
<div>+ACPI_MODULE_NAME(&quot;acpi-als&quot;);</div><div>+</div><div>+MODULE=
_AUTHOR(&quot;Martin Liska&quot;);</div><div>+MODULE_DESCRIPTION(&quot;ACPI=
 Ambient Light Sensor Driver&quot;);</div><div>+MODULE_LICENSE(&quot;GPL&qu=
ot;);</div>
<div>+</div><div>+struct acpi_als_chip {</div><div>+<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>struct acpi_device<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span>*device;</div><div>+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct acpi_als=
_device<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>*ac=
pi_als_sys;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>stru=
ct mutex<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>l=
ock;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	<=
/span>struct iio_trigger<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>*trig;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>int illuminance;</div><div>+<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>int temperature;</div><div>+<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>int chromaticity;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
polling;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>int count;</div><div>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct acpi_als_mapping *mappings;</div>
<div>+};</div><div>+</div><div>+static int acpi_als_add(struct acpi_device =
*device);</div><div>+static int acpi_als_remove(struct acpi_device *device,=
 int type);</div><div>+static void acpi_als_notify(struct acpi_device *devi=
ce, u32 event);</div>
<div>+</div><div>+static const struct acpi_device_id acpi_als_device_ids[] =
=3D {</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>{&quot;ACPI0008&quot;, 0},</div><div>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>{&quot;&quot;, 0},</div>
<div>+};</div><div>+</div><div>+MODULE_DEVICE_TABLE(acpi, acpi_als_device_i=
ds);</div><div>+</div><div>+static struct acpi_driver acpi_als_driver =3D {=
</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>.name =3D &quot;acpi_als&quot;,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.cla=
ss =3D ACPI_ALS_CLASS,</div><div>+<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>.ids =3D acpi_als_device_ids,</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.ops =3D {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.ad=
d =3D acpi_als_add,</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>.remove =3D acpi_als_remove,</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.notify =3D acpi_als=
_notify,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>},<=
/div><div>+};</div><div>+</div><div>+struct acpi_als_mapping {</div><div>+<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int adjustm=
ent;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
illuminance;</div><div>+};</div><div>+</div><div>+#define ALS_INVALID_VALUE=
_LOW<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>0</di=
v><div>
+#define ALS_INVALID_VALUE_HIGH<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>-1</div><div>+</div><div>+/* ------------------------=
--------------------------------------------------</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Ambient Light Sensor=
 device Management</div>
<div>+ =C2=A0 -------------------------------------------------------------=
------------- */</div><div>+</div><div>+/*</div><div>+ * acpi_als_get_illum=
inance - get the current ambient light illuminance</div><div>+ */</div><div=
>
+static int acpi_als_get_illuminance(struct acpi_als_chip *als)</div><div>+=
{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</sp=
an>acpi_status status;</div><div>+<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>unsigned long long illuminance;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>status =3D acpi_evaluate_integer(als-&gt;device-&gt;handle,</div><d=
iv>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>&quot=
;_ALI&quot;, NULL, &amp;illuminance);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>if (ACPI_FAILURE(status)) {</div><div>+<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">		</span>ACPI_EXCEPTION((AE_INFO, status, &quo=
t;Error reading ALS illuminance&quot;));</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>als=
-&gt;illuminance =3D ALS_INVALID_VALUE_LOW;</div><div>+<span class=3D"Apple=
-tab-span" style=3D"white-space:pre">		</span>return -ENODEV;</div><div>+<s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>als-=
&gt;illuminance =3D illuminance;</div><div>+</div><div>+<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>return 0;</div><div>+}</div><=
div>+</div>
<div>+/*</div><div>+ * acpi_als_get_color_chromaticity - get the ambient li=
ght color chromaticity</div><div>+ */</div><div>+static int acpi_als_get_co=
lor_chromaticity(struct acpi_als_chip *chip)</div><div>+{</div><div>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>acpi_status stat=
us;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsi=
gned long long chromaticity;</div><div>+</div><div>+<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>status =3D</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0acpi_ev=
aluate_integer(chip-&gt;device-&gt;handle, &quot;_ALC&quot;, NULL,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
=C2=A0&amp;chromaticity);</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>if (ACPI_FAILURE(status)) {</div><div>+<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACPI_DEBUG_PRINT=
((ACPI_DB_INFO, &quot;_ALC not available\n&quot;));</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -ENODEV;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>}</div><div>+<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>chip-&gt;chromaticity =3D chromaticity;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn 0;</div><div>+}</div><div>+</div><div>+/*</div><div>+ * acpi_als_get_col=
or_temperature - get the ambient light color temperature</div><div>+ */</di=
v>
<div>+static int acpi_als_get_color_temperature(struct acpi_als_chip *chip)=
</div><div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>acpi_status status;</div><div>+<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>unsigned long long temperature;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>status =3D</div><div>+<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span> =C2=A0 =C2=A0acpi_evaluate_integer(chip-&gt;device-&gt=
;handle, &quot;_ALT&quot;, NULL,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
=C2=A0&amp;temperature);</div><div>+<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>if (ACPI_FAILURE(status)) {</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACPI_DEBUG_PRINT((A=
CPI_DB_INFO, &quot;_ALT not available\n&quot;));</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -ENODEV;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>}</div><div>+<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>chip-&gt;temperature =3D temperature;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn 0;</div><div>+}</div><div>+</div><div>+/*</div><div>+ * acpi_als_get_map=
pings - get the ALS illuminance mappings</div><div>+ *</div><div>+ * Return=
 a package of ALS illuminance to display adjustment mappings</div>
<div>+ * that can be used by OS to calibrate its ambient light policy</div>=
<div>+ * for a given sensor configuration.</div><div>+ */</div><div>+static=
 int acpi_als_get_mappings(struct acpi_als_chip *chip)</div><div>+{</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
result =3D 0;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>acpi_status status;</div><div>+<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>struct acpi_buffer buffer =3D { ACPI_AL=
LOCATE_BUFFER, NULL };</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unio=
n acpi_object *alr;</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>int i, j;</div><div>+</div><div>+<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>/* Free the old mappings */</di=
v>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kfre=
e(chip-&gt;mappings);</div><div>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>chip-&gt;mappings =3D NULL;</div><div>+</div><div>+<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>status =3D<=
/div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =C2=
=A0 =C2=A0acpi_evaluate_object(chip-&gt;device-&gt;handle, &quot;_ALR&quot;=
, NULL, &amp;buffer);</div><div>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>if (ACPI_FAILURE(status)) {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ACP=
I_EXCEPTION((AE_INFO, status, &quot;Error reading ALS mappings&quot;));</di=
v><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>r=
eturn -ENODEV;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>alr =3D buffer.pointer;</div><div>+<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>if (!alr || (alr-&gt;type !=3D ACPI_TYP=
E_PACKAGE)) {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>pri=
ntk(KERN_ERR PREFIX &quot;Invalid _ALR data\n&quot;);</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">		</span>result =3D -EFAULT;=
</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>got=
o end;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>}</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Found %d illum=
inance mappings\n&quot;,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=C2=A0alr-&gt;package.count));</div><div>+</div><div>+<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>chip-&gt;count =3D alr-&gt;pack=
age.count;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>if (!chip-&gt;count)</div><div>+<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">		</span>return 0;</div><div>+</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>chip-&gt;mappings =3D=
</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =C2=
=A0 =C2=A0kmalloc(sizeof(struct acpi_als_mapping) * chip-&gt;count, GFP_KER=
NEL);</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (!chip-&gt;mappings) {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>res=
ult =3D -ENOMEM;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>goto end;</div><div>+<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>}</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>for (i =3D 0, j =3D 0; i &lt; chip-&gt;count; i++) {</div><div>+<sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>struct acpi_=
als_mapping *mapping =3D &amp;(chip-&gt;mappings[j]);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>uni=
on acpi_object *element =3D &amp;(alr-&gt;package.elements[i]);</div><div>+=
</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</sp=
an>if (element-&gt;type !=3D ACPI_TYPE_PACKAGE)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>co=
ntinue;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>if (element-&gt;package.count !=3D 2)</div><div>+<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>continue;</d=
iv>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
		</span>if (element-&gt;package.elements[0].type !=3D ACPI_TYPE_INTEGER ||=
</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</sp=
an> =C2=A0 =C2=A0element-&gt;package.elements[1].type !=3D ACPI_TYPE_INTEGE=
R)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>co=
ntinue;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>mapping-&gt;adjustment =3D</div><div>+<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">		</span> =C2=A0 =C2=A0element-&g=
t;package.elements[0].integer.value;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>map=
ping-&gt;illuminance =3D</div><div>+<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span> =C2=A0 =C2=A0element-&gt;package.elements[1].in=
teger.value;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>j++=
;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">		</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;Mapping [%d]: &quot;<=
/div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
=C2=A0&quot;adjustment [%d] illuminance[%d]\n&quot;,</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =C2=A0i, mapping-=
&gt;adjustment,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
=C2=A0mapping-&gt;illuminance));</div><div>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}</div><div>+</div><div>+end:</div><div>+=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>kfree(buff=
er.pointer);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn result;</div><div>+}</div><div>+</div><div>+/*</div><div>+ * acpi_als_ge=
t_polling - get a recommended polling frequency</div><div>+ * <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =C2=A0for the Ambi=
ent Light Sensor device</div>
<div>+ */</div><div>+static int acpi_als_get_polling(struct acpi_als_chip *=
chip)</div><div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>acpi_status status;</div><div>+<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>unsigned long long polling;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>status =3D</div><div>+<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span> =C2=A0 =C2=A0acpi_evaluate_integer(chip-&gt;device-&gt=
;handle, &quot;_ALP&quot;, NULL, &amp;polling);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
ACPI_FAILURE(status)) {</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">		</span>ACPI_DEBUG_PRINT((ACPI_DB_INFO, &quot;_ALP not av=
ailable\n&quot;));</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -ENODEV;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>}</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>chip-&gt;polling =3D polling;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>retu=
rn 0;</div><div>+}</div><div>+</div><div>+static int get_illuminance(struct=
 acpi_als_chip *als, int *illuminance)</div><div>+{</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int result;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>result =3D acpi_als_get_illuminance(als);</div><div>+<span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>if (!result)</div><div>+=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>*illumina=
nce =3D als-&gt;illuminance;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return result;</div><div>+}</div><div>+</div><div>+static void acpi=
_als_notify(struct acpi_device *device, u32 event)</div><div>+{</div><div>+=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct iio=
_dev *indio_dev;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>stru=
ct acpi_als_chip *chip;</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>int illuminance;</div><div>+</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>printk(&quot;XXXX: n=
otification: %u\n&quot;, event);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>indio_dev =3D acpi_driver_data(device);</div><div>+<span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>chip =3D iio_priv(indio_de=
v);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>get_illuminance(chip, &amp;illuminance);</div><div>+</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iio_buffer_enabled(indio_dev))</div><div>+<s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>{</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>pri=
ntk(&quot;XXXX: calling trigger poll: %p\n&quot;, indio_dev-&gt;trig);</div=
><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>		</span>dump_stack();</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>iio=
_trigger_poll(indio_dev-&gt;trig, iio_get_time_ns());</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div><div>+}</div>=
<div>
+</div><div>+static int acpi_als_read_raw(struct iio_dev *indio_dev,</div><=
div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struc=
t iio_chan_spec const *chan, int *val, int *val2, long mask)</div><div>+{</=
div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>stru=
ct acpi_als_chip *chip =3D iio_priv(indio_dev);</div><div>+<span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>int ret =3D -EINVAL;</div>=
<div>+</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>mute=
x_lock(&amp;chip-&gt;lock);</div><div>+</div><div>+<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>switch (mask) {</div><div>+<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>case IIO_CHAN_INF=
O_RAW:</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>case=
 IIO_CHAN_INFO_PROCESSED:</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>switch(chan-&gt;type) {</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">		</span>case IIO_LIGHT:</di=
v>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>re=
t =3D get_illuminance(chip, val);</div><div>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">			</span>break;</div><div>+<span class=3D"Apple=
-tab-span" style=3D"white-space:pre">		</span>default:</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>br=
eak;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>}</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>if(!ret)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>re=
t =3D IIO_VAL_INT;</div><div>+</div><div>+<span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">		</span>break;</div><div>+<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>default:</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev=
_err(&amp;chip-&gt;device-&gt;dev, &quot;mask value 0x%08lx not supported\n=
&quot;, mask);</div><div>+<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>break;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><=
/div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>mutex_unlock(&amp;chip-&gt;lock);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return ret;</div><div>+}</div><div>+</div><div>+static int acpi_als=
_write_raw(struct iio_dev *indio_dev,</div><div>+ =C2=A0 =C2=A0 struct iio_=
chan_spec const *chan, int val, int val2, long mask)</div>
<div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>	</span>return 0;</div><div>+}</div><div>+</div><div>+static const struct =
iio_chan_spec acpi_als_channels[] =3D {</div><div>+<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>{</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.ty=
pe =3D IIO_LIGHT,</div><div>+<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">		</span>.indexed =3D 1,</div><div>+<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">		</span>.channel =3D 1,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.sc=
an_type.sign =3D &#39;u&#39;,</div><div>+<span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">		</span>.scan_type.realbits =3D 10,</div><div>+<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.scan_type.st=
oragebits =3D 16,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>.in=
fo_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>IIO_CHAN_INFO_SCALE_=
SEPARATE_BIT,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>},</=
div><div>+};</div><div>+</div><div>+static const struct iio_info acpi_als_i=
nfo =3D {</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>.driver_module =3D THIS_MODULE,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.rea=
d_raw =3D &amp;acpi_als_read_raw,</div><div>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>.write_raw =3D &amp;acpi_als_write_raw,<=
/div><div>
+};</div><div>+</div><div>+static irqreturn_t acpi_als_trigger_handler(int =
irq, void *p)</div><div>+{</div><div>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>printk(&quot;XXXX: TRIGGER handler called :)&q=
uot;);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return IRQ_HANDLED;</div><div>+</div><div>+<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>struct iio_poll_func *pf =3D p;</d=
iv><div>
+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct ii=
o_dev *idev =3D pf-&gt;indio_dev;</div><div>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>struct acpi_als_chip *chip =3D iio_priv(=
idev);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>stru=
ct iio_buffer *buffer =3D idev-&gt;buffer;</div><div>+<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>int i, j =3D 0;</div><div>+</di=
v><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>/*=
 TODO: remove */</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>u8 b=
[64];</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>for (i =3D 0; i &lt; idev-&gt;masklength; i++) {</div><d=
iv>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>if (!=
test_bit(i, idev-&gt;active_scan_mask))</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>co=
ntinue;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>// TODO: read</div><div>+<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">		</span>j++;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>if (idev-&gt;scan_timestamp) {</div><div>+<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">		</span>s64 *timestamp =3D (s64 *)((u8 =
*)b +</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>=
ALIGN(j, sizeof(s64)));</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">		</span>*timestamp =3D pf-&gt;timestamp;</div><div>+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>buffer-&gt;access-&gt;store_to(buffer, (u8 *)b, pf-&gt;timestamp);<=
/div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>iio_trigger_notify_done(idev-&gt;trig);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></di=
v><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>re=
turn IRQ_HANDLED;</div><div>+}</div><div>+</div><div>+/**</div><div>+ * acp=
i_als_data_rdy_trigger_set_state() set datardy interrupt state</div>
<div>+ **/</div><div>+static int acpi_als_data_rdy_trigger_set_state(struct=
 iio_trigger *trig,</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">						</span>bool state)</div><div>+{</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct iio_dev *indio=
_dev =3D trig-&gt;private_data;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>dev_dbg(&amp;indio_dev-&gt;dev, &quot;%s (%d)\n&quot;, __func__, st=
ate);</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>return 0;=C2=A0</div>
<div>+}</div><div>+</div><div>+static const struct iio_trigger_ops acpi_als=
_trigger_ops =3D {</div><div>+<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>.owner =3D THIS_MODULE,</div><div>+};</div><div>+</div>=
<div>
+static const struct iio_buffer_setup_ops acpi_als_buffer_ops =3D {</div><d=
iv>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.preen=
able =3D &amp;iio_sw_buffer_preenable,</div><div>+<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>.postenable =3D &amp;iio_triggered_=
buffer_postenable,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>.pre=
disable =3D &amp;iio_triggered_buffer_predisable,</div><div>+};</div><div>+=
</div><div>+static struct iio_trigger *acpi_als_allocate_trigger(struct iio=
_dev *idev)</div>
<div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>	</span>int ret;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>struct iio_trigger *trig;</div><div>+<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>struct acpi_als_chip *chip =
=3D iio_priv(idev);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>trig =3D iio_trigger_alloc(&quot;acpi-als&quot;);</div><div>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (trig =3D=3D =
NULL)</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn NULL;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>trig-&gt;dev.parent =3D idev-&gt;dev.parent;</div><d=
iv>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>trig-&=
gt;private_data =3D idev;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>trig=
-&gt;ops =3D &amp;acpi_als_trigger_ops;</div><div>+</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>ret =3D iio_trigger_r=
egister(trig);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
ret)</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>return NULL;</div><div>+</div><div>+<span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>return trig;</div>
<div>+}</div><div>+</div><div>+static int acpi_als_trigger_init(struct iio_=
dev *idev)</div><div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>struct acpi_als_chip *chip =3D iio_priv(idev);</di=
v>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
i, ret;</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>chip-&gt;trig =3D devm_kzalloc(&amp;idev-&gt;dev, size=
of(chip-&gt;trig), GFP_KERNEL);</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>if (chip-&gt;trig =3D=3D NULL) {</div><div>+<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">		</span>ret =3D -ENOMEM;</div><div>+<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>goto error_re=
t;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>chip-&gt;trig =3D acpi_als_allocate_trigger(idev);</=
div><div>
+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (chip-=
&gt;trig =3D=3D NULL) {</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">		</span>dev_err(&amp;idev-&gt;dev, &quot;Could not alloca=
te trigger %d\n&quot;);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
 =3D -ENOMEM;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">		</span>goto error_trigger;</div><div>+<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>}</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return 0;</div><div>+</div><div>+error_trigger:</div><div>+<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>iio_trigger_free(c=
hip-&gt;trig);</div>
<div>+error_ret:</div><div>+<span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>return ret;</div><div>+}</div><div>+</div><div>+</div><di=
v>+static int acpi_als_add(struct acpi_device *device)</div><div>+{</div><d=
iv>
+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int resul=
t;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</s=
pan>struct acpi_als_chip *chip;</div><div>+<span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>struct iio_dev *indio_dev;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>/*</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>if (unlikely(als_id &gt;=3D 10)) {</div><div>+<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">		</span>printk(KERN_WARNING PREFIX=
 &quot;Too many ALS device found\n&quot;);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -ENODEV;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>}</div><div>+<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>*/</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></di=
v><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>in=
dio_dev =3D iio_device_alloc(sizeof(*chip));</div><div>+<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>if (!indio_dev) {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev=
_err(&amp;device-&gt;dev, &quot;iio allocation fails\n&quot;);</div><div>+<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>return -EN=
OMEM;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>chip =3D iio_priv(indio_dev);</div><div>+</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>device-&gt;driver_dat=
a =3D indio_dev;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>chip=
-&gt;device =3D device;</div><div>+<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">	</span>mutex_init(&amp;chip-&gt;lock);</div><div>+</div><=
div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indio=
_dev-&gt;info =3D &amp;acpi_als_info;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indi=
o_dev-&gt;channels =3D acpi_als_channels;</div><div>+<span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>indio_dev-&gt;num_channels =3D A=
RRAY_SIZE(acpi_als_channels);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indi=
o_dev-&gt;name =3D ACPI_ALS_DEVICE_NAME;</div><div>+<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>indio_dev-&gt;dev.parent =3D &amp=
;device-&gt;dev;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>indi=
o_dev-&gt;modes =3D INDIO_DIRECT_MODE;</div><div>+</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>result =3D iio_trigge=
red_buffer_setup(indio_dev, &amp;iio_pollfunc_store_time,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>&=
amp;acpi_als_trigger_handler, &amp;acpi_als_buffer_ops);</div><div>+</div><=
div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if(re=
sult) {</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>pri=
ntk(&quot;Could not setup buffer for iio device\n&quot;);</div><div>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>goto exit_iio_f=
ree;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>result =3D acpi_als_trigger_init(indio_dev);</div><div>+<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (result) {</div=
>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>pri=
ntk(&quot;Couldn&#39;t setup the triggers.\n&quot;);</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>// TODO</div><div>+<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>//goto err=
or_unregister_buffer;</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}</d=
iv><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>result =3D iio_device_register(indio_dev);</div><div>+<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (result &lt; 0) {=
</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev=
_err(&amp;chip-&gt;device-&gt;dev, &quot;iio registration fails with error =
%d\n&quot;,</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">			</span>result);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>got=
o exit_iio_free;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>}</div><div>+</div><div>+<span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>printk(&quot;ACPI ALS initialized&quot;);<=
/div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>return 0;</div><div>+</div><div>+<span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>exit_iio_free:</div><div>+<span class=3D"App=
le-tab-span" style=3D"white-space:pre">		</span>iio_device_free(indio_dev);=
</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn result;</div><div>+}</div><div>+</div><div>+static int acpi_als_remove(=
struct acpi_device *device, int type)</div><div>+{</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct iio_dev *indio=
_dev;</div>
<div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>indio_dev =3D acpi_driver_data(device);</div><div>+<span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>if(!indio_dev) {</div><div=
>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dev_err=
(&amp;device-&gt;dev, &quot;could not get indio_dev for ACPI device\n&quot;=
);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ret=
urn -1;</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>	</span>}</div><div>+</div><div>+<span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">	</span>iio_device_unregister(indio_dev);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>iio_=
device_free(indio_dev);</div><div>+</div><div>+<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>return 0;</div><div>+}</div><div>+</di=
v><div>
+static int __init acpi_als_init(void)</div><div>+{</div><div>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return acpi_bus_regis=
ter_driver(&amp;acpi_als_driver);</div><div>+}</div><div>+</div><div>+stati=
c void __exit acpi_als_exit(void)</div>
<div>+{</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>	</span>acpi_bus_unregister_driver(&amp;acpi_als_driver);</div><div>+}</di=
v><div>+</div><div>+module_init(acpi_als_init);</div><div>+module_exit(acpi=
_als_exit);</div>
</div><div><br></div><div><br></div><br><div class=3D"gmail_quote">On 9 Jul=
y 2012 15:29, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic2=
3@cam.ac.uk" target=3D"_blank">jic23@cam.ac.uk</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
cc&#39;d Jon Brenner and Peter Meerwald.<div class=3D"im"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
=C2=A0 =C2=A0 Iconia Tab W500 contains Ambient Light Sensor (hid 0008), I s=
tarted<br>
implementing IIO device drive having following questions:<br>
<br>
=C2=A0 =C2=A0 - chip could offer following variables: illuminance, color ch=
romaticity<br>
=C2=A0 =C2=A0 and color temperature, how should I connect last 2 vars to an=
y of IIO<br>
=C2=A0 =C2=A0 CHANNEL types?<br>
</blockquote></blockquote></div>
Jon&#39;s recent proposed additional modifiers cover temperature. Chromatic=
ity is a new one I think though?<div class=3D"im"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 - I&#39;m not sure how to connect an illuminance mapping to I=
IO<br>
=C2=A0 =C2=A0 infrastructure?<br>
</blockquote></blockquote></div>
When you say mapping, what do you mean? That term tends to get used<br>
for quite a few different things...<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">
<br>
See IIO_DEVICE_ATTR() maybe ?<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thank you,<br>
Martin Li=C5=A1ka<br>
</blockquote>
<br>
Best regards,<br>
Marek Vasut<br></div><span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
<br>
</font></span></blockquote>
<br>
<br>
</blockquote></div><br></div>

--f46d044472f3df534504c9684c4d--
