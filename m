Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:54585 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbcHZQZV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Aug 2016 12:25:21 -0400
Message-ID: <57C06DE9.4090204@parrot.com>
Date: Fri, 26 Aug 2016 18:27:21 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 3/3] iio:pressure: initial zpa2326 barometer support
References: <cover.1472050374.git.gregor.boirie@parrot.com> <a16becf5ac0ac811a993a26de32a0d41f3eb4ffa.1472050374.git.gregor.boirie@parrot.com> <CACRpkdaPXjsTzpA3yP6U9y_tFuUpXfrO68Y-hqH80np_gdGyhg@mail.gmail.com>
In-Reply-To: <CACRpkdaPXjsTzpA3yP6U9y_tFuUpXfrO68Y-hqH80np_gdGyhg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Answers inline.

On 08/25/2016 10:38 AM, Linus Walleij wrote:
> On Wed, Aug 24, 2016 at 4:58 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
>
>> Introduce driver for Murata ZPA2326 pressure and temperature sensor:
>> http://www.murata.com/en-us/products/productdetail?partno=ZPA2326-0311A-R
> Grrr no serious spec from the manufacturer. Luckily I found this:
> http://www.is-line.de/fileadmin/user_upload/is-line/sensorik/hersteller/datasheets/mu_ZPA2326_air_pressure_sensor.pdf
This is it. From a software standpoint this version is fairly complete.
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> +++ b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
>> @@ -0,0 +1,23 @@
>> +Murata ZPA2326 pressure sensor
>> +
>> +Pressure sensor from Murata with SPI and I2C bus interfaces.
>> +
>> +Required properties:
>> +- compatible: "murata,zpa2326"
>> +- reg: the I2C address or SPI chip select the device will respond to
>> +
>> +Optional properties:
>> +- interrupt-parent: should be the phandle for the interrupt controller
>> +- interrupts: interrupt mapping for IRQ
>> +- vdd-supply: an optional regulator that needs to be on to provide VDD
>> +  power to the sensor
> According to the datasheet there is also VREF so I guess you
> should include vref-supply and handle that regulator in the code.
> They don't really say what voltage this is but I suspect something like
> vddio or vario, i.e. signal level voltage.
On my prototyping board this is just hardwired with VDD... I simply 
forgot it.
VREF is used for sensing pressure (coupled with sensing capacitance).

