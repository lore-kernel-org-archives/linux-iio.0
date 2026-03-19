Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44939524E
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949830; cv=none; b=nfr6+zoypJAUe+kAJRY8sluF8zLKeFWtWXO6kBipzEVqtfDtNL/z3BCmTIiMZxGqLY3Q3I4ori58G9BVOHRTq0Dr1Q5ltfvTo77prxUdz9hOWX5h6lHeG/lY3LUhTAbht+/LUJQxPZQmkgbtq2nWRFc17fZfK25jwSdhYxvmSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949830; c=relaxed/simple;
	bh=BBI/oqloZue43OsqCTnV7aPG4pBpVJxCRr5rHu7dyxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB1OpsG3LNeLxSOjZKULePXZeAOMNWwCVNqODcHgdcO/MXGTWhCj2outRgchvVIqGIUjUduVtSNhf3y4t2Q1ltpfh7GBB1+qPfCS0AA+VfKbGOMHL6uBqK9hcuk/DUgGmMyKq4Abr5UndgDRrYfyHAxGPfR38PokNgguOWSczz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFV195IY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFV195IY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC3C2BCAF;
	Thu, 19 Mar 2026 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773949829;
	bh=BBI/oqloZue43OsqCTnV7aPG4pBpVJxCRr5rHu7dyxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFV195IYqhVRcIppA3AquYtF/g+RU5uAxD9GAixz4215xGMJfWwkGMe0lrKl1mRaj
	 Bs8epuoFWQjLZd/qBLulwe+c2ZAm4rbR/+ZGY27o+KuCRXvrITo45MeQ4nihfVYoch
	 KiNpfVPEaTALC4e+hE+Cp2Ewt3HY1PZHcVFyVBc8D+0JHRFOuDPPXkyRd9P9PY5s/+
	 IVlzjnMc3nhDOltV+pyypZvtMoCZov9+bugpMezfmAe4IfUVQlkIZh6wutsCbt1OwA
	 R6nPmgMyB06kTb7v+3+NmyMzw/Dx40dIFkK5tVxAi56nGaJJVsQ//a3I+QaL+qhAGq
	 PAejjqL7NR8Dg==
Date: Thu, 19 Mar 2026 19:50:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: remove redundant OR with
 zero
Message-ID: <20260319195020.789fed7f@jic23-huawei>
In-Reply-To: <abu-21Hi5eXkuGkQ@ashevche-desk.local>
References: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
	<abu-21Hi5eXkuGkQ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 11:16:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 19, 2026 at 12:57:42PM +0400, Giorgi Tchankvetadze wrote:
> > The expression 'ADC5_GEN3_CHAN_CONV_REQ | 0' is redundant because
> > OR-ing any value with zero does nothing. Remove the pointless '| 0'
> > to simplify the code.  
> 
> Have you read the comment above?
> 
> ...
> 
> >  	 * Use channel 0 by default for immediate conversion and to indicate  
> 
> ^^^
> 
> >  	 * there is an actual conversion request
> >  	 */  
> 
> I believe this is done for clarity. No need to have this patch, but I won't
> object going it in, since the comment still stays. I leave it to Jonathan,
> but I'm not going to give any tag here.
> 
Without the 0 it might appear that the comment was talking about what was
explicitly set in what was left. So ADC5_GEN3_CHAN_CONV_REQ hich would be
misleading.  So short of saying in the comment that the 0 is another field
in the same register I don't see this being conveyed as well by comments as
the code is doing.

Thanks,

Jonathan



