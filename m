Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA272F3601;
	Thu,  5 Feb 2026 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323585; cv=none; b=kgc7CWVGKNoLVXpqA21/evXn/bofcacQrisb2gbQMalesfKzeE1yL+iPeKIK33+20wfozs2MnpUjaWB3bpT9WhP4/SgxwQsUB8tE702bDfB/fAovfODpRlVrSzwp9Y4MeIDF/iyA8ldHDYuAY6l+jMXLC9fnZMkC9YweAJUKzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323585; c=relaxed/simple;
	bh=0OzRt5s9csbB6yRKYGkiY0RMMzoyhj4YB+4hQWChGm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvSzkVOopC+BwYkPZDjjyGwHbsNANgfIG+iCO7/Q2uSBH+iLBcyI1WMD5CjwKYs7ZZvpZ8BqEIM+KERRGvr3whmntItGxq1/AKI/ikBxyk1v6/PcfPygWoyDD14QdIrgQIRebIZ0JmYWyd3W4bPy1F5Nt4xzEAzmtMUC9ONT3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m62pM0aM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m62pM0aM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9754C4CEF7;
	Thu,  5 Feb 2026 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770323585;
	bh=0OzRt5s9csbB6yRKYGkiY0RMMzoyhj4YB+4hQWChGm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m62pM0aMBhHQn/CmdJN7boPsMJupj9L1eTKj8EJRW+Y66jofVpjAtxbH7XbVAxidP
	 lW0NC2YHwPR633JOcS6CirM0zgEOwtkGpSEicgAuiTdRt/1PTkTq0wCy3eEOo+7rRl
	 AWQ5Fl2tSzrazkBi3bPNKaK9GgnYNPmWgD0LioQmU9EEZpunmvselFRZaB+qIW/ZUa
	 olYd4L1GZb6FbAsc37354wXzBle5pZbb1XgEKdMEqmTVjXJMGomcfuFkZ5xlxjL+KT
	 MqI7JXrWw087C1QW9ymygVXm8cHeCziTjCWWJXjGHk2kbZ/cFDyzYF+saboszScS/8
	 Mar1R8fOqa+Wg==
Date: Thu, 5 Feb 2026 20:32:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 3/9] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Message-ID: <20260205203255.4bee225e@jic23-huawei>
In-Reply-To: <aYKmoIe4sXNcMEYa@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
	<20260203-iio-ad8366-update-v3-3-5d5636b5181a@analog.com>
	<aYKmoIe4sXNcMEYa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 03:53:36 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 03, 2026 at 11:24:09AM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Adopt proper mutex lifecycle with devm_mutex_init(),
> > replacing mutex_init().  
> 
> ...
> 
> It's better to add here
> 
> 	struct device *dev = &spi->dev;
> 
> and (re-)use it in all followup patches. This will make the code easier
> to read.

Just to be clear. Please add a patch before this making use of
what Andy suggests in existing code. Then it will be available
to use in this patch as well.

Thanks,

Jonathan

> 
> > +	ret = devm_mutex_init(&spi->dev, &st->lock);
> > +	if (ret)
> > +		return ret;  
> 

