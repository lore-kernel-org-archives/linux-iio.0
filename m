Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39464 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbaHGQ67 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 12:58:59 -0400
Message-ID: <53E3B051.4080705@kernel.org>
Date: Thu, 07 Aug 2014 17:58:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <53E34E60.80507@kernel.org> <20140807142829.GA24581@saruman.home> <53E3A8B4.70805@kernel.org> <20140807163509.GA29964@saruman.home>
In-Reply-To: <20140807163509.GA29964@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/08/14 17:35, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 07, 2014 at 05:26:28PM +0100, Jonathan Cameron wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 07/08/14 15:28, Felipe Balbi wrote:
>>> Hi,
>>> 
>>> On Thu, Aug 07, 2014 at 11:01:04AM +0100, Jonathan Cameron wrote:
>>>> On 06/08/14 17:10, Felipe Balbi wrote:
>>>>> TI's opt3001 light sensor is a simple and yet powerful little device. The device provides 99% IR rejection,
>>>>>  Automatic full-scale, very low power consumption and measurements from 0.01 to 83k lux.
>>>>> 
>>>>> This patch adds support for that device using the IIO framework.
>>>>> 
>>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> I don't suppose there is a datasheet available?
>>> 
>>> There is a summary datasheet available. The device isn't released yet:
>>> 
>>> http://www.ti.com/product/OPT3001?keyMatch=opt3001&tisearch=Search-EN
>>> 
>> Ah well...  Not much on that ;)
> 
> yeah, when the thing is released the full datasheet will be available, I'm sure. Until then, you'd have to sign an
> NDA with TI to get the full datasheet, I'm afraid :-s
> 
>>>>> Also, there are a couple details about this device which I need to know if it looks for you:
>>>>> 
>>>>> This device has a single enable bit which will enable both rising and falling edge triggers, but the limits
>>>>> are separate.
>>>>> 
>>>>> The same limits are also used for hysteresis-style capture and that's controlled by a single bit flip.
>>>> With this on, it generates an event whenever the value changes by more than a certain amount?  If so this is 
>>>> better handled by providing a trigger and a buffer.  Note that the events path carries no data other than an 
>>>> event code.
>>> 
>>> It's still a bit weird to me. So, without Latch bit, then yeah, it'll be more of a trigger e.g:
>> IIO triggers are actually more similar to those you find in video systems than the osciloscope type triggers you
>> are perhaps thinking of. They cause a 'scan' of data to be captured every time the fire.
>> 
>> A 'scope trigger would cause a set of data to be captured everytime it first (e.g. multiple scans of the
>> available channels).  We have talked a few times about adding this option, but it hasn't happened yet...
> 
> ok
> 
>>> I can set low limit to 200 lux and high limit to 50 lux, then I'll get a rising edge IRQ when I have more than
>>> 50 lux and a falling edge when I get less than 200 lux.
>>> 
>>> If Latch bit is set, however, then it's almost like it ignores low/high limit altogether and I get an IRQ ever 
>>> $int_time ms or so.
>> That would be similar to the motion triggers we have for accelerometers. They capture every sample as long as the
>> threshold is met (during motion). No idea why you'd really want to do that on a light sensor though.  Perhaps not
>> worth capturing light info if the cover is closed on a phone?
> 
> Yeah, but that's something else altogether. This device doesn't really care about a phone cover. Sounds like policy
> which should be in userland, or part of an iio_gpio_trigger...
Agreed.  Can you think of a use for the non latched version? :)
> 
>>>>> How do you want this to look on sysfs ? Currently, enable/disabling any of rising/falling edges, will
>>>>> disable both.
>>>> That's pretty common.  The ABI basically allows for any setting to change any other (as there are much
>>>> weirder connections than this in some devices).
>>> 
>>> ok, so it's alright to have two "enable" files and have they refer to the same bit ?
>> Absolutely.  Depending on the combinations it is sometimes possible to construct an 'EITHER' enable file - for
>> example driver/iio/adc/xilinix-xadc-core.c
> 
> will read
> 
>>>>> +		thresh_mantissa = &opt->high_thresh_mantissa; +		thresh_exp = &opt->high_thresh_exp; +		break; +	case 
>>>>> IIO_EV_DIR_FALLING: +		reg = OPT3001_LOW_LIMIT; +		thresh_mantissa = &opt->low_thresh_mantissa; +
>>>>> thresh_exp = &opt->low_thresh_exp; +		break; +	default: +		ret = -EINVAL; +		goto err; +	} + +	ret =
>>>>> opt3001_find_scale(opt, val, val2, &exponent); +	if (ret < 0) { +		dev_err(opt->dev, "can't find scale for
>>>>> %d.%d\n", val, val2); + goto err; +	} + +	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent; +
>>>>> value = exponent << 12 | mantissa; +	ret = opt3001_write(opt, reg, value); +	if (ret < 0) { +
>>>>> dev_err(opt->dev, "failed to read register %02x\n", reg); +		goto err; +	} +
>>>> As stated above an additional switch statement here with direct assignment of the relevant threshold values
>>>> would be clearer.
>>>>> +	*thresh_mantissa = mantissa; +	*thresh_exp = exponent; + +err: +	mutex_unlock(&opt->lock); + +	return
>>>>> ret; +} + +static int opt3001_read_event_config(struct iio_dev *iio, +		const struct iio_chan_spec *chan,
>>>>> enum iio_event_type type, +		enum iio_event_direction dir) +{ +	struct opt3001 *opt = iio_priv(iio); + +
>>>>> return opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS; +} + +static int opt3001_write_event_config(struct
>>>>> iio_dev *iio, +		const struct iio_chan_spec *chan, enum iio_event_type type, +		enum iio_event_direction
>>>>> dir, int state) +{ +	struct opt3001 *opt = iio_priv(iio); +	int ret; +	u16 mode; +	u16 reg; + +	if (state
>>>>> && opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS) +		return 0; + +	if (!state && opt->mode == 
>>>>> OPT3001_CONFIGURATION_M_SHUTDOWN) +		return 0; + +	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS +		: 
>>>>> OPT3001_CONFIGURATION_M_SHUTDOWN; + +	ret = opt3001_read(opt, OPT3001_CONFIGURATION); +	if (ret < 0) { + 
>>>>> dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_CONFIGURATION); +		return ret; +	} + +	reg
>>>>> = ret; +	opt3001_set_mode(opt, &reg, mode); + +	if (opt->hysteresis) +		reg |= OPT3001_CONFIGURATION_L; +
>>>>> else + reg &= ~OPT3001_CONFIGURATION_L; + +	ret = opt3001_write(opt, OPT3001_CONFIGURATION, reg); +	if (ret
>>>>> < 0) { + dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_CONFIGURATION); +		return ret; +
>>>>> } + +	/* wait for mode change to go through */ +	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
>>>>> + +	return 0; +} + +static const struct iio_info opt3001_info = { +	.driver_module = THIS_MODULE, +	.attrs
>>>>> = &opt3001_attribute_group, +	.read_raw = opt3001_read_raw, +	.write_raw = opt3001_write_raw, +
>>>>> .read_event_value = opt3001_read_event_value, +	.write_event_value = opt3001_write_event_value, +
>>>>> .read_event_config = opt3001_read_event_config, +	.write_event_config = opt3001_write_event_config, +}; +
>>>>> +static int opt3001_read_id(struct opt3001 *opt) +{ +	char manufacturer[2]; +	u16 device_id; +	int ret; + +
>>>>> ret = opt3001_read(opt, OPT3001_MANUFACTURER_ID); +	if (ret < 0) { +		dev_err(opt->dev, "failed to read
>>>>> register %02x\n", +				OPT3001_MANUFACTURER_ID); +		return ret; +	} + +	manufacturer[0] = ret >> 8; +
>>>>> manufacturer[1] = ret & 0xff; + +	ret = opt3001_read(opt, OPT3001_DEVICE_ID); +	if (ret < 0) { +
>>>>> dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_DEVICE_ID); +		return ret; +	} + +
>>>>> device_id = ret; + +	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0], +			manufacturer[1],
>>>>> device_id); + +	return 0; +} + +static int opt3001_configure(struct opt3001 *opt) +{ +	int ret; +	u16 reg;
>>>>> + +	ret = opt3001_read(opt, OPT3001_CONFIGURATION); +	if (ret < 0) { +		dev_err(opt->dev, "failed to read
>>>>> register %02x\n", + OPT3001_CONFIGURATION); +		return ret; +	} + +	reg = ret; + +	if (reg &
>>>>> OPT3001_CONFIGURATION_CT) + opt->int_time = 800000; +	else +		opt->int_time = 100000; + +	reg &=
>>>>> ~OPT3001_CONFIGURATION_L; +	reg &= ~OPT3001_CONFIGURATION_RN_MASK; +	reg |= OPT3001_CONFIGURATION_RN_AUTO;
>>>>> + +	ret = opt3001_write(opt, OPT3001_CONFIGURATION, reg); +	if (ret < 0) { +		dev_err(opt->dev, "failed to
>>>>> write register %02x\n", + OPT3001_CONFIGURATION); +		return ret; +	} + +	ret = opt3001_read(opt,
>>>>> OPT3001_LOW_LIMIT); +	if (ret < 0) { + dev_err(opt->dev, "failed to read register %02x\n", +
>>>>> OPT3001_LOW_LIMIT); +		return ret; +	} + + opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret); +
>>>>> opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret); + + ret = opt3001_read(opt, OPT3001_HIGH_LIMIT); +	if (ret
>>>>> < 0) { +		dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_HIGH_LIMIT); +		return ret; +	}
>>>>> + +	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret); +	opt->high_thresh_exp =
>>>>> OPT3001_REG_EXPONENT(ret); + +	return 0; +} + +static irqreturn_t opt3001_irq(int irq, void *_opt) +{
>>>> 
>>>> Pass the iio_dev in to the irq setup instead of opt and you will then not need the opt reference to the
>>>> struct iio_dev.
>>> 
>>> What's the difference ? When used this way we have:
>>> 
>>> struct opt3001 *opt = _opt; struct iio_dev *iio = opt->dev;
>>> 
>>> Done your way we will have:
>>> 
>>> struct iio_dev *iio = _iio; struct opt3001 *opt = iio_priv(iio);
>>> 
>>> I don't see the benefit of changing this as I'll access to both opt and iio.
>> Because one way you get it from the IIO core support.  The other way around you have a local copy.  Basically
>> it's better from a consistency point of view to have all drivers do it one way around than end up with a mixture 
>> of the two (which way around doesn't really matter - but rather late to change now!)
> 
> don't really care, frankly. i'll just change it
> 
>>>>> +static int opt3001_probe(struct i2c_client *client, +		const struct i2c_device_id *id) +{ +	struct device
>>>>> *dev = &client->dev; + +	struct iio_dev *iio; +	struct opt3001 *opt; +	int irq = client->irq; +	int ret; +
>>>>> +	iio = devm_iio_device_alloc(dev, sizeof(*opt)); +	if (!iio) +		return -ENOMEM; + +	opt = iio_priv(iio); +
>>>>> opt->client = client; +	opt->dev = dev;
>>>> 
>>>> This is very circular and it rarely makes sense to have the device private structure have a reference to the
>>>>  iio_dev.  Here it is only used in the interrupt handler. Avoid that by making the private data passed to
>>>> the interrupt handler the struct iio_dev instead of the struct opt3001.
>>>> 
>>>>> +	opt->iio = iio; + +	mutex_init(&opt->lock); +	i2c_set_clientdata(client, opt); + +	ret = 
>>>>> opt3001_read_id(opt); +	if (ret) +		return ret; + +	ret = opt3001_configure(opt); +	if (ret) +		return ret;
>>>>> + + iio->name = client->name; +	iio->channels = opt3001_channels; +	iio->num_channels = 
>>>>> ARRAY_SIZE(opt3001_channels); +	iio->dev.parent = dev; +	iio->modes = INDIO_DIRECT_MODE; +	iio->info = 
>>>>> &opt3001_info; + +	ret = devm_iio_device_register(dev, iio); +	if (ret) { +		dev_err(dev, "failed to
>>>>> register IIO device\n"); +		return ret; +	} +
>>>> Normally we'd expect the devm_iio_device_register (that provides the userspace interfaces) to be after the
>>>> irq request.
>>> 
>>> that's wrong. By the time the IRQ is requested, an IRQ can actually fire and you better have a valid e.g.
>>> iio_dev by then.
>> Its very unusual to bring up a device with the IRQ already in a position to fire.  Normally that would require
>> some enabling from userspace after the driver is loaded?  How can it fire here before that point?
> 
> at the moment you call request_irq() (or any of its friends), that IRQ line is unmasked and ready to fire. Remember
> that IRQ lines can be shared and your IRQ handler will be called even if a separate device triggered the IRQ. Heck,
> if you have a bad board design, even noise can assert the IRQ line but let's not go there :-)
IIRC Sharing is only possible if the device driver explicitly allows it?
Bad board design can get you in many many ways ;)
> 
> In any case, you better have valid pointers around so that by the time your IRQ is triggered, you don't crash the
> kernel. Another way would be to mask the IRQ at your device level, but that still doesn't solve shared IRQs.
> 
> I usually request the IRQ as the last step for that very reason.
Fair enough - easy way to be sure I guess.  Though by just before the
register of the device all relevant pointers should be available.  It
won't do anything particularly helpful but it should not crash. If it
does then we have a bug we should probably close.
> 
> cheers
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJT47BRAAoJEFSFNJnE9BaI3GQP/3PPNLqjiXLHlV0LeVuNEpW5
r9HVbu8JpA4i0k5Aau6ak88nP4LDUXOcPWRtOFfz+5hHIvr9kFUp+FYLitMRML28
5yIvAa+TDijjSJwrlcIZdTDAXL8552S1NY/4+QcX4DJtYV8nnkSBOwDQkSPtxll/
Fia9LIKEvxOHkXlofNMhnGVwQcazVp7usiXxL07orBtPwCTUxKXpEuadnjIAdsiJ
CSiDt9YVR5mw3RJYrGYDHLnBPlo0kw3R/DElkii30N0K7bqh6CGSvXJv04j7sjky
gwvBmu1qbwymWny0Z50cWqoWPDady2/yrI57f/dbyUJJayLyC6roGor6e7h5SQuY
ShNAb+QOZLIFvLPEjsTA2pjju0vbNKN+JhNeRx8/GOMo1o6gzwHs966J7m8zJPXK
SfJ+FHGJoNS1vHEEEYtJ/qHdIa17Z7d5BUCdaV3V7pe20KYuFGRVn3arldND9dR+
PoTDKziNKzW9YPRPKiLNZbbmTgYxtbcIZE9EKBnkACm8C+W6jr3i4amwKgZH2WSu
81kTxVxfrHftY3L2eDMJVuULgZsAjYqK8zKcRzlyza2pVu1wWxfy15fLYt2/QY/f
gyPvTS2IvkMOGwLJerpr2wlMEKDn8gADUD/7dUs8g/2n3tmLPqOzq0F0umfHlAPh
eSwAiVDG6TfDeamnutQN
=/khk
-----END PGP SIGNATURE-----
