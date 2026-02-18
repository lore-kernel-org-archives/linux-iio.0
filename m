Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95E1DF271;
	Wed, 18 Feb 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438753; cv=none; b=V6936f6d6zGQhHJ/Vvx5Q0BBUEi9/rvUX6eOExDNoE4iVuygXf8VMNboOWzzxt4NICPMefVg146unCyuVmrXfPvrK+URvHG31zIlO8CfH89j5OSfVveUFFrVGPABIB7gj6hZziCKV3zPXF6xby98AUhV9yoF1YEb3kQWzXmFof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438753; c=relaxed/simple;
	bh=6aTTV2D4GFbT9AcSSsbxK6cVpicgRb5RWvt/cwVA1sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSM6TuKhi4myB4csU1B82fa+mjp/xRvnt+VYM/pJqEcqCOf1a4AqMpnzHs0aOW/iSfxpAeT8Lf+MAozPLhWcntm+ifZXcsV/vj8hjHUBvl0M7DOHSZIOVaySyMRltokTLC4B547Av9AqVcG5B+BVTeq9aj4Q+ceVrfGH7CuzRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmBMhBeB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmBMhBeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF70C116D0;
	Wed, 18 Feb 2026 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771438753;
	bh=6aTTV2D4GFbT9AcSSsbxK6cVpicgRb5RWvt/cwVA1sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmBMhBeB71qKwrUWyVjfoZbTWAZ5eDvXzTjLaF96LYav+WSumGPi+qzADjZqVj1dS
	 6EeaVMrvMq76zep+//Mly6I+q3BCnHoQYTI/A1Ql7GJmL1TqcaSn3XDJac6guRK/Is
	 ixGXDNIHL7U6Dx3VUKTXDDVctL0uEDVCL7uH6Vs0vkkOm/NFgwx0DT2+ho5YprzH7N
	 Cicb8Pr3hjo1pAYYKmIndY511wZoCB1I/8XCTH+eO6cJgkypXRW4t/oieTAUmHhA6R
	 mDr0g4NQPvScp79nxDcGksK40BfM6Tor5xMieBs88YG9z88exWktDNUP/PVXkk4+y0
	 Z/XeNtU7w+NgQ==
Date: Wed, 18 Feb 2026 18:19:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Gabriel
 Shahrouzi <gshahrouzi@gmail.com>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
Message-ID: <20260218181851.46b339a7@jic23-huawei>
In-Reply-To: <CADJHxWDXqgpbK1+cffhPeTEz95L0zeCGGWb96_QwuxjEofBNKg@mail.gmail.com>
References: <20260122145633.14938-1-architanant5@gmail.com>
	<aXI-ZV4uAd5GyFLz@smile.fi.intel.com>
	<aXI_HnvDNbX68-lq@smile.fi.intel.com>
	<CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
	<aXJmYAZ-8KkXCFI9@smile.fi.intel.com>
	<CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
	<b27c638e-f0fb-42af-978f-89e38dea2b23@baylibre.com>
	<ca488ef9-f4f1-4f7e-9656-8c5d132d0d1c@baylibre.com>
	<CADJHxWDXqgpbK1+cffhPeTEz95L0zeCGGWb96_QwuxjEofBNKg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Feb 2026 22:16:19 +0530
Archit Anant <architanant5@gmail.com> wrote:

> On Tue, Feb 17, 2026 at 12:34=E2=80=AFAM David Lechner <dlechner@baylibre=
.com> wrote:
> > Actually, I just saw this was in staging, so I guess not breaking users=
pace
> > isn't the top priority if there the other way is objectively better. I =
would
> > assume that testing/measurement could show which is actually correct. =
=20
>=20
> Since I don't have the hardware to perform those measurements and confirm
> if the precision improvement is valid or a regression, I will take the
> conservative
> approach for v2.
>=20
> I will send a v2 that only replaces do_div() with div64_ul() and uses
> BIT_ULL(27), preserving the original (mclk / 4) logic to guarantee no
> behavioral change.
>=20

I started writing that I didn't care either way and given the chances of
not having to fix some ABI up on the way out of staging is near zero
(which would break any userspace anyway) but then I took at look at the
log.  We've had a fixes for this fairly recently!

Might imply Gabriel has hardware? (or a 'healthy' interest in
reading data sheets! :)

So +CC Gabriel who might have some insight.

Thanks,

Jonathan
