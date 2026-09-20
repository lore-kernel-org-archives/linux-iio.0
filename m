Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4E33986F;
	Sun, 20 Sep 2026 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948694; cv=none; b=Tg1gGSr9NbqfbblqhY9XAYGpugoyRxbUNkQf9vKdx9lKIUAx07V2EwBUxtGa9Wwi+4HfJ70qN3dLPW441bjFosUuqqSpK2Apcxxyd1snwq6nmM6BXZBvxgNKA0gvhH0V84HMldTuCjlHIJWWI8oBh1bRJDdVHh9UHKBE6IUNBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948694; c=relaxed/simple;
	bh=unZ47QzyFfwjJpbtNdkezWolAAeWPFtDsCfXETyW8/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nyid46WY1yGEvmI3W5GVsjDrdPQ7KrUqQWrK9RM8nddq7kWdyDOwEm/bDx7nFf+MUfZHtRWqwbwsj6RtXEnyxhcqiaLN3+zf8O7iD0631JU2tSVtjBsV84o483X9Dvw0r1ifkustIsetTPOy7B87vl1trZwdNbvpSYc0pCJe6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnGqBtGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnGqBtGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0A1F000FF;
	Sun, 20 Sep 2026 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948693;
	bh=X4OR2xznffxykb/XkO54aJknAmh0YBEqRGx0ght3biQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jnGqBtGUL3y4VszS4K+JKCZ51DBg4dBK3sMXpnrq4lxC2DQfIDa1PUSytybG5UMLe
	 ju/PsVgQ9JG2ASvF80g+hE7TtupnU78myFIiU0H/jsUcg+eIBkCxkxUFd1wv59DPeO
	 Uy+7x/p4VrPlDWP/Y/8h66VHRQ1NB8nnZMjab1z8sIK6fAMWopfwSml4hzxNW5reIk
	 z5QP/TDbRXtmMfXBKsqkys77qmyrUE4Ot4jY3Sk+/+oNK8vTj5VJj3lbeEeWzsDR7s
	 u0hr6KhrjqMWNdNlZNxdxZghsePXWub0CsfeyfIy2ICesN2DizZjFr8Eo/53tzh23M
	 eBWWv/Z/CCAUA==
Date: Mon, 21 Sep 2026 00:58:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: isl29501: Fix return type of
 isl29501_register_write
Message-ID: <20260921005806.56c74e59@jic23-hlaptop>
In-Reply-To: <20260917152339.00004fd4@gmail.com>
References: <20260917130052.636055-1-salah.triki@gmail.com>
	<20260917152339.00004fd4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 15:23:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 17 Sep 2026 14:00:52 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > isl29501_register_write() was returning a u32 instead of an int.
> > Since the function returns negative error codes (such as -ERANGE or
> > return values from i2c_smbus_write_byte_data()), returning an unsigned
> > integer type prevents callers from correctly checking for negative error
> > conditions.
> > 
> > Fix this by changing the function return type from u32 to int.
> > 
> > This was found through manual code review.
> > 
> > Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---  
> 
> Makes sense. I'd mark this for stable.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied and marked for stable.  Note this doesn't mean it will
go upstream particularly quickly.  Most likely I'll be folding
the fixes into the pull request for the next merge window.

Thanks,

Jonathan

> 

