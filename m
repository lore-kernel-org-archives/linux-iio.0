Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD23DA7EC;
	Mon,  4 May 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907395; cv=none; b=CT/52Lxo5olSvOYZuDrYhUuAftvKa2V/CRGkbxmPJHYZmoLCsoxxEpmHx/Ff2az/8ifqAexvwrcMJip1RGgl2B+1n7KaqgRCzfGSMO3Tu+w/rKms3T1IF2nE0bCnFLNOHpmjtcmjU1vBh0M5m7ARtvzFijnA1bR42xCkT5eM3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907395; c=relaxed/simple;
	bh=ya1Yr7yEHE7Kdr6k/vEbaqLTRmV6HIv9eTa9EXyoJik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9PX974RyOOVg00mQfC9Baf0eesMh3UqGlTgMNCVwB+KFTKcc+aohnkQ8QpEmaHBZkur8iRCRYGfAPYngTbgApLGLySI+Gj5OKfHduZWjEPj4mwah6/hIAAUIpOAq5LZlw9ymyl2lLozlLGdUQUXqnR7ynZVprTAvWoG7DCVQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS4tdP84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS4tdP84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF94DC2BCB8;
	Mon,  4 May 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777907395;
	bh=ya1Yr7yEHE7Kdr6k/vEbaqLTRmV6HIv9eTa9EXyoJik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uS4tdP84PZWfg7XoWZmdS30sFwjBnhJ8mtakUgFAcvWgf+mtLhYJpV7Rq3S1rAiQ9
	 LgCV9opsn6QPXgWRWd1Rot6n/+Vw/3fP+jTInLKscr2zjkr7oPcDSXnjpmlgWr+GI2
	 /baRx1ugdJBLqQl1k1A/3SnMJKHLnSt0vKF00anIPDdkK9ZaORaRDXOyOPKzTz2h5W
	 5EkkJIAxLZUBcndzTCcI0azfG3aVHbid5mUNcpYYuxCvUQz0xuJDLcJ7RbFwim83Zq
	 QnLuqU06KjtTAHOkU2TiYssYbxmaeqVShGDRO4Vd5+/JyfDnwI49eCPVjKVVQZ5WnE
	 YmAoNYxj4oFKA==
Date: Mon, 4 May 2026 16:09:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <20260504160948.114762db@jic23-huawei>
In-Reply-To: <CALoEA-wpqpT7iscVZScXduj1S02hVtz8AQCiKj-Aiz-5A0N7TA@mail.gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
	<20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
	<CALoEA-wpqpT7iscVZScXduj1S02hVtz8AQCiKj-Aiz-5A0N7TA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 13:33:10 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 4 May 2026 at 11:48, Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> > @@ -708,6 +705,11 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
> >  static int ak8975_start_read_axis(struct ak8975_data *data,
> >                                   const struct i2c_client *client)
> >  {
> > +       int irq_timeout_ms = 100;
> > +       int timeout_ms = 500;
> > +       int poll_ms = 10;
> > +       int ret;
> > +
> >         /* Set up the device for taking a sample. */
> >         int ret = ak8975_set_mode(data, MODE_ONCE);  
> 
> BTW, also noticed a redefinition error here.
Given that's one that should have resulted in a build fail
please make sure you build after applying each patch in the
series.  Need that for bisection to work and because I might
pick up a partial set.

Thanks,

J
> 

