Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A32F1FC7;
	Sun, 12 Apr 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019868; cv=none; b=Kq+auhtUTxsTW70aFNezNpaPeTXBP+glBQ7QsNr63mL7dvAbUvx6wIF14T/Q9vsYKiCcxc8yrj4ssPmfj6BzyqUGtiGa7gvfvuj+lcqNvZyjTDIQzQQ1JSe/3Dd91YrpYeHjuzMBThmoSKxTY+AxOa6pO5v+Tg4LYNQKBBxR+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019868; c=relaxed/simple;
	bh=Vh9FTETQoXxTFIntauqsEqEvJ+G+BA7zRteZrB3dWo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsMqlvj6WxLJv3nHwDXv4elATxhpp/2isZOZJwEuExevUv+TCEQuGGl54OLG5r0KVI7NH1tYAXfNnQHSgfEyzdZxe9fxDArE5kNPMyuT2xewvf2UX/W6Uu0LySQAnz9ygvpKwmL3iP4EsNs+SY/gsCyxNYXfJfmE/mrSittIwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tssN/9wl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tssN/9wl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9238EC19424;
	Sun, 12 Apr 2026 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019867;
	bh=Vh9FTETQoXxTFIntauqsEqEvJ+G+BA7zRteZrB3dWo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tssN/9wlN7PXVQ1yrmbHOUK203mozceDzm/AbftZqDfrKxuosvbeZHU1ygQ5wJhMo
	 DlS0fvhsNTvxRjIVezqpHNPh9U1KRN2jZXi6HTJeANIWldjVXKoNmnX3SPbGo8Ztr6
	 bqoLL2hK0DJoSE8uosZeXm5d76lnmmT3f3Xv3sAzWlrsHI0mWz4R2OyjFtMwt101pj
	 POLSH83Z4brhAFC93LQSh92AsJilhdC+/kfAwHPM0fqyYZ+c+T5iv9BIMcwzrHGBsV
	 ug7ZLPYElvqEyg1cwDvevTgXFGjratwDljfggJUFm+8acNmP3ZbiZk/Ft2JrrM3v71
	 B0isDVZ1fpwJA==
Date: Sun, 12 Apr 2026 19:50:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] staging: iio: adc: ad7816: use modern IIO
 attribute macros
Message-ID: <20260412195059.7b5bcc3c@jic23-huawei>
In-Reply-To: <acuPlI8kh7iyWPXt@ashevche-desk.local>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
	<20260331072453.6530-5-mdmahmudulhasan1511@gmail.com>
	<acuPlI8kh7iyWPXt@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 12:10:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Mar 31, 2026 at 01:24:53PM +0600, Md. Mahmudul Hasan Mabud wrote:
> > Modernize the driver by using IIO_DEVICE_ATTR_RW and
> > IIO_DEVICE_ATTR_RO macros. This involves renaming the callback
> > functions to standard <name>_show and <name>_store formats, making
> > the code cleaner and more maintainable.  
> 
> Missed my comments about commit message changes and below about line lengths.
> 
> 
Another example of why you should go slow in sending new versions!
Andy's email came in after you sent this version I think.

J
