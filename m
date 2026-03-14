Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7191EE7D5;
	Sat, 14 Mar 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773487081; cv=none; b=DJzfrFkAchwe0ADNz4sWgDDrsqNCpMdXqMW+JYjWRGVCAU16T+kiL3NQEGmm5QHQcS4d8ZzQCjPMDbuHDgZhJU+9qZal8OG6SdkUgl9cCT96u/gvenhVdpesvI+HeSKFnzmtq+CCKRWDJPxiUElFebOyPYNupPJhWHXi/lOIEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773487081; c=relaxed/simple;
	bh=+X6ekc+juBndZfhDr5Cki9FfQkuBL/nJ6v+dd4hZGRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+ne9mKwSqUEwPOeY5b4S+Vl+qTcJclsqtyrS2yd2TAetEu1hrFwm25OvKezq5oYo/iavH/FccxwkZbFUdC9bUHec5MvenOnHVTx3wQx9vbYGnZnHiq5MQGPNz1D+wzxXJCt7Ic7bJhQ1uWmttSokH2NKxw6pITNUxNHq3V5X1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRkyXpEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRkyXpEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA7BC116C6;
	Sat, 14 Mar 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773487081;
	bh=+X6ekc+juBndZfhDr5Cki9FfQkuBL/nJ6v+dd4hZGRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GRkyXpENL3DX67TTB9dpa68LUE9XxZvCFTeT4fBPEaoHXQq+esUQToSwmca+ardub
	 WpND+wPq4ve5Pa8kcAwUgKcGwEUNnnKHgeDTnL16Jd5OtZgCu2cR3ouqBOxorthx6P
	 h+Wl5Z2DzJZEolkHMHRyxOCtPt6/G+KWkkSxNx0MFnQPsgGQmfr5aezUlavpzRc/a/
	 Z7hczumtm8QZG9boY/m8S9bNv73w7bI3j6NdTfRXNyQ1+D7Nb3P64vA/zn7BMo0Lc7
	 SIlOYvzhmD1X/4f//47+CX7dmeUNQIjhiDGCm2CHhcmMjeQr0G+zO7h4RPMTQdhyym
	 7O6hOZWyTDjAw==
Date: Sat, 14 Mar 2026 11:17:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: rfd77402: Fix completion race condition
 in IRQ mode
Message-ID: <20260314111748.3f7e3c4e@jic23-huawei>
In-Reply-To: <CAHc1_P63xwVnn1mO8Qwxq=r9L32JFdS_hqigWKU3gHMeweN9eA@mail.gmail.com>
References: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
	<CAHc1_P63xwVnn1mO8Qwxq=r9L32JFdS_hqigWKU3gHMeweN9eA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Mar 2026 22:32:58 +0530
Shrikant <raskar.shree97@gmail.com> wrote:

> On Wed, Mar 4, 2026 at 7:44=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wrote:
> >
> > In IRQ mode, the completion was being reinitialized after the
> > measurement command had already been sent to the hardware. This
> > created a race condition where the IRQ handler could call complete()
> > before reinit_completion() was executed. Consequently,
> > wait_for_completion_timeout() would fail to see the signal and wait
> > until it timed out.
> >
> > Move reinit_completion() to occur before the measurement command is
> > triggered to ensure the synchronization primitive is ready to
> > capture the interrupt.
> >
> > Fixes: dc81be96a73a ("iio: proximity: rfd77402: Add interrupt handling =
support")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> >  drivers/iio/proximity/rfd77402.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/r=
fd77402.c
> > index 6afdbfca3e5a..81b8daf17a54 100644
> > --- a/drivers/iio/proximity/rfd77402.c
> > +++ b/drivers/iio/proximity/rfd77402.c
> > @@ -173,10 +173,8 @@ static int rfd77402_wait_for_result(struct rfd7740=
2_data *data)
> >         struct i2c_client *client =3D data->client;
> >         int val, ret;
> >
> > -       if (data->irq_en) {
> > -               reinit_completion(&data->completion);
> > +       if (data->irq_en)
> >                 return rfd77402_wait_for_irq(data);
> > -       }
> >
> >         /*
> >          * As per RFD77402 datasheet section '3.1.1 Single Measure', the
> > @@ -204,6 +202,9 @@ static int rfd77402_measure(struct rfd77402_data *d=
ata)
> >         if (ret < 0)
> >                 return ret;
> >
> > +       if (data->irq_en)
> > +               reinit_completion(&data->completion);
> > + =20
> Looks good to me.
> Reviewed-by: Shrikant Raskar <raskar.shree97@gmail.com>
>=20
Applied to the fixes-togreg branch of iio.git. Note I just sent a pull
request on that so will probably rebase after that (hopefully) gets
merged into char-misc-linus.

Thanks,

Jonathan
> Regards,
> Shrikant

