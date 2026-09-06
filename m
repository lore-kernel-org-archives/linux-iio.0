Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F627A462;
	Sun,  6 Sep 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730694; cv=none; b=lm6CXfc751mxhcoMy1bh+GIHw+qMs4ikqb7HZuoYvszVJeAnc4j+6Fxo6E9BFQNi5Q4umcAq5Qw96k4oQXlB8PjOJNf9CcsApurueVdRbKnp2GEqvczYqwkjmv8Zs/6wOZgwijIF4mNivWbuUS3oHEQ77D4r5xssl9CHWFQW3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730694; c=relaxed/simple;
	bh=0UAsf2uSK003jxDcHj1umMbZvLwoGaSYFRC3C0sRjPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ9Ed8FSS/E7Rn7hhlXqB1P50hDbQ+npgU9oumZ9jFXmnHu75xiU1FbpTaaxqDU9f2hNcMKrIFYTeOE0S5JnjIlo6OwC5jp7dyqf4cCYyaAnaQYzmYOhHlgVzp9iTwJ83O+kA4cIiJaegM98kaUF4sNJXPtOiwtzlGy4awNHNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EroILAX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EroILAX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07161F00A3A;
	Sun,  6 Sep 2026 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788730693;
	bh=tkC11QLMwBCkI/R92EJ+NtiSGru7aAIOn0TD0dzx9aU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EroILAX6SlVg4/v0cxaqWHVJ63c2Nk2R483EhHr8jE7GeCP/5wwuFFgacSOz/Btzu
	 WXX8GZmB8UHi0RZXLmtRgDx3asnRpj+jYlq6oa4sMtBkcMdBHmATk+70woyTaGi/se
	 gQQknwgtDRA/I50vV1XXFmDt+DxmBnx3kcwMXLTQ43MCL0msNg13Ralqr13X2sMlst
	 wpY81FDIVylOFuAyMYDDza8Q+oxNcs0iZpDZ3Flgv6j+llsUgaqGBGY0Ee3vQNAJcM
	 ifK/yLRb70stiHf6tIqWlb5U+AvnIj3Oi0uySUTSvSQKzpX5zd3cCh4mqT5oDnVYch
	 m6aHYd5oXtmSA==
Date: Sun, 6 Sep 2026 22:38:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <20260906223807.0648c9a8@jic23-huawei>
In-Reply-To: <542c61177f34fe6f6c0f937021f6b3b7ca51a024.1788336588.git.mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
	<542c61177f34fe6f6c0f937021f6b3b7ca51a024.1788336588.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 11:49:18 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The "interrupt polarity high"-macro for KX022A variant is defined as:
> "#define KX022A_MASK_IPOL KX022A_MASK_IPOL1"
> 
> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
> using the KX022A_IPOL_HIGH would produce a compile error.
> 
> Fix the define by using correct mask.
> 
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

This one can go the slow way.  Applied to the testing branch of iio.git.
Thanks,

Jonathan

