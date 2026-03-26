Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1F25776
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512864; cv=none; b=uUyV1DJSlKkWzk99sTOu7NUu2MfHBFbGIscTQ+W5XcujYyl7fesJx54sx8uprlcqcsgBO0gKQZ7JHlxpzGiJiuq6CmuCzeiVfp5jpmPX6US5+FtuA9R0uSuTB09z9X5pjkIz/5bCU/Mp9wmc/W6GR+LXMnnblsZsTGi5sg7+F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512864; c=relaxed/simple;
	bh=l+u3whK5LO57kB+ZuDeUNTnyQS/8L90B0JtF+UeCmMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7uFosCNHQW+jI2JvJljlKbB6R11sgjJ1fuy5tzFZDFBPmH5nBmD+TXU1rGJtxEMDOZ+rUk3R7k+NnlcrlpRaxXkJNmdkiqGRIc50hihgiv6ccePTKJLp95lGeb6kh6t6CQPXX4IFkvwdcchRCbym49xZejDzPSFWxewKFP3vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXOzHYbH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXOzHYbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9772DC116C6;
	Thu, 26 Mar 2026 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774512863;
	bh=l+u3whK5LO57kB+ZuDeUNTnyQS/8L90B0JtF+UeCmMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DXOzHYbHN4yO857eb88xDIl19NhBjPV2oTleU5tBKzgHwRbZN4aJZypDKyZHNDinp
	 4C37sM16E6aIHDMAIDAUuo9acmMzFlXlIpwktBoS0pTMyQ34VfCMhfAvRqfIvIoZN8
	 vhy294pGCPGvr1V2XqM8fNT0fYgvQzxLQQnRSdWcGBqSyFq4THIDtxHz+j9RQDiagH
	 9w97wDyMlb6Z1yELPcQ0wSTVDXrep+SSvraESooHUJh5R94VF85SXEXIISPsSTV4vh
	 BB4fjWrO3W7O+zNNZTcYZZ9FWDTRfNVsns6vhyfKHdF8+q2AMzkCS12k3bpCBmG/oJ
	 JAqZ9iMJEQ73w==
Date: Thu, 26 Mar 2026 08:14:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
Message-ID: <20260326081417.6b949211@jic23-huawei>
In-Reply-To: <CAE7dp2oFaheJMcK_khRRSZnQpAVN8Lgsy_phZsNO=spcbJU+Rg@mail.gmail.com>
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
	<abfVKws8hF4bUbv5@ashevche-desk.local>
	<20260321210833.7268a3b1@jic23-huawei>
	<CAE7dp2qUM3Sza1endobT44VqAdwoBFqXb77MAfaFK1h8tJkOGQ@mail.gmail.com>
	<20260325204039.582cce84@jic23-huawei>
	<CAE7dp2oFaheJMcK_khRRSZnQpAVN8Lgsy_phZsNO=spcbJU+Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 12:06:13 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> On Thu, Mar 26, 2026 at 12:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
>=20
> > > I haven=E2=80=99t done a full sweep across iio/adc yet; this was a lo=
cal fix.
> > > Given how broad this kind of cleanup can get(fixing formatting in
> > > multi line comments in the entire iio/adc directory), I assumed it
> > > would be preferred to keep the scope limited rather than risk missing
> > > cases in a larger series.
> >
> > How big is it looking?  I wasn't expecting these to be particularly com=
mon.
> >
> > Jonathan
> >
>=20
> Hi Jonathan,
> I took a closer look.
> There are a handful of similar multi-line comments across
> drivers/iio/adc.. However, a good portion of them
> are file headers, NOTE blocks, or structured comments that appear
> intentional.
>=20
> There are some cases similar to the one fixed here, but overall it
> doesn=E2=80=99t seem particularly widespread. I think , not widespread en=
ough
> for patch series.
OK.  If you want to work on this, send whatever tidy ups look sensible
to you.  I don't mind how you break them up into patches / series as
long as finest granularity is one per file. Somewhat coarser is also
fine.

Thanks,

Jonathan

>=20
>=20
> Regards,
> Giorgi

