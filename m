Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579064;
	b=FVGgPhFmzuZ/nZj02Ql5rjDAYoYceRsT0wSNt1MiAspsM4vyp75ui7bk471x810o7vEZ
	 B1LK4mgt+vMSBBbny6TObYfgDOPQwxaXHNwtqP0KerrsxHngastaCMiISV34lm9oUGQYj
	 3ihF//3vH9gBI9j+mFctJPD/5x3anhqkQlSguDT5LlFPzJJ1C44IoyHl9A0l/i5dmD1dr
	 gCmVeeDU8G73Ntcj7/4ecYDkFviYegSQO/VvhRfEhK/lvsC1HHUSKZqabBZqZNkae8mCe
	 L+Qobpj0hl/sN8AwR+B1C5nOs5tB7StiKQCROzf7amjlPKiWTuPkCIK8ZKSmxQ+WNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=juwtuX1dTURgBPsoQcGSwifONYB+Qi1UFToNXXp+tq8=;
	b=yO1Ild/5YCvSf2kqTtfVj8Qp4MSGFeKWebmzj2X7P9OwndBkD5SbEKG4VdY4hB0LNq3j
	 16HCpQUhQfD1S3PhuVj8ZVk/xZ4W3FTXPyciuTZ3NxntSTEf6IDhXYt5xp4aL/pGoHmPh
	 ffhpZ3N/T/rMnY7CqAupkcypwZmO++KXZS2hVwmkzcVwKUE4dQ5SmIoAjaJaUVHwLP0D3
	 6WBDTzkkeZMYCeEgPTrWGoZPffi0GJtJC0ZSXD9oLGyUjKC0mxNW1fHXBoMX86WKLN8hZ
	 jPq51Vyh/N1Yuz4aV5KVVTMwn9K7/xwYXcSwwOXm3lug0C1h9QY+Ta5qZ91fE7PZWuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNmZa6DS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110E606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNmZa6DS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DD71F000C1;
	Mon,  2 Nov 2026 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579063;
	bh=juwtuX1dTURgBPsoQcGSwifONYB+Qi1UFToNXXp+tq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XNmZa6DS2dHByxqsgjMQnLxddbn/X0Jfbs7ZoAAJvk5PhKEEAHJhkYTnwrvUFB0/K
	 XG0onPS8jsXMwK1WlOrDDeHQe11ab6KXLa3kcgbTVeXvQyQlnbe49hJtLbavRRGWpP
	 eQq5jDibilONy/fGyO1TZ5rdHEECJoljKZ3Prjwp/j5nuhDlxXwuoz0Pf/8Odyn6dD
	 M8auMOQ2Bqdfl1ZISI2DXZf90X2noWJET39QjOiPdJUtye7Zs84fIv+eeAV3UWvD78
	 qk7LdqRi1huRQQPWhiUpwnYybNShDPqKE9FqZFdLMWtV//8WIBvIN1sf+D6FThmDLv
	 YuGcBsYlWghug==
Date: Mon, 2 Nov 2026 00:24:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] iio: gyro: fxs210002c: Use guard(mutex)() for
 remaining simple cases.
Message-ID: <20261102002416.7dcd08d0@jic23-hlaptop>
In-Reply-To: <at-SbqRdChCsEtcL@google.com>
References: <20261026032051.1004536-1-jic23@kernel.org>
	<20261026032051.1004536-3-jic23@kernel.org>
	<at-SbqRdChCsEtcL@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 10:48:30 -0700
Brian Norris <briannorris@chromium.org> wrote:

> On Mon, Oct 26, 2026 at 03:20:51AM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > With the exception of the more complex flow in the trigger handler,
> > all uses of the data->lock are switched to using guard()()
> > simplifying various error flows.
> > 
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> >  drivers/iio/gyro/fxas21002c_core.c | 71 ++++++++++--------------------
> >  1 file changed, 24 insertions(+), 47 deletions(-)  
> 
> super-nit: it seems like the name of this driver is "fxas21002c", but
> your title is "fxs210002c". Understandable that one might miss 1 out of
> 10 gibberish part numbers ;)
oops.

Fixed up and applied.
> 
> Otherwise:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 

