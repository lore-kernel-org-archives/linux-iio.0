Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323932C8B;
	Sun,  1 Mar 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368478; cv=none; b=J3FfcnuAHwbgutgUBOiQuZ4M6M8kIsk76nWRQ6POwTOrPszSSod56kFU+PcUtGBBkdqli+ng2CQqQtKPPW5QtBMUDIyk6OWnQYBpa28SMR49yqn81KB61wpLNxS1rCIRIw3CeoWWKUJJz/+XXwIo5V/B0JQjaaQrwPlPhULYRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368478; c=relaxed/simple;
	bh=qBx8QActkRRZ60WEDdQxgzqdU05IE+jf6ADgS02I1yI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK8a+n/FdKzKR49J7Kvr79QqanbJY4Nh+IcPD8fVCm6jTu9DoQEyF/DFGaV7E3X7E8Y9rQwoxAi4jdoqY0/7bmy3oB9J9NnmInjLmf9G0FiMIgfuXCBfqC/T8vub+2LnQCF12ByNMWPy1ZyVCzg8YkDj6M7wLQ17CyLHeoqUHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suy09AyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suy09AyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE74C116C6;
	Sun,  1 Mar 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772368477;
	bh=qBx8QActkRRZ60WEDdQxgzqdU05IE+jf6ADgS02I1yI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Suy09AyEKk19MO1XWwYZeiYyBkMkhij3UXE9ejp2hNzz5fgDSWHiXgi8Z/f/LPSSY
	 6HjazEp+0IZ490kE0uH9J39peM8FjXph8N1xDabJOq2V05f9gqcLT3Z6qTip2gNS7v
	 f18eds0JcJrx/Bds3TBEb1ku48x+LdjuWpTlNrPc8J25ZyVMWAxHISKNqonv2sxbet
	 5prwr+xUv9wGXOZek3wf5TorRUZ8fZlChJlUntAQyccmnUF3S1U0SOzY6r4JbBeOtD
	 LIsFMAVczq6VqP8SEEf0OOLgGlmZUqdVq5H6kSy1bYaJSjNY9rHFfhrLIpcA69LC5Z
	 iJqQWdNHF4b0g==
Date: Sun, 1 Mar 2026 12:34:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Jorge Marques
 <jorge.marques@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: adc: Add support for ad4062
Message-ID: <20260301123429.45d591a0@jic23-huawei>
In-Reply-To: <aYX1qCSTSuIEt2GV@smile.fi.intel.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
	<aYXvT5FW0hXQwhm_@stanley.mountain>
	<aYX1qCSTSuIEt2GV@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 16:07:36 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 06, 2026 at 04:40:31PM +0300, Dan Carpenter wrote:
> > [ Smatch checking is paused while we raise funding.  #SadFace
> >   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]  
> 
> Oh, this is indeed sad. Wondering if LF can donate...
> 
> > Commit d5284402d28f ("iio: adc: Add support for ad4062") from Dec 17,
> > 2025 (linux-next), leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/iio/adc/ad4062.c:1557 ad4062_probe()
> > 	warn: passing positive error code 's32min-(-1),1-3' to 'dev_err_probe'  
> 
> >     1555         ret = ad4062_request_ibi(i3cdev);
> >     1556         if (ret)  
> 
> 	if (ret < 0)
> 
> resolves immediate isssue, but...
> 
> > --> 1557                 return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");  
> > 
> > The comments for ad4062_request_ibi() say it returns negative error codes
> > but the comments for i3c_master_enec_locked() say it returns "a positive
> > I3C error code if the error is one of the official Mx error codes, and
> > a negative error code otherwise."  
> 
> ...would be nice to have a conversion helper to get Linux error codes
> from the Mx ones.
> 

@Jorge,  can you take a look at this please and ideally send a fix.

Thanks,

Jonathan
