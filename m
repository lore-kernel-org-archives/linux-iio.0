Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809839;
	b=uhR/f73zFycHDm2mzcEHwbAt/7hzaTzpkcgtMjhNKYzHSduIn4GPKoG+ZjELSSX1f81I
	 8KqLVNV3plgX65mOX1kz/cgJzFjZTD7HHekhJtVOYj2Mqmpf+1iCoAJQgcqGrsqej8upx
	 QbrMXl/0wcDtG+i4aNxL7Yjg4ytZX0+aKHTaAroDGq9oL/46GZhuvu685To2YNw29dtLR
	 iNz+fCRv7k6bNAALMPKOa08Jx2bjpvgZzdxmWcmomtix4VncQUPwjXOv4i0PPCKgDGNWQ
	 MP3q8jtReEVScw6+1B7J+bu3HabnAgcmM6B8JN/xx23x0nR9b2UXSV6t2pCJdtvL57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809839;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q5oNvwlrSmzVl4Pfa+U6fXz0MufSP4EYM6gckAHNebg=;
	b=CqmGrdgYVoGJ2RuydsZE8+iKvN5EtXXT6/SaDBiIIcT88OD+wh5yjaKOQSzcuVrGSEyd
	 Uu6PUmqx2S1thL7nNadWcp4jAiiS7EwIOKTCBRoFrNBuX0C+J2HlsF518DrK+tiQ4IcoB
	 mt33p4lGBpdqJOtkQhl798MZ3ZUWj45jnxbZ5cs92JgDNgNtbzrhS4VeXoRdbt39wFOAq
	 aazX2yapLFHzm4VMZ8kRdjOcXIJgV58301Fw++KH/TUx/hC2JrdA09+NilSA5m78Ex5me
	 5FT3v5FEXj/s41ib7ICYiBhLhLr2wx8f8cWkIeB0iS+GgR/zF0MMwbjUjiyOyMmWSJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9PkSNUE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2518606A31A;
	Sat, 24 Oct 2026 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9PkSNUE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D21F01825;
	Sat, 24 Oct 2026 02:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809838;
	bh=q5oNvwlrSmzVl4Pfa+U6fXz0MufSP4EYM6gckAHNebg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b9PkSNUE2rl/bH6NaOpJ7jnXySnsLvcnPC9tmFk1kUOMrl6ThsKV0RB8gkQHAXn9a
	 psgiWRk6BJcZ4wFEXDx7cI5KOBX08tY/oa4QhB9iA770C0X0EvXgO4sbmJIsyFI96O
	 T07G9G1j7uwGJNKW9XQxRy8cTBuuMcNWlAaliDGOFOf5HWw5ffZ2b1CM07BUDZObe2
	 U0pH3aKlwoNvnCbjzMlkpfv+zxedsjdStCe12AlZcQ+Huq2FvOh7+ac2S+GBNhtWIR
	 v2PVh65G9kmy8CNMX58bRRrIUvRdU7jda1uwn6qEq/oYTV/pWYBQIzucb7dOB1LX2a
	 kcELLEyFAH0Vw==
Date: Sat, 24 Oct 2026 03:43:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Iron Berrington <berringtoni36@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] iio: accel: adxl345: update period cache
 after successful write
Message-ID: <20261024034351.5d1be9c6@jic23-hlaptop>
In-Reply-To: <CAF2O-sPB3ggqwEA1LXsrA=tCpZGJMdx8KAXLXrW7RcaEk9y1iA@mail.gmail.com>
References: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
	<atXvOA40_3qE2HA-@ashevche-desk.local>
	<CAF2O-sPB3ggqwEA1LXsrA=tCpZGJMdx8KAXLXrW7RcaEk9y1iA@mail.gmail.com>
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

On Mon, 19 Oct 2026 07:53:28 -0500
Iron Berrington <berringtoni36@gmail.com> wrote:

> Hi Andy,
> 
> Thanks for the review and the Reviewed-by tag. I'll address the
> time-unit constants in a separate cleanup patch, keeping this fix
> focused on updating the cache after successful writes.
> 
Applied.
> Best regards,
> Wenqiang
> 
> 
> On Mon, 19 Oct 2026 13:21:44 +0300, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:
> >  
> > > The ADXL345 event-period read path returns st->inact_time_ms. The setters
> > > for inactivity, free-fall and the ODR-derived default currently update
> > > this cache before writing TIME_INACT or TIME_FF. If the regmap write
> > > fails, the sysfs write reports an error but a subsequent read returns
> > > the requested period even though it was not programmed.
> > >
> > > Update the cached period only after the corresponding regmap write
> > > succeeds.  
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Assuming that my comments may lead to a separate cleanup patch later on.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  