>
>> +config ZPA2326
>> +       tristate "Murata ZPA2326 pressure sensor driver"
>> +       depends on I2C || SPI
>> +       select IIO_BUFFER
>> +       select IIO_TRIGGERED_BUFFER
>> +       help
>> +         Say Y here to build support for the Murata ZPA2326 pressure and
>> +         temperature sensor.
>> +
>> +         To compile this driver as a module, choose M here: the module will
>> +         be called zpa2326.
>> +
>> +config ZPA2326_I2C
>> +       tristate "support I2C bus connection"
>> +       depends on I2C && ZPA2326
>> +       help
>> +         Say Y here to build I2C bus support for the Murata ZPA2326 pressure
>> +         and temperature sensor.
>> +
>> +         To compile this driver as a module, choose M here: the module will
>> +         be called zpa2326_i2c.
>> +
>> +config ZPA2326_SPI
>> +       tristate "support SPI bus connection"
>> +       depends on SPI && ZPA2326
>> +       help
>> +         Say Y here to build SPI bus support for the Murata ZPA2326 pressure
>> +         and temperature sensor.
>> +
>> +         To compile this driver as a module, choose M here: the module will
>> +         be called zpa2326_spi.
> Why are these two not using regmap, i.e. ZPA2326_I2C could
> select REGMAP_I2C and ZPA2326_SPI could
> select REGMAP_SPI.
>
> This can usually be done very nicely even if the I2C/SPI
> protocol deviates slightly from the default (and most common)
> created by the default devm_regmap_init_i2c(), e.g.
> the SPI specialness we added to drivers/iio/pressure/bmp280-spi.c
>
> Regmap cuts down so much code that it's usually worth
> it even if it can require a bit of overhead.
see below.
>
>> +/* Comment out to enable really verbose logging. */
>> +/*#define DEBUG*/
> If we want this then add a Kconfig option to turn it on instead,
> for example in pincontrol I have this
> (drivers/pinctrl/Kconfig)
>
> config DEBUG_PINCTRL
>          bool "Debug PINCTRL calls"
>          depends on DEBUG_KERNEL
>          help
>            Say Y here to add some extra checks and diagnostics to PINCTRL calls.
>
> And in the top-level Makefile:
>
> subdir-ccflags-$(CONFIG_DEBUG_PINCTRL)  += -DDEBUG
>
> This can be made as a totally separate patch as a debug switch
> for the entire IIO subsystem..
I just did not want this to be configurable. This was meant for driver 
developpers
usage only.
Now that dynamic_debug is available, sysadmins may enable tracing 
dynamically
anyway. Maybe I should simply get rid of it.
>> +#include <linux/sched.h>
> Why?
old inclusion not cleaned up
>
>> +#include <linux/pm_runtime.h>
> Nice!
>
>> +/* 200 ms should be enought for the longest conversion time in one-shot mode. */
>> +#define ZPA_CONVERSION_TIMEOUT (HZ / 5)
> Don't define that relative to HZ because HZ is not fixed.
> Define it as 200 in ms.
I need this constant to be expressed as jiffies for 
wait_for_completion() usage.
I know I can rely upon msecs_to_jiffies() but HZ is always one sec even 
for tickless
systems and wait_for_completion() will in the end schedule a timer based on
jiffies passed in argument. So what am I getting wrong ?
Maybe I should rename this constant however...
>
>> +/* Registers map. */
>> +#define ZPA_REF_P_XL_REG                     ((u8)0x8)
>> +#define ZPA_REF_P_L_REG                      ((u8)0x9)
>> +#define ZPA_REF_P_H_REG                      ((u8)0xa)
>> +#define ZPA_RES_CONF_REG                     ((u8)0x10)
>> +#define ZPA_CTRL_REG0_REG                    ((u8)0x20)
>> +#      define ZPA_CTRL_REG0_ONE_SHOT        BIT(0)
>> +#      define ZPA_CTRL_REG0_ENABLE          BIT(1)
>> +#define ZPA_CTRL_REG1_REG                    ((u8)0x21)
>> +#      define ZPA_CTRL_REG1_MASK_DATA_READY ((u8)BIT(2))
>> +#define ZPA_CTRL_REG2_REG                    ((u8)0x22)
>> +#      define ZPA_CTRL_REG2_SWRESET         BIT(2)
>> +#define ZPA_CTRL_REG3_REG                    ((u8)0x23)
>> +#      define ZPA_CTRL_REG3_ODR_SHIFT       (4)
>> +#      define ZPA_CTRL_REG3_ENABLE_MEAS     BIT(7)
>> +#define ZPA_INT_SOURCE_REG                   ((u8)0x24)
>> +#      define ZPA_INT_SOURCE_DATA_READY     BIT(2)
>> +#define ZPA_THS_P_LOW_REG                    ((u8)0x25)
>> +#define ZPA_THS_P_HIGH_REG                   ((u8)0x26)
>> +#define ZPA_STATUS_REG                       ((u8)0x27)
>> +#      define ZPA_STATUS_P_DA               BIT(1)
>> +#      define ZPA_STATUS_FIFO_E             BIT(2)
>> +#      define ZPA_STATUS_P_OR               BIT(5)
> I never saw this creative use of whitespace before, I recommend
> that you get rid of it.
>
>> +#define ZPA_PRESS_OUT_XL_REG                 ((u8)0x28)
>> +#define ZPA_PRESS_OUT_L_REG                  ((u8)0x29)
>> +#define ZPA_PRESS_OUT_H_REG                  ((u8)0x2a)
>> +#define ZPA_TEMP_OUT_L_REG                   ((u8)0x2b)
>> +#define ZPA_TEMP_OUT_H_REG                   ((u8)0x2c)
> Why this parathesizing and (u8) casting? It looks superweird,
> try to get rid of the casts.
removed
>
>> +       /*
>> +        * Underlying I2C / SPI bus adapter used to abstract slave register
>> +        * accesses.
>> +        */
>> +       const struct zpa_bus       *bus;
> This would be replaced with
>
> #include <linux/regmap.h>
>
> struct regmap *map;
>
> If you use regmap instead.
see below
>
>> +       /*
>> +        * Interrupt handler stores sampling operation status here for user
>> +        * context usage.
>> +        */
>> +       int                         result;
> I don't understand that comment.
reworded as :
"Allows sampling logic to get completion status of operations interrupt 
handlers
  perform asynchronously"
