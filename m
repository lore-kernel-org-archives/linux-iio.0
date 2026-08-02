Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E760EEC3;
	Sun,  2 Aug 2026 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635213; cv=none; b=Jrj2lx3YMhFzDERxlYTc/yDC2UMmoLXyExigooJP1G4B17h44FiLO6bLQBVQtDY0+0aG7qlGbk9Qm1hklFe+VDztWkgz6oLY1J50fcqya3S0eCsmAN9vf8aY0VznUpBr6BuzahU28x+Jo0qSTofGGvMVtiAO4qiHSjLNhfifB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635213; c=relaxed/simple;
	bh=nSxVdNCUEdPlMPgWMYIUacfV82rRwl/QaLPeij40FNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdnMT1aIWzBqEZmx3pPNVdlfgXJ64Rs/jTXnOmErxRvcbCfVRcM8qFV88FyAMPlUwvJGeym3osrP+WcIxIkfjds5e+QAn3P3E/UWhrnLI6ZPrr6s+dS/Z/pYV569Q0wZ40jS6FcXPVwE8REoXzdBw4ESOk7fM3trl2tlq5U63hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuI44daS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuI44daS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5930A1F00AC4;
	Sun,  2 Aug 2026 01:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635212;
	bh=QSysgj7/UaKADRX8fNJ0d893OM/M86DkZEqIG4GZWwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PuI44daSbhc/W3760q/yxs6tkoktCz0bc4XD1cbapQ8D3H3PE4HSTFqeEEBZskvzo
	 1O2pUc6TStdBmXa2FVXy3ecCmPQfeRbtAGoDIVDe03XNt7MvlPWdKnIZhAppW1K1+G
	 C6WIu5MP7sOWa/iaKxrqyF1eKommXoVObhCjEdK4G0i85UjDZTiUvsFaldF2Hg9mMJ
	 YMi17ck3JB9+kFOnE+7+SoSqSey0h6GenJEc0cbmKOEpTIRWPEkwwIOJBO4qaF5vKG
	 X1Em+s/c6uzZsnbtdYhIiNqbhE/NNHorpGEEoWT0oofxKBV8LkLgQ0IMQZCtM2lQUw
	 dMydf3myHsPDA==
Date: Sun, 2 Aug 2026 02:46:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>, Kevin Tsai
 <ktsai@capellamicro.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Giorgi
 Tchankvetadze <giorgi@tchankvetadze.com>
Subject: Re: [PATCH] iio: light: cm32181: return zero after writing
 calibscale
Message-ID: <20260802024648.48f19c30@jic23-huawei>
In-Reply-To: <20260731161127.00001478@gmail.com>
References: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
	<20260731161127.00001478@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 16:11:27 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 31 Jul 2026 17:20:48 +0400
> Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
> 
> > From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> > 
> > The write_raw callback is documented to return 0 on success or a
> > negative error code.  However, the IIO_CHAN_INFO_CALIBSCALE case
> > returns 'val' (the user-supplied value) instead of 0.
> > 
> > Fix it by returning 0 on success, matching the behavior of other
> > calibscale implementations in the subsystem.
> > 
> > Fixes: 971672c0b3cc ("iio: add Capella CM32181 ambient light sensor driver.")
> > Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> > ---  
> 
> LGTM.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 


Applied to the testing branch of iio.git and marked for stable.

Thanks,

Jonathan
