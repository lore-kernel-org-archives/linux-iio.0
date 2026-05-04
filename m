Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F13E0240
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908492; cv=none; b=RmvbMpUFtdLFAciqN9ybb5kq0To+ajwe8/odkqUwCyMvvyU/TShYphGc3FlEnY32yNbTEVTLFwWF8wwfG9jkQKRzNiCEWlI3nsvD2PWNOHHzx8fFliG1X6dejZCgWWr0Z4QcyWBQlnFGzGUu5h0qV7WZ/7lVI7z1BYlhkXtoWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908492; c=relaxed/simple;
	bh=JAiiJcmfhbTkB4HlzTzj2DHalm2a7NWJbDL28MQe3R4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV4YV3ER5Bx+fEfK88mUxFt4l4+HKqGcdcM4Ma87dIerj1LEaHP6OWZ9n5KL2s7EaoUPZpGNpsU2iaXrMnOEqG0ZbxWVP1Zy9UhsKmb3AL7fHadiwJVpDWo0NzqF6ndE6lXFJ5s3upmIwMCxhiq+owMRdBuQw1lISKNP2ZODIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqvWHwfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqvWHwfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15FAC2BCF5;
	Mon,  4 May 2026 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908491;
	bh=JAiiJcmfhbTkB4HlzTzj2DHalm2a7NWJbDL28MQe3R4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqvWHwfNqa0oWH0UDyzmWdJTxfdfe8Bdk4H7FbQN8/F61YjNGw90Jt5WKuaPSRVrY
	 OLIN/mD2KoZlQtd62TsMK14+ivdXfyH/PcUyvSKYQUbFN8HO2pEJISXvwt6ffkDKPw
	 7YY/HWi+/MaSybcayBRGydnvwJSDIzb1WLuUUMuKF4n9UH6qQPa/+b1ZI4PuXJJjuh
	 N8YTdZmvqo9w+Nx1oczcenwY1vy1vPuBHVz4ryNeIIL/t9RrLt6k34QCsib9AmzHRs
	 Oztm6Nu+siaMNKBjHFoUa+SIWKbrh+wbQDe1MQzqu0mCcnPAXaCcw7GSsrAR7q6UGV
	 Bbqi0n37sFAVg==
Date: Mon, 4 May 2026 16:28:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 joshua.crofts1@gmail.com, Felipe Khoury Dayoub <felipedayoub@usp.br>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match
 IWYU
Message-ID: <20260504162803.7d12c156@jic23-huawei>
In-Reply-To: <afJg4G3oyfCZ-UiS@ashevche-desk.local>
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
	<20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
	<afJg4G3oyfCZ-UiS@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 22:49:52 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 01:13:39PM -0300, Rafael G. Dias wrote:
> > Clean up the included headers in stk3310.c according to the
> > Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
> > header and add explicit dependencies to improve compilation accuracy.  
> 
> ...
> 
> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>  
> 
> In most cases we assume errno (but strictly speaking it's asm/errno) is
> included by err.h. Double check if there are no codes >= 512 are in use in the
> driver. If no, drop errno.h.
> 
I dropped that as well as it's all simple -EINVAL/ -ENOMEM
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/kernel.h>  
> 
> > +#include <linux/irqreturn.h>  
> 
> Implied by interrupt.h.
> 
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> > +#include <linux/sprintf.h>
> > +#include <linux/types.h>  
> 

