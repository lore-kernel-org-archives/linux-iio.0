Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CD30C62D;
	Sat, 16 May 2026 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931542; cv=none; b=rUA89kVrBL0qTn/rVb+azeBx29LFm0U5uUkfyLgkLq2voHiNg7UcdW4Rn+/AeNA7AIcf5KYVR/u/NDq0DgepiE5SvBylVYiBz4Tw7koseaC+5LhGiK2sHEZr+dMA3IP+djRj0EhoW9rJR1OAq/hBIg4uu+E2xqfSzE3NccZAar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931542; c=relaxed/simple;
	bh=tFEB8nxGo12335xY/TcM4wiRXhshhkmKJYKNVDYt7t0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4jlwXbz5kLQRKYzEBNxOzSv98KCbrcvnGLRMq8Qhhr19/odoMefUkY+zufHf/5KOHKVfIbe8+M70E3y75buryPuOIwOYBda+BlugvbgdXoxXTizVxuj72HPImNDrm+2oycK0lcWrzagNRPcRzn2+/wNBUeHV/D7dBZ9j06RVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5k4Xt+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5k4Xt+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42AAC19425;
	Sat, 16 May 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778931542;
	bh=tFEB8nxGo12335xY/TcM4wiRXhshhkmKJYKNVDYt7t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5k4Xt+XjJDvmLIuRjxry94tF6mx8TIN1fZlihGmzndasAoDI/d39gok7zeOY5ymb
	 d2DfFZ2E/58D22emBKC9lnykjyKNB/BwHIb2zwFVJyU2xTSk0lWyDDua7rJV+mu8Gx
	 LpJQgZuSqxzD3CoDEUwUBEE+DFCiCn217OfJxs0Yr1XZilkrNX7vq1c2k2ID+YdXL7
	 xC7+9fdvo4dg0D9e8rVzaU0JUlNZxTB4ZAwqTNeK87/5EAo2GacPeQ67YoqcHYppDZ
	 Z+7Q23kKecf8EwDer3Uw/Nnu0Q3rsankXAzcDOOEcou0txJBwqQXz7lyw4vUBy7IRX
	 4WAwD5RB0a3EQ==
Date: Sat, 16 May 2026 12:38:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Abinash Singh <abinashlalotra@gmail.com>
Subject: Re: [PATCH] staging: Documentation: dds: replace frequencyY with
 frequency
Message-ID: <20260516123754.16becb25@jic23-huawei>
In-Reply-To: <CAMV7Lq7NqxO5cpy7zSrawBORWgtEhm2QTTgRtLptV9==yCs+wg@mail.gmail.com>
References: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
	<20260512150846.76f896a7@jic23-huawei>
	<CAMV7Lq7NqxO5cpy7zSrawBORWgtEhm2QTTgRtLptV9==yCs+wg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 22:14:34 +0530
Abinash Singh <abinashsinghlalotra@gmail.com> wrote:

> Hi Jonathan
>=20
> On Tue, May 12, 2026 at 7:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 11 May 2026 22:42:55 +0530
> > Abinash Singh <abinashsinghlalotra@gmail.com> wrote:
> > =20
> > > From: Abinash Singh <abinashlalotra@gmail.com>
> > >
> > > The documented frequencyY attribute naming is implementation
> > > specific and differs from common IIO sysfs attribute
> > > conventions.
> > >
> > > Replace the non-standard frequencyY attribute documentation with
> > > out_altvoltageX_frequency and document tuning word selection
> > > through out_altvoltageX_frequencysymbol
> > >
> > > This makes the documented ABI naming consistent with standard
> > > IIO sysfs attribute conventions and clarifies how tuning word
> > > registers are selected and programmed.
> > > =20
> >
> > Hmm. So some history on why it was done like this (long time back
> > but I think I recall the basic argument).
> >
> > Consider the programming you need to set up FSK on a channel and
> > the fact that someone is recieving the result.
> >
> > When you set the symbol to program it that channel will begin
> > outputting the voltage. That means someone at the other end starts
> > decoding it.
> >
> > Hence we normally expect to set a frequency 'before' changing the
> > symbol.  Hence the per symbol files.
> >
> > There might be a valid way to set them up using your proposed
> > interface but I'm not currently understanding what it is. =20
>=20
> I think I misunderstood the purpose of
> out_altvoltageX_frequencysymbol.
>=20
> I initially thought it was used to select which tuning word register
> to write into, whereas it actually selects the active output tuning
> word. That explains why my proposed interface was confusing.
>=20
> The ordering requirement you described for FSK setup makes sense now.
> With separate frequency0/frequency1 files, userspace can configure both
> tuning words before switching the active symbol.
>=20
> >
> > We went through the same dance with the more complex DDS that
> > Rodrigo is working on. Take a look at the multichannel approach
> > he is using.  It may apply here - I'm not sure.
> > =20
>=20
> With my approach we can have a new entry  /out_altvoltageX_frequencySelect
> which can act as a mux to write into FREQ0 and FREQ1 register
> via  /out_altvoltage_frequency.

We could but given that is custom ABI anyway, what is the advantage over
per symbol controls?  Generally 'mux' control sysfs attributes are harder
to use than separate files.  For starters you'd also need an
out_outvoltageX_symbolcount or something like that to know what values
can be used.  One file per symbol and that is explicit without yet
more descriptive ABI needing to be defined.


>=20
> I will take a look at Rodrigo's multichannel DDS approach before
> proposing any ABI changes further. It would be helpful if you could
> share links to the relevant discussion or patches.

https://lore.kernel.org/all/20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@an=
alog.com/

and the earlier versions of that series.

>=20
> > =20
> > >
> > > Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
> > > ---
> > >
> > > The out_altvoltageX_frequencysymbol and
> > > out_altvoltageX_frequency_scale attributes can be added
> > > through extended channel attributes (.ext_info in channel_spec struct=
 of IIO)
> > >
> > > Feedback on this approach would be appreciated, and if
> > > there is some other way in your mind. I would like to
> > > work on that.
> > >
> > > I am also interested in working on the sysfs-bus-iio-dds
> > > documentation and the ad9834 driver. I recently bought an
> > > AD9833 IC for experimentation and testing.
> > > =20
> > Excellent!
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > > Thanks =20
>=20
>=20
> And do we need to really work on this documentation in order to work on a=
d9834.c
> What else can be done in ad9834.c apart from this naming.??

The challenge has always been the ABI for these.
We need to work out what it should be (which is kind of what Rodrigo is doi=
ng
in his RFCs) before we commit it in stone.  Whilst not ideal, we can evolve
an ABI for a driver in staging (for IIO anyway - be careful in other places)
but not once it is out of staging.

Jonathan

>=20
> Thanks
>=20
> Abinash Singh

