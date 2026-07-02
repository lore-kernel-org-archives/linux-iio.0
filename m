Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F037A84D;
	Thu,  2 Jul 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013588; cv=none; b=SNerIsbPROp76kSXPU9qTxErISy+IPywnckqiOX+2D53JeNWW/lRfjqlP0dXEq0r00ypZ3xnrGeGz3mZR9ZesoCoFbbVdRu5hUWP0pnMCX1hExG/w8WC8TovG/udC6vVs075nUJ6b+G1CNkI8C8eYtoYnnV8Bmm+kFY5OMClYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013588; c=relaxed/simple;
	bh=azJxWdbYBPOwuGwuMAC/vjofRWL9j8g0XkB4feHV/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMITkLskSUrDAq07h7X58GMxsmya9z+IAfZnCH4mICDG8uDzldnJY1kdqLygjM5uXzggucLZ7KTZWp3Auuym4L3a5eQfrgLTMNwOIODbgkZYusHIvUYfeyxUruQ4Wl+Pe+L3ZasJoBgVk8+QsSw8AWo2JOJzeiXoe569UNp9uVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1inlsSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1inlsSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AC51F000E9;
	Thu,  2 Jul 2026 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013587;
	bh=vu7hJBa17KvDD2t1R6QGkhxoSNaJ2zR2JlqWPzMaz4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m1inlsSMNXfbkSFN+YWd+Mr9fl05jzEgugnOZWrz03XQo9s5YQoax/iOt8Bw6r+5o
	 K3IAF7r0wr2tgyIqvvryarrp5shfEcIG6EWSfZkm4unESJan4MXUF6uI2k25iRx/ew
	 8hc/C96KdW5O3MJyaGOPu2MHUpUvgGdINfotQi4eM/7yLCM/QXutK53Cjuk3kETOcJ
	 jX+B6KZc+a3uX56x592XQfjHWjrURtHGxM27x1QXd5seFMHU2vzAp/c2MxNDizmPL6
	 NJNNS7xkhmliIP8ULgYLloDzvidU3Js7Q5viFzftohQti2iR5mS4zIRrjj0f8yQ9Y9
	 NvusU7JzV1XcQ==
Date: Thu, 2 Jul 2026 18:33:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vidhu Sarwal <vidhu.linux@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: light: al3010: fix incorrect scale for the highest
 gain range
Message-ID: <20260702183303.28c29671@jic23-huawei>
In-Reply-To: <akYzFtxKhq5U2kFY@ashevche-desk.local>
References: <20260702052913.114130-1-vidhu.linux@gmail.com>
	<akYzFtxKhq5U2kFY@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 12:44:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 02, 2026 at 10:59:13AM +0530, Vidhu Sarwal wrote:
> > al3010_scales[] encodes the highest gain range as {0, 1187200}.
> > For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
> > 1000000, so the scale 1.1872 should instead be represented as
> > {1, 187200}.
> > 
> > Since write_raw() compares the value from userspace against this
> > table, writing  1.1872 scale never matches the malformed
> > entry and returns -EINVAL. As a result, the highest gain range cannot
> > be selected. Reading the scale in that state also reports the malformed
> > value.     
> 
> Trailing spaces in the last line of the above paragraph.
> 
> > 
> > Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
> > Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>  
> 
> ...
> 
> >  static const int al3010_scales[][2] = {
> > -	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
> > +	{1, 187200}, {0, 296800}, {0, 74200}, {0, 18600}  
> 
> While at it, add a trailing comma.
Can we take opportunity to move to IIO (well my) preferred formatting
	{ 1, 187200 }, { 0, 296800 }, { 0, 74200 }, { 0, 18600 },  

Thanks,

Jonathan

> 
> >  };  
> 
> Otherwise LGTM, thanks.
> 

