Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E135F16C;
	Sat,  7 Mar 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888600; cv=none; b=WLO6XfGc2sOG2XONmRo4N9aKJqXERiJ9lmEkGNTMBy+MJuE6XWza8exwJmUXCsOoxD31U9m0SObRuZ0SgKqJSFwaRr+6NCNQWrAn/1Yry++e4HQyO9/YyKKTVIkBXUwPQp4m8kWuM3iCmkMjUOreEC9vu+5MkngwGblBe6+weVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888600; c=relaxed/simple;
	bh=lRpDj0VuyGwln7PgEBz+0ozbTQYHQsFZgqtsANP+7uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BypraoW69l5s0C/aBW9/zyXbiB3L3CrdiO8dtRAfQP8T9AkhOu8BsRj9yknNdaDKVLLfULiyupHEcamvOp6GoqSPJmO5zbxxJ8Q2H5uIw5KDNI4KgAoxw2FWYChrUqGJ6qgUm8q/VWGUatl1TfnACQgBup4OgyI+3gIrOBrgHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpiPnGUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpiPnGUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF59C19422;
	Sat,  7 Mar 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772888600;
	bh=lRpDj0VuyGwln7PgEBz+0ozbTQYHQsFZgqtsANP+7uI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OpiPnGUJiFVRj4b9MQZ0U+kTZnRt3DEZmoYO+RONSlpeG5M0CAJbugAFRWVB3iwqS
	 wflMUT11FuQGDm4Cq+ttf540bNjU56T8lI6xAs/VUhUytWoixxL0EQJlvLh/2y7eWt
	 XTCJtzHd2hQswHWH9HHqmfhDeDqgd+Kx2GktEFV0j1rY8iFK5k+YUNglN+GwTXFKtb
	 jIODQm7Qnm3PcjvNrdJeNOWYGPdaLkUL836RlzBt3EtuikztxVQ50xnUlJV5fMz4Vc
	 tmALQN2U6lwBsFhL1JTcDUIcl8MCN2d1jsxnC1hKta/cJV5HV+SBFvGqknzGY5ogeO
	 q3juU3M//DYxw==
Date: Sat, 7 Mar 2026 13:03:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <20260307130312.2efd100e@jic23-huawei>
In-Reply-To: <77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080706.2844472-1-flavra@baylibre.com>
	<77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 16:35:39 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/4/26 2:07 AM, Francesco Lavra wrote:
> > This modifier applies to the IIO_ROT channel type, and indicates a data
> > representation that specifies the {x, y, z} components of the normalized
> > quaternion vector.
> > 
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
> >  drivers/iio/industrialio-core.c         |  1 +
> >  include/uapi/linux/iio/types.h          |  1 +
> >  tools/iio/iio_event_monitor.c           |  1 +
> >  4 files changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index bd6c3305dd2b..54e38ebb044d 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1755,6 +1755,19 @@ Description:
> >  		measurement from channel Y. Units after application of scale and
> >  		offset are milliamps.
> >  
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_partial_quaternion_raw
> > +KernelVersion:	7.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Raw value of {x, y, z} components of the quaternion vector. These
> > +		components represent the axis about which a rotation occurs, and are
> > +		subject to the following costraints:  
> 
> s/costraints/constraints/
> 
> > +		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1  
> 
> Isn't this usually written with w first?
> 
> > +		- the rotation angle is within the [-180, 180] range, i.e. the w  
> 
> Best to say the angle units. IIO standard unit for angle is radians.
> 
> > +		  component (which represents the amount of rotation) is non-negative
> > +		These constraints allow the w value to be calculated from the other
> > +		components: w = sqrt(1 - (x^2 + y^2 + z^2)).
> > +
> >  What:		/sys/.../iio:deviceX/in_energy_en
> >  What:		/sys/.../iio:deviceX/in_distance_en
> >  What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 22eefd048ba9..792fbeb0dfa8 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -125,6 +125,7 @@ static const char * const iio_modifier_names[] = {
> >  	[IIO_MOD_LIGHT_UVB] = "uvb",
> >  	[IIO_MOD_LIGHT_DUV] = "duv",
> >  	[IIO_MOD_QUATERNION] = "quaternion",
> > +	[IIO_MOD_PARTIAL_QUATERNION] = "partial_quaternion",  
> 
> We've found that using `_` in components of the attribute name makes it
> difficult to parse since you have to know all component names to know
> where the break between components is. Each time we add something with
> an `_` means all parsers need to be updated to handle the new name.
> 
> In other components, we've just squashed the two words together without
> any space or punctuation to get around this problem. I find that rather hard
> to read though.
> 
> I wonder if we could propose something different going forward to do a better
> job being consistent and readable. For example, use a `-` at the word break
> in components that have more than one word in the name.
Whilst I can see the argument, I'm not keen on more punctuation in the filenames.
May well trip up someone's parser.  For now squashing the spaces is probably
the best option.

This made me spot a major issue though. We can only add to end of these
enums, not the middle!

> 
> >  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> >  	[IIO_MOD_TEMP_OBJECT] = "object",
> >  	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
