Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78603CC304;
	Fri, 22 May 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447274; cv=none; b=ie3fSD+M7Tyjp/F8D4pKPY+h2Yf1iM0URNYsnu6zNCX85G8Zo1a3Ficn1b4iigkNBIBbe7TuPP2FjoV76mxDObCQ5M/A3vTP3cOLmbfd/3DbSfT9oTPpiEcM4CgnN7oquUIVAgludt7PWrNMCuyzVu9VM5kZOtMfpntK3B9xy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447274; c=relaxed/simple;
	bh=VoqSSr6SFCd7KX19yU/Ythf5usTFnX7TNdYxdaGmlEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCyCU5ZaP9/q/rO2E+G39wykAo2oSw1+SQUxgJ9RvwHX7FtfLtMiwzI689fgpy2Wi+KZwLJtKF5q1kLr6G1T/voHzgK0bU5qFAu/fFQGmBihmoIqvvBd0URxsaJ4f62hv0GF6QowqLwTgVRmle3QjQP1zPufvO/HGtCamTgNz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW4b9h+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW4b9h+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1321F000E9;
	Fri, 22 May 2026 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779447273;
	bh=zo7xZVZuaqNUtAJ4AFiwelE3O6ioLTV60tcoTNmKXEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YW4b9h+a+Z6HzD1qgVqNfQKy+HO6hkwS3FXSphq6qkZOJOc6r1y8i2Lpt7uElgXmv
	 Xavot82qkPMfHMJUpJroElhuqqRclOul7YFpM0mzcW45qtAPNcqmWyHJLe62WGsl/s
	 6HxX3A+b3U7tG/PVyfWG/K3oKfEHclvMWOc4EWX7wAkxjxqSwp8CfZVOjFcxqtk7PQ
	 saGQzC+lUrFurtRjtSgtt6WwVkWD9DU4EA3negswERMfF8Nm9VVBDiv6aIm+0gGmPR
	 6Vpc12ud6azAnaVa69m+eb2Z+zcEL9t5qXeal7Q/6Zv/rgfKYjpXnSzN6PmfJiXKIC
	 mbceIvo8X5veA==
Date: Fri, 22 May 2026 11:54:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V8 02/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID: <20260522115423.1b30d4d4@jic23-huawei>
In-Reply-To: <20260521-challenge-flaccid-26b6f5d2d0bd@spud>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-3-macroalpha82@gmail.com>
	<20260520174217.6ca98524@jic23-huawei>
	<20260521-premium-afterlife-0d7a22b77517@spud>
	<PH0PR19MB99733879756FFB321CDCDD9B81A50E2@PH0PR19MB997338.namprd19.prod.outlook.com>
	<20260521-challenge-flaccid-26b6f5d2d0bd@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 21:08:07 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, May 21, 2026 at 12:43:09PM -0500, Chris Morgan wrote:
> > On Thu, May 21, 2026 at 05:44:21PM +0100, Conor Dooley wrote:  
> > > On Wed, May 20, 2026 at 05:42:17PM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 18 May 2026 15:05:17 -0500
> > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > >   
> > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > 
> > > > > Add devicetree binding for the Invensense ICM42607 and Invensense
> > > > > ICM42607P inertial measurement unit. This unit is a combined
> > > > > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > > > > 
> > > > > This device is functionally very similar to the icm42600 series with a
> > > > > very different register layout.
> > > > > 
> > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>  
> > > > Note that Sashiko has highlighted that the binding this being added to
> > > > has a potential problem.
> > > > 
> > > > interrupts are required but interrupt-names are not.
> > > > That would be fine but the binding doesn't say there is a default
> > > > ordering for the interrupts - so if we don't have names we have no
> > > > idea which interrupt it is.
> > > > 
> > > > This needs fixing - probably by adding a default  
> > > 
> > > Worth pointing out that this isn't an issue with this particular patch,
> > > the problem exists in mainline.  
> > 
> > The driver I lovingly borrowed this code from seems to have fallback
> > logic, basically picking the first interrupt if it couldn't find one
> > named "INT1". I was told early on not to do this that way, so in my
> > case the interrupt-names would be required (but not for the existing
> > driver because of this fallback).
> > 
Ah, so it  has a default that we've elected not to document.
I can't remember the history of that - probably similar discussion about
there being no right default when there are two (near?) identical operating interrupt
pins.

> > Should I make the requirement conditional just to my compatible
> > strings?  
> 
> Sure, sounds like a good idea to me

Agreed - that closes this for this part without spitting lots of warnings
for the older one.

J
