Return-Path: <leonard.crestez@intel.com>
Subject: Re: [RFC] iio: Add driver for Silabs si1132, si1141/2/3 and
 si1145/6/7 ambient light, uv index and proximity sensors
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <38c1e53954ca5e869b7b433c0718dbc49e1aad28.1463679547.git.leonard.crestez@intel.com>
 <1463695165-6256-1-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <ab26a565-6176-93da-b33a-ab5aaf225ffb@intel.com>
Date: Tue, 24 May 2016 20:51:51 +0300
MIME-Version: 1.0
In-Reply-To: <1463695165-6256-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/20/2016 12:59 AM, Peter Meerwald-Stadler wrote:
> From: Peter Meerwald <pmeerw@pmeerw.net>
> 
> The si114x supports x=1,2,3 IR LEDs for proximity sensing together with
> visible and IR ambient light sensing (ALS).
> 
> Newer parts (si1132, si1145/6/7) can measure UV light and compute an UV index
> 
> Arranging 3 IR LEDs in a triangular shape can be used for detection of swipe
> gestures (the present driver only measures the intensities, it does not process
> the data); there is an affordable reference design (via Digikey), see
> http://www.silabs.com/products/sensors/Pages/HID-USB-to-IR-Reference-Design.aspx
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
> This is the code I am currently working on, partly tested. I've stripped some
> features from earlier versions and added support for newer chips.
> I hope this is useful to Crestez Dan Leonard. I'm happy to review stuff
> as the code gets forged into shape and appreciate any testing.

This driver seems to have a somewhat divergent set of features compared
to the older one I found:
* https://www.spinics.net/lists/linux-iio/msg06468.html

Notable differences:
- si114x only support 41/42/43
- si114x supports dataready irqs and putting the device in "auto" mode.
- si114x supports controlling sampling frequency (which only makes sense
with irq support)
- si114x has sysfs entries for controlling normal/high signal range.
- si114x exposes parameter ram via debugfs
- si114x exposes HARDWAREGAIN instead of SCALE. The latter seems better
anyway.
- Driver id is different

There seems to be a driver based on your old si114x in the chromiumos
tree but I don't think it's used much. Still it makes me think if it's
worth using si114x as the name in the interest of devicetree binding
compatibility.

I also looked through the code and found some small issues (mentioned
inline). I guess I should fix them, add support for interrupts and post
it for inclusion again, right?

I have both a si1143 and a si1145 I can test on.

Another issue is that there is no support for "illuminance" in lux.
Datasheet recommends determining this on the based on some interpolation
of ALSVIS an ALSIR. I guess it would be possible to cobble something
together based on the sensitivities mentioned in the datasheet but I'd
rather not attempt this.

> +++ b/drivers/iio/light/si1145.c
> @@ -0,0 +1,855 @@
> +/*
> + * Helper function to operate on parameter values: op can be query or set
> + * Function returns (modified) value and needs locking
> + */
> +static int __si1145_param(struct si1145_data *data, u8 op, u8 param, u8 value)
> +{
> +	int ret;
> +
> +	if (op != SI1145_CMD_PARAM_QUERY) {
> +		ret = i2c_smbus_write_byte_data(data->client,
> +			SI1145_REG_PARAM_WR, value);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, SI1145_REG_COMMAND,
> +		op | (param & 0x1F));
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_read_byte_data(data->client, SI1145_REG_PARAM_RD);

What is the point of reading back the value that was just read? It would
be faster to avoid this when doing a PARAM_SET command. Better yet
si1145_param_query and si1145_param_set should be distinct functions.

The datasheet recommends always checking the 'response' register after
every command but this doesn't seem to be implemented anywhere.

> +static irqreturn_t si1145_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct si1145_data *data = iio_priv(indio_dev);
> +	/*
> +	 * Maximum buffer size:
> +	 *   6*2 bytes channels data + 4 bytes alignment +
> +	 *   8 bytes timestamp
> +	 */
> +	u8 buffer[24];
> +	int i, j = 0;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +		SI1145_REG_COMMAND, SI1145_CMD_PSALS_FORCE);
> +	if (ret < 0)
> +		goto done;
> +	msleep(10);

I guess this means only software triggers are supported, and at a
relatively low frequency?

> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		int run = 1;
> +
> +		while (i + run < indio_dev->masklength) {
> +			if (test_bit(i + run, indio_dev->active_scan_mask))
> +				run++;

Doesn't this assume that channels with consecutive scan indices will
have consecutive addresses as well? Looking at channel definitions that
doesn't seem to be always true. It is false for AUX channels on devices
with less than 3 proximity channels.

> +static int si1145_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	return si1145_set_chlist(indio_dev, *indio_dev->active_scan_mask);

The si1145_set_chlist function can return a positive value on success
but iio interprets any non-zero result from buffer_ops.preenable as an
error.

-- 
Regards,
Leonard
