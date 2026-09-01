Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479B38F934;
	Tue,  1 Sep 2026 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226696; cv=none; b=UAwZtCSI6vOuN/f1uObMjnQUNtYCFYk882UbEaBHPu443tQ3g6TfaziDENSmz3c0IVIjw+Lc/Jm9RhiWdeGzSesXVOSy2AyHNgrqXwFnilLNlnda+gdQorQijhIc40W7isFe/Vp2cVhCCV5sIf84eAmQFwhclrJzSpjb9RbbDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226696; c=relaxed/simple;
	bh=Kd0aQb2iW9hJJk5GOwilOGsnDa4JsdghPXrfBvtR52c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WErbryyAc3jm1dy1E9J+3w1fKO2Ceq298aKVfCL3FBufdtbYBk5QeRbyCqcQCvXbNrLzg9C5KVdFuN97aq7Uz+3yQ46bJfuvyVQdhiTlCgFvBw2Wml8rHeJQZHk6mJyjp4JuqoQTC7x8l7wqDSGDtIb4qR3+m8U5NP1HaO7CTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcdeswUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcdeswUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8071F000E9;
	Tue,  1 Sep 2026 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226691;
	bh=BrIiRFWtczkZQEdzjQfU9/6RPpw/i2QrGgvd2I+VXzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NcdeswUltGsBhID6VXv/iVFj1j2VSDPdMjVwIMYNjhwk+qAL2m3Tij7x+6lPct52V
	 SylHxgblCs1CbxzFhF8XlDug85XelzDJLFy160Rku11eEmBe4+WC1r0gtgBDo1wjCW
	 x5qSDPmUVvrCjoVld7nDbuS42ebeC00QMNv1qn16e+WtUR1+ChiHq7xFlpOgtbKd/O
	 sSaVkW2mE0F0U1nSRH8GojV62Ia0ow3GVB1GI1z/udq+g0gbx0k71n75x4279cw3VA
	 AtYvM7tXgXg2RalTE7wO6M0MVuN2EAL7i8HzPqKURD42lhfpD0WTcaiA3Cc4XdE4xq
	 GnBZ7Ep70PC3w==
Date: Tue, 1 Sep 2026 02:38:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Marius Cristea <marius.cristea@microchip.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260901023805.20abc542@jic23-huawei>
In-Reply-To: <apUo4afCh5LhUqIO@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
	<20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
	<ao_z9QTJC_q8gH0v@ashevche-desk.local>
	<178813177252.2788519.10940489053707901297.b4-reply@b4>
	<apUo4afCh5LhUqIO@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:10:25 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 31, 2026 at 12:16:12AM +0100, Jonathan Cameron wrote:
> 
> ...
> 
> > > > +	device_for_each_child_node_scoped(dev, child) {
> > > > +		if (st->num_channels == ARRAY_SIZE(st->channels))
> > > > +			return dev_err_probe(dev, -ECHRNG, "Too many channels\n");  
> > > 
> > > Okay, this actually better to be ENOSPC
> > >   
> > > > +		ret = fwnode_property_read_u32(child, "reg", &ch);
> > > > +		if (ret)
> > > > +			return dev_err_probe(dev, ret,
> > > > +					     "Missing reg property in channel node\n");
> > > > +
> > > > +		if (ch >= AD5529R_MAX_CHANNELS)
> > > > +			return dev_err_probe(dev, -EINVAL,  
> > > 
> > > and ECHRNG is here.  
> > 
> > That one is getting rather creative even though I guess the description
> > does fit rather well.  So I don't object, but also feel -EINVAL is
> > probably good enough for an invalid property value.  
> 
> But missing property message propagates the fwnode return code (which will be
> EINVAL IIRC). So the above is not about missing property, it's about wrong
> channel. Note, I have checked uses of ECHRNG in the kernel, and many of them
> are fine with the suggested one.

Fair enough and works for me.  We can add this to the list of things
to tidy up if we happen to be touching other code that deals with
wrong channel numbers.  Not something we want to generate churn though
unless there are far fewer instances of this than I think there are!

Jonathan

> 
> > > > +					     "Channel %u exceeds maximum 15\n",  
> 

