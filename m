Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30E3659E8;
	Sun, 21 Jun 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782051037; cv=none; b=MDEl2vVi8KV5noG5mCR7mXnt75MSh2ZrTyJl8Tcu49+D7Yd5toUerXiDQvLakbmm36Gmd8QxbonYtp4b43ovTFyMG8yt4iwx70Hp7j9wKr54z+EqnJa5fsd8RWg27mCnladf+kIFRIHC2x5SOZ4fKxuKiJjaEn5XQWVACvawQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782051037; c=relaxed/simple;
	bh=dFhAy2i6MemUhVBpxRX5kEfl6boZmPjl6K2rdhtil3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVgziR8tcKXArs02QNyFRoT9fJRb542gfzL/Olsr2hiMWLyE5iDG8cDGWOCJjwRBeQf4RnbPN6r6dNE/j83fvhU0c0Eb91dNXA76NyD7+Gfkue94brVKqhB3tCuQYXABa6vDtkZ7xxauxG8ks+KHTyiszjCEXSBJoPSeQsDMIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+Rj/Zkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+Rj/Zkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FFE1F000E9;
	Sun, 21 Jun 2026 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782051036;
	bh=d71ItCVHJbPlKwUm7p+uxHBTSKf+Z391+seM8dThinc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z+Rj/Zkb+B11kl2Pjd8dX3zMa/T2jM5TuHUNgXfmJVAV5u+V61XjACMgnjs4QpmGS
	 JFvb6z3hIQuj/Wk3Nq4e9upAh+GQSEbYnojVaNfulmtePQEhvzOJYorT25JJBWdzk2
	 /PeOaC1QEF/OeX+QQzc17jaLcKag4ubNdy7KwJP4ZNT9ZN+LjaMQitRGtY45ij/x7m
	 GgCRmM6bc2AQi9DCRd8ZjFQRq04QQIhAxw86fiqcBT95dZZOJYHvfCK9ohiXLvXzcm
	 IZlwp7ChPoht84jVxZt1qatZaWrRozR4MMiPbjiQv3ksD4TxeFWTbNyFwPlc5+XGcJ
	 0MrUL5Rqgcjxg==
Date: Sun, 21 Jun 2026 15:10:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
Message-ID: <20260621151026.69714694@jic23-huawei>
In-Reply-To: <ai1dhJWb9vKqxEEe@ashevche-desk.local>
References: <20260612215151.1886851-1-robh@kernel.org>
	<ai1dhJWb9vKqxEEe@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 16:39:16 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jun 12, 2026 at 04:51:50PM -0500, Rob Herring (Arm) wrote:
> > The "st,adc-alt-channel" and "st,filter0-sync" properties are
> > documented as boolean flags. The legacy parser read them as integer
> > cells, unlike the child-node parser which already checks only for
> > presence.
> > 
> > Use presence and boolean helpers so both parsers follow the binding and
> > the property type checker no longer reports the flags.  
> 
> For the patch
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> However one interesting remark below.
> 
> ...
> 
> > -	ret = of_property_read_u32_index(indio_dev->dev.of_node,
> > -					 "st,adc-alt-channel", chan_idx,
> > -					 &df_ch->alt_si);  
> 
> > +	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,  
> 
> I believe it still has another (serious?) issue. We usually don't use indio_dev
> for device properties. It's not a device that is described in DT.
> It seems the only driver in IIO that does that. Note, I haven't conducted any
> deeper research, it might be (however I'm quite in doubt) that this is correct
> use and one device registers a few indio_dev:s.

It is curious.  The registration sequence in this driver is complex, but I'm not
seeing anything that sets the fwnode for the struct iio_dev->dev before calling
the init() callbacks that end up in this code.  It is set later by iio_device_register()
(iirc that has something to do with consumers turning up later).

St folk could you take a look at this and see what we are missing
if it does currently work?

For now I'll apply this patch but might need to drop it if a fix clashes
with it.

Thanks,

Jonathan



> 
> > +					    "st,adc-alt-channel");  
> 

