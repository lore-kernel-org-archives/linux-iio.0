Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094240;
	b=lIOKPMQtUWJxBRgr1WhwdEcaUjO/CBRLj1gtty19RnZOe/BL98LPyC5DNQyoWBeOqXeX
	 PThuHL+hx0TrJS1OLZjiNnWpEajHHHSmfcr7+Og+MQHWrNkH7w5PsEV3GC0PiXtcuDkEz
	 jDviIE6Ye2KSENLwr1MfKgO+8hx3KI2gMaaX03c07TWC8ooUnulV9xTGj6i8MUSMrzQHJ
	 UEvNcvAm77CQW8zdDXzIOINuDZZ1c4iTrUSWKCsQ3CNkCVD/X4qvYftpgZLCQYIWzp2B7
	 rbeuxtR2wzb0/YBbKFEF6Gl4RFEGXb4RTtHDQ1Wd00oaXrCLVQ1pnggMn4Lazw8pjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JU7cdEgcWrPZJ2PncHPRkLbpC7QORz3Ir1iu9UbvPsw=;
	b=bdJlVoEPNqtmEcftqAMsnYUxlwOS5dIqE6ioWJWNksQ8so4NXymvMN6UyB369UKrpWCp
	 hTv9RfilrDzcGbiVlGpmGFe3b/V25k6/c7mSkv+IXKSQEKDNkr01xjV6EOHlMZeT74jV3
	 6idASQYzj8jm8VTVwSmL19dJfz7mL4SvQv+WykXCKg6oeVcwhyhqgy74gTMvilGZfwr6j
	 9etYauYXfzO0rUyO0Gn1s6feo0UB8kdJaDrMuaJ7VIW4c9/3ew1MsOpRGSQnwqggIVa+N
	 aEosXZ5MTlAqvkCEPlr8ChU/gZKIHaxcih7d7APRFRodWSJBvUCFPH5LnW+gACXPHwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/C9Hhd7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384E606A326;
	Sat,  7 Nov 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/C9Hhd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB761F0089F;
	Sat,  7 Nov 2026 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094239;
	bh=JU7cdEgcWrPZJ2PncHPRkLbpC7QORz3Ir1iu9UbvPsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/C9Hhd7y7+W1AZchIY/JvBx7Birq0AIs31BfvppbtLChvPEfk2mXoQZfC/tTUhG5
	 xEs8akouSn2mi/MN81i6yy2DHaE7o9rWQBTpzVmBbjtEg2I7ILU+owvTbvpPkk2Rsy
	 KvSwT7veLv57pP+Hm1USkGDC5mKNr9m9VFyRT9lTRoz8DQHznJHqZy1k+JurfsQv41
	 k1iPXckr8TjFOqIFrNKoLVPXFY5Om+xrJgxbYd21jyiykm+uyIU+jwaBSe5FqWf/sn
	 zvXe8kEgi3PgQ/XkdX74bmo8d+2dtYjiQf33C8hGoOeKTCONXJ85wFVwB44mUu+97V
	 c6HJ7l8NfCXFQ==
Date: Sat, 7 Nov 2026 23:30:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Michal Simek
 <michal.simek@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amitrkcian2002@gmail.com
Subject: Re: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
Message-ID: <20261107233031.7ea9a718@jic23-hlaptop>
In-Reply-To: <aumzIdkwp_jVcTTs@ashevche-desk.local>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
	<20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
	<aumzIdkwp_jVcTTs@ashevche-desk.local>
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

On Tue, 3 Nov 2026 12:10:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 02, 2026 at 05:51:09PM +0530, Amit Kumar Mahapatra wrote:
> > Interrupt teardown is registered with devm_add_action_or_reset(), so
> > sysmon_disable_interrupts() runs when the driver is unbound but not when
> > the system shuts down: device_shutdown() invokes only the driver's
> > .shutdown callback, which this driver does not implement.
> > 
> > The device is therefore left with its alarm interrupts enabled in
> > hardware once Linux has stopped servicing them.
> > 
> > Add a .shutdown callback performing the same teardown, so the device is
> > quiesced before control is handed on. The helper lives in the core
> > module, so it is exported for the platform front-end. It skips a
> > device described without an interrupt, which never set up interrupt
> > handling.
> > 
> > Disabling the interrupts at shutdown is safe to have and not a must have
> > requirement for shutdown.  
> 
> ...
> 
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct sysmon *sysmon = iio_priv(indio_dev);  
> 
> Side Q to Jonathan: How do you see having a helper that unites these two?
> Something like void *iio_priv_from_drvdata(struct device *dev)
> 
There is no strong reason to assume that dev_get_drvdata() returns
an iio_dev (even though that's a common choice) so a helper would
have to express that somehow in the naming.




