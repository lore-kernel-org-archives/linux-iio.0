Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33612 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaCWTbd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Mar 2014 15:31:33 -0400
Message-ID: <532F36D2.4020701@kernel.org>
Date: Sun, 23 Mar 2014 19:32:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>,
	Matthew Garrett <mjg59@srcf.ucam.org>
CC: platform-driver-x86@vger.kernel.org,
	Javier Achirica <jachirica@gmail.com>,
	linux-iio@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 10/11] sony-laptop: als support
References: <1395356482-7446-1-git-send-email-malattia@linux.it> <1395356482-7446-11-git-send-email-malattia@linux.it>
In-Reply-To: <1395356482-7446-11-git-send-email-malattia@linux.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/14 23:01, Mattia Dongili wrote:
> From: Javier Achirica <jachirica@gmail.com>
>
> vaios come with two different type of ACPI based ALS controls. The
> oldest incarnation exposes and requires a much lower level control over
> the ALS device (tsl256x) and raw data, the most recent one is much
> simpler and only allows fetching lux readings.
> Additionally, the DSDT exposes data tables that can be used apply
> corrections and appropriate scaling to the sensor's readings.
> The device is registered via the IIO subsystem and the tables exposed as
> attributes of the IIO device.
>
> As a bonus, enabling the sensor makes backlight Fn keys behave
> differently than default. Instead of changing backlight, _BCM will
> generate events to the SNC device (with no indication of the new
> backlight value) expecting that to do the legwork instead.
> To make this work in Linux we force registering platform backlight
> control and use the backlight subsystem to get notified about changes
> and applying the change using SNC specific methods.
>
> The device is enabled by default but allows disabling passing
> enable_als=0 as a module parameter.
>
> Mattia's changes:
> * remove unused event read functions
> * rework backlight device registration precedence
> * add callback for brightness change notifications
> * re-arm ALS events after the event
> * Kconfig: select IIO
> * remove unused function and redundant allocation
> * reformat code
> * add module parameter to disable ALS
> * do not force backlight device to be created when no ALS is setup.
> * remove redundant tsl driver setup calls
> * change calculate_lux function to return a value
> * simplify tsl256x_get_id function
>
> Marco Chiappero worked on early revisions of this code, see
> http://www.absence.it/vaio-acpi/
>
Hi,

I hate to say it but my first reaction to this was, 'What are so
many functions doing in one file in the first place?'

The embedded world has been busy splitting up and reparcelling large
files like this so the various devices end up within the correct
subsystems. I won't even go into all the reasons for this as they
are listed everywhere else?  Is this just a case of modifying old
code no one wants to touch on a larger scale or is there actually
resistance to breaking new functionality out of this file and
into nice clean small chunks?
   
So my first request is can we at least split this new functionality
out?

As I look through what we have here, it looks like we ought to have
this functionality alone split into the ALS sensor and a backlight
driver (which can by all means use the standard interfaces to
talk to the ALS)... (event support for in kernel users isn't there
yet, but this might motivate us to hurry up with it).

The bulk of this driver is actually just a set of nasty access routines
and then functionality that already exists in the existing tsl2563 driver.
Hence, unless there are very good reasons why not I would suggest the
following.

1) Convert the existing tsl2563 driver over to using regmap.
2) Add regmap support for the access routines we have here then add the
    little bit of code needed to make the tsl2563 register appopriately.  This
    may require a small amount of magic mfd like code in here.
(plan b on this is to perhaps create an i2c bus driver using the sony
specific calls).
3) Figure out what extra bits are that are needed by the ALS driver we have
    here and add them on (kelvin support and perhaps a few other bits).
4) Then and only then take on any non ALS elements in here (such as the
    back light).

The other als driver (one where all the clever stuff is hidden) should ideally
be a completely separate als driver (be it a very simple one.

Anyhow, your code is reasonably clean but I think some of these questions about
the fundamental approach need addressing to avoid getting ourselves into a
nasty mess in the long term.   Sorry if this review seems a little negative.
I appreciate that you've only taken the approach taken throughout this file!

Just as an aside, is there any interest in cleaning this whole file up?
The sonypi device looks like it should registering a whole host of standard
interfaces...

Jonathan
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Marco Chiappero <marco@absence.it>
> Signed-off-by: Javier Achirica <jachirica@gmail.com>
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>   Documentation/laptops/sony-laptop.txt |   31 +
>   drivers/platform/x86/Kconfig          |    1 +
>   drivers/platform/x86/sony-laptop.c    | 1111 ++++++++++++++++++++++++++++++++-
>   3 files changed, 1128 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/laptops/sony-laptop.txt b/Documentation/laptops/sony-laptop.txt
> index 978b1e6..014ebdf 100644
> --- a/Documentation/laptops/sony-laptop.txt
> +++ b/Documentation/laptops/sony-laptop.txt
> @@ -79,6 +79,37 @@ such a laptop you will find the necessary rfkill devices under
>   /sys/class/rfkill. Check those starting with sony-* in
>   	# grep . /sys/class/rfkill/*/{state,name}
>
> +Ambient Light Sensor:
> +---------------------
> +On models equipped with ALS, sony-laptop will create an IIO device available
> +under:
> +	/sys/bus/iio/devices/
> +In addition to the sensor's readings, a number of other attributes are exposed
> +for userspace to consume:
> +	typical_illuminance	Typical illuminance level for brightness
> +				control in lux.
Is this a target value?  Need a better description for this as it's not immediately
obvious what it is.

> +	backlight_illuminance	Threshold in lux for keyboard backlight.
> +	lux_correction_percent	Correction factor to apply to brightness in
> +				percentage.
If applied to the measurement before exposed to userspace then it should
be handled using the iio info_mask element calibscale. If it's a value that
should be applied in userspace then the scale infomask element.
  
> +	low_threshold_percent	Percentage from current lux level to trigger
> +				event (low).
Interesting.  These are a new one :)
Anyhow the should be handled through additions to iio's iio_event_info
enum and all the stuff that goes with that.
Perhaps
IIO_EV_INFO_PERCENT, with sysfs attributes
events/in_illuminance_thresh_rising_percent
events/in_illuminance_thresh_falling_percent

Actually you don't seem to have any IIO_EV_INFO stuff in here yet you
are still pushing out events via IIO. Interesting...

> +	high_threshold_percent	Percentage from current lux level to trigger
> +				event (high).
> +	als_event_rate		Time in milliseconds between brightness changes
> +				when triggered by light change.
The naming is not nearly descriptive enough as I'd read that as being how
often an event (e.g. it going dark) is checked from the als.

> +	als_event_delay		Percentage of brightness changes when triggered
> +				by light change.
> +	key_event_rate		Time in milliseconds between brightness changes
> +				when triggered by keypress.
> +	key_event_delay		Percentage of brightness changes when triggered
> +				by keypress.
These are so device dependent we'll probably just let them go.  Might be
something that's worth checking with the input guys to discover if they
have an interface already defined for this sort of thing.

> +	interrupt_rate		Light sensor interrupt rate in milliseconds.
> +	light_compensation_x10	Light compensation needed due to sensor cover.
Offset, or a scale factor?  Either way there are well defined abi elements for
this already.

