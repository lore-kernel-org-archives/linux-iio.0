Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD839367F5C;
	Sat, 31 Jan 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885565; cv=none; b=VlY7VmiwT2tzOdjTH3LuvVmqL5YyR5cJs6r78jpp9s7hquf3NklwsHwc1BQz2kYOj6mRPhK1toztnq0Alxc89Yjg6hoYPItxZUQyM5AVqnkZhvwofFCXYf9mftrGt1ZaNNbU3t918OE5XtLjP2cx6SgZ89OsRlsYKj0KieOl1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885565; c=relaxed/simple;
	bh=ALRdXW4pX4sHTd09bikJBPFPtH1YzMDGWThqbDooB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdhOk3VuwOjT7qLegJns27tQuoFjDF7qqry4jZFs+lvgmuua/AnLivjVshBT0UYOqCW/cO953idnEtvFw8epr3b7oHTwC2f7wliK/KeQ0FPJ6zC6XHjWBaPpZ5wxVVQPBo66zSVj0VnE6kpr5EQeUtV4Wu//cXDuthz6xJC8AgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAwfZLMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAwfZLMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D395FC4CEF1;
	Sat, 31 Jan 2026 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769885565;
	bh=ALRdXW4pX4sHTd09bikJBPFPtH1YzMDGWThqbDooB0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAwfZLMN7qwCDU2S4y33qoCZvUcb4wWodPOVhbdB5t/JELnLmX54wJ4T2eAxQaaEQ
	 5g1NWPKuYDXLoXA/hylOXmKdkcLXx5giXHqbiNQnfzXAvGGQuc3AhDvuceVJwTQ1zn
	 nHj0JhobbgDrKdrLFlz5aiAM+01KeKIHPR+kiH5+dw2x0W9RIyHTkGXcQDVvohQ9wu
	 VDDiR3pUDfd+uFfb5kLAsW6eq8V0pmHTIbU9El87oQg82t+7nJoV5cMksCVR/WIp1w
	 J/gF7L7QkXnleC9Ao++/iirfK6cNfuvIle/kDj8JV85W/XCQdJjFcBgD/de9TXu2va
	 JlAcdQd8FWdEg==
Date: Sat, 31 Jan 2026 18:52:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 nuno.sa@analog.com, andy@kernel.org
Subject: Re: [RFC PATCH v1 2/9] iio: ABI: Accurately describe
 in_distance_input
Message-ID: <20260131185238.675c93cb@jic23-huawei>
In-Reply-To: <aXA-p5p5dT3uBDva@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
	<b38d761e3d78d6121bd3f3de0908a156ad9ea277.1768759292.git.marcelo.schmitt1@gmail.com>
	<2d148091-9e40-41ee-95cb-544abcbf81be@baylibre.com>
	<aXA-p5p5dT3uBDva@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 23:49:11 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/18, David Lechner wrote:
> > On 1/18/26 12:20 PM, Marcelo Schmitt wrote:  
> > > There is only one driver (drivers/iio/accel/mma9553.c) that declares a
> > > channel of type IIO_DISTANCE with an info_mask containing
> > > IIO_CHAN_INFO_PROCESSED. Though, mma9553.c provides distance in meters (as
> > > would be expected for the _input interface). Split in_distance_raw and
> > > in_distance_input ABI documentation to provide accurate description for the
> > > in_distance_input interface.
> > > 
> > > Fixes: 7cf78db585b1 ("iio: Add ABI documentation for illuminance raw and scale values in light")
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > > Added a fix tag though not sure it's needed/desired since it might not be worth
> > > to backport documentation?
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index aec39b8e3345..27251b65ea0e 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1613,6 +1613,13 @@ Description:
> > >  		user). Units after application of scale are Joules.
> > >  
> > >  What:		/sys/.../iio:deviceX/in_distance_input
> > > +KernelVersion:	4.0
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute is used to read the measured distance (in meters)
> > > +		to an object or the distance covered by the user since the last
> > > +		reboot while activated.
> > > +
> > >  What:		/sys/.../iio:deviceX/in_distance_raw
> > >  KernelVersion:	4.0
> > >  Contact:	linux-iio@vger.kernel.org  
> > 
> > I'm not sure it is worth splitting these up since the documentation is
> > just repeated except for the bit about scale. And it is common knowledge
> > that scale only applies to raw and not input.  
> 
> It's common knowledge to us who are familiar with IIO. For anyone else, it might
> not be. Plus, it is tecnically incorrect to have _raw and _input together like
> they were before.
If it's caused confusion. I think it's worth splitting them.
If the repeated text becomes too large, we can use a cross reference.

J
> 
> > 
> > Also, looks like raw and input are swapped. raw it the one with scale
> > so the sentence about scale should be with the raw attribute.  
> 
> Hmm, have I messed up with the patches? Their final look in my local tree is:
> 
> What:		/sys/.../iio:deviceX/in_distance_input
> KernelVersion:	4.0
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		This attribute is used to read the measured distance (in meters)
> 		to an object or the distance covered by the user since the last
> 		reboot while activated.
> 
> What:		/sys/.../iio:deviceX/in_distance_raw
> KernelVersion:	4.0
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		This attribute is used to read the measured distance to an object
> 		or the distance covered by the user since the last reboot while
> 		activated. Units after application of scale are meters.

