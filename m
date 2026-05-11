Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B532860F;
	Mon, 11 May 2026 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500323; cv=none; b=KTJFi3CTs8ko0PWndleCzRpd0ymxbKgkvgiv5fLARlN9JKBs4xVcl7tI/yoTlU2FkYXpYtjKD7xUiD/nHzbLpUVfRO5D7N6ruYJaN3U9DJxl6uniTMy27ZqFu2G9lF4cxcrGc70+w3Bz7q7ddpVYNol1lJnNxq7R9wt7s4/5NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500323; c=relaxed/simple;
	bh=umgFVDilhu00ZRamvPs3y1Gtwk57i55IWfg6uEhTvUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCcvVgUU+KQskESSuuqH9RZ9ZmIFxlJPhRHK17vvAbyXlbPay8wdty58TS9T30bX3oZob83PQeJiDBN2X4EdfIX//o84h4CGitazzBPCyHkeWMN83IpvHfYxkM1uzbjp0meygPHDSsknNEzzCqCGP38A6UTUWmVbXBG1r3D89gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWWPzpxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWWPzpxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EEDC2BCB0;
	Mon, 11 May 2026 11:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500323;
	bh=umgFVDilhu00ZRamvPs3y1Gtwk57i55IWfg6uEhTvUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWWPzpxOHBInXDAojirE650x1YKpp/1Z7vmDcgfzQHoUJeVBkXQb11/GU7RD+I55i
	 OwUuyQvhhALsNbw1+WnZaTSQnWmOPh/9uyDY8eRV9uX6UvumRgKqJsK5f4wGy3BOE5
	 JsmlMF0ud2tMSlNsXoVcK0OZ0ggra79FXwiw8andbHUu/7SQIQYzAuV4AamCbnsz6L
	 4WWI3aCn5Q+sF3vXk66PDrnnnfkr+BAU1MSxkNZbMXB1JuW3GbimnLWN98sydAE7ws
	 SZbPfsjMl5J0AO9ZXdDqEY94SX5wwkpCxH4qhOzvFGnsFf0Wu+ZTJtJdSYZAaCGX0X
	 rEC2g8TqYEqQA==
Date: Mon, 11 May 2026 12:51:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0)
 in scd30_i2c_command()
Message-ID: <20260511125154.473b8209@jic23-huawei>
In-Reply-To: <CAKqfh0FEm0Ys7m+vdvaV7qavj86tm7HKf+pFN6-DD=T8HKR1ag@mail.gmail.com>
References: <DIDF7CF01QK0.38MS3JFMU6RPL@gmail.com>
	<20260508181612.11176-1-sozdayvek@gmail.com>
	<CAKqfh0FEm0Ys7m+vdvaV7qavj86tm7HKf+pFN6-DD=T8HKR1ag@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 14:50:24 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Fri, May 8, 2026 at 2:16=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.c=
om> wrote:
> >
> > On Fri, 08 May 2026, Maxwell Doose wrote: =20
> > > I guess we're still handling the cases where both response/rsp and
> > > size are zero here below?
> > >
> > > Should add a comment showing that this handles this case but that's
> > > just my personal nit. Not worth forcing a v3 so
> > >
> > > Acked-by: Maxwell Doose <m32285159@gmail.com> =20
> >
> > Thanks for the ack and the review!
> >
> > You're right -- the (NULL, 0) write-command path is still handled
> > correctly by the existing rsp-NULL branch below; the new check only
> > rejects the genuinely buggy (NULL, size>0) combination. Happy to add
> > a short comment making that intent explicit if Jonathan would prefer
> > a v3, otherwise I'll keep it noted for a future cleanup.
> > =20
>=20
> BTW, if Jonathan asks you to resend for some other technical issue,
> please add that comment. Otherwise if he doesn't ask for v3 or doesn't
> include it himself, don't bother. Also, keep in mind that "Acked-by !=3D
> Reviewed-by". Just means the patch is appropriate for inclusion.

In my view it is a little borderline on whether such a comment
is useful given the fairly obvious && rather than || in the check
added. Anyhow, no other reason to respin to I've applied this as is.

Thanks,

Jonathan

>=20
> best regards,
> max

