Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D9433E7F;
	Sat,  4 Jul 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206385; cv=none; b=A5EXUDry0xhU0+0N3dHr/O/Ky+WxL9wfsYWThVPAulZAtKImN2LN7V2uYJewad4fkYmD+Q+8tTjnIAyjeknfaRKq6SrrU+8NdzFH6hlZorsUGS6RAXJTd1DCWVsYTgxqVVzWNWIgCnMg5U5/V5aVYp7s44kM3YFwG7e8Xx65/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206385; c=relaxed/simple;
	bh=1q7wOW+/aBFf/iqT4oWppkZOn8TKbcDd0CGeatq746U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxspgWUZY/wpE0KeY8RufP8ap40/QDEJ2qCgrKWjevFCVDVxxQjBNJo4jwhCJEYmv9m2aBAya5P4Y8T+98SH68RZ5iOu/1JvrHmbCTuqlOhyAzK0+Lf0tnosRcU0VH7bPwh+JVQ76TDEMOFmtd4XMcUnJQ1k9aGqrJ05Sbe3EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEAHs6wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEAHs6wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EB11F000E9;
	Sat,  4 Jul 2026 23:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783206384;
	bh=dtdhWRsvcLD8x9kSSFf/H3/nDxcZaVMQ9mXA2216y9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LEAHs6wi6oCoa1vf49MpAoXxOrv9J7Znd3KsW5jqLn/vx6DQUGsON/UgLoehVC4rJ
	 c+g0y2+uZIk4L/Lq1ByKqtSmFZZdxX3QqihHpmZIGiPnxz8bK2XupSs3UtV/sr6vV+
	 E/J1SMxTMht7P4rYVgXvz/vjz4l2EXjBfVAN7YcTOrRmtLBYvp4siteoKGyx8LkNLx
	 f5mx0ncN4lxajwjt4awLKQ2xenG8I0To0ZI5nLHp6Ce1tJuXb+sy+VrzE4gx6gQNFP
	 gndvjxvnp3Di+zj9uH2+zpgiyTXNA2Ce661DuTfvO7rfJsvQuOozWPZW20fN34YpRo
	 HSiSF3PrHtNEA==
Date: Sun, 5 Jul 2026 00:06:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vidhu Sarwal <vidhu.linux@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: light: al3010: fix incorrect scale for the
 highest gain range
Message-ID: <20260705000616.3aaa1254@jic23-huawei>
In-Reply-To: <akj49teBHChc17uB@ashevche-desk.local>
References: <20260702052913.114130-1-vidhu.linux@gmail.com>
	<20260704115245.11167-1-vidhu.linux@gmail.com>
	<akj49teBHChc17uB@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 15:13:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jul 04, 2026 at 05:22:45PM +0530, Vidhu Sarwal wrote:
> > al3010_scales[] encodes the highest gain range as {0, 1187200}.
> > For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
> > 1000000, so the scale 1.1872 should instead be represented as
> > { 1, 187200 }.
> > 
> > Since write_raw() compares the value from userspace against this
> > table, writing the advertised 1.1872 scale never matches the malformed
> > entry and returns -EINVAL. As a result, the highest gain range cannot
> > be selected. Reading the scale in that state also reports the malformed
> > value.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

For future reference, please never send a new version in reply to an earlier
version. It both gets very confusing as threads develop and also puts your
patches way back in the maintainers inbox, which often slows down getting them
applied.

Applied and marked for stable 

thanks, Jonathan
