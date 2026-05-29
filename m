Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340937A4B7;
	Fri, 29 May 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074901; cv=none; b=II4FkCar1SjygmGyhJCYmvUDur23z2eCMnD9fkdSj0GdaW2VjcwboueqD0uVZFBH4CkMRcOQjbRgw1JqeuGzfZStXI3LUTjh4hx+DQ/nZMrFcHZv3GTB/Czs0BgxJaYmSkUOEgRHogGaBd7fzO0HepM3lO/z4jxR0wIXmhmhXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074901; c=relaxed/simple;
	bh=6yxZYqhRWp4MTIXszU9QBaSLC0ybtH6ouJJxGW+Wrl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tsi4QqLs5kyodX2yUDJjzadulrb14ZmZf29eyemVszyUlJD91DHJPbKaOXVDPIDD7MTqrYNw9jyaLeKvFrE1q4wEekGC1TbdVM7pu+tNnNsci6WlgojGfO529/F/O8BwLy3MFEvz4wjT6apA+ZrcsQoB6JYoA5vo8p9wKXfcSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV/OTy0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV/OTy0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BFE1F00899;
	Fri, 29 May 2026 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074900;
	bh=AQyImAe9+AwI+Ul+2CXQGqw4GniyZyDQn9AXIBkPSsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gV/OTy0LX+UMYT6m9/lP5HHoD0aiQDj2yqAs09xeGyWrO3qaIl2XCUXVUd/qNTC3M
	 3yjeRJC76NL7t6ak1n7Gn+JKIGDsTwR1lmyLgEkMPbPMSEw1VvHJUZNHGbDFiLbWw9
	 r8iuC5XugpW7JkaOCM6UIScMnc6b3ikrU5AKJgIYEbI97jKe5JZa+2trYvTGOo2+op
	 IkmNEmPGJYpp41NA5ZNtuEwcp3MdohwStxt8mQwrJTI3I/kSJh8iJsWD81qB0oCRk+
	 kqyGie36IguMibVyAz4LoVfGmggGkB07pGE/6qarjWVIXI5waXeB6rPjFD94ZZus1F
	 cPzMo53m2Ie7A==
Date: Fri, 29 May 2026 18:14:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jinseob Kim <kimjinseob88@gmail.com>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/6] dt-bindings: iio: add OSF GREEN sensor
 aggregation device
Message-ID: <20260529181451.45b5d1bb@jic23-huawei>
In-Reply-To: <20260529-recant-imperfect-ba65ef80e542@spud>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
	<20260529121005.1470-2-kimjinseob88@gmail.com>
	<20260529-recant-imperfect-ba65ef80e542@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 17:31:42 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, May 29, 2026 at 09:10:00PM +0900, Jinseob Kim wrote:
> > Describe OSF GREEN as the first board target.
> > 
> > Add vendor prefix and MAINTAINERS binding entry.
> > 
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> > ---
> >  .../iio/imu/opensensorfusion,osf-green.yaml   | 43 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  MAINTAINERS                                   |  5 +++
> >  3 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
> > new file mode 100644
> > index 000000000..626b41fb0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml  
> 
> This is still not an IMU.

Might include one but agreed, it is more.  So probably move it up a a directory
to bindings/iio as it's more of a sensorhub.

> pw-bot: changes-requested
> 
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-green.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: OSF GREEN sensor aggregation board
> > +
> > +maintainers:
> > +  - Jinseob Kim <kimjinseob88@gmail.com>
> > +
> > +description: |
> > +  OSF GREEN is an STM32F405-based sensor aggregation board from the Open
> > +  Sensor Fusion open hardware project. It sends OSF0 capability, status, and
> > +  sample frames to a host over a UART link.
> > +
> > +  Open Sensor Fusion is not a generic industry standard. Public project and
> > +  hardware documentation is available at:
> > +
> > +    https://github.com/opensensorfusion
> > +    https://github.com/opensensorfusion/opensensorfusion-hardware
> > +
> > +allOf:
> > +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: opensensorfusion,osf-green  
> 
> I'm still not convinced by the compatible here, or at least I am not
> convinced by it without clear answers to my questions on v1 about
> discoverability and compatibility between protocol versions. If the
> software on the "osf-green" is updatable (it is, right?) the compatible
> doesn't actually represent the hardware, it represents the programming
> model of what's exposed on the serial port to the host. That means the
> compatible you use has to identify the exact protocol version
> implemented, or provide enough information that the version can be
> figured out by software.
> 
> Given you talk about OSF0 communicating capability etc, it seems to me
> like OSF0 is a discoverable bus? In that case, compatibles for boards
> doesn't really matter, all software should need to know is that there is
> an OSF0 "bus" and query it for what sensors are there.

Agreed - should be very generic and rely on protocol discovery. Only
need to break that if some some silly reason the way protocol version is
discovered changes.

> 
> The questions I asked on v1 were:
> - What does "v0" mean here? Is the data format not complete yet?
> - Are versions of the protocol likely to be backwards compatible?
> - Will the device identify what version of the protocol it implements?
> 
> Remember, there's no rush here, and you're better off slowing down and
> taking your time responding to reviews before sending new versions, so
> that the same conversations don't take place multiple times.
> 
> Cheers,
> Conor.
> 