>   Also: use kerneldoc for
> documenting the fields, see:
> Documentation/kernel-doc-nano-HOWTO.txt
Even for internal driver implementation ?? I didn't want to bloat kernel 
docs just for
hardware driver internals.
>
>> +       /*
>> +        * Optional interrupt line: negative if not declared into DT, in
>> +        * which case user context keeps polling status register to detect
>> +        * sampling completion.
>> +        */
>> +       int                         irq;
> If you use devm_* to request the irq you usually do not need
> to keep this around.
needed for sampling logic to determine whether it has to poll or wait 
for irq
completion.
>
>> +/******************************************************************************
>> + * Various helpers
>> + ******************************************************************************/
> Usually just skip the excess stars:
>
> /*
>   * Various helpers
>   */
>
> But it's just like, my opinion.
>
>> +#define zpa_err(_idev, _format, _arg...) \
>> +       dev_err(zpa_iio2slave(_idev), _format, ##_arg)
>> +
>> +#define zpa_warn(_idev, _format, _arg...) \
>> +       dev_warn(zpa_iio2slave(_idev), _format, ##_arg)
>> +
>> +#define zpa_dbg(_idev, _format, _arg...) \
>> +       dev_dbg(zpa_iio2slave(_idev), _format, ##_arg)
>> +
>> +static struct zpa_private *zpa_iio2priv(const struct iio_dev *indio_dev)
>> +{
>> +       return (struct zpa_private *)iio_priv(indio_dev);
>> +}
> Uhhhh.... Is this necessary?
just shorter in client code.
>
>> +/*
>> + * Fetch single byte from slave register.
>> + * indio_dev: IIO device the slave is attached to.
>> + * address:   address of register to read from.
>> + *
>> + * Returns the fetched byte when successful, a negative error code otherwise.
>> + */
>> +static int zpa_read_byte(const struct iio_dev *indio_dev, u8 address)
>> +{
>> +       return zpa_iio2priv(indio_dev)->bus->zpa_read_byte(indio_dev, address);
>> +}
> So with regmap you can just inline some calls to read from the map.
> regmap_read() and regmap_write()
>
>> +/*
>> + * Fetch multiple bytes from a block of contiguous slave registers.
>> + * indio_dev: IIO device the slave is attached to.
>> + * address:   start address of contiguous registers block to read from.
>> + * length:    number of bytes to fetch.
>> + * value:     location to store fetched data into.
>> + *
>> + * Returns: zero when successful, a negative error code otherwise.
>> + */
>> +static int zpa_read_block(const struct iio_dev *indio_dev,
>> +                         u8                    address,
>> +                         u8                    length,
>> +                         u8                   *value)
>> +{
>> +       return zpa_iio2priv(indio_dev)->bus->zpa_read_block(indio_dev, address,
>> +                                                           length, value);
>> +}
> And it has regmap_bulk_read() too.
Starts to make a number of pros...
>
>> +/*
>> + * Retrieve the most recent pressure sample from hardware fifo.
>> + *
>> + * Note that ZPA2326 hardware fifo stores pressure samples only.
>> + */
>> +static int zpa_dequeue_pressure(const struct iio_dev *indio_dev, u32 *pressure)
>> +{
>> +       int err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
>> +
>> +       if (err < 0)
>> +               return err;
>> +
>> +       if (!(err & ZPA_STATUS_P_OR)) {
>> +               /*
>> +                * Fifo has not overflown : retrieve newest sample. We need to
>> +                * pop values out until fifo is empty : last fetched pressure is
>> +                * the newest.
>> +                * In nominal cases, we should find a single queued sample only.
>> +                */
>> +               int cleared = -1;
>> +
>> +               do {
>> +                       err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
>> +                                            (u8 *)pressure);
>> +                       if (err)
>> +                               return err;
>> +
>> +                       err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
>> +                       if (err < 0)
>> +                               return err;
>> +
>> +                       cleared++;
>> +               } while (!(err & ZPA_STATUS_FIFO_E));
>> +
>> +               if (cleared)
>> +                       /*
>> +                        * Samples were pushed by hardware during previous
>> +                        * rounds but we didn't consume them fast enought:
>> +                        * inform user.
>> +                        */
>> +                       zpa_warn(indio_dev, "cleared %d fifo entries", cleared);
>> +
>> +               return 0;
>> +       }
> Make the error case the exception instead.
>
> if (err & ZPA_STATUS_P_OR) {
>     handle error
> }
>
> ...normal flow here ...
damned! ack'ed.
>
>> +/* Enqueue new channel samples to IIO buffer. */
>> +static int zpa_fill_sample_buffer(struct iio_dev           *indio_dev,
>> +                                 const struct zpa_private *private)
>> +{
>> +       struct {
>> +               u32 pressure;
>> +               u16 temperature;
>> +               u64 timestamp;
>> +       }   sample;
> (...)
>> +       /*
>> +        * Now push samples using timestamp stored either :
>> +        *   - by hardware interrupt handler if interrupt is available: see
>> +        *     zpa_handle_irq(),
>> +        *   - or oneshot completion polling machinery : see
>> +        *     zpa_trigger_oneshot().
>> +        */
>> +       iio_push_to_buffers_with_timestamp(indio_dev, &sample,
>> +                                          private->timestamp);
>> +       return 0;
> That is an interesting construction, maybe more drivers should
> pick this up, because it makes things much more clear.
>
>> +#ifdef CONFIG_PM
>> +static int zpa_runtime_suspend(struct device *slave)
> Usually I just use struct device *dev to have simple variable names.
> I don't see the "slave" quality of this struct device *.
Well that's kinda subjective : when I cross a "struct device *", I often
wonder if it points to IIO device or I2C/SPI slave device (bus oriented
terminology).
It makes things more obvious despite not widely in use. Well... to me...
>
>> +{
>> +       const struct iio_dev *indio_dev = dev_get_drvdata(slave);
>> +
>> +       if (pm_runtime_autosuspend_expiration(slave))
>> +               /* Userspace changed autosuspend delay. */
>> +               return -EAGAIN;
> Is this something that is needed?
May be useful to system designer/integrator, mostly for energy saving
assessment (or debug).

For reference, from Documentation/power/runtime_pm.txt:
"In addition, the power.autosuspend_delay field can be changed by user 
space at
any time.  If a driver cares about this, it can call 
pm_runtime_autosuspend_expiration()
from within the ->runtime_suspend() callback while holding its private lock.
If the function returns a nonzero value then the delay has not yet 
expired and the
callback should return -EAGAIN."

>> +const struct dev_pm_ops zpa_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                               pm_runtime_force_resume)
>> +       SET_RUNTIME_PM_OPS(zpa_runtime_suspend, zpa_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(zpa_pm_ops);
> Nice.
>
>> +/* Request the PM layer to power supply the device. */
>> +static int zpa_resume(const struct iio_dev *indio_dev)
>> +{
>> +       struct device *slave = zpa_iio2slave(indio_dev);
>> +       int            err = pm_runtime_get_sync(slave);
>> +
>> +       if (err < 0)
>> +               goto put;
>> +
>> +       if (err > 0) {
Just to be sure there is no misunderstanding : this case is not an
error condition.
It simply checks if device was already in the "power up" state to
save extra bus accesses (mainly one-shot / continuous
mode setup and clear fifo operations) with additional benefit of
reducing power up latency.
>> +               /*
>> +                * Device was already power supplied: get it out of low power
>> +                * mode.
>> +                */
>> +               err = zpa_enable_device(indio_dev);
>> +               if (err)
>> +                       goto put;
>> +
>> +               /* Inform caller device was already power supplied. */
>> +               return 1;
>> +       }
>> +
>> +       /* Inform caller device has just been brought back to life. */
>> +       return 0;
>> +
>> +put:
>> +       pm_runtime_put_noidle(slave);
>> +       return err;
>> +}
> I don't see other drivers bothering with this excess error
> handling and I think you can just pm_runtime_get_sync()
> around the areas you need.
at least one : drivers/linux/iio/accel/mma8452.c

Generally speaking I agree with your statement. However I'm afraid
skipping pm_runtime_put_noidle() call would prevent a parent
device from switching to sleep mode since I suppose it would
still be ref-counted...

Let me think of this one more time...
Ah! Unless you thought of autosuspend logic ?

Can you confirm /  refute this (i'm far from an expert on this) ?

>> +static int zpa_suspend(const struct iio_dev *indio_dev)
>> +{
>> +       struct device *slave = zpa_iio2slave(indio_dev);
>> +       int            err = zpa_disable_device(indio_dev);
>> +
>> +       pm_runtime_mark_last_busy(slave);
>> +
>> +       if (err)
>> +               goto err;
>> +
>> +       err = pm_runtime_put_autosuspend(slave);
>> +       if (err) {
>> +               dev_warn(slave, "failed to autosuspend (%d)", err);
>> +               goto err;
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       pm_runtime_put_noidle(slave);
>> +       return err;
>> +}
> Likewise just
> pm_runtime_mark_last_busy()
> pm_runtime_put_autosuspend()
>
> Checking all these errors is overengineered IMO, something
> going wrong would be so odd that this is cluttering more than
> helping.
Agreed. I should just make sure nothing harmful can happen on
interrupt side. Currently, this should be safe enough though.
>
>> +
>> +/* Setup runtime power management with autosuspend support. */
>> +static void zpa_init_runtime(struct device *slave)
>> +{
>> +       pm_runtime_get_noresume(slave);
>> +       pm_runtime_set_active(slave);
>> +       pm_runtime_enable(slave);
>> +       pm_runtime_set_autosuspend_delay(slave, 1000);
>> +       pm_runtime_use_autosuspend(slave);
>> +       pm_runtime_mark_last_busy(slave);
>> +       pm_runtime_put_autosuspend(slave);
>> +}
>> +
>> +static void zpa_fini_runtime(struct device *slave)
>> +{
>> +       pm_runtime_disable(slave);
>> +       pm_runtime_set_suspended(slave);
>> +}
>> +#else /* !CONFIG_PM */
>> +static int zpa_resume(const struct iio_dev *indio_dev)
>> +{
>> +       return zpa_enable_device(indio_dev);
>> +}
>> +
>> +static int zpa_suspend(const struct iio_dev *indio_dev)
>> +{
>> +       return zpa_disable_device(indio_dev);
>> +}
>> +
>> +#define zpa_init_runtime(_slave)
>> +#define zpa_fini_runtime(_slave)
>> +#endif /* !CONFIG_PM */
> I would just put runtime PM activation verbatim into the common
> probe() and disablement verbatim into the common remove().
>
> For an example see:
> drivers/iio/light/bh1780.c
> which was removed by runtime PM people (Ulf Hansson).
>
>> +static irqreturn_t zpa_handle_irq(int irq, void *data)
>> +{
>> +       struct iio_dev *indio_dev = (struct iio_dev *)data;
>> +
>> +       if (iio_buffer_enabled(indio_dev)) {
>> +               struct zpa_private *priv = zpa_iio2priv(indio_dev);
>> +
>> +               /* Timestamping needed for buffered sampling only. */
>> +               priv->timestamp = iio_get_time_ns(indio_dev);
>> +       }
> I don't understand this. Isn't it so that this interrupt only occurs
> if the hardware trigger is enabled? And that means that triggered
> buffer is active and it implies that we're using a buffer so
> iio_buffer_enabled() is always true here.
May also happen in INDIO_DIRECT_MODE and INDIO_BUFFER_SOFTWARE
in addition to INDIO_BUFFER_TRIGGERED.
So the check is here to prevent from getting timestamp when interrupt is
generated upon read_raw accesses (if valid irq found at init time).
However I really wonder if iio_get_time_ns() adds any significant overhead.
If not, we could simply skip this test, but I suspect it is depending on the
kind of clock selected.

>
> When I wrote my drivers I rather faced the following:
>
> - If I'm using my own hardware trigger, take the timestamp in the
>    interrupt handler top half.
>
> - If not, take the sample in the trigger handler.
>
> That is, I'm rather looking for a function that tells me if my
> buffer is using my own hardware trigger, or something else.
>
> And that I am tentatively solving with a local variable in the
> state container, like bool hw_irq_trigger, which feels a bit
> shaky, so we really should be looking at a way to ask the
> framework if we're using our own trigger, right?
This driver is not meant to perform buffered sampling coupled
with its own hardware trigger.
See patch series cover-letter (the INDIO_BUFFER_SOFTWARE
related question) and zpa_validate_trigger().
So it is a bit different from st_sensors model if this is what you had
in mind.

The whole thing tries to ensure proper synchronization of sampling
with external trigger (such as an hrtimer based one). This is rather
complex if the underlying process is continuously sampling at its
own pace.
Implementation is much more straightforward if sampling is done
"on demand" (upon trigger dispatching).

>
>> +static int zpa_acknowledge_irq(const struct iio_dev     *indio_dev,
>> +                              const struct zpa_private *private)
>> +{
>> +       /*
>> +        * Device works according to a level interrupt scheme: reading interrupt
>> +        * status de-asserts interrupt line.
>> +        */
>> +       int err = zpa_read_byte(indio_dev, ZPA_INT_SOURCE_REG);
>> +
>> +       if (err < 0)
>> +               return err;
>> +
>> +       /* Data ready is the only interrupt source we requested. */
>> +       if (!(err & ZPA_INT_SOURCE_DATA_READY)) {
>> +               zpa_warn(indio_dev, "unexpected interrupt status %02x", err);
>> +               return -ENODATA;
>> +       }
> This looks strange. I think this should rather lead to IRQ_NONE
> being returned from the interrupt handler than a negative return value
> from this function, do you agree?
>
>> +       /* New sample available: notify our internal trigger consumers. */
>> +       iio_trigger_poll_chained(private->trigger);
>> +
>> +       return 0;
>> +}
> I think this whole function should be skipped and inlined into
> zpa_handle_threaded_irq() for clarity.
reworked and inlined
>
>> +static irqreturn_t zpa_handle_threaded_irq(int irq, void *data)
>> +{
>> +       struct iio_dev     *indio_dev = (struct iio_dev *)data;
>> +       struct zpa_private *priv = zpa_iio2priv(indio_dev);
>> +       irqreturn_t         ret = IRQ_NONE;
>> +
>> +       priv->result = zpa_acknowledge_irq(indio_dev, priv);
>> +
>> +       if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
>> +               /* Continuous sampling enabled. */
>> +
>> +               if (!priv->result)
>> +                       /* Populate IIO buffer */
>> +                       zpa_fill_sample_buffer(indio_dev, priv);
>> +               /*
>> +                * Tell power management layer we've just used the device to
>> +                * prevent from autosuspending to early.
>> +                */
>> +               pm_runtime_mark_last_busy(zpa_iio2slave(indio_dev));
> Runtime PM will not autosuspend while you're holding a reference,
> i.e. after a get_sync()
ah! i missed the point completely...
>
> This is rather something you should do right before
> runtime_pm_put_autosuspend() to mark that this was the last
> time we were busy.
>
> I think you can just skip this.
>
>> +               return (!priv->result) ? IRQ_HANDLED : IRQ_NONE;
> Here IRQ_NONE is returned correctly.
>
>> +       }
>> +
>> +       if (priv->result)
>> +               /*
>> +                * Interrupt happened but no new sample available: likely caused
>> +                * by spurious interrupts, in which case, returning IRQ_NONE
>> +                * allows to benefit from the generic spurious interrupts
>> +                * handling.
>> +                */
>> +               goto complete;
> Aha so here the negative error code from the helper function
> means the default assignment to ret , IRQ_NONE gets returned.
> That is hard to follow, just inline the other function as I suggest and
> I think it becomes simpler to see.
>
>> +       switch (type) {
>> +       case IIO_PRESSURE:
>> +               zpa_dbg(indio_dev, "fetching raw pressure sample");
>> +
>> +               err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
>> +                                    (u8 *)value);
> Use a local variable instead of modifying the buffer in-place, else you
> leave junk in the buffer on the error path.
>
> u8 raw_val[3];
>
> zpa_read_block(.... &raw_val);
>
> is the pattern I would use.
>
>> +               if (err) {
>> +                       zpa_warn(indio_dev, "failed to fetch pressure (%d)",
>> +                                err);
>> +                       return err;
>> +               }
>> +
>> +               /* Pressure is a 24 bits wide little-endian unsigned int. */
>> +               *value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
>> +                        ((u8 *)value)[0];
> That works, some would use some sign extension and le32_to_cpu() I
> guess but who cares.
>
>> +       case IIO_TEMP:
>> +               zpa_dbg(indio_dev, "fetching raw temperature sample");
>> +
>> +               err = zpa_read_block(indio_dev, ZPA_TEMP_OUT_L_REG, 2,
>> +                                    (u8 *)value);
> Do not modify buffer in-place.
>
>> +               if (err) {
>> +                       zpa_warn(indio_dev, "failed to fetch temperature (%d)",
>> +                                err);
>> +                       return err;
>> +               }
>> +
>> +               /* Temperature is a 16 bits wide little-endian signed int. */
>> +               *value = (int)le16_to_cpup((__le16 *)value);
>> +
>> +               return IIO_VAL_INT;
>> +
>> +       default:
>> +               BUG();
> That's nasty. Just dev_err() and an explanation is better I think.
>
>> +/*
>> + * Reject external trigger attachment if setting up continuous hardware sampling
>> + * mode.
>> + */
>> +static int zpa_validate_trigger(struct iio_dev     *indio_dev,
>> +                               struct iio_trigger *trigger)
>> +{
>> +       int ret = 0;
>> +
>> +       mutex_lock(&indio_dev->mlock);
>> +
>> +       if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
>> +               ret = -EBUSY;
>> +
>> +       mutex_unlock(&indio_dev->mlock);
>> +
>> +       return ret;
>> +}
> This looks more like something the IIO core should be doing.
> Why do we need to look for such things in drivers?
see above discution about buffered sampling coupled
with hardware trigger.
>
>> +/* Finalize one shot cycle processing in triggered sampling mode. */
>> +static void zpa_complete_oneshot_trigger(const struct iio_dev *indio_dev)
>> +{
>> +       /*
>> +        * Tell power management layer we've just used the device to prevent
>> +        * from autosuspending to early.
>> +        */
>> +       pm_runtime_mark_last_busy(zpa_iio2slave(indio_dev));
> Again as long as the reference is held this should not be necessary.
>
>> +static const struct iio_buffer_setup_ops zpa_ring_setup_ops = {
>> +       .preenable   = zpa_preenable_ring,
>> +       .postenable  = zpa_postenable_ring,
>> +       .predisable  = zpa_predisable_ring,
>> +       .postdisable = zpa_postdisable_ring,
>> +};
> So in my drivers I tend to pick a runtime PM reference with
> runtime_pm_get_sync() in .preenable and runtime_pm_mark_last_busy()
> and runtime_pm_put_autosuspend() in .postdisable() so the power
> is on around the whole buffered measurement cycle.
>
> Then for the raw reads some special quirks.
reworked.
>
>> +static int zpa_debugfs_read(struct iio_dev *indio_dev,
>> +                           u8              reg,
>> +                           unsigned int   *value)
>> +{
>> +       int err;
>> +
>> +       switch (reg) {
>> +       case ZPA_REF_P_XL_REG:
>> +       case ZPA_REF_P_L_REG:
>> +       case ZPA_REF_P_H_REG:
>> +       case ZPA_DEVICE_ID_REG:
>> +       case ZPA_RES_CONF_REG:
>> +       case ZPA_CTRL_REG0_REG:
>> +       case ZPA_CTRL_REG1_REG:
>> +       case ZPA_CTRL_REG2_REG:
>> +       case ZPA_CTRL_REG3_REG:
>> +       case ZPA_INT_SOURCE_REG: /* Will acknowledge interrupts. */
>> +       case ZPA_THS_P_LOW_REG:
>> +       case ZPA_THS_P_HIGH_REG:
>> +       case ZPA_STATUS_REG:
>> +       case ZPA_PRESS_OUT_XL_REG:
>> +       case ZPA_PRESS_OUT_L_REG:
>> +       case ZPA_PRESS_OUT_H_REG:  /* Will pop samples out of hardware fifo. */
>> +       case ZPA_TEMP_OUT_L_REG:
>> +       case ZPA_TEMP_OUT_H_REG:
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       err = zpa_claim_direct_mode(indio_dev);
>> +       if (err < 0)
>> +               return err;
>> +
>> +       err = zpa_read_byte(indio_dev, reg);
>> +       if (err < 0)
>> +               goto release;
>> +
>> +       *value = err;
>> +       err = 0;
>> +
>> +release:
>> +       zpa_release_direct_mode(indio_dev);
>> +       return err;
>> +}
> Regmap provides all of this for free. It has a min_reg and max_reg
> property.
>
> But overall it is not so necessary to be overly protective in debugfs
> (what register can be read etc): it is debugfs after all, you should know
> what you're doing.
I'd prefer to trash the debugfs thing then (access to reserved register
space may lead to unpredictable results).
What do you think ?

Anyway, I was not really convinced by regmap usage untill now : using
it would save a fair amount of code.
Rework in progress...

And many many thanks for sharing your views.

Regards,
Greg.
>
>> +static int zpa_read_raw(struct iio_dev             *indio_dev,
>> +                       struct iio_chan_spec const *chan,
>> +                       int                        *val,
>> +                       int                        *val2,
>> +                       long                        mask)
>> +{
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               return zpa_sample_oneshot(indio_dev, chan->type, val);
> So when using rumtime PM I would just take the pm reference around
> this call actually, apart from around the buffer preenable/postdisable.
>
>> +       default:
>> +               BUG();
> Again that is nasty.
>
>> +static const struct iio_chan_spec zpa_channels[] = {
>> +       [0] = {
>> +               .type                   = IIO_PRESSURE,
>> +               .channel                = 0,
>> +               .scan_index             = 0,
>> +               .scan_type              = {
>> +                       .sign                   = 'u',
>> +                       .realbits               = 24,
>> +                       .storagebits            = 32,
>> +                       .endianness             = IIO_LE,
>> +               },
>> +               .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
>> +                                         BIT(IIO_CHAN_INFO_SCALE),
>> +       },
>> +       [1] = {
>> +               .type                   = IIO_TEMP,
>> +               .channel                = 1,
>> +               .scan_index             = 1,
>> +               .scan_type              = {
>> +                       .sign                   = 's',
>> +                       .realbits               = 16,
>> +                       .storagebits            = 16,
>> +                       .endianness             = IIO_LE,
>> +               },
>> +               .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
>> +                                         BIT(IIO_CHAN_INFO_SCALE) |
>> +                                         BIT(IIO_CHAN_INFO_OFFSET),
>> +       },
>> +       [2] = IIO_CHAN_SOFT_TIMESTAMP(2),
>> +};
> This looks nice.
>
>> +static int _zpa_read_i2c_byte(const struct i2c_client *client, u8 address)
>> +{
>> +       int            err;
>> +       u8             byte;
>> +       struct i2c_msg msg[] = {
>> +               [0] = {
>> +                       .addr  = client->addr,
>> +                       .flags = client->flags,
>> +                       .len   = 1,
>> +                       .buf   = &address
>> +               },
>> +               [1] = {
>> +                       .addr  = client->addr,
>> +                       .flags = client->flags | I2C_M_RD,
>> +                       .len   = 1,
>> +                       .buf   = &byte
>> +               }
>> +       };
>> +
>> +       err = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
>> +       if (err < 0)
>> +               return err;
>> +
>> +       if (err != ARRAY_SIZE(msg))
>> +               return -ENOMSG;
>> +
>> +       return (int)byte;
>> +}
> This just looks like a reimplementation of I2C regmap.
>
> So use I2C regmap as abstraction.
>
>> +static int _zpa_read_spi_byte(struct spi_device *slave, u8 address)
>> +{
>> +       struct spi_transfer xfer[2];
>> +       u8                  buf;
>> +       int                 err;
>> +
>> +       /* Request read cycle. */
>> +       address |= ZPA_SPI_ADDR_RD;
>> +
>> +       /* Zero-initialize to ensure forward compatibility. */
>> +       memset(xfer, 0, sizeof(xfer));
>> +
>> +       /* Register address write cycle. */
>> +       xfer[0].tx_buf = &address;
>> +       xfer[0].len = sizeof(address);
>> +
>> +       /* Register content read cycle. */
>> +       xfer[1].rx_buf = &buf;
>> +       xfer[1].len = sizeof(buf);
>> +
>> +       err = spi_sync_transfer(slave, xfer, ARRAY_SIZE(xfer));
>> +       if (err)
>> +               return err;
>> +
>> +       return buf;
>> +}
> Sane here but for SPI, use regmap correct me if I'm wrong.
>
> Look at drivers/iio/pressure/bmp280* for regmap inspiration.
>
> Yours,
> Linus Walleij

