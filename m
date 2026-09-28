Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F354EB846;
	Mon, 28 Sep 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618212; cv=none; b=jZGLD9yBuMcFFZtUCRIBVUR0Bae40LwQ2KLXdjJP2gtOxj1g9IbB6jTrb5oIZ+2w/CJZfsumDAjy13vHPolINpt+IgLMxPLounlnSYvKfFv8jXsvLpBQvFZxEmsES3gcKP/Y/9TUz7Z0mCw5PhCkTPrPngDuE4w0Pj/vGQhth1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618212; c=relaxed/simple;
	bh=v2t115RMwmB3tT4LZcxnzrXsnNoqDvqRGisLn5BcZQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsbsA1GcO3OVvsoHAT8dLp5axmAUtHjo+hYIpyFzpdAFguayTUATfe3a2Fq4bv+sI0bJXipDhx0g8XS9+/oPAz7aggR9OFBlG9ogUMzSBmjLCI2aT3LZ6ttmJJiX/JTHfm++DprgR+ZN5ll0mSChQBkuwlYow1QV7UcBcGu3qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQrhqGJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQrhqGJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B11F00893;
	Mon, 28 Sep 2026 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618211;
	bh=1Z7QEPOyjMU7Nsxw7yDdAJWQEuZX0wQS6RV5zguO1wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQrhqGJhQ44MJtfIWTR/XDZY0LYu+vjyUDt4F/cKn8PUpZb5CQzhl4xxm6PTpjtFO
	 soqorKu71t7rDi9RvkFOjrEJE27nGtaEMgtcFDozU3DhsG/+G+Z+S1Ky/Z2yKN62B8
	 m0EcSujQV4kgRiWK0wpewI/WlF+X8Y+fIkhCd/PDGiBztdKuXXOEAg4bAw+b2yJRym
	 TlE7uSw/LoCPfiournaKCwMgxP57FhAvBRjBCAInU5kT1y/wqGr5cJLh0EgzAHH1w9
	 2ONdk1vgeaiTLuZHdGX6EOu4Hd5FUZWP3jE77SMqNCzLTVtnDAXEnSxoRAgE2pb+oO
	 yUu/6FgjZys7A==
Date: Mon, 28 Sep 2026 12:56:49 -0500
From: Rob Herring <robh@kernel.org>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	Henrik Grimler <Henrik.Grimler@axis.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Message-ID: <20260928175649.GA91418-robh@kernel.org>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
 <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>
 <aq_lObgrI7uAi0K1@debian-BULLSEYE-live-builder-AMD64>
 <3ab2ba81a38d4da84d4e3ebc147aa956728e96bc.camel@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab2ba81a38d4da84d4e3ebc147aa956728e96bc.camel@axis.com>

On Mon, Sep 28, 2026 at 08:55:12AM +0000, Kanak Shilledar wrote:
> Hi Marcelo,
> 
> On Sun, 2026-09-20 at 10:52 -0300, Marcelo Schmitt wrote:
> > Hello Kanak,
> > 
> > On 09/17, Kanak Shilledar wrote:
> > > ICM42370P is a 3-axis accelerometer. The device can support I2C,
> > > SPI
> > > and I3C. Add the supporting devicetree documentation for the
> > > device.
> > > The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> > > 
> > Patch 3 says ICM-42370-P is almost identical to the existing
> > Invensense ICM-42607-P.
> > Instead of creating a new doc, could we have similar properties for
> > ICM-42370-P
> > by extending
> > Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml?
> > The updates on the other patches keep supporting both ICM-42370-P and
> > ICM-42370-P with the same device driver.
> 
> ICM-42370-P is very similar to ICM-42607-P but it's an accelerometer as
> it does not have gyro. As dt-bindings should describe the hardware I
> think it should be inside the iio/accel/ directory although it is using
> the same driver of IMU. If you think it should be in the same file, I
> will move it and update the binding description.

Doesn't really matter if different functions as long as the properties 
are the same.

Rob
