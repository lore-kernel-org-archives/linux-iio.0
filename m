Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F047E0FF;
	Sun, 19 Apr 2026 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617645; cv=none; b=paU4Rh2rL0t+2D+eIQVQzp8ITolDT/4kCaNFkBqXBwYnfHlXOu0SQT6wDNGrAuNoVRes2WvzF4ozkgX9YbSphNrPwtwBEZB6ogMFfSp/PhAXPuRJKsGMDJUT8zVzj9axs5r+GerFR+uSb0JuR1TgjBDFz52VaM3pOWP90BAJQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617645; c=relaxed/simple;
	bh=TCJhV6gG3U5DUQ9suCRJ5q1D7mW1YpKtqdnGLDRt/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPEP+EogRio/snxn7hamNA5fTYcENqUoJl5VjPljMVXQWLEYE9bKDSGeY9iDjTvcS2VR5v7q39YFZi8nGhNTaMqamaw6umg7pwluy71TD/GkgWeOIJBYNenDwcY1s3t8e00k+eSRzw810dkCjh02U4fiMd/K9hj2rZ9b/SB6Cww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaWzBvND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaWzBvND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41DAC2BCAF;
	Sun, 19 Apr 2026 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617644;
	bh=TCJhV6gG3U5DUQ9suCRJ5q1D7mW1YpKtqdnGLDRt/AE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PaWzBvNDYyYBvfYqPsyFLfksF3wlyUOh5YyEEYCYK1TCwkMgBWQ0BUJT2qbUfPO1k
	 TuvKYSzDvxkKsGBy2Tk6TUS50dQfhkYqtJbSH0QsC1Jc3ifzH1ULgku8Et6bCa9MZV
	 RG5Ihjubp/LmthqhTTO8YDUNiyOSxYlzA2YiDxYR4dHRKeahlU3PGhbtLreBTXzBFh
	 25zW9riPkPFowaaKTDyZ3U1QKLGkHbJkQBVxthIxsqcXHWR4WgAL10lDX1Yy+MmklH
	 TUqtwluLSv+FnXaE8SWGTxPmppkvvcNpOVFF3tQ3H3E1K8iqDEKqLLdF8qeNNztkAQ
	 0YpeMuLL3RZLA==
Date: Sun, 19 Apr 2026 17:53:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header
Message-ID: <20260419175355.0b915e8c@jic23-huawei>
In-Reply-To: <aeJyzXXX-2zOgU3A@ashevche-desk.local>
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
	<20260417101623.1281-2-joshua.crofts1@gmail.com>
	<aeJyzXXX-2zOgU3A@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 20:50:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 17, 2026 at 10:16:22AM +0000, Joshua Crofts wrote:
> > Remove kernel.h proxy header and add replacement headers (array_size,
> > dev_printk.h, kstrtox, mod_devicetable, mutex, types, asm/byteorder) to  
> 
> I guess it's better to add .h to all of them.
> No need to resend for that. Perhaps Jonathan tweaks it.
> 
> > maintain atomicity. Moved asm/div64.h header below generic <linux/*>
> > headers. Additionally, add bitops.h for BIT_ULL() macro.
> > 
> > Audited using the include-what-you-use tool.  
> 
Tidied up. The Sashiko stuff disagreed a bit with one or two choices, but
nothing that I think warrants a change to this.

So applied this patch

Thanks,

Jonathan


