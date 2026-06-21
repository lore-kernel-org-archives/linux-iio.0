Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6127FB37;
	Sun, 21 Jun 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060715; cv=none; b=tnrU5Xhe3f/tLOnMhzhZavNk7bETY//QlFiYKwzFXqAHbjq8z4/d4x0Ceu5vOTC1A9Vfw1XryqBHxJuI8+r8+OvJ1WzzOx9L37E3abNErz5G3E7sBer3lYPUroxn0SlbHEColParfDwYAxfgxPX2akOd/KwVRLEMTkVu8mZWIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060715; c=relaxed/simple;
	bh=VmOZuuKHoE2poIi7qdHKMrBnebJrJXL9mbHDMZ1culA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMMCiNEszxsgpLSQnbWiC802M3ZoqK2vcRz5zXngLkjUj2D5znK79z5c4TiCEjDtIjmK4Ki65DI94lTfI4UYUtNwee7HJiMf+hXbqhAZOXdxzFk0R8S3++FlqfNTWtywlYE7OBNkhS6scYDkI39Gr7bqgBWy/qqWoHgJh6elaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nonhY4Vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nonhY4Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56991F000E9;
	Sun, 21 Jun 2026 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782060714;
	bh=ASrkAAK+5WLXtQCuK+olx+VWmplSpg488e7Z/5X38pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nonhY4VjW69TpuK54dsyj36rpTPvmFA6y0mo+Q/IIKymw/qLWr/0HSLCPMuTUT7Hs
	 YRpbomi61SS4ZA31QX6x1/BI6ns7QX8uOMltKc7sTZea4pZyU/OK/6ID/ly/esql5l
	 i3Wmy4cJY30JZUikptFavuj8TAnwDWVCprJf3L0x5VRPXM6Cpmq8ahGmsLEiG35UPa
	 4B6k2VyUQaMlyY90dvPLRozsX2DlhxTRnvpR0/SewwWxlr3nm4KcxvDIwKSRFK5sqe
	 NFTfVphprKtzO2zqdislvM2u2gsDtF5PmQwPAW6gRFeVaH/HSkOvZt5u0LWSlupF4L
	 K3dKw34fRgwvA==
Date: Sun, 21 Jun 2026 17:51:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Miao Li <limiao870622@163.com>, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, marcus.folkesson@gmail.com, dixitparmar19@gmail.com,
 bigeasy@linutronix.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <20260621175145.76742ca1@jic23-huawei>
In-Reply-To: <20260620085512.4a3c2748@systembl0wer>
References: <20260620015940.27636-1-limiao870622@163.com>
	<20260620085512.4a3c2748@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 08:55:12 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 20 Jun 2026 09:59:40 +0800
> Miao Li <limiao870622@163.com> wrote:
> 
> > From: Miao Li <limiao@kylinos.cn>
> > 
> > Update the list of included headers in stk8ba50.c using
> > Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> > and add missing headers such as array_size.h, bitops.h,
> > dev_printk.h, etc.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Miao Li <limiao@kylinos.cn>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied to the testing branch of iio.git.

thanks,

Jonathan

