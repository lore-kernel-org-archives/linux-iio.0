Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07902798F8;
	Sun, 23 Aug 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523622; cv=none; b=k4HD5jn5frc3tD8JrusbYeXJuVvA7UKbz401f/ADL8Ai3Efra8Y8G16oVNsJGpv6MshXeVu1W1nkB5hNpC4UifcDn90K90pc2Je6g3FsFgDp8y6CRkD6+bYeD5AekcE24zdchgqrwHo7OFOWM5wKEq/g1e7p9IMBM/71kemSpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523622; c=relaxed/simple;
	bh=ecaY7Cn/nK2TpS39eeXykNbyyUmTp11m2bcB8FINFeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl0DuJf6r7hXaEnWMOnoDJJrF+vtZR2s7TpsO11mTsc7U3s1BGnbHrkXf0G0qlay2gW8eE+N9/bJYNKgtw67scmoghElE2CM/HdJK6mW6+DUusLTGn8EQ24EFkw/2GC6eMvSmXm/2hTx+vGrKFmRgQATCx6kDSt9ClGNAu/smNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbn3GVIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbn3GVIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459961F000E9;
	Sun, 23 Aug 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523621;
	bh=qqiRFwf4uT2MeXy+VYXwG9Y2wJXiqkdT9gKM8WnSxg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bbn3GVIfQsj2yWCyLMn2KQmbVdV2cQxWPucDNdUmpN1enb8D7wF0aw3ZFdNJ4RhEa
	 vokmVMtK4D60H6Y/WUkaDF1r9z+EBvI+Cbt5a1RzKrpjhwQbREc8CY6v+u1O1X/ddc
	 TICYmZhMPWXY6B6mfSaSSXczWb+xEjfsCRtT0ywSyjSPuwPvBlsdo2ieFfe6Jb5Non
	 PR7NVS5JckXFx/vATaK221Aedru2jK6eEDC+O7h+/2v4rAeIs9zNYbyqADVrKDEscA
	 EBZ+u8dCVqR9UI8ZMQaIOdb73mvDPqRDw9cHil5N+SPQulZajgSTzNhpC5edofpowu
	 UlpAWCeuDpRQw==
Date: Sun, 23 Aug 2026 23:20:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ti-ads112c14: add burnout current support
Message-ID: <20260823232018.6fad4bbd@jic23-huawei>
In-Reply-To: <20260727030822.3766f628@jic23-huawei>
References: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
	<20260727030822.3766f628@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 03:08:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 24 Jul 2026 15:49:16 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
> > The TI ADS112C14 ADC has a feature to enable a "burnout" current when
> > taking a measurement. This can be used to detect open/short circuit
> > conditions of a connected sensor. However, enabling this affects the
> > accuracy of the reading. So we add a custom "burnoutraw" attribute for
> > this. This works like the standard raw attribute to do a direct read
> > but does so with the burnout current enabled.
> > 
> > If this sounds familiar, it is because we discussed this on a similar
> > chip recently [1]. And this is why I put the ABI docs in a common ADC
> > file rather than one specific to this chip.
> > 
> > [1]: https://lore.kernel.org/linux-iio/20260622110223.7e854dde@jic23-huawei/
> > 
> > Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>  
> 
> Seems fine to me, but given it is new ABI, I'd like some more eyes on the documentation
> patch in particular.

Seems no interest in this from others. I've no idea what this was on top
of so please rebase or resend alongside those other series.

All I know is it doesn't apply to my tree  - which isn't that surprising
given all the series around for this driver!

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > ---
> > David Lechner (TI) (2):
> >       iio: adc: ti-ads112c14: add burnout current support
> >       iio: ABI: add sysfs attribute for _burnoutraw
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio-adc |   9 ++
> >  drivers/iio/adc/ti-ads112c14.c              | 126 ++++++++++++++++++++++++++--
> >  2 files changed, 126 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
> > change-id: 20260724-iio-adc-ti-ads112c14-burnout-184304669165
> > prerequisite-change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3:v2
> > prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
> > prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
> > prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609:v1
> > prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
> > prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
> > prerequisite-patch-id: ed5d4c1628ef60ed542339fe5fb490383ee8074f
> > prerequisite-patch-id: b92f5609fcf39e958e78b4dd74c3d323ebb6a161
> > 
> > Best regards,
> > --  
> > David Lechner (TI) <dlechner@baylibre.com>
> >   
> 
> 

