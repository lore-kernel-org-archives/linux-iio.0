Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670FB377EBA;
	Tue, 28 Jul 2026 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274734; cv=none; b=fjFYKoG/HjC5hjckdAMg6nmEuhY/XxiMVZuoveZlKscncI8/mG1ik15w9k4UrTsC+h5rIPobwvZnfuFcSHbisd28E2OAegV46PMbxRB4XjblOTM/duSZii1pDaCtHvY3m1/jvkNljFeDOXplZr6PkXsJ+bIsOadKbboeCw+XbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274734; c=relaxed/simple;
	bh=RQ3ShZ+udcLQC4huC/oT9zjnJvS50/825XG4Q9C/AM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRJvnAey4UCEOPdczI6jga2aQSSCuUkqzrpx/OVSsOL3LmgClHq2kCb7pg1QL6D+jv3gPPqAin8zD2JlIBQwSgA3kX1af5TqumC2B78j/tUj2KuHMbik6jXq+Kk8YMlBHn+tskcgoCXjcSonAO0oGqYGTFB6XJJhDAQp6VCJM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN3NXmk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN3NXmk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16F01F000E9;
	Tue, 28 Jul 2026 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274733;
	bh=WqinqkJB2bqsVkejxdMHQAl/VI+juu7i1MgYhYIzXlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QN3NXmk2iP94YYvIAlPIdhISOhXaMx5TnedLZvAiaZGUbemxwal9ga+bzTry3JnWL
	 qnPWCFGrjAnSeIzn5yZeKlLUmqcL/FDJe/pAcDyfcvAnGApXPHDT/fFxQTs48/CVTN
	 x5JLDKXbT+1QQi2w5yzQmUTE8bef/hRKPmF5m9bT60A+bFsbNf9xpW1eOIE6Ahscyh
	 LIpenV0pDO/1V4mORxmqxOKJsTJXAwnyBX083lYVd/kHo/QYSUgS3aqPjoZbdP5MgY
	 gZhPxFzWVaeVXYZtNa5yCUiaWaPpf1x6yFWVCeUEoVA5+gcgLn76TGUHP9LX10vow2
	 1DgbINvJdy3CA==
Date: Tue, 28 Jul 2026 22:38:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, joshua.crofts1@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze
 <giorgi@tchankvetadze.com>
Subject: Re: [PATCH] iio: light: veml3328: remove redundant cast in
 read_avail
Message-ID: <20260728223848.5736c529@jic23-huawei>
In-Reply-To: <CAE7dp2qeg=Zzrr+cqOEJOnn7UudiD=a=_578T3OzKCPTX28JmA@mail.gmail.com>
References: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com>
	<90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
	<CAE7dp2qeg=Zzrr+cqOEJOnn7UudiD=a=_578T3OzKCPTX28JmA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2026 17:50:23 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> On Mon, Jul 27, 2026 at 5:16=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > Usually, we would declare the array like:
> >
> > static const int veml3328_scale_vals[4][4][2] ...
> >
> > in which case this cast would be needed.
> >
> > =20
> I intentionally kept the patch tiny and dealt with the obvious thing,
> but yes, I agree this is how it should be done.

I think it is worth making the more complex change to improve the
readability more generally.  So if you don't mind, please do that
for v2.

Jonathan

