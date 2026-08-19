Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D259367B90;
	Wed, 19 Aug 2026 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101640; cv=none; b=RZ3h45UN832ngBsBExhIpkZmiMNIwvq2Kbnc7SKh0YxGULoT/1GOTDhX4SaW0KNEmLSBS7rIZdg1MkFaVOwa6mzNgI0+RDAyYGIDRqCXrERa7s+MiJzzexPiJmNmBp2niIar1y91Wg2P5m5XNSgvYsOaOTAlys857tZ072yIqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101640; c=relaxed/simple;
	bh=l6lMKFQP8Sn+wzT/y8ohNuKh6RmsYBuHwVgSLVZjJbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/3a0SNwSQOS5vSHfiP1yLbsmU7/kvnEymG4O1WbiXMR1rJ0/7yhWFyTg+O13Hozi4AWFKJqfnxHg4KmJ2reBUuYPX/PulunQ7nCYx2s9vrFT8pQEIcl/xOeJxz7sKHWYgISdrZowtSxZSKN91oyjRI2Sgur1YvlTWcWnjrYG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJqJwj1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJqJwj1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295521F000E9;
	Wed, 19 Aug 2026 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787101639;
	bh=YyoKZhoBWc8QW9AvgJ2OZyBteDyAtmyQpEB+hEoZreI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kJqJwj1F4QmmuV+a8GddMGgzfidkurTu4vLUSPbxIGrC4GGs+5BD5F9RMVOXV46eW
	 2fmnKyRTOqm9laPxCytCwOcgulsLf/pIPXfynn8GNVX//KOT63qDOr6W58YPCqFlIC
	 K0I81G6yLzvntHPCOzpXq+PIeV4jlt2wjOV5VxmidYxv/CL3sK/0nhtcBUyEKjDbtk
	 f6vjePh3ZEeMLVaRZWk4iX/9C/zHJtwTZ3ABb66jrZI5VVEN1QzhY+TPF92fnwA6wq
	 GI2Twn2Oj4TjYyp27cDIEzib/GgsLYzg8YUettWq7jIukite91yNiN9DmiLlD4dDbI
	 O4UgRY5u40tvA==
Date: Wed, 19 Aug 2026 02:07:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helper: fix error headers
Message-ID: <20260819020715.3789082d@jic23-huawei>
In-Reply-To: <7155f6fd-435a-4176-aa9a-79888e0b5ccc@gmail.com>
References: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
	<7155f6fd-435a-4176-aa9a-79888e0b5ccc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:03:53 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 15/08/2026 01:23, Javier Carrasco wrote:
> > Both industrialio-gts-helper.c and iio-gts-helper.h use error codes
> > defined in <asm-generic/errno-base.h> (usually included via
> > <linux/errno.h>), but only industrialio-gts-helper.c includes it. On the
> > other hand, that file also uses error macros like IS_ERR() and
> > PTR_ERR(), which are included in <linux/err.h>.
> > 
> > Add the right includes to provide the used elements from the error
> > headers:
> > 
> > - <linux/errno.h> in iio-gts-helper.h
> > 
> > - <linux/err.h> in industrialio-gts-helper.c, which in turn includes
> >    <asm/errno.h>, which only includes <asm-generic/errno-base.h>
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> > I stumbled upon this while refactoring veml6031x00.c
> > (which uses IIO GTS) just because clangd threw a couple of errors where
> > -EINVAL is returned in iio-gts-helper.h
> > 
> > In the end everything compiles anyway, and therefore I have not
> > added a "Fixes:" tag, but please let me know if that is really required
> > for something like this. It is also true that if the gts header is
> > included first, the compiler will throw the same error clangd showed me
> > and the kernel won't compile... Unlikely to ever happen, though.  
> 
> Unlikely or not, this sounds like an error to me. Hence, I don't think a 
> fixes-tag would be wrong either.
> 
> Anyways - thanks!
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Applied (without fixes tag - not known to be a problem right now and these
sort of things are really common) to the testing branch of iio.git

Thanks,

Jonathan

> > 
> > I have compiled and tested this implementation with the driver I am
> > attempting to upstream without any issues.
> > ---
> >   drivers/iio/industrialio-gts-helper.c | 2 +-
> >   include/linux/iio/iio-gts-helper.h    | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> > index 4f52dc373abf..af6ed37fb34a 100644
> > --- a/drivers/iio/industrialio-gts-helper.c
> > +++ b/drivers/iio/industrialio-gts-helper.c
> > @@ -5,7 +5,7 @@
> >    */
> >   
> >   #include <linux/device.h>
> > -#include <linux/errno.h>
> > +#include <linux/err.h>
> >   #include <linux/export.h>
> >   #include <linux/minmax.h>
> >   #include <linux/module.h>
> > diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> > index 66f830ab9b49..f63a482b82b8 100644
> > --- a/include/linux/iio/iio-gts-helper.h
> > +++ b/include/linux/iio/iio-gts-helper.h
> > @@ -7,6 +7,7 @@
> >   #ifndef __IIO_GTS_HELPER__
> >   #define __IIO_GTS_HELPER__
> >   
> > +#include <linux/errno.h>
> >   #include <linux/types.h>
> >   
> >   struct device;
> > 
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260814-iio-gts-err-headers-d7ecb6b5ebb7
> > 
> > Best regards,  
> 
> 

