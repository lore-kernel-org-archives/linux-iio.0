Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BC4B8DEB;
	Wed,  6 May 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090049; cv=none; b=l1at4zB4+/Saz3c8gWbhMrHhmX4+DCQMwrFVW6886tzKYPSxJLUiNmDuyYgHm+fsz+AyBa4k+Lhmt15NAVHcrsWuYbKqWMZW/mMJB5oa6BZFlL7dziCS/Lua5cSF0SwzDwMCul+4GhlbkkHPtdDmDR32u74Z9BZ1DHzYbP9crMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090049; c=relaxed/simple;
	bh=+Ob7CahNfGgNUgGSAMNdSSBE8aZsX/LgN5QgRpdOy+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnP6ZwJ4pGnWDiFBoFhErnW4775ji3+yrY/Yg2OaaKhL+s0m5i8AcZNmgi/bpcrXE3oiLMVE7RuXSNVJ7EMkTnReE+4H+DAyMaCCkME2j9332sXdEtUP+1jr+tJmYdsNj264srApjrXrI84JgxNFaAq2I0VxdFmgG9I1A5i7Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyWvYRH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyWvYRH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C5C2BCB0;
	Wed,  6 May 2026 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090048;
	bh=+Ob7CahNfGgNUgGSAMNdSSBE8aZsX/LgN5QgRpdOy+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyWvYRH5JBJHr4uFFF16PSc6rsSix/Jdm3NtSKSWJUhNKKyhA+uCQNI1wrVTpPFrd
	 3QeN51NMxioJS3GZurDZENZx9ifH4JNROKGUnNNwSZKePG63GW/YMV7W5P5Bq8lNAv
	 UTCjDOUyztfkBCfrAD8E7hHliG6nZNCfuwtNdxORuA28WTCw7SUR0Hbzd5HZiOgThe
	 jvYHFCUj15BM4+baH17wnWR70J28aT+YD406As7gxo293r9CUGvo7IVY5+ZASpAimc
	 mX92CHr3ky/6rp9tglKFDnURmJFsHINFi1/Ihw5uyDhx6CvtU/liHMLyZxCy3QAc+l
	 KnkCrVwYtMhLw==
Date: Wed, 6 May 2026 18:53:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 christoph.muellner@theobroma-systems.com, martink@posteo.de,
 mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] iio: accel: mma8452: cleanup codestyle warning
Message-ID: <20260506185359.68a43855@jic23-huawei>
In-Reply-To: <CALoEA-yUHJb=coHuPYjrVhP_Vmvvi7qKxkXJqTp3qXRQ_wuG8g@mail.gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-4-sanjayembedded@gmail.com>
	<CALoEA-yUHJb=coHuPYjrVhP_Vmvvi7qKxkXJqTp3qXRQ_wuG8g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 11:24:25 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 5 May 2026 at 19:48, Sanjay Chitroda <sanjayembeddedse@gmail.com>=
 wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Reported by checkpatch:
> > FILE: drivers/iio/accel/mma8452.c
> >
> > CHECK: Alignment should match open parenthesis
> >
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  drivers/iio/accel/mma8452.c | 47 +++++++++++++++++++------------------
> >  1 file changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 279a9b364886..916631519d3f 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -706,8 +706,8 @@ static int mma8452_set_hp_filter_frequency(struct m=
ma8452_data *data,
> >  }
> >
> >  static int __mma8452_write_raw(struct iio_dev *indio_dev,
> > -                            struct iio_chan_spec const *chan,
> > -                            int val, int val2, long mask)
> > +                              struct iio_chan_spec const *chan,
> > +                              int val, int val2, long mask) =20
>=20
> This is still not aligned by 1 character, it should be aligned with the f=
irst
> character after the opening parenthesis.

Hi Joshua,

Trap of reading patches in emails is that tabs and space combinations don't
always look correct. Also your email client replaced them all with spaces
to add more confusion ;)

=46rom origin patch

 static int __mma8452_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
 {

With the leading chars removed removes one space from top line
but nothing from the following ones as they have leading tabs.

So you get:

static int __mma8452_write_raw(struct iio_dev *indio_dev,
			       struct iio_chan_spec const *chan,
			       int val, int val2, long mask)
{

So this is fine.  I haven't checked the others but guess they are the same.

I frequently end up testing this by hand when I think indents are off
and often turns out I'm wrong!

...

>=20
> The rest is correct though.
They all have leading tabs on all lines.

Jonathan

