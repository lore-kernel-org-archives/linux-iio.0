Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039239;
	b=da3k9lCUUDKyCeuT3FcXT8gvw2eGrUoasUpB+NnsdJd81qCZp/qusl8g2NS0h8FLxHiw
	 XAyRW5FMUibMcZsdNTIqO1SuIIIKMprmx5gUzMhAYe/ZfX4R3qreknFXRQRyb1VKDvv01
	 0kOrqViEVw4y1MXODIJOTVa2ghosVXvhwc3+1CILauGcn0u6X9njiJ1BmEFt1IedjzLBa
	 dYyaUGOuR/Qpone/dMkTWM4wVLECebFurV/SbXqDlAq508dRnOl624dx3Ti4W/kcH83AD
	 /nguU2jePtg9aZZJmBBaw0SevY3W5XN08iPVth21zbJmfRo2FwZju1Wyzg2Heo336dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EW/j4AHQToanR4iAnbKrwXf5ZMy3lNHSEzakLY3OOkE=;
	b=0yMh6Z9Xm9YU9NRcnemlkQkcf6qlwUiLeR+oN9Fj5uaJ3pqCBhb2PMu+96Vu/NWsAb0U
	 7CEYeR8tOUBw99MHDDi3gFhvKCdP5GHzucUS1D+aS9G4C0uM8ZjUickcM44fIj6FstgWo
	 nofgS4R31reOBgTC0l7uf9ggvRB1x6j+h8eUYi7MHLdSbe3ndZJVMfHsgaRTFUBGZvYLe
	 DTqL2oxw2rbzzb1/BDaGIzEPeDPmuWGluyJHW3NjXSE+kRIgQ1znJskz18LJwaoVKN4IC
	 YV+51pq5gLHzz78/4MF5vlMQJa0YJTwww3DkfRhBsxz9EqyAJTLB8wbwQx6nnhpeSeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EHUn/RC5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F562606A330;
	Wed, 18 Nov 2026 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHUn/RC5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045061F000C6;
	Wed, 18 Nov 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039239;
	bh=EW/j4AHQToanR4iAnbKrwXf5ZMy3lNHSEzakLY3OOkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EHUn/RC5tq2E/sDD9KuZBuc3WUNlBitDQRQ+XXA1pPaXDyVDr72v8dR3Brnq6I1xl
	 mNBEKAeHSOwM0jXRISwmZOmN4sJ+XwdJBqkRvpknbqHFAuqmUqOygSxJ9uoPeIQuCC
	 akBNA4P5pGfE3qK8Ifv3d5xCPfpqnRQaAo6AOAf6s/UVAYVxezDqOr5ikwifG7GoyP
	 bMmpEatW+uw7d3bAdqC8cop/FIjYHIQ9sIda0QL8qnIdo6db/aDqvAbav1GMeMEGJt
	 yY70g+ClHORIh8mv5OS8JLNxaMVGMu3JfkazYlhhwg9CcGGjCN3moPgI6WSXngWzql
	 Nw+BAauBDDRUQ==
Date: Wed, 18 Nov 2026 22:00:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, Benson
 Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Tzung-Bi Shih
 <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Introduce cros_ec power monitoring
Message-ID: <20261118220033.70425495@jic23-hlaptop>
In-Reply-To: <20261118204532.257423-1-dbalint@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
	<20261107010356.39d9eddf@jic23-hlaptop>
	<20261118204532.257423-1-dbalint@google.com>
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

On Wed, 18 Nov 2026 20:45:32 +0000
Daniel Balint <dbalint@google.com> wrote:

> On Sat, 7 Nov 2026 01:03:56 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Hi Daniel
> > 
> > I'm not necessarily against this but when adding monitoring components
> > to IIO the usual question is why not hwmon?  What features are not
> > well supported by that framework?
> > 
> > Note historically I suspect we accepted one or two drives into IIO that
> > would have fitted better there so precedence isn't a strong argument.
> > 
> > Convention for these somewhat borderline case is +CC hmwon maintainer
> > and list as well as IIO with that explanation in the cover letter.
> > That avoids any last minute surprises!  
> 
> Hi Jonathan,
> 
> Thanks for taking a look!
> The main reason for choosing IIO over hwmon is that for On-Device Power
> Monitoring, userspace needs an atomic, untorn snapshot across all rails
> (up to 64) over the same integration window, triggered on demand from
> userspace and read out in a single buffer read rather than repeated
> per-channel sysfs reads.
> 
> Reflecting that requirement, EC_PWRMON_LATCH on the EC is a global,
> stateful command: a single latch simultaneously snapshots all onboard
> power accumulators and resets their accumulation window on the EC, so
> individual channels cannot be latched independently. As far as I know,
> hwmon only exposes independent per-channel sysfs attributes with no
> multi-channel buffer or on-demand trigger ABI, whereas IIO's triggered
> buffer interface is well suited for this kind of pattern.

Ok, but that's not in the driver yet. I see you refer to that below
as a v2 thing, so not a problem.

Do you need that coherent snapshot to get to userspace in one go? 

For accumulator channels the way they are normally done to sysfs
style reads is to snapshot on each read, update an internal store
of accumulation since enable then provide whichever one was requested.
That way no data is lost - but you don't get an aligned snapshot.
So it depends on what maths you are going to do with them, whether
it can be done in kernel and if not how much interchannel skid
matters.

So tell us more on why you need that coherent snapshot to userspace.

I agree that if you do, then hwmon wouldn't currently be a good fit
(unless I'm also missing a way to do it).

> 
> CC'ing hwmon maintainer and list to keep me honest.
> 
> If there is no objection to adding the driver to IIO, I will clean up the
> custom energy_value attribute and replace it with the standard IIO
> triggered buffer interface in v2, along with addressing other review
> comments and including the above explanation in the v2 cover letter.
> 
> Thanks,
> Daniel

