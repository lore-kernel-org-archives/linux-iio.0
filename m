Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B9285060;
	Wed, 19 Aug 2026 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101472; cv=none; b=LJYrpC2Gygm/hp6Z79FbQr8qxEl6dqq17U60Oj0MVCDVg2Xw2gClTAE1GWCNdJ7vmLUUXFX153wTSvOOG51sp0mqzlucdpGa+gXmc6gMK0J/Pu6PZNhkT7LI90jgvKEPhbUU0eSrhpsI2z6JfMXYSjppnYen2ZzxodhLZ3tdRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101472; c=relaxed/simple;
	bh=a58e86nBBNovQnEVRhycGQYE+nENT0BPOQ5uZ4Xrkts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXBkQ3xpHX88IWojmP6NGrQDKb7+8pAGfMv4oFvP4aMcc+urQyCuFAiqXodR6j/B/coVgRsxdw6hk/YAZbB+0xI2EOMWu69IyPc5bR9MpI/kBcQWEccnp8/QpGltoKxMYdE0ONM4AF1jGuFW1aFF+2C/bkkYqJdEXHLMdZj1BVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4LKCqWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4LKCqWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EAF1F000E9;
	Wed, 19 Aug 2026 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787101470;
	bh=GccWG6NlqJnPZlaUDtMAW8yoVn0Vv/jGilm4jtu0/6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N4LKCqWbySeQvzjkyPdeMYqfpjFG66TQQIrG42CrV93U6UZi8rLQOfg6GDgzjAodM
	 8QXho1mPtWunw1Nyvyz8CUX6vyZA7NRgglFogyJ/dIkjHjN8ecLKH0PJUm3CXSD9Za
	 S8UZvgZBEg8ph/i1ookRyrbXEHwoT3DZqP1nPI7NhC1m5lfFRQdKTRUScSbb7olAD8
	 6v02Eo4vWLXl3sgqiAgBvY2mwg4nGIIo8+Q1+tF9MZfXwgxbTsSqovxVS/79XB1/n6
	 KptWObJwOoD1W2nin+Lpye9A6jpC0NAcopEE8ByLDEdOlSD2UBRrTE0v+Hy2Ovai37
	 T5rJwNhC5hJxA==
Date: Wed, 19 Aug 2026 02:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 0/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260819020426.1de53bce@jic23-huawei>
In-Reply-To: <aoRl-7XIianTyKIB@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
	<aoRl-7XIianTyKIB@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 17:02:35 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 18, 2026 at 01:34:25PM +0200, Javier Carrasco wrote:
> > These ambient light sensors with I2C interface provide two light
> > channels (ALS and IR), high/low threshold alarms with configurable
> > persistence, and a data ready signal.
> > 
> > The devices covered by this driver have the same resolution, and they
> > share most of their functionality. These are the differences between
> > them (note that the x belongs to their names, and it is not a wildcard):
> > 
> >  - Device ID: accessible via two 8-bit registers, different values for
> >    veml6031x00/veml6031x01 and veml60311x00/veml60311x01.
> >  - I2C address: same grouping, 0x29 and 0x10 I2C addresses.
> >  - AEC qualification: AEC-Q100 for veml6031x00/veml60311x00 and
> >    AEC-Q101 for veml6031x01/veml60311x01.
> > 
> > The alarms and the data ready signals share the interrupt pin, and an
> > interrupt status register must be accessed to identify the source. Such
> > multiplexing is not new in IIO, and I have followed existing examples
> > for it. The persistence setting (own attribute) to trigger the alarms
> > uses the pattern that has already been used for the veml6030.
> > 
> > The device configuration is in general documented in the datasheet and
> > the application note. There is an exception, though: the activation of
> > the "active force" mode that is required for the data ready signal must
> > be carried out in two steps even though the affected bits are located in
> > the same register: first ALS_AF (active force mode enable) must be set,
> > and then ALS_TRIG (active force trigger setting) must be enabled. I have
> > added a brief commentary in the code to explain this behavior, which has
> > been confirmed by the manufacturer.
> > 
> > The datasheet specifies the scale and integration time for the ALS channel.
> > Although both settings also affect the measured IR value, no transfer
> > function, accuracy, or calibration is specified for converting the IR
> > output into a physical quantity. The IR channel is therefore intended only
> > as a qualitative indication of the infrared content of the incident light,
> > rather than as a precision measurement channel. Consequently, the driver
> > does not expose scale or integration time as IR-channel attributes.
> > 
> > The only functionality that has not been implemented yet is the x0.66
> > gain (and its x0.165 counterpart when PD_DIV=1), which makes the gts
> > helpers less usable due to the conversions required. It is indeed an
> > uncommon gain to use (there are x0.5 and x0.125 gains) with no known
> > use-case at the moment that justifies making adjustments to the gts
> > helpers or adding artificial conversions to make it work.
> > 
> > This driver has been tested with the four supported devices separately
> > as well as in pairs where the I2C addresses don't overlap.  
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> for all patches, but DT.
> 
> There are minor things that may be addressed later, or in next version if asked
> for other reasons.
> 
Assuming remaining discussion resolves, there is just enough requested
here that I think a v8 makes sense.  This is particularly because
of where we are in the cycle and the massive amount of time we have
as a result.

Note I didn't find anything that Andy hadn't already raised.
Looking nice!

Jonathan


