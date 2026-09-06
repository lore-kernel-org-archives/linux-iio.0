Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94315746F;
	Sun,  6 Sep 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788653511; cv=none; b=rnZmvbNYni3TgJf8yGCsFrdOQ6dnp4fGPhVCojDmm8cGJ0dSylh8pvR3oZ/epZlSNk87MxsRmK2IyZVeYfvXV1g7nePg45rfSSE49oYmQ3XE5jc3Oqi/sXBiltJ61oUTH7bhp3LYKsaURZDL2LggQZKFN4vTHnVcvhIUdFN9374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788653511; c=relaxed/simple;
	bh=l1hkHsIy+E+8CveQ8h98HHxdF1yyMoJ1DepDtPFgWyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQVU01g4KdGaIvxzpnisgVIDXxqPiWgh/vU3U6IKzPQqoZs7im2eHqHtdQH6ExnWOR21QVtWD6E9BXxI5Ua0EW8v4rQD7jc8iOY/BLEFA09f4coiotZ3LhIYJTJNB/+gRmMhccDOZmrpk+B0UCrHqyfUlGkpRjXehiMM2Tb+omI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub4f8Ns4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub4f8Ns4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567AA1F00A3A;
	Sun,  6 Sep 2026 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788653510;
	bh=P1VhBhJ2SVBj84g41MZsEzrPAza2UbfNOvtzAxLUEzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ub4f8Ns4T6gIS8ZTlqwC7TzmChwVMjMAyFYwwZjQtbeUyWzDjZG3S5JAaxnpZoNYj
	 PSwep+vKMbOPs2PBNTMh0U3Qpj4nI5HVqkikT5LTAmdMLXhHT1II+sEzMrGdCHfbTP
	 8LtPiTelZvgmka1bc9Vs/SJRpBfEqz31pq6WsD5fx+c4cym06r2ZIEqicLEqyNcjW0
	 J2JhfJSAq6LfjWieL0HTQtlNeRFnCkbfmd2snR3MafIP/6HQTugpvfSQ0OxHiY+7Ll
	 dwR6bE16Vg/ZHQuLIWw0f7qWm3hI+SSDhgxKLmnzLrIjkhtsQ8sd3Awg2rpp/pZrnq
	 erkf5mx7UQg2w==
Date: Sun, 6 Sep 2026 01:11:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor driver
Message-ID: <20260906011145.4a0f4933@jic23-huawei>
In-Reply-To: <20260905084258.350fdccb@systembl0wer>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
	<521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
	<20260905084258.350fdccb@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 08:42:58 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Hi Chang,
> 
> Comments inline.
> 
> Josh
> 
> On Fri,  4 Sep 2026 22:53:26 -0700
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> > sensor with I2C interface.
> > 
> > The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
> > via the IIO sysfs interface. Each channel's raw data is provided as a
> > 16-bit little-endian unsigned integer.
> > 
> > Basic power management (suspend/resume) is supported. More complex
> > features such as interrupt support and configurable gain/integration
> > time will be added in future patches.
> > 
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

Nice review.  A few small comments on necessity of features etc
inline.

> > diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> > new file mode 100644
> > index 000000000000..b620dd308380
> > --- /dev/null
> > +++ b/drivers/iio/light/as7343.c

> > +	/* Need to set REG_BANK to 1 before we can access ID */
> > +	ret = regmap_set_bits(data->regmap, AS7343_REG_CFG0,
> > +			      AS7343_CFG0_REG_BANK);
> > +	if (ret < 0)
> > +		return ret;
> > +	/* Check device ID */  

...

> 
> > +	ret = regmap_read(data->regmap, AS7343_REG_ID, &val);
> > +	if (val != AS7343_DEVICE_ID)
> > +		return -ENODEV;  
> 
> It's better to just do a dev_warn() in case of any fallback
> devices instead of a hard return.

dev_info(dev, "Unknown device ID: %x\n", val);

or something like this.  In many cases a mismatch is not an error, it is a
fallback device tree compatible being used.  This is common when a manufacturer
issues a new device that is a refresh of an older design and so interface
compatible but with a different device ID.
 

...

> > +
> > +	/* Set 83.4ms integration time and x64 gain for now */  
> 
> Good for an initial draft, however you'll definitely have to
> implement the write function for this to get merged into mainline.
> Skimming the datasheet shows that there are more integration times
> possible, not to mention that you can also set the gain etc.

If there is a sensible default / initial value that works most of the time
(short value probably to avoid saturation) then controlling this isn't
a requirement for merge.  It's a nice to have though!

...

> > +
> > +static int as7343_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct as7343_data *data = iio_priv(indio_dev);
> > +
> > +	return regmap_clear_bits(data->regmap, AS7343_REG_ENABLE,
> > +				 AS7343_ENABLE_SP_EN);
> > +}
> > +
> > +static int as7343_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct as7343_data *data = iio_priv(indio_dev);
> > +
> > +	return regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> > +			       AS7343_ENABLE_SP_EN);
> > +}
> > +  
> 
> You have suspend/resume functions, yet you're missing a
> devm_pm_runtime_enable() in probe. 

There is not requirement to do any specific combination of power management
for an IIO driver because what is necessary is very dependent on the usecase
a particular developer has. So runtime pm is a nice to have only (as is the
suspend / resume stuff we have here).  May well make sense to use the same
for both types (there are macros to ensure that).

> Additionally, you could enable
> the autosuspend function as well (note, you'll have to wake the
> device before reading, there are macros that simplify this though,
> see PM_RUNTIME_ACQUIRE_AUTOSUSPEND)

All nice to haves indeed - but not strictly necessary. Many drivers
don't go that far initially and it is fairly easy to retrofit this stuff
if someone cares.

Jonathan
