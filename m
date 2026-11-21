Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291167;
	b=aUlXZYLDSu8atzfsHBemXnaC5oTLkbPcT91WDHJVum0rpEyYE41DrWv1OAMOYCT8fhMF
	 DoSxLHG4cKgVZo0cUVjzYLWeAiDpQa+YC9CFQqURf4VzJ5qHXihyX03PirwrT8CXG6lcz
	 Z9b1pMN2ZJwsZPq2x2FY40BDiunZZtTaJtQ3hNQZsO1DEtw7BIk7wxUgqLjWkX+wEsVbJ
	 u12kFXo9UCml4d6JkbzC+48l03+wKhyEOZ/2mOgDbElM/i/Hf19fwjPc3J5F2/XS583pR
	 lYT3OfIixMKk84ZgM/svtK/22xYaesV0LuoSREoZ2VSkOMtSKi60+lGT9dvsBYrvn/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0q7G+RMyPqjNpAAoSS1DHITnsBLyy83Zh0kaNJU7Dho=;
	b=M3x7UZQybju+g3gQLzs0mSG5fEeJ1D15jAip/LZfGMlzd5hOIix3ojHtJH0LIzdTdk8l
	 o/efhRAGUb3vXl8qgzqURh74fB7aFV91b0iVViCryhuDkk2k+qyAi5Uk9VGsOJF8GqtkW
	 lsn5axnwOSg+U+Uhgemvo3nfZqUrQltVoXSCq1jYaB+OJ5I09qc6R8FFpfy9wsT1LxSsa
	 pFWlhwJ+SpXBD0QqLDzVEiKxI26fYqviLpDNARgM+JNmDqPDEgew5s4zAd47ySbSSNS+P
	 N5EqU5FCOuxqaWtN+xC/p5uOCaxlXpI7eHFNoUs2ZU+ExiDDfP1pZKNaW0eahcGqC+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GINPSegR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47974606A320;
	Sat, 21 Nov 2026 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GINPSegR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4731F000C0;
	Sat, 21 Nov 2026 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795291167;
	bh=0q7G+RMyPqjNpAAoSS1DHITnsBLyy83Zh0kaNJU7Dho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GINPSegRlQprh21fQDt7nIuL4HehHZ1Xt0tNMwelTtz8T7bmR1jB2FcEQcCD1YnVn
	 Z2HqUwwZtOx9d1avpYXi81NC1Je0x6JFdC218rJdTie+acubCRRuxnqC624DytOo/t
	 1CVpFI/wZa1HAdWlbOWXQ0z61m93trhc8GBGcCijgzm50WT/splgqrLWQH9QBPa5+7
	 tZxMfYfaP3gRF94cq8wdMdnRbgqUNAcWhy+RGeKQbnd4VTNCFI3tJomhy6Du4qFVGA
	 h7opKKVnQx13Ravt9djLE6aDh6FxW9aFcUuoRtrS5ilcqkaQVV/NnlrJDSj5I1kfi5
	 slsWlohGDe4DQ==
Date: Sat, 21 Nov 2026 19:59:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Viral Patel <viral8854@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>, Victor
 Chernyakin <chernyakin.victor.j@outlook.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add Infineon TLE493D-W2B6
 driver
Message-ID: <20261121195920.573a0727@jic23-hlaptop>
In-Reply-To: <20261121-tle493d-v2-2-92d7e57cec89@gmail.com>
References: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
	<20261121-tle493d-v2-2-92d7e57cec89@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 11:25:11 +0530
Viral Patel <viral8854@gmail.com> wrote:

> Add a driver for the Infineon TLE493D-W2B6, a 3D Hall effect magnetic
> sensor with 12-bit resolution per axis and an integrated temperature
> sensor, accessed over I2C.

This either suffers from copying LLM generated commit messages or
is pretty much what the LLM came up with.  They are way way too verbose
as they generate something that hides the important details largely
defeating the point of a commit message.  I'm only interested in a
couple of lines of 'what' followed by any 'why' stuff for less obvious
decisions.  A starting point of telling the LLM it is being to verbose
and to keep to these aspects tends to help, but then it needs the human
to edit even that for the bits that actually matter! 

> 
> The sensor is run in master-controlled mode. Each measurement rewrites
> the Config register with the "trigger after write" bits set in the
> register address byte, which starts a single conversion, and then polls
> registers 0x00 to 0x06 until Diag reports a completed conversion with a
> new frame counter. Results with a fuse parity error, test mode flag or
> bad bus parity are rejected. FP and CP are recomputed on every write of
> MOD1 and Config, as a wrong FP makes the sensor release the bus until it
> is reset.

This is too much detail for a commit message.  I'd just keep the first
sentence about master-controlled mode.  The rest should be clear from
the code and if it isn't comments belong down there, not in a commit
message no one normally sees.

> 
> The /INT output shares a pin with SCL, so the interrupt is disabled and
> so is clock stretching. The sensor's reset sequence is four SMBus Quick
> commands, so it is sent during probe only if the adapter supports
> I2C_FUNC_SMBUS_QUICK.

First sentence of this good.   Second one see the code, no need to say.

> 
> Raw I2C transfers are used rather than regmap: once PR is set a plain
> read always starts at register 0x00, and the register address byte of a
> write carries trigger bits.
> 
> The X, Y and Z channels and the temperature channel are available
> through sysfs and through a triggered buffer with a software timestamp.
> Wake-up, self-test, low-power and fast modes, sampling frequency control
> and the short range are not supported yet.