> +	minimum_illuminance	Minimum expected illuminance level in lux.
Expected in what sense?
> +	maximum_illuminance	Maximum expected illuminance level in lux.
> +	algorithm		Brightness calculation algorithm to be used.
That's a lot of new abi as far as IIO is concerned.  It will all need documenting in
Documentation/ABI/testing/sysfs-bus-iio-sony-laptop or the generic files if appropriate.
Also, no units for some of the above.

> +Depending on the sensor and laptop model, some of these attributes may not be
> +available.
>
>   Development:
>   ------------
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5ae65c1..761086f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -279,6 +279,7 @@ config SONY_LAPTOP
>   	select BACKLIGHT_CLASS_DEVICE
>   	depends on INPUT
>   	depends on RFKILL
> +	select IIO
>   	  ---help---
>   	  This mini-driver drives the SNC and SPIC devices present in the ACPI
>   	  BIOS of the Sony Vaio laptops.
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index 19d769e..b0a311f 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -61,6 +61,9 @@
>   #include <linux/workqueue.h>
>   #include <linux/acpi.h>
>   #include <linux/slab.h>
> +#include <acpi/video.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
>   #include <linux/sonypi.h>
>   #include <linux/sony-laptop.h>
>   #include <linux/rfkill.h>
> @@ -138,6 +141,12 @@ MODULE_PARM_DESC(kbd_backlight_timeout,
>   		 "meaningful values vary from 0 to 3 and their meaning depends "
>   		 "on the model (default: no change from current value)");
>
> +static int enable_als = 1;
> +module_param(enable_als, int, 0444);
> +MODULE_PARM_DESC(enable_als,
> +		 "set this to 0 to disable the SNC controlled ALS sensor "
> +		 "(default: 1)");
> +
>   #ifdef CONFIG_PM_SLEEP
>   static void sony_nc_thermal_resume(void);
>   #endif
> @@ -200,6 +209,138 @@ static int sony_nc_rfkill_setup(struct acpi_device *device,
>   static void sony_nc_rfkill_cleanup(void);
>   static void sony_nc_rfkill_update(void);
>
> +#define ALS_TABLE_SIZE	126
> +
> +struct als_device_ops {
> +	int (*init)(const u8 defaults[]);
> +	int (*exit)(void);
> +	int (*event_handler)(void);
> +	int (*set_power)(unsigned int);
> +	int (*get_lux)(unsigned int *);
> +	int (*get_kelvin)(unsigned int *);
> +};
> +
> +struct als_device {
> +	int handle;
> +
> +	unsigned int levels_num;
> +	u8 *levels;
> +	u8 *defaults;
> +	u8 parameters[ALS_TABLE_SIZE];
> +	struct als_param_list *als_params;
> +
> +	/* common device operations */
> +	const struct als_device_ops *ops;
> +
> +	/* IIO device */
> +	struct iio_dev *indio_dev;
> +};
> +static struct als_device *als_handle;
> +
> +struct als_param_list {
> +	int offset;
> +	char *name;
> +};
> +
const?
> +static struct als_param_list als_params[] = {
> +	{ 1, "typical_illuminance" },
> +	{ 11, "backlight_illuminance" },
> +	{ 0, "lux_correction_percent" },
> +	{ 3, "low_threshold_percent" },
> +	{ 4, "high_threshold_percent" },
> +	{ 5, "als_event_rate" },
> +	{ 6, "als_event_delay" },
> +	{ 7, "key_event_rate" },
> +	{ 8, "key_event_delay" },
> +	{ 9, "interrupt_rate" },
> +	{ 10, "light_compensation_x10" },
> +	{ 0, NULL }
> +};
> +
const?
> +static struct als_param_list ngals_params[] = {
> +	/* Should these two should go to a "range" file in IIO? */
An excellent question.   Ranges aren't currently well defined.
There is a patch set I posted a while ago introducing _available
type sysfs attributes which does include the ability to specify
the limits on any iio info_mask element (including *_input)
which would do the job.  That series has gotten somewhat stalled
by me being busy though... Hence I'm not totally against this
but it would be in_illuminance_maximum to fit with the normal
ABI form.  We'd just leave this in place once that new support
is there as well. Doesn't do any realy harm.
> +	{ 4, "minimum_illuminance" },
> +	{ 6, "maximum_illuminance" },
> +	{ 0, "als_event_rate" },
> +	{ 1, "als_event_delay" },
> +	{ 2, "key_event_rate" },
> +	{ 3, "key_event_delay" },
> +	{ 8, "algorithm" },
> +	{ 0, NULL }
> +};
> +
Why not just reorder the code so these show functions are
before they are used?  Looks straight forward and much neater.
I guess this is part of this being in a monolithic file.

The more I read, the more I think this definitely needs breaking
up.  Taking this driver outside of it is just the start.
> +static ssize_t sony_nc_als_parameters_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer);
> +static ssize_t sony_nc_als_param_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer);
> +
This one isn't documented above.  Every attr MUST be documented.
It needs to be in the Documentation/ABI/testing directory, but
having it above would have been a good start ;)
> +static struct device_attribute als_attr_backlight_sensibility_table =
> +	__ATTR(backlight_sensibility_table, 0444,
> +		sony_nc_als_parameters_show, 0);
> +
> +static ssize_t sony_nc_als_kelvin_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer);
Are we talking actual temperature or colour temperature here?
Either way, I missed the documentation...
> +
> +static struct device_attribute als_attr_kelvin =
> +	__ATTR(kelvin, 0444, sony_nc_als_kelvin_show, 0);
> +
> +#define ALS_ATTR(_name, _mode)					\
> +struct device_attribute als_attr_##_name = __ATTR(_name,	\
> +		_mode, sony_nc_als_param_show, 0)
> +
> +static ALS_ATTR(typical_illuminance, 0444);
> +static ALS_ATTR(backlight_illuminance, 0444);
> +static ALS_ATTR(lux_correction_percent, 0444);
> +static ALS_ATTR(low_threshold_percent, 0444);
> +static ALS_ATTR(high_threshold_percent, 0444);
> +static ALS_ATTR(als_event_rate, 0444);
> +static ALS_ATTR(als_event_delay, 0444);
> +static ALS_ATTR(key_event_rate, 0444);
> +static ALS_ATTR(key_event_delay, 0444);
> +static ALS_ATTR(interrupt_rate, 0444);
> +static ALS_ATTR(light_compensation_x10, 0444);
> +
> +static ALS_ATTR(minimum_illuminance, 0444);
> +static ALS_ATTR(maximum_illuminance, 0444);
> +static ALS_ATTR(algorithm, 0444);
> +
> +static struct attribute *als_attributes[] = {
> +	&als_attr_backlight_sensibility_table.attr,
> +	&als_attr_typical_illuminance.attr,
> +	&als_attr_backlight_illuminance.attr,
> +	&als_attr_lux_correction_percent.attr,
> +	&als_attr_low_threshold_percent.attr,
> +	&als_attr_high_threshold_percent.attr,
> +	&als_attr_als_event_rate.attr,
> +	&als_attr_als_event_delay.attr,
> +	&als_attr_key_event_rate.attr,
> +	&als_attr_key_event_delay.attr,
> +	&als_attr_interrupt_rate.attr,
> +	&als_attr_light_compensation_x10.attr,
> +	&als_attr_kelvin.attr,
> +	NULL
> +};
> +
> +static struct attribute *ngals_attributes[] = {
> +	&als_attr_backlight_sensibility_table.attr,
> +	&als_attr_minimum_illuminance.attr,
> +	&als_attr_maximum_illuminance.attr,
> +	&als_attr_als_event_rate.attr,
> +	&als_attr_als_event_delay.attr,
> +	&als_attr_key_event_rate.attr,
> +	&als_attr_key_event_delay.attr,
> +	&als_attr_algorithm.attr,
So is algorithm going to give me a magic number?  Please convert this
to something human readable if so.
> +	NULL
> +};
> +
> +struct attribute_group als_attr_group = {
> +	.name = "als_parameters"
> +};
> +
> +static int sony_nc_als_setup(struct acpi_device *dev, unsigned int handle);
> +static void sony_nc_als_cleanup(struct platform_device *pd);
> +static void sony_nc_als_resume(void);
> +
>   /*********** Input Devices ***********/
>
>   #define SONY_LAPTOP_BUF_SIZE	128
> @@ -1065,20 +1206,43 @@ static int sony_nc_get_brightness_ng(struct backlight_device *bd)
>   	return (result & 0xff) - sdev->offset;
>   }
>
> -static int sony_nc_update_status_ng(struct backlight_device *bd)
> +static int __sony_nc_set_brightness_ng(struct sony_backlight_props *bl,
> +		int brightness)
>   {
> -	int value, result;
> -	struct sony_backlight_props *sdev =
> -		(struct sony_backlight_props *)bl_get_data(bd);
> +	int result = 0;
> +	int value = brightness + bl->offset;
>
> -	value = bd->props.brightness + sdev->offset;
> -	if (sony_call_snc_handle(sdev->handle, sdev->cmd_base | (value << 0x10),
> +	if (sony_call_snc_handle(bl->handle, bl->cmd_base | (value << 0x10),
>   				&result))
>   		return -EIO;
>
>   	return value;
>   }
Whilst this stuff is presumably being driver from the ALS it is decidedly
back light specific. Perhaps I'm idealistic in thinking it should be
a different driver.
>
> +
> +static int sony_nc_update_status_ng(struct backlight_device *bd)
> +{
> +	struct sony_backlight_props *sdev =
> +		(struct sony_backlight_props *)bl_get_data(bd);
> +
> +	return __sony_nc_set_brightness_ng(sdev, bd->props.brightness);
> +}
> +
> +static void sony_nc_brightness_changed_ng(struct backlight_device *bd,
> +		int brightness, int max_brightness)
> +{
> +	int new_brightness =
> +		brightness * bd->props.max_brightness / max_brightness;
> +	struct sony_backlight_props *sdev =
> +		(struct sony_backlight_props *)bl_get_data(bd);
> +
> +	dprintk("brightness changed cur: %d, max: %d -> new: %d\n", brightness,
> +			max_brightness, new_brightness);
> +
> +	__sony_nc_set_brightness_ng(sdev, new_brightness);
> +	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
> +}
> +
>   static const struct backlight_ops sony_backlight_ops = {
>   	.options = BL_CORE_SUSPENDRESUME,
>   	.update_status = sony_backlight_update_status,
> @@ -1088,6 +1252,7 @@ static const struct backlight_ops sony_backlight_ng_ops = {
>   	.options = BL_CORE_SUSPENDRESUME,
>   	.update_status = sony_nc_update_status_ng,
>   	.get_brightness = sony_nc_get_brightness_ng,
> +	.brightness_changed = &sony_nc_brightness_changed_ng,
>   };
>
>   /*
> @@ -1201,7 +1366,8 @@ static int sony_nc_hotkeys_decode(u32 event, unsigned int handle)
>   enum event_types {
>   	HOTKEY = 1,
>   	KILLSWITCH,
> -	GFX_SWITCH
> +	GFX_SWITCH,
> +	ALS
>   };
Hmm. I don't suppose suggesting this should be an mfd with a nice clean
event hook up interface will go down to well?
>   static void sony_nc_notify(struct acpi_device *device, u32 event)
>   {
> @@ -1276,6 +1442,38 @@ static void sony_nc_notify(struct acpi_device *device, u32 event)
>   			ev_type = GFX_SWITCH;
>   			real_ev = __sony_nc_gfx_switch_status_get();
>   			break;
> +
> +		case 0x0143:
> +		case 0x014b:
> +		case 0x014c:
> +		case 0x0163:
Could you document what these different events are here?  Would make
it easier to review.
> +			sony_call_snc_handle(handle, 0x2000, &result);
> +			/* event reasons are inverted ? */
> +			real_ev = (result & 0x03) == 1 ? 2 : 1;
> +			dprintk("ALS event received (%s change): 0x%x\n",
> +					real_ev == 1 ?
> +					"light" : "backlight", result);
> +			if (real_ev == 1 &&
> +					als_handle->ops->event_handler)
> +				als_handle->ops->event_handler();
> +
> +			ev_type = ALS;
> +			break;
> +
> +		case 0x012f:
> +		case 0x0137:
> +			sony_call_snc_handle(handle, 0x0800, &result);
> +			real_ev = result & 0x03;
> +			dprintk("ALS event received (%s change): 0x%x\n",
> +					real_ev == 1 ?
> +					"light" : "backlight", result);
> +			if (real_ev == 1 &&
> +					als_handle->ops->event_handler)
> +				als_handle->ops->event_handler();
> +
> +			ev_type = ALS;
> +			break;
> +
>   		default:
>   			dprintk("Unknown event 0x%x for handle 0x%x\n",
>   					event, handle);
> @@ -1378,6 +1576,11 @@ static void sony_nc_function_setup(struct acpi_device *device,
>   				pr_err("couldn't set up GFX Switch status (%d)\n",
>   						result);
>   			break;
> +		case 0x012f:
> +			result = sony_nc_als_setup(device, handle);
> +			if (result)
> +				pr_err("couldn't set up ALS (%d)\n", result);
> +			break;
>   		case 0x0131:
>   			result = sony_nc_highspeed_charging_setup(pf_device);
>   			if (result)
> @@ -1400,6 +1603,10 @@ static void sony_nc_function_setup(struct acpi_device *device,
>   			if (result)
>   				pr_err("couldn't set up keyboard backlight function (%d)\n",
>   						result);
> +			result = sony_nc_als_setup(device, handle);
> +			if (result)
> +				pr_err("couldn't set up ALS (%d)\n", result);
> +
>   			break;
>   		case 0x0121:
>   			result = sony_nc_lowbatt_setup(pf_device);
> @@ -1481,6 +1688,9 @@ static void sony_nc_function_cleanup(struct platform_device *pd)
>   		case 0x015B:
>   			sony_nc_gfx_switch_cleanup(pd);
>   			break;
> +		case 0x012f:
> +			sony_nc_als_cleanup(pd);
> +			break;
>   		case 0x0131:
>   			sony_nc_highspeed_charging_cleanup(pd);
>   			break;
> @@ -1494,6 +1704,7 @@ static void sony_nc_function_cleanup(struct platform_device *pd)
>   		case 0x014c:
>   		case 0x0163:
>   			sony_nc_kbd_backlight_cleanup(pd, handle);
> +			sony_nc_als_cleanup(pd);
>   			break;
>   		case 0x0121:
>   			sony_nc_lowbatt_cleanup(pd);
> @@ -1550,6 +1761,14 @@ static void sony_nc_function_resume(void)
>   		case 0x0135:
>   			sony_nc_rfkill_update();
>   			break;
> +		case 0x012f:
> +		case 0x0137:
> +		case 0x0143:
> +		case 0x014b:
> +		case 0x014c:
> +		case 0x0163:
> +			sony_nc_als_resume();
> +			break;
>   		default:
>   			continue;
>   		}
> @@ -1769,6 +1988,845 @@ static int sony_nc_rfkill_setup(struct acpi_device *device,
>   	return 0;
>   }
>
> +/* ALS */
> +
coding style please :)
/*
  * model
> +/* model specific ALS data and controls
> + * TAOS TSL256x device data
> + */
> +#define LUX_SHIFT_BITS		16	/* for non-floating point math */
> +/* scale 100000 multiplied fractional coefficients rounding the values */
> +#define SCALE(u)	((((((u64) u) << LUX_SHIFT_BITS) / 10000) + 5) / 10)
> +
These are the same register defines as in the tsl2563 driver. Please factor
them out of there into a header then use it. We don't want this repeated in
two different drivers.

> +#define TSL256X_REG_CTRL	0x00
> +#define TSL256X_REG_TIMING	0x01
> +#define TSL256X_REG_TLOW	0x02
> +#define TSL256X_REG_THIGH	0x04
> +#define TSL256X_REG_INT		0x06
> +#define TSL256X_REG_ID		0x0a
> +#define TSL256X_REG_DATA0	0x0c
> +#define TSL256X_REG_DATA1	0x0e
> +
> +#define TSL256X_POWER_ON	0x03
> +#define TSL256X_POWER_OFF	0x00
> +
> +#define TSL256X_POWER_MASK	0x03
> +#define TSL256X_INT_MASK	0x10
> +
> +struct tsl256x_coeff {
> +	u32 ratio;
> +	u32 ch0;
> +	u32 ch1;
> +	u32 ka;
> +	s32 kb;
> +};
> +
> +struct tsl256x_gain_coeff {
> +	u32 time;
> +	u16 min;
> +	u16 max;
> +	u16 scale;
> +};
> +
very similar stuff to this is in the tsl2563 driver.
Any chance of sharing code?
> +struct tsl256x_gain_coeff tsl256x_gain[] = {
> +	{
> +		.time   = 0x12, /* 402 ms, gain x16 */
> +		.min    = 0,
> +		.max    = 65534,
> +		.scale  = 1,
> +	}, {
> +		.time   = 0x02, /* 402 ms, gain x1 */
> +		.min    = 2048,
> +		.max    = 65534,
> +		.scale  = 16,
> +	}, {
> +		.time   = 0x01, /* 101 ms, gain x1 */
> +		.min    = 4095,
> +		.max    = 37176,
> +		.scale  = 64,
> +	}, {
> +		.time   = 0x00, /* 13.7 ms, gain x1 */
> +		.min    = 3000,
> +		.max    = 65535,
> +		.scale  = 468,
> +	},
> +};
> +
> +struct tsl256x_data {
> +	unsigned int periods;
> +	struct tsl256x_gain_coeff const *gain;
> +	u8 defaults[4];
> +	struct tsl256x_coeff const *coeff_table;
> +};
> +static struct tsl256x_data *tsl256x_handle;
I'm against limiting a driver to a single instance on principle
but I guess it doesn't matter here.
> +
> +static const struct tsl256x_coeff tsl256x_coeff_fn[] = {
> +	{
> +		.ratio	= SCALE(12500),	/* 0.125 * 2^LUX_SHIFT_BITS  */
> +		.ch0	= SCALE(3040),	/* 0.0304 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(2720),	/* 0.0272 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(313550000),
> +		.kb	= -10651,
> +	}, {
> +		.ratio	= SCALE(25000),	/* 0.250 * 2^LUX_SHIFT_BITS  */
> +		.ch0	= SCALE(3250),	/* 0.0325 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(4400),	/* 0.0440 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(203390000),
> +		.kb	= -2341,
> +	}, {
> +		.ratio	= SCALE(37500),	/* 0.375 * 2^LUX_SHIFT_BITS  */
> +		.ch0	= SCALE(3510),	/* 0.0351 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(5440),	/* 0.0544 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(152180000),
> +		.kb	= 157,
> +	}, {
> +		.ratio	= SCALE(50000),	/* 0.50 * 2^LUX_SHIFT_BITS   */
> +		.ch0	= SCALE(3810),	/* 0.0381 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(6240),	/* 0.0624 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(163580000),
> +		.kb	= -145,
> +	}, {
> +		.ratio	= SCALE(61000),	/* 0.61 * 2^LUX_SHIFT_BITS   */
> +		.ch0	= SCALE(2240),	/* 0.0224 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(3100),	/* 0.0310 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(180800000),
> +		.kb	= -495,
> +	}, {
> +		.ratio	= SCALE(80000),	/* 0.80 * 2^LUX_SHIFT_BITS   */
> +		.ch0	= SCALE(1280),	/* 0.0128 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(1530),	/* 0.0153 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(197340000),
> +		.kb	= -765
> +	}, {
> +		.ratio	= SCALE(130000),/* 1.3 * 2^LUX_SHIFT_BITS     */
> +		.ch0	= SCALE(146),	/* 0.00146 * 2^LUX_SHIFT_BITS */
> +		.ch1	= SCALE(112),	/* 0.00112 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(182900000),
> +		.kb	= -608,
> +	}, {
> +		.ratio	= UINT_MAX,	/* for higher ratios */
> +		.ch0	= 0,
> +		.ch1	= 0,
> +		.ka	= 0,
> +		.kb	= 830,
> +	}
> +};
>
So what are _fn and _cs?
+
> +static const struct tsl256x_coeff tsl256x_coeff_cs[] = {
> +	{
> +		.ratio  = SCALE(13000),	/* 0.130 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(3150),	/* 0.0315 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(2620),	/* 0.0262 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(300370000),
> +		.kb	= -9587,
> +	}, {
> +		.ratio  = SCALE(26000),	/* 0.260 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(3370),	/* 0.0337 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(4300),	/* 0.0430 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(194270000),
> +		.kb	= -1824,
> +	}, {
> +		.ratio  = SCALE(39000),	/* 0.390 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(3630),	/* 0.0363 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(5290),	/* 0.0529 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(152520000),
> +		.kb	= 145,
> +	}, {
> +		.ratio  = SCALE(52000),	/* 0.520 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(3920),	/* 0.0392 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(6050),	/* 0.0605 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(165960000),
> +		.kb	= -200,
> +	}, {
> +		.ratio  = SCALE(65000),	/* 0.650 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(2290),	/* 0.0229 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(2910),	/* 0.0291 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(184800000),
> +		.kb	= -566,
> +	}, {
> +		.ratio  = SCALE(80000),	/* 0.800 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(1570),	/* 0.0157 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(1800),	/* 0.0180 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(199220000),
> +		.kb	= -791,
> +	}, {
> +		.ratio  = SCALE(130000),/* 0.130 * 2^LUX_SHIFT_BITS  */
> +		.ch0    = SCALE(338),	/* 0.00338 * 2^LUX_SHIFT_BITS */
> +		.ch1    = SCALE(260),	/* 0.00260 * 2^LUX_SHIFT_BITS */
> +		.ka	= SCALE(182900000),
> +		.kb	= -608,
> +	}, {
> +		.ratio  = UINT_MAX,	/* for higher ratios */
> +		.ch0    = 0,
> +		.ch1    = 0,
> +		.ka	= 0,
> +		.kb	= 830,
> +	}
> +};
> +
Hmm. So in this code you are talking directly the underling taos chip?
Interesting.  I wonder if it would be possible with the insertion
of a few callbacks to utilize som of the tsl2563 code directly..

> +/* TAOS helper & control functions */
> +static inline int tsl256x_exec_writebyte(unsigned int reg,
> +						unsigned int const *value)
Why _exec_  Also these are totaly sony specific as far as I can see.
Hence call it.
sony_tsl256x_write_byte or similar.
> +{
> +	unsigned int result;
> +
> +	return (sony_call_snc_handle(als_handle->handle, (*value << 0x18) |
> +		(reg << 0x10) | 0x800500, &result) || !(result & 0x01))
> +		? -EIO : 0;
> +}
> +
Why pass the value as a pointer?  If you are writing it that makes no real
sense.  Just pass a u16. Same for the writebyte above. Will get rid
of quite a few unnecessary lines of code below.
> +static inline int tsl256x_exec_writeword(unsigned int reg,
> +						unsigned int const *value)
> +{
> +	u8 result[1];
> +	int offset = sony_find_snc_handle(als_handle->handle);
> +	u64 arg = (*value << 0x18) | (reg << 0x10) | 0xA00700 | offset;
> +
> +	/* using sony_call_snc_handle_buffer due to possible input overflows */
> +	if (sony_nc_buffer_call(sony_nc_acpi_handle, "SN06", &arg,
> +				result, 1) < 0)
> +		return -EIO;
> +
> +	return result[0] & 0x01;
> +}
> +
> +static inline int tsl256x_exec_readbyte(unsigned int reg, unsigned int *result)
> +{
> +	int arg = (reg << 0x10) | 0x800400;
> +
> +	if (sony_call_snc_handle(als_handle->handle, arg, result) < 0)
> +		return -EIO;
> +
> +	if (!(*result & 0x01))
> +		return -EINVAL;
> +
> +	*result = (*result >> 0x08) & 0xFF;
> +
> +	return 0;
> +}
> +
As you are reading a word, don't use a 32bit + integer.
u16 *result

Then you can avoid the masking below as well.
> +static inline int tsl256x_exec_readword(unsigned int reg, unsigned int *result)
> +{
> +	int arg = (reg << 0x10) | 0xA00600;
> +
> +	if (sony_call_snc_handle(als_handle->handle, arg, result) < 0)
> +		return -EIO;
> +
> +	if (!(*result & 0x01))
> +		return -EINVAL;
> +
> +	*result = (*result >> 0x08) & 0xFFFF;
> +
> +	return 0;
> +}
> +
> +static int tsl256x_interrupt_ctrls(unsigned int *interrupt,
> +					unsigned int *periods)
> +{
> +	unsigned int value, result;
> +
> +	/* if no interrupt parameter, retrieve interrupt status */
> +	if (!interrupt) {
> +		if (tsl256x_exec_readbyte(TSL256X_REG_INT, &result))
> +			return -EIO;
> +
> +		value = (result & TSL256X_INT_MASK);
> +	} else {
> +		value = *interrupt << 0x04;
> +	}
> +
> +	/* if no periods provided use the last one set */
If none provided, do you need to set it at all? If you do then the comment
should make this clear.
> +	value |= (periods ? *periods : tsl256x_handle->periods);
> +
> +	if (tsl256x_exec_writebyte(TSL256X_REG_INT, &value))
Read the return values of the exec_writebyte and return that. I know
here it is the same, but it will leave use with a more obviously correct
driver which will be easier to maintain in the long run.
> +		return -EIO;
> +
> +	if (periods)
> +		tsl256x_handle->periods = *periods;
> +
> +	return 0;
> +}
> +
> +static int tsl256x_setup(void)
> +{
> +	unsigned int interr = 1, zero = 0;
> +
Style again.
> +	/* reset the threshold settings to trigger an event as soon as the event
> +	 * goes on, forcing a backlight adaptation to the current lighting
> +	 * conditions
> +	 */
> +	tsl256x_exec_writeword(TSL256X_REG_TLOW, &zero);
> +	tsl256x_exec_writeword(TSL256X_REG_THIGH, &zero);
Here is a fine illustration of why passing a pointer into a write function
for the value is not a clean way of doing it.  Also, two possible errors
here that aren't handled.  Check for all such cases and make sure you have
handled them.
> +
> +	/* set gain and time */
> +	if (tsl256x_exec_writebyte(TSL256X_REG_TIMING,
> +				&tsl256x_handle->gain->time))
> +		return -EIO;
> +
> +	/* restore persistence value and enable the interrupt generation */
> +	if (tsl256x_interrupt_ctrls(&interr, &tsl256x_handle->periods))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int tsl256x_set_power(unsigned int status)
> +{
> +	int ret;
> +
> +	if (status) {
> +		ret = tsl256x_setup();
> +		if (ret)
> +			return ret;
> +	}
> +
> +	status = status ? TSL256X_POWER_ON : TSL256X_POWER_OFF;
> +	ret = tsl256x_exec_writebyte(TSL256X_REG_CTRL, &status);
return directly
e.g.
if (status)
	return sony_tsl256x_write_byte(TSL2563_REG_CTRL, TSL256X_POWER_ON);
else
	return sony_tsl256x_write_byte(TSL2563_REG_CTRL, TSL256X_POWER_OFF);
Or even better reorganise the function to only check status once.
> +
> +	return ret;
> +}
> +
Cleaner not to bother with this function and just read the channels
directly where they are wanted via the readword calls.  It doesn't
add much to readability etc.
> +static int tsl256x_get_raw_data(unsigned int *ch0, unsigned int *ch1)
> +{
> +	if (!ch0)
> +		return -EINVAL;
> +
> +	if (tsl256x_exec_readword(TSL256X_REG_DATA0, ch0))
> +		return -EIO;
> +
> +	if (ch1) {
> +		if (tsl256x_exec_readword(TSL256X_REG_DATA1, ch1))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tsl256x_set_thresholds(const unsigned int *ch0)
> +{
> +	unsigned int tlow, thigh;
> +
> +	tlow = (*ch0 * tsl256x_handle->defaults[0]) / 100;
> +	thigh = ((*ch0 * tsl256x_handle->defaults[1]) / 100) + 1;
> +
> +	if (thigh > 0xffff)
> +		thigh = 0xffff;
> +
> +	if (tsl256x_exec_writeword(TSL256X_REG_TLOW, &tlow) ||
> +		tsl256x_exec_writeword(TSL256X_REG_THIGH, &thigh))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
Prefix this appropriately. SONY_LAPTOP_TSL256X_MAX_LUX or similar.
> +#define MAX_LUX 700000
I'd like to know how this differs form the function in tsl2563.c...

This takes a few more things into account perhaps, but they are fundamentally
the same and we should only have one...
> +static unsigned int tsl256x_calculate_lux(const u32 ch0, const u32 ch1)
> +{
> +	/* the raw output from the sensor is just a "count" value, as it is the
> +	 * result of the integration of the analog sensor signal, the
> +	 * counts-to-lux curve (and its approximation can be found on the
> +	 * datasheet).
> +	 */
> +	const struct tsl256x_coeff *coeff = tsl256x_handle->coeff_table;
> +	u32 ratio, temp, integer;
> +
> +	if (ch0 >= 65535 || ch1 >= 65535)
> +		return MAX_LUX;
> +
> +	/* STEP 1: ratio calculation, for ch0 & ch1 coeff selection */
> +
> +	/* protect against division by 0 */
> +	ratio = ch0 ? ((ch1 << (LUX_SHIFT_BITS + 1)) / ch0) : UINT_MAX - 1;
> +	/* round the ratio value */
> +	ratio = (ratio + 1) >> 1;
> +
> +	/* coeff selection rule */
> +	while (coeff->ratio < ratio)
> +		coeff++;
> +
> +	/* STEP 2: lux calculation formula using the right coeffcients */
> +	temp = (ch0 * coeff->ch0) - (ch1 * coeff->ch1);
> +	temp *= tsl256x_handle->gain->scale;
> +	/* the sensor is placed under a plastic or glass cover which filters
> +	 * a certain ammount of light (depending on that particular material).
> +	 * To have an accurate reading, we need to compensate for this loss,
> +	 * multiplying for compensation parameter, taken from the DSDT.
> +	 */
> +	temp *= tsl256x_handle->defaults[3] / 10;
> +
> +	/* round fractional portion to obtain the integer part */
> +	integer = (temp + (1 << (LUX_SHIFT_BITS - 1))) >> LUX_SHIFT_BITS;
> +
> +	if (integer > MAX_LUX)
> +		return MAX_LUX;
> +
> +	return integer;
> +}
> +
This is new for a tsl256x chip..  Hmm. approximate temperature form the
infrared channel?  How accurate is it? (just currious as I wouldn't have
through these were really suitable for use as thermopiles)

Why pass in ch1 if you aren't going to use it?
> +static void tsl256x_calculate_kelvin(const u32 *ch0, const u32 *ch1,
> +					unsigned int *temperature)
> +{
> +	const struct tsl256x_coeff *coeff = tsl256x_handle->coeff_table;
> +	u32 ratio;
> +
> +	/* protect against division by 0 */
> +	ratio = *ch0 ? ((*ch1 << (LUX_SHIFT_BITS + 1)) / *ch0) : UINT_MAX - 1;
> +	/* round the ratio value */
> +	ratio = (ratio + 1) >> 1;
> +
> +	/* coeff selection rule */
> +	while (coeff->ratio < ratio)
> +		coeff++;
> +
> +	*temperature = ratio ? coeff->ka / ratio + coeff->kb : 0;
> +}
> +
integ?  Why that variable name?
> +static int tsl256x_get_lux(unsigned int *integ)
> +{
> +	int ret = 0;
> +	unsigned int ch0, ch1;
> +
> +	if (!integ)
> +		return -1;
> +
> +	ret = tsl256x_get_raw_data(&ch0, &ch1);
> +	if (!ret)
Flip this and exit out wiht an error.  Thats a far more common
kernel code ideom and when writing this sort of code you want
to do what people expect...
e.g.
if (ret)
    return ret;
*integ =
> +		*integ = tsl256x_calculate_lux(ch0, ch1);
> +
> +	return ret;
> +}
> +
> +static int tsl256x_get_kelvin(unsigned int *temperature)
> +{
> +	int ret = -1;
> +	unsigned int ch0, ch1;
> +
> +	if (!temperature)
> +		return ret;
> +
> +	ret = tsl256x_get_raw_data(&ch0, &ch1);
> +	if (!ret)
> +		tsl256x_calculate_kelvin(&ch0, &ch1, temperature);
> +
> +	return ret;
> +}
> +
> +static int tsl256x_get_id(void)
> +{
> +	int id, ret;
> +	unsigned int result;
> +	char *name = NULL;
> +
> +	ret = tsl256x_exec_readbyte(TSL256X_REG_ID, &result);
> +	if (ret)
> +		return ret;
> +
> +	id = (result >> 0x04) & 0x0F;
> +	switch (id) {
> +	case 11:
> +		name = "TAOS TSL2569";
Hmm. Didn't know this part existed.  I wonder if the existing tsl2563 will
work with it out of the box.  Guess I'll have to read the datasheet at
some point.
> +		break;
> +	case 5:
> +		name = "TAOS TSL2561";
> +		break;
> +	case 3:
> +		name = "TAOS TSL2563";
> +		break;
> +	case 0:
> +		name = "TAOS TSL2560CS";
> +		break;
> +	default:
> +		pr_warn("unsupported ALS model %u rev%u\n", id, result & 0x0F);
> +		return -ENXIO;
> +	}
> +
> +	pr_info("ALS model %u rev%u (%s)\n", id, result & 0x0F, name);
> +	return id;
> +}
> +
> +static int tsl256x_event_handler(void)
> +{
> +	unsigned int ch0, scale, interr = 1;
> +
> +	/* clear the notification */
> +	sony_call_snc_handle(als_handle->handle, 0x04C60500, &interr);
> +
> +	/* read the raw data */
> +	tsl256x_get_raw_data(&ch0, NULL);
> +
> +	scale = tsl256x_handle->gain->scale;
> +	if (ch0 < tsl256x_handle->gain->min)
> +		tsl256x_handle->gain--;
> +	else if (ch0 > tsl256x_handle->gain->max)
> +		tsl256x_handle->gain++;
> +
> +	if (tsl256x_handle->gain->scale != scale) {
> +		ch0 *= scale;
> +		ch0 /= tsl256x_handle->gain->scale;
> +		tsl256x_exec_writebyte(TSL256X_REG_TIMING,
> +				&tsl256x_handle->gain->time);
> +	}
> +
> +	/* set the thresholds */
> +	tsl256x_set_thresholds(&ch0);
> +
> +	/* enable interrupt */
> +	tsl256x_interrupt_ctrls(&interr, NULL);
> +
You are pushing events without any direct control interface for them...
> +	iio_push_event(als_handle->indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +					    0,
> +					    IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_EITHER),
> +		       iio_get_time_ns());
> +	return 0;
> +}
> +
> +static int tsl256x_init(const u8 defaults[])
> +{
> +	int id = tsl256x_get_id();
> +	if (id < 0)
> +		return id;
> +
> +	tsl256x_handle = kzalloc(sizeof(struct tsl256x_data), GFP_KERNEL);
> +	if (!tsl256x_handle)
> +		return -ENOMEM;
> +
> +	/* populate the device data */
*laughs*  Not remotely inituitive.  This needs an enum for each of the
two defaults registers..
> +	tsl256x_handle->defaults[0] = defaults[3];  /* low threshold % */
> +	tsl256x_handle->defaults[1] = defaults[4];  /* high threshold % */
> +	tsl256x_handle->defaults[2] = defaults[9];  /* sensor interrupt rate */
> +	tsl256x_handle->defaults[3] = defaults[10]; /* light compensat. rate */
> +	tsl256x_handle->gain = tsl256x_gain;
> +	tsl256x_handle->periods = defaults[9];
> +	tsl256x_handle->coeff_table = id == 0 ?
> +		tsl256x_coeff_cs : tsl256x_coeff_fn;
> +
> +	return 0;
> +}
> +
> +static int tsl256x_exit(void)
> +{
> +	unsigned int interr = 0, periods = tsl256x_handle->defaults[2];
> +
> +	/* disable the interrupt generation, restore defaults */
> +	tsl256x_interrupt_ctrls(&interr, &periods);
> +
> +	tsl256x_handle->coeff_table = NULL;
> +	kfree(tsl256x_handle);
> +
> +	return 0;
> +}
> +
> +/* TAOS TSL256x specific ops */
> +static const struct als_device_ops tsl256x_ops = {
> +	.init = tsl256x_init,
> +	.exit = tsl256x_exit,
> +	.event_handler = tsl256x_event_handler,
> +	.set_power = tsl256x_set_power,
> +	.get_lux = tsl256x_get_lux,
> +	.get_kelvin = tsl256x_get_kelvin,
> +};
> +
So down to here you have some sony specific read access to a device
we already have support for.... See introduction to this review.

Now this looks more interesting...

> +/* unknown ALS sensors controlled by the EC present on newer Vaios */
> +static int ngals_get_lux(unsigned int *integ)
> +{
> +	unsigned int data;
> +
> +	/* Event needs to be rearmed */
> +	if (sony_call_snc_handle(als_handle->handle, 0x12200, &data))
> +		return -EIO;
> +	/* read raw data */
> +	if (sony_call_snc_handle(als_handle->handle, 0x1000, &data))
> +		return -EIO;
> +
> +	/* if we have a valid lux data */
> +	if (!!(data & 0xff0000) == 0x01)
Its late and I need more coffee but...
if (data & 0ff00000) gives the same result...
> +		*integ = 0xffff & data;
> +	else
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int ngals_event_handler(void)
> +{
> +	unsigned int unused;
> +
Again, you are pushing without there being any sysfs elements to control them..
With those missing there is no way for userspace to know that the device
might spit out events, or what they might be...

> +	iio_push_event(als_handle->indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +					    0,
> +					    IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_EITHER),
> +		       iio_get_time_ns());
> +
> +	/* Event needs to be rearmed */
> +	if (sony_call_snc_handle(als_handle->handle, 0x12200, &unused))
> +		return -EIO;
> +	if (sony_call_snc_handle(als_handle->handle, 0x1000, &unused))
> +		return -EIO;
> +
> +
> +	return 0;
> +}
> +
> +static const struct als_device_ops ngals_ops = {
> +	.init = NULL,
> +	.exit = NULL,
> +	.event_handler = ngals_event_handler,
> +	.set_power = NULL,
> +	.get_lux = ngals_get_lux,
> +	.get_kelvin = NULL,
> +};
> +
> +static int __sony_nc_als_power_set(unsigned int status)
> +{
> +	unsigned int cmd, result;
> +
> +	if (als_handle->ops->set_power) {
> +		if (als_handle->ops->set_power(status))
> +			return -EIO;
> +	}
> +

> +	/*  turn on/off the event notification */
If so then then this is what should be controllable from userspace...
via the event_info elements in iio.
There are a lot of magic addresses in here. If they are known then
they should be replaced by appropriately informative #defined names.
> +	cmd = als_handle->handle < 0x0143 ? 0x0901 : 0x2200;
> +
> +	if (sony_call_snc_handle(als_handle->handle,
> +				(status << 0x10) | cmd, &result))
> +		return -EIO;
> +
> +	if (sony_call_snc_handle(als_handle->handle, 0x1000, &result))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/* ALS sys interface */
Naming of this vs next function is confusing.. Call it
sony_nc_als_array_show or similar (or just name it after the backlight
and be done with it)
> +static ssize_t sony_nc_als_parameters_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer)
> +{
> +	ssize_t count = 0;
> +	unsigned int i, num;
> +	u8 *list;
> +
This definitely needs documenting..
> +	/* backlight_sensibility_table */
> +	list = als_handle->levels;
> +	num = als_handle->levels_num;
> +
> +	for (i = 0; i < num; i++)
> +		count += snprintf(buffer + count, PAGE_SIZE - count,
> +				"%u ", list[i]);
> +
> +	count += snprintf(buffer + count, PAGE_SIZE - count, "\n");
> +
> +	return count;
> +}
> +
> +static ssize_t sony_nc_als_param_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer)
> +{
> +	ssize_t count = 0;
> +	unsigned int i;
> +	int offset;
> +
> +	for (i = 0; als_handle->als_params[i].name; i++)
> +		if (!strcmp(attr->attr.name, als_handle->als_params[i].name))
> +			break;
> +
> +	/* first 2 elements of the array are 2 bytes values */
> +	offset = als_handle->als_params[i].offset;
> +	if (i < 2)
> +		count = snprintf(buffer, PAGE_SIZE, "%u\n",
use a shift instead of *256 (usual thing about what people expect rather than
anything else. Might also need a typecast to avoid ti occuring entirely
in a u8 value (which obviously won't work).
> +				als_handle->defaults[offset]
> +				+ 256 * als_handle->defaults[offset + 1]);
> +	else if (als_handle->als_params[i].name)
> +		count = snprintf(buffer, PAGE_SIZE, "%u\n",
> +				als_handle->defaults[offset]);
> +
> +	return count;
> +}
> +
I'd argue this is just a temperature reading and hence should be done
via a temperature channel. Irritatingly they are in celcius, but
the conversion is at least nice and easy ;)
> +static ssize_t sony_nc_als_kelvin_show(struct device *dev,
> +		struct device_attribute *attr, char *buffer)
> +{
> +	ssize_t count = 0;
> +	unsigned int kelvin = 0;
> +
> +	if (als_handle->ops->get_kelvin)
> +		als_handle->ops->get_kelvin(&kelvin);
> +
> +	count = snprintf(buffer, PAGE_SIZE, "%d\n", kelvin);
> +
> +	return count;
> +}
> +
> +
> +/* ALS attach/detach functions */
> +static void sony_nc_als_resume(void)
> +{
> +	__sony_nc_als_power_set(1);
> +}
> +
> +static int sony_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	struct als_device *als_handle = iio_priv(indio_dev);
> +
> +	if (als_handle->ops->get_lux(val))
> +		return -EINVAL;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info sony_info = {
> +	.attrs			= &als_attr_group,
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= &sony_read_raw,
> +};
> +
> +static const struct iio_event_spec sony_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER
Would expect some control stuff in here as well...
> +	}
> +};
> +
> +static const struct iio_chan_spec sony_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.channel = 0,
> +		.event_spec = sony_events,
> +		.num_event_specs = ARRAY_SIZE(sony_events)
> +	}
> +};
> +
> +static int sony_nc_als_setup(struct acpi_device *dev, unsigned int handle)
> +{
> +	struct iio_dev *indio_dev;
> +	int result = 0;
> +	u64 arg;
> +
> +	if (!enable_als)
> +		return 0;
> +
> +	indio_dev = devm_iio_device_alloc(&dev->dev, sizeof(struct als_device));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	als_handle = iio_priv(indio_dev);
> +	als_handle->indio_dev = indio_dev;
> +	als_handle->handle = handle;
> +
> +	/* model specific data */
> +	switch (handle) {
> +	case 0x0143:
> +	case 0x014b:
> +	case 0x014c:
> +	case 0x0163:
> +		/* check the device presence */
> +		if (sony_call_snc_handle(handle, 0x100, &result)) {
> +			result = -EIO;
> +			goto nosensor;
> +		}
> +
> +		if (!(result & 0x02))
> +			/* no ALS controls */
> +			goto nosensor;
> +
> +		als_handle->ops = &ngals_ops;
> +		als_handle->levels_num = 16;
> +		/* There're 101 additional values. What do we do with them? */
> +		als_handle->als_params = ngals_params;
> +		als_attr_group.attrs = ngals_attributes;
> +		break;
> +
> +	case 0x0137:
> +		/* check the device presence */
> +		if (sony_call_snc_handle(handle, 0xB00, &result)) {
> +			result = -EIO;
> +			goto nosensor;
> +		}
> +
> +		if (!(result & 0x01))
> +			/* no ALS controls */
> +			goto nosensor;
> +		/* fall through */
> +
> +	case 0x012f:
> +		als_handle->ops = &tsl256x_ops;
> +		als_handle->levels_num = 9;
> +		als_handle->als_params = als_params;
> +		als_attr_group.attrs = als_attributes;
> +		break;
> +
> +	default:
> +		result = -EINVAL;
> +		goto nosensor;
> +	}
> +
> +
> +	/* backlight levels are the first levels_num values, the remaining
> +	 * values are default settings for als regulation
> +	 */
> +	als_handle->levels = als_handle->parameters;
> +	als_handle->defaults = als_handle->parameters + als_handle->levels_num;
> +
> +	/* get ALS parameters */
> +	arg = sony_find_snc_handle(handle);
> +	if (sony_nc_buffer_call(sony_nc_acpi_handle, "SN06", &arg,
> +		als_handle->parameters, ALS_TABLE_SIZE) < 0)
> +		goto nosensor;
> +
> +	/* initial device configuration */
> +	if (als_handle->ops->init) {
> +		result = als_handle->ops->init(als_handle->defaults);
> +		if (result)
> +			goto nosensor;
> +	}
> +
> +	indio_dev->dev.parent = &dev->dev;
> +	indio_dev->channels = sony_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sony_channels);
> +	indio_dev->name = "sony-laptop";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &sony_info;
> +
> +	result = iio_device_register(indio_dev);
> +	if (result < 0)
> +		goto nosensor;
> +
> +	/* set power state */
> +	if (__sony_nc_als_power_set(1))
> +		pr_warn("unable to set the power status\n");
> +
> +	return 0;
> +
> +nosensor:
> +	iio_device_free(indio_dev);
> +	als_handle = NULL;
> +
> +	return result;
> +}
> +
> +static void sony_nc_als_cleanup(struct platform_device *pd)
> +{
> +	if (als_handle) {
> +		if (__sony_nc_als_power_set(0))
> +			pr_info("ALS power off failed\n");
> +
> +		if (als_handle->ops->exit)
> +			if (als_handle->ops->exit())
> +				pr_info("ALS device clean-up failed\n");
> +
> +		iio_device_unregister(als_handle->indio_dev);
Either drop the free or don't use a devm allocation.  You don't
want one in the probe error path either.

> +		iio_device_free(als_handle->indio_dev);
> +		als_handle = NULL;
> +	}
> +}
> +/* end ALS code */
> +
>   /* Keyboard backlight feature */
>   struct kbd_backlight {
>   	unsigned int handle;
> @@ -3058,6 +4116,7 @@ static void sony_nc_backlight_ng_read_limits(int handle,
>   	case 0x143:
>   	case 0x14b:
>   	case 0x14c:
> +	case 0x163:
>   		lvl_table_len = 16;
>   		break;
>   	}
> @@ -3086,11 +4145,30 @@ static void sony_nc_backlight_ng_read_limits(int handle,
>
>   static void sony_nc_backlight_setup(void)
>   {
> +	acpi_handle unused;
>   	int max_brightness = 0;
>   	const struct backlight_ops *ops = NULL;
>   	struct backlight_properties props;
> +	int acpi_video_support = acpi_video_backlight_support();
> +
> +	/* backlight control behaves differently when ALS is enabled.
> +	 * 1. if the acpi backlight device is not registered we lose brightness
> +	 *    key press events (Fn+F[56])
> +	 * 2. when the acpi backlight device is registered, changing brightness
> +	 *    through that doesn't have any effect other than sending a
> +	 *    notification to SNC: Notify (\_SB.PCI0.LPCB.SNC, 0x93)
> +	 *    In this case we SNC is supposed to react and set the new
> +	 *    brightness but the brightness value set via _BCM is stored outside
> +	 *    SNC scope.
> +	 * We allow registering our "sony" backlight device even if acpi is
> +	 * preferred and we set it up to receive notifications upon which we act
> +	 * scaling _BCM's values to SNC's.
> +	 */
> +	if (!als_handle && acpi_video_support) {
> +		pr_info("brightness ignored, must be controlled by ACPI video driver\n");
> +		return;
>
> -	if (sony_find_snc_handle(0x12f) >= 0) {
> +	} else if (sony_find_snc_handle(0x12f) >= 0) {
>   		ops = &sony_backlight_ng_ops;
>   		sony_bl_props.cmd_base = 0x0100;
>   		sony_nc_backlight_ng_read_limits(0x12f, &sony_bl_props);
> @@ -3120,7 +4198,15 @@ static void sony_nc_backlight_setup(void)
>   		sony_nc_backlight_ng_read_limits(0x14c, &sony_bl_props);
>   		max_brightness = sony_bl_props.maxlvl - sony_bl_props.offset;
>
> -	} else if (acpi_has_method(sony_nc_acpi_handle, "GBRT")) {
> +	} else if (sony_find_snc_handle(0x163) >= 0) {
> +		ops = &sony_backlight_ng_ops;
> +		sony_bl_props.cmd_base = 0x3000;
> +		sony_nc_backlight_ng_read_limits(0x163, &sony_bl_props);
> +		max_brightness = sony_bl_props.maxlvl - sony_bl_props.offset;
> +
> +	/* legacy */
> +	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
> +						&unused))) {
>   		ops = &sony_backlight_ops;
>   		max_brightness = SONY_MAX_BRIGHTNESS - 1;
>
> @@ -3205,12 +4291,7 @@ static int sony_nc_add(struct acpi_device *device)
>   			sony_nc_function_setup(device, sony_pf_device);
>   	}
>
> -	/* setup input devices and helper fifo */
> -	if (acpi_video_backlight_support()) {
> -		pr_info("brightness ignored, must be controlled by ACPI video driver\n");
> -	} else {
> -		sony_nc_backlight_setup();
> -	}
> +	sony_nc_backlight_setup();
>
>   	/* create sony_pf sysfs attributes related to the SNC device */
>   	for (item = sony_nc_values; item->name; ++item) {
>

