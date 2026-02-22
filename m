Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D95EACD;
	Sun, 22 Feb 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767816; cv=none; b=guynvF2+wfM3Ejh4WnRCeBD4023/9r+2pJTZaO4bKfgKBmczCJPId4dP9YfnnlyDyuCB362/2FpgZsQgyG9PUxaY1VRYBNxCmZdVbps8Ybu+gREtrcWlNVVgxK2HSSI7qabrLiMYOZBY+VaCfdhwtkpeJGwcWSo63tIFJY+J5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767816; c=relaxed/simple;
	bh=2Q+BHkaVfNpXGP7MtgMP8pPOuYDXW7/eZDJPKhJ2IuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5pgWpOiWf446DOedRj50fwkspratsiJRXMhJBTrSMYGOjqvkm6bDMEOs7xNM2+6LZ/lXQq1sSlkW6YDXvK0uYCdQvBtEo/ta9FGGULqe9WPDWW3/KmalAmgq86FRliaDFgqUYXFzx2Q6LAfiqWSjyCO562/n2lk+Ihc2BW3PDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXu4mJpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXu4mJpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB1C116D0;
	Sun, 22 Feb 2026 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771767815;
	bh=2Q+BHkaVfNpXGP7MtgMP8pPOuYDXW7/eZDJPKhJ2IuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXu4mJpyxrw7D30vb5aPp3oTS0S4aKA7uODJCk0ms14D94JvlFVoD+zQlnqlKvS4G
	 UyGOdC8oldvr+FQnveQIWuIRz9OdkaoOqlx53YlyzVGcGGBerB3oeQ5aYtomWSJziO
	 A0WaoKtL8YWtG2+uq6yUtY2beLPpambVwd7a9qrDEM5PS0NFYh74yJhYECrcAq3J4I
	 qR+murqC1lOvNWfkRNtb5dopJJQ1oVFOsy3hSl4ULz5I+qst8LCkABDb6497vQkmSk
	 kCcG0j9W+2JqMFXg+D1OfDoYt3WXudLy9ppDyq3OGfXjEhf7QtjKfl21cMP5g3unKP
	 aRxDtEjrAm7/g==
Date: Sun, 22 Feb 2026 13:43:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
Message-ID: <20260222134326.7fc1f45a@jic23-huawei>
In-Reply-To: <aZXD0smUd3CRgPcv@smile.fi.intel.com>
References: <20260218125327.21467-1-architanant5@gmail.com>
	<aZXD0smUd3CRgPcv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 15:51:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 18, 2026 at 06:23:27PM +0530, Archit Anant wrote:
> > Replace do_div() with div64_ul() since the remainder is not used.
> > div64_ul() is the preferred API for 64-bit by 32-bit division when
> > only the quotient is needed.
> > 
> > Also replace explicit casting and shifting with the BIT_ULL(27) macro
> > for clarity.
> > 
> > Note: A mathematical simplification to `(freq * BIT_ULL(29)) / mclk` was
> > suggested during review to improve precision. However, as confirmed by
> > maintainers, the original driver's truncation via `(mclk / 4)` might
> > be intentional or relied upon by userspace. Since hardware is not
> > available for verification, this patch preserves the original logic
> > to avoid regression risk in the absence of testing.
> > 
> > Issue identified by coccicheck using do_div.cocci.  
> 
> > Changes in v2:
> > - Replaced explicit `(u64)(1 << 27)` with `BIT_ULL(27)` as suggested by Andy Shevchenko.
> > - Kept original arithmetic logic `(mclk / 4)` to preserve behavior.  
> 
> The place for changelog (and comments)...
> 
> > Signed-off-by: Archit Anant <architanant5@gmail.com>
> > ---  
> 
> ...is here.
> 
> But do not resend until maintainers explicitly ask for that.
> 
Tweaked commit message as Andy pointed out was needed.

Applied to the togreg branch of iio.git

Andy, if you want to give a tag I can role that in for now as need
to rebase anyway on rc1.  This mail felt like an 'almost tag' ;)

Thanks,

Jonathan


