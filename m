Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AB1E1DF0;
	Tue,  1 Sep 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232571; cv=none; b=S5oxBCpvA89c54fFFYr2cwPU9wl74iXsfWmJnS7kzXHX9trkn4oM4jYZHMBaaKAYZ3FMsdKn3AcUm1DReeem7elDLTqqe5Lk7ehzf/diTdZcm1aY/3HgHPbZiDTbQlpgr9pgHPihP+pKjqgOpKmyUqsVGVlUJBb98vZ6p9hNzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232571; c=relaxed/simple;
	bh=lzJo3/KB4L8BSyvP+5QAIfXzxRglLEpG+KC98DQTTXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7fRnFH4roxJxAF4CfnKhpIe5D3ApG5Z/Dt6KLKbjTnvwDwNswQOFR/Kejjf9o5/NCxwMgLW5HkdwWU6QWbNShpp8yfQIgBBMl0IEGZOfA4E4vSfAg8TY6WyRadK1hEDcl0DsmR2sKQK7RwAQfdsSc2u9Y3cKHe8RY8Q3ZiA09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTyAbdp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTyAbdp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997FB1F000E9;
	Tue,  1 Sep 2026 03:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232570;
	bh=Mz+07mICPoRLK08jztHD58aBq0D+ziKWII3djAJ2Nwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTyAbdp2lsxTPw1V0ikCo5Q+30kQ6UYxW2uAhhGfEYpArIZ2CfpDUdgAJv4pdLmu5
	 GLAS7U/Oe7pUX6SnLbvYntiGAutdOdY3CLoj5tXayWTpRpqo7+HspOjZ2txuf2SqJO
	 fMn6Old+kvY2+sovrQ+ajp+oNxTtY1qdnW6CfTtPa9JO6BsUuw6NERHws91uMO2fy9
	 LQOqqwy8vwVRhfgh/KtpB/zXPbaiS2BheyRuCLF55z3NpICUFmrtqTiTsmCSHqNz6H
	 vUtrjMr/kMeu41fJLlICH3v4R+hk9BmyWDn2NG4uC/p1qwGFcI3amK435jdxDxrSZP
	 56UjwpuG4d03Q==
Date: Tue, 1 Sep 2026 04:16:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: mdshahid03@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: bcm_iproc_adc: fix include
 dependencies
Message-ID: <20260901041604.5729b0e1@jic23-huawei>
In-Reply-To: <apY4GY-0_XMSfE9B@debian-BULLSEYE-live-builder-AMD64>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
	<20260830170919.470974-3-mdshahid03@gmail.com>
	<apY4GY-0_XMSfE9B@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 23:27:37 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 08/30, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > Add the headers required directly by the driver for completion and
> > mutex APIs.
> > 
> > Remove the unused `linux/io.h` header now that register access is
> > handled through regmap APIs.
> > 
> > Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> > ---
> >  drivers/iio/adc/bcm_iproc_adc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> > index e46e3761993a..2b59819c4ca4 100644
> > --- a/drivers/iio/adc/bcm_iproc_adc.c
> > +++ b/drivers/iio/adc/bcm_iproc_adc.c
> > @@ -4,11 +4,12 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/completion.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/io.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>  
> 
> I think that's okay. Though, if you go for a v3, you may also add 
> #include <linux/bits.h>
> #include <linux/types.h>
> #include <linux/array_size.h>

These 3 are good.

> #include <linux/device-id/of.h>

Generally now assumed to be from appropriate bus header.

> #include <linux/iio/types.h>

Assumed to be via iio.h. I can't really remember why it is a separate header :(


> which mostly completes the list of includes iwyu tool reports to be missing.
> 
> With best regards,
> Marcelo

