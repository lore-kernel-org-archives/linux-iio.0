Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092247;
	b=gE/XRRX+lzHVYkkrK9leEKaTXZ0TuCXmfbMahisbLN4QiOF67yDB+KaH2XOKRu9giNVS
	 MmJzlmZAf3BGUkcWjMhuy8+EfuaHeAoyJbOie9nbY/hkrB2Ztfk3a1cMo3pYtYLtkiT2Z
	 hSa5ChYv6btGYH7NFUxO+pw98si290HXxg18AHeCR70D+jxk7N8z8y20EEMoztobl2/NQ
	 HaQ08OsK8pl2Vqo6c+PP0VauEVug377021ClEMllm50K0iTuIlhDMLVJGkdLzZB/gbcKd
	 Oi8FvDcqAej8pN0ibpmer2mR1MmvI/rRsSB1OkVRI5KnloztVvtr/5h0uJK7n7x8XPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092247;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4vBP5iKbuEoP6It5IVi0YurYzg152ZqlRsIj9Prr+98=;
	b=MOQJxILgbNGtZix8/3YvVVAfRxgDpwUcWKNBGrEJpWHiP6AP1bGwSc3tbe2Gzb9Pa0Cc
	 thuoml3ng6b16/oTGtIlCEjGpMF51i4PJHEz3UF+dSBqiumC6zed9zbHsgGdVgoJFtVNw
	 1mzPo1pDv0mD/oWVkyTcAZ5T9saHNeUqXEm67JgXVaq1afj8iSE2Av+G6ZiM7SolpDFBn
	 s4IzlKLhScQHlOMGGczyIioa40p/eO6kZ7rCRIiuCIHI6ZAvOeqYgDYh3JClZov06BXxM
	 cUifbNc/ZhdkIu8k6bcatGlODWUbtcbsJJ7+vngLw55pm6iTluvUsKmQmFFwRiQjcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWLXzqn2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA1606A326;
	Sat,  7 Nov 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWLXzqn2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C715B1F0089F;
	Sat,  7 Nov 2026 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092246;
	bh=4vBP5iKbuEoP6It5IVi0YurYzg152ZqlRsIj9Prr+98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oWLXzqn2CsgZSrF9XXH6l/TjYiX9KlgjzE8G/znkcpwk3DPrXcZ7pD1Nl4uJnkDmt
	 isREPOhN40hXVC85xZrDwM4aSPVFkQeUvHFdmQSmUrIznGUoP+pOt19EmGddEnGanF
	 77aNq9zK4unZ95zxk14WJrKafVl/MsaCTdFdpz4y0VWEPL6rdbrze+Y0NtdQMmmnY6
	 NaGsMHEkz/2Lvi3EKDWuStVChtjuYqx/gxSz0sLwmGxrLeh7ZkX2gg61ENIUh+ov5G
	 PR5JKfGr1ck6Z3r+TsAho2byMSG3iC1OWBVvCNhN8nHotekyoSJmRmUP3JxuX/6omp
	 4R4RWViilpf0A==
Date: Sat, 7 Nov 2026 22:57:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261107225721.1d4d6d63@jic23-hlaptop>
In-Reply-To: <676555ed-aa24-4654-a8bd-0606f1436396@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
	<20261102-topic-sm8x50-iio-max34417-adc-v5-3-0ffa5e5f2d5c@linaro.org>
	<20261104023032.0a21da0d@jic23-hlaptop>
	<676555ed-aa24-4654-a8bd-0606f1436396@linaro.org>
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

On Wed, 4 Nov 2026 09:33:15 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 11/4/26 03:30, Jonathan Cameron wrote:
> > On Mon, 02 Nov 2026 15:49:06 +0100
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >   
> >> The MAX34417 is a specialized current and voltage monitor used to
> >> determine power consumption of portable systems. The driver support
> >> getting the channels voltage, average power, accumulated average
> >> power and energy over an I2C/SMBUS serial interface.
> >>
> >> The MAX34417 datasheet only specified on how to calculate the
> >> accumulated average power, but with the Sample Per Second rate
> >> we can easily get accumulated Energy in mJ.
> >>
> >> By default the IIO driver only supports single-shot Voltage
> >> and Power sensing, but the accumulation can be enabled by
> >> enabling the Energy IIO channel which then enables the
> >> Continuous Accumulation Mode.
> >>
> >> The counter is common to all channels, so when reading a single
> >> channel we will copy all accumulators to registers, so in order
> >> to permit reading individual channels we must accumulate the
> >> other channels in the driver when Continuous Accumulation Mode
> >> is enabled.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>  
> > 
> > The use of the regmap_noinc stuff to deal with the variable
> > size 'registers' is novel.  Might be worth just adding a little
> > commentary on that to somewhere. Perhaps the regmap_config as a comment.
> > 
> > Other than that, just a question about why we need the postfixes
> > for the labels. That seems superfluous.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
> >> new file mode 100644
> >> index 000000000000..e679cf142141
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/max34417.c  
> >   
> >> +
> >> +static const struct regmap_config max34417_regmap_config = {
> >> +	.reg_bits	= 8,
> >> +	.val_bits	= 8,  
> > As noted above. This isn't really true.  You are just use noinc
> > reads to pretend it is.  Those are normally only used for
> > fifo registers so I think we should have a comment here talking
> > about that choice.  
> 
> Well, reg_bits is 8, but val_bits is 8 for the control & status registers,
> for the data registers the value bits is variable, so it's kind of true.
> 
> But I should add the readable_noinc_reg callback, yes it's not FIFOs,
> but both 3 data registers have different data width which should be
> read using the noinc to use i2c_smbus_read_i2c_block_data().
> 
> I can provide my custom register read/write copied from regmap-i2c if
> you find it better to avoid abusing regmap...

I'm fine with what you have here. Just after a comment to remind
me of how this works if I'm looking at it in a few years time!

> 
> > 
> > It is pretty neat so I'm not against it but it might rather
> > surprise anyone looking at the datasheet!
> > 
> > 
> >   
> >> +	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,
> >> +	.writeable_reg	= max34417_writeable_reg,
> >> +	.readable_reg	= max34417_readable_reg,
> >> +	.volatile_reg	= max34417_volatile_reg,
> >> +	/* No cache since the only non-volatile register is read-only */
> >> +};  
> > 
