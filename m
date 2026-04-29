Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912D3CF02C
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458189; cv=none; b=qPx1k5plNxa5Hka+/AQ/ArBnEwJtjMDPG63ARjmriaJ6tMF7WzQJJq9p/sWPnP4/hyC31mcrPJRjG80VKr8ueEZtP0hk7ioTqaunYQkgj5JDOKLW44SraUTf48ee8RKMx74k9xCPyxQHs4cFavnzdA4o3oLMteXVxJx4+qfmB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458189; c=relaxed/simple;
	bh=aO6ym6S+Gsnx5UiISIxVuNMcMsCWCrSzaJK1hp9Lk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUNz6RR9cc9K8JVweW/e88nO64gOjm5YYasVJHhFXsgohDGC3yqq0cx9gignzLmQFZEMesYh0es3DeEEVfIthP+xQhB3mi5oyH2BZ3IvOIWQnRErXwJqv4eUDU4xxy/xvaRICL6QUW0giI6KRgjvzELpQF88jwbst5Qpa/0Ry90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHmwbL+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHmwbL+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85BC19425;
	Wed, 29 Apr 2026 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777458189;
	bh=aO6ym6S+Gsnx5UiISIxVuNMcMsCWCrSzaJK1hp9Lk1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHmwbL+lXnmeLoDFuvqOFnTULMMpqRDxZCYdeXoMC6Ng0I3zOnBzDwutdWYXlSfqf
	 ake3HxIMGB/YKStH68hOy2HlttykTNEu3ZhUtWjiZqqRt8fE/cBoRHwrmct4y33/gu
	 whVx6tbJa7zDpAa1W/weWSNx0orEWkW16TXL5y7kK/tghbt6P5Ez7gJV+Su7SiePOp
	 vv1Vt/xdoHn4b1mP0evxuijq//wcoNZLhcXoGkOSxMzq8AYEwB4Jsb5HNrgV0B7ohf
	 V+YvgojExKq+W+upg2SIIPLSbjiCGaaiv3zXgaL9Ni4RjfAJucoxAzrWNz4vZqdgsK
	 TqgOYc2wIU5bw==
Date: Wed, 29 Apr 2026 11:23:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, Felipe
 Khoury Dayoub <felipedayoub@usp.br>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match
 IWYU
Message-ID: <20260429112300.696e2722@jic23-huawei>
In-Reply-To: <CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
	<20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
	<CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:49:36 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 28 Apr 2026 at 18:14, Rafael G. Dias
> <rafael.guimaraes.dias@usp.br> wrote:
> >
> > Clean up the included headers in stk3310.c according to the
> > Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
> > header and add explicit dependencies to improve compilation accuracy.
> >
> > Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
https://sashiko.dev/#/patchset/20260428161339.1187956-1-rafael.guimaraes.dias%40usp.br
Had a few comments.  I added asm/byteorder.h and linux/sysfs.h.

Maybe we could argue the sysfs.h one will always be included by
iio/sysfs.h but I think it's better to explicitly include it
for struct attribute_group and similar.

The asm/byteorder.h is simpler one as that should definitely be here.

Anyhow, tweaked whilst applying and applied to the testing branch of
iio.git.

However, do slow down a bit as Joshua suggested - I'd generally
suggest a week between first version and second, but I am a bit
more relaxed on this for students and new submitters doing fairly
simple patches.

Thanks,

Jonathan

> > ---
> >  drivers/iio/light/stk3310.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> > index 1fad9367c2d4..37b7b9367269 100644
> > --- a/drivers/iio/light/stk3310.c
> > +++ b/drivers/iio/light/stk3310.c
> > @@ -7,16 +7,27 @@
> >   * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
> >   */
> >
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/kernel.h>
> > +#include <linux/irqreturn.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> > +#include <linux/sprintf.h>
> > +#include <linux/types.h>
> >
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/types.h>
> >
> >  #define STK3310_REG_STATE                      0x00
> >  #define STK3310_REG_PSCTRL                     0x01
> > --
> > 2.43.0
> >  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

