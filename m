Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9025F99F;
	Tue, 23 Jun 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227449; cv=none; b=RolEgRGqluc55PXkaieYy36Bgw6kbkkOjnCK5wKnh3kdJ7hbtAbeq7xRpDt2XO3OzgbnsPZbqCovUmWkV/7CM4ytJ2CmjWiWD4Vlng/13DNH1dlDkbtP6fFeACUqCLet7mxbr7tzMsvQFlkaKPD/tHjQ9jlKgr3rFIFB8BtF7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227449; c=relaxed/simple;
	bh=WidTaHwkogQl64oY8d9iqyW9XjIyn5296C/AG1GVeJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1I79vfWpEkST+EI+CGa+/NktE70YZKq3ZHrq3x7NN4i5iVzn3YdiNXkpJzxNVeg5/A/mVhLHj0gJnrUI2LwqINOdAFYZv6vVXJBgjs4nAsarLxJTwcJCFBpkBEOzbGmg5566u9LFJZP+p838gw+1OOvbQlZNwGPYTwBHSCZ6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR56Wa5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR56Wa5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705741F00A3A;
	Tue, 23 Jun 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227448;
	bh=JbnEvt1HYbMhxvD0ZUEB9Wz8ezFMKa7Yiz789jn378Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kR56Wa5RrjGIycvuXt4DdZ+TTHnp16yTDBAq8s2nyvOzJ1vTF3bi4uB02BN0S38sG
	 kyChjWVQRlOI1eKTzdBc2obuYnPEN+kAiZAw9YUDragqBJs8TfdcKboC4dAyhRPAI0
	 HR6j5obPwvpVx/rXNFh6TFvCRkueIuJXsuavEZ7COBAPg7oM24IZtZjarCuTXftaQc
	 VXxqKMFWfH1SqoGossGvrdGGCu2FzrXbE358FI6gDIXBxMrea5BajbqDXmKoSj6Euf
	 +c0kAIc2VcU9Wnz+6s33xSm9MGiwUMFa6gDMP/1git4w55pWNK4zyDWmsurANgzAzy
	 DVQ+HEJYsHaDg==
Date: Tue, 23 Jun 2026 16:10:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
Message-ID: <20260623161038.6429c3d7@jic23-huawei>
In-Reply-To: <ajpX3E2zHYh2e8FG@ashevche-desk.local>
References: <20260612215151.1886851-1-robh@kernel.org>
	<ai1dhJWb9vKqxEEe@ashevche-desk.local>
	<20260621151026.69714694@jic23-huawei>
	<46fce99d-9dd5-435b-95cd-86ed4771aa83@foss.st.com>
	<ajpX3E2zHYh2e8FG@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 12:54:36 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 23, 2026 at 11:43:49AM +0200, Olivier MOYSAN wrote:
> > On 6/21/26 16:10, Jonathan Cameron wrote:  
> > > On Sat, 13 Jun 2026 16:39:16 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Fri, Jun 12, 2026 at 04:51:50PM -0500, Rob Herring (Arm) wrote:  
> 
> ...
> 
> > > > > -	ret = of_property_read_u32_index(indio_dev->dev.of_node,
> > > > > -					 "st,adc-alt-channel", chan_idx,
> > > > > -					 &df_ch->alt_si);  
> > > >   
> > > > > +	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,  
> > > > 
> > > > I believe it still has another (serious?) issue. We usually don't use indio_dev
> > > > for device properties. It's not a device that is described in DT.
> > > > It seems the only driver in IIO that does that. Note, I haven't conducted any
> > > > deeper research, it might be (however I'm quite in doubt) that this is correct
> > > > use and one device registers a few indio_dev:s.  
> > > 
> > > It is curious.  The registration sequence in this driver is complex, but I'm not
> > > seeing anything that sets the fwnode for the struct iio_dev->dev before calling
> > > the init() callbacks that end up in this code.  It is set later by iio_device_register()
> > > (iirc that has something to do with consumers turning up later).
> > > 
> > > St folk could you take a look at this and see what we are missing
> > > if it does currently work?
> > > 
> > > For now I'll apply this patch but might need to drop it if a fix clashes
> > > with it.  
> > 
> > I confirm that the current legacy path is functional
> > (With the st,adc-alt-channel property fix applied)  
> 
> Yeah, it's here
> https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/adc/stm32-dfsdm-adc.c#L1772
> and should gone. Basically one wants to replace all these to use device and
> fwnode propery APIs and proper device node, without that hack.

If we 'were' going to keep this it should have been using the helper
to set that. I thought all those had been cleaned up so didn't check
for it being directly written :(  Obviously this comment is irrelevant
given the code is going away!

Jonathan

> 
> > It currently works because the driver initializes np from dev->of_node in
> > probe, and that value is then used in init callbacks.
> > 
> > I agree that this approach is not robust, as it depends on initialization
> > sequencing and on using an IIO object that is not the DT owner object. I
> > will prepare a patch to use the DT device directly as the single source for
> > DT properties.
> > 
> > I also suggest keeping a fallback path for st,adc-alt-channel so we do not
> > break legacy DTs that have not yet migrated to the new binding.
> > I prepare this also.  
> 

