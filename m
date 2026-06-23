Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4655478D;
	Tue, 23 Jun 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227738; cv=none; b=sXJpzZphkKCjNsK/qnw87U099NtYFmdV2aJvteXcVjSwIwQ65l7/eKurtNIB8F9YOIqkk5c5zwSvVyQkFEJqpLFyikHMBo5oBMGu26E2+FBQsvMvRoYpj01xhrtYV91gyVBkARyPmKdJbL4gIalcf90FfLfhfiiqmRNTLH2H33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227738; c=relaxed/simple;
	bh=gubHqCI4nHLzPzWT0NULmwIa3jzOA4oQFJSIRDBkE6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebDj5JBwaXfZrC52E4xnBo+j4WXEPgTbBGl3AcGFO08y/WJTTvoxkVBIi1ynAmes/PdIhGJI7ejEALqUwt0MmMFHAUrXzqVR4lpOyA+0CZujE9Q0tNXmfFvgUo5bDP8fqhNtNlHmnnvGDF4VvPPi0MFRxotkVeETMtzdiKkgImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COSxw0gF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COSxw0gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E91F000E9;
	Tue, 23 Jun 2026 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227737;
	bh=IPOBmqwVoyjRS2u66O6YAVJSo8yViJnEx+BNzty711k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=COSxw0gF3QYuNJh9ZJ5fqD5kq/uiYqZSDMIVEkJqAbInBUU6mfevw8xAX3lrOhr7D
	 rRyaZDnooKcpcVnE+vaibH+IHcdvJmnPooj//fkwNiKtJoS+pww2yPlQ41T9a3sQsF
	 UnVnkNIkalwiYHlkpv9VfK2M17gPYXeXKqS8+Tt/gNtz6iO7hrsTM2LJPUETGLBzSN
	 h5ph74zMF14l07AqIQtAfQMFEvSSCi9Jztm7bs9WuZWiSKPAyN5MHgZZLq0kW4psYK
	 1z37dYL6gHV7M1aIu7F/sW1N/UgoVcO+Z1OodHFUmF+iiOS7wu9u1y6MxlZka6TMT2
	 KVrsYfQ2Ux5dA==
Date: Tue, 23 Jun 2026 16:15:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260623161527.7b7b0ccb@jic23-huawei>
In-Reply-To: <ajotNPhg8fR3tLZp@ashevche-desk.local>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-9-macroalpha82@gmail.com>
	<ajEhr0JIQwzRgoZa@ashevche-desk.local>
	<PH0PR19MB997338E86152468CE26F60953FA5E42@PH0PR19MB997338.namprd19.prod.outlook.com>
	<ajotNPhg8fR3tLZp@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 09:52:36 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 17, 2026 at 04:10:49PM -0500, Chris Morgan wrote:
> > On Tue, Jun 16, 2026 at 01:13:03PM +0300, Andy Shevchenko wrote:  
> > > On Mon, Jun 15, 2026 at 12:25:51PM -0500, Chris Morgan wrote:  
> 
> ...
> 
> > > Can be some of the code deduplicated between gyro and accel?  
> > 
> > Probably a fair amount, but the deduplication will likely need to be
> > undone somewhat if we get buffer, WoM or apex support added back
> > (I don't have any devices with such functionality, so if anyone will
> > do it then it won't be me). I can refactor more if you want, or we
> > can keep it split like this to make it easy if someone else wants to
> > tackle the buffers/IRQs stuff later? Your call.  
> 
> Just asking. Jonathan, David, Nuno, what's your opinion on this?
> Personal opinion is to avoid solving the issues that do not exist.
> If you are not committing into those features, let's not prepare
> driver for them right now.
> 
Agreed.  My only exception to this is normally when someone tells
me they have the code and plan to post a follow up set very shortly.
Then I get a bit more relaxed as they chances of 'preparing' for the
future being relevant become much higher!

Jonathan
