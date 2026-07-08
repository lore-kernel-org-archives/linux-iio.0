Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337DF3C379F
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537534; cv=none; b=E/+pRsBzeYmJ0WNkMqJJo2Xi7C0J6SZUIJT6PrVBlkF+4MO7ed1tB8zF9X+1+GYgdohWACyklFXQgTAHuGypidKMDhFs4baVxzxwTt50zXHxZoJvunRgn8uRGKoQmRWqJ9gjQqUgbAU6LSkEOplzCE3GU0xxPlLlwqznF4HeLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537534; c=relaxed/simple;
	bh=Z8Yz9PKa7uFBWQo8Ur5SwLO33rz2LIemEl2lFmYjXMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiVNppzRPvsRPgKRcG8FtCNRcOC5ezVkscqLq09bOZxZbck1K5rEU51ZpRoZXBiUV9fDhLZMAF6AuESIZDQ+1i3R7qcCJf48WrjWHHsRY52/DT4BtKR16Cwdvrkm5/tXavljM/zkx34csPcRXca01K9li4kpPp44pIg7bri6Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPpm5cJQ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPpm5cJQ"
Date: Thu, 9 Jul 2026 01:04:41 +0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783537521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56W/VFUwknXNliD4iRNfvqsZnF1lfz6PNsFALT4S+Ss=;
	b=tPpm5cJQ9fSbbSzx4HMJOU0eijyxCSlk687BAxtBKlGrFXPNYns4ZlHAAaM/nOK4fEuKRo
	c98R/OR4MpJM4WJkfyJwE3mGMviZyiMGfh8y0G26rr8obr6xNm5A6ErLBcfKQZENYnRpFO
	iKKkTjQpU4o35PMm9FAdGhbdLGii0oM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lukas Metz <lukas.metz@gmx.net>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ak6eihbwmVyd6JBu@fedora>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
 <20260708183359.495c4b65@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708183359.495c4b65@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

On 26/07/08 06:33PM, Jonathan Cameron wrote:
> 
> > > +
> > > +#include <linux/array_size.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/mod_devicetable.h>  
> > I asked you to add this "mod_devicetable.h" header previously. But I noticed some reviews by Uwe 
> > to use more specific headers. 
> > In your case these should be 
> > 
> > 
> > #include <linux/device-id/spi.h>
> > #include <linux/device-id/of.h>
> > 
> Not necessary given they are guaranteed to be include by the bus headers.
> 
> Take a look at what Uwe did in his series.  The actual device-id headers
> are added to very few drivers - mostly the bus ones are enough.
> 
> Jonathan

Thanks for the clarification. I should have investigated more instead of
following half the story.

--
Best regards,
Sirat