Don't care about what you didn't support for a commit message.  What
you do support can be summarised as something like.

Both sysfs and triggered buffer capture of channels is supported.

> 
> This is not added to the tlv493d driver: apart from the X/Y/Z bit
> packing, the two parts differ in write format, read protocol after
> reset, register map and parity scheme.

That is cover letter detail. Not useful in here unless it was really
borderline so discussion likely.

> 
> Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2. The
> user manual is provided by Infineon after a free registration:
> https://www.infineon.com/gated/infineon-tle493d-w2b6-usermanual-en_dc6d4e62-cde1-4d4b-87bb-c3368e25e35c

Add this manual as a second datasheet tag and drop that paragraph.

> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
> Signed-off-by: Viral Patel <viral8854@gmail.com>

A lot of the comments below are more things that I thought
about asking for and then why I didn't! :)

I want to give others time to comment anyway so wouldn't have picked it up
today, but if it wasn't for the commit message I might just have considere
picking it up later in the week (possibly tweaking a few trivial things
whilst applying).

Thanks,

Jonathan


> diff --git a/drivers/iio/magnetometer/tle493d.c b/drivers/iio/magnetometer/tle493d.c
> new file mode 100644
> index 000000000000..62b7e7ea7ec0
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tle493d.c


> +#define TLE493D_RESET_DELAY_US	30
> +/* A full range conversion takes about 175 us */
> +#define TLE493D_POLL_US		100
> +#define TLE493D_TIMEOUT_US	1000

That's a generous margin. I suppose it's still only a
millisec so who cares!


> +/*
> + * Write one register, updating its parity bit first. Only MOD1 and Config
> + * are written by this driver. The sensor drops off the bus until reset if
> + * MOD1 is written with a wrong FP.
> + */
> +static int tle493d_write(struct tle493d_data *data, u8 reg, u8 val, u8 trig)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	switch (reg) {
> +	case TLE493D_REG_MOD1:
> +		val = tle493d_mod1_fp(val, data->regs[TLE493D_REG_MOD2]);

Why reuse val?  I'd just write buf[1] directly here then no need to do
so below.

> +		break;
> +	case TLE493D_REG_CONFIG:
> +		val = tle493d_config_cp(data->regs, val);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	buf[0] = FIELD_PREP(TLE493D_ADDR_TRIG, trig) |
> +		 FIELD_PREP(TLE493D_ADDR_REG, reg);

Given I'm suggesting writing buf[1] in the switch, maybe move this
line ahead of that as seems weird to set buf[1] before buf[0].

> +	buf[1] = val;
> +
> +	ret = i2c_master_send(data->client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	data->regs[reg] = val;
> +
> +	return 0;
> +}


> +static irqreturn_t tle493d_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct tle493d_data *data = iio_priv(indio_dev);
> +	u8 buf[TLE493D_DATA_LEN];
> +	struct {
> +		s16 magn[3];
> +		u16 temp;
> +		aligned_s64 timestamp;
> +	} scan = { };

I messed around with a named structure type here then designated
initialiser below but it ends up messier, so this is good.
Just left a comment here for any other reviewers who wonder
the same!

> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = tle493d_measure(data, buf);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		goto out;
> +
> +	scan.magn[0] = tle493d_get_channel_data(buf, TLE493D_AXIS_X);
> +	scan.magn[1] = tle493d_get_channel_data(buf, TLE493D_AXIS_Y);
> +	scan.magn[2] = tle493d_get_channel_data(buf, TLE493D_AXIS_Z);
> +	scan.temp = tle493d_get_channel_data(buf, TLE493D_TEMPERATURE);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}



> +static int Andreas Kemnade <andreas@kemnade.info>(struct tle493d_data *data, unsigned int iicadr)
> +{
> +	struct device *dev = &data->client->dev;
> +	unsigned int hwv, id;
> +	u8 mod1;
> +	int ret;
> +
> +	/*
> +	 * After reset the sensor uses a 2-byte read protocol which plain I2C
> +	 * reads cannot handle, so MOD1 has to be written before any read. MOD2
> +	 * is not known yet and FP is computed with its reset value, PRD = 0.
> +	 * Clock stretching and the interrupt are disabled because /INT shares
> +	 * the SCL pin.
> +	 *
> +	 * Every MOD1 write also sets IICadr, which selects the address the
> +	 * sensor responds on, so it must match the address the device is
> +	 * already on or the sensor moves to another address.
> +	 */

See below for where I'm requesting a cross reference to this comment.
I wrote a nice paragraph asking for basically this text before scrolling up
and seeing it here :)


> +
> +static int tle493d_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tle493d_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int iicadr;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -EOPNOTSUPP, "plain I2C transfers not supported\n");
> +
> +	/* MOD1 writes need the IICadr value matching the current address */
> +	for (iicadr = 0; iicadr < ARRAY_SIZE(tle493d_i2c_addrs); iicadr++) {
> +		if (client->addr == tle493d_i2c_addrs[iicadr])
> +			break;
> +	}
> +	if (iicadr == ARRAY_SIZE(tle493d_i2c_addrs))
> +		return dev_err_probe(dev, -EINVAL, "unsupported I2C address 0x%02x\n",
> +				     client->addr);
Add a reference here back to the more detailed comment above.
/* Unable to support other addresses, see tl2493d_init() */

Otherwise this smells to much like an over restrictive limitation
on devices to ones we know about.  In this particular case it is
a fundamental constraint!



> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;

> 

