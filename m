Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB43009D4;
	Sat, 28 Feb 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296437; cv=none; b=KRanJP9ffLZhMSyqC2zI0uVV61QX6FwLMC+YP1/nVnMToM8VGgQuNiGkFdfedyVsBumHXRu6d8hTG4CziXhozfJAWuDQtqKpcLO/XoPqc0n3AsI8Iau/tsHqAWM06IUsDAwhaFIFGM1pa0rmUEjj31FIzUNRgkSKPHw5sYLgGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296437; c=relaxed/simple;
	bh=Y4Pt3IwlT6t/oYjVE++bJVtJ2yTDSSWoI/MnAV9GB0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xan4Vwv/umLHph4f0XtNzyOiKOaqVudgqWqOglbQIWAKKYUq08TIYSYMuOeOi7Nt1eqUSj//Xg6RVF/1bLRAEfnnz6u/LI0rWL/dN47KETwawJ1i36vZ6vDRFwCqgiafMWuP28jIFGqoaxM5WaTKOiAaOru24YnmhHNLXmwtrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojewnic6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojewnic6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E27DC116D0;
	Sat, 28 Feb 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296437;
	bh=Y4Pt3IwlT6t/oYjVE++bJVtJ2yTDSSWoI/MnAV9GB0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ojewnic6dFmN/sIvtAUZtVHCRiGe/q4UaXhDLr0Z1lClf7WN8q4L7GbWqnEZnNqao
	 YknEuqVDb/Ju5i6SHl1fKgZZ/1C/sVr18xM3o+/C9NB2g633ezz1LEsXGmPtIwouMO
	 GwMC3uJT9foZye9YNrHQaPEWDZUzKgCGBT3l5jTs2bXxvtcTpcfDDjaQp9u6OiAb8Q
	 D+bN1jCGv+3b3HEHlC+gsWjHnUBYh8GyzBXSngo1df1s7q8dxTT3glUqpR3d0t6XAU
	 IIZ7GDhbK6q4OixdEf0ygZSmi97rL0tPq3bz/RaABb/heVTt9IYxVhKE71tnc7M3Ji
	 T6BffFvNOPcEw==
Date: Sat, 28 Feb 2026 16:33:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Message-ID: <20260228163347.093621ce@jic23-huawei>
In-Reply-To: <aaBIQ2zmMuEflPlN@smile.fi.intel.com>
References: <20260225-mcp47feb02-v2-1-4792dc3942d9@gmail.com>
	<aZ8cXbvj7KcQNvp3@smile.fi.intel.com>
	<CAN4SLj3jw-SqXSV04CA_-d=e=Mu63xaJuzu1rUYzTtt7myqMKw@mail.gmail.com>
	<aaBIQ2zmMuEflPlN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 15:18:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 26, 2026 at 07:16:26PM +0800, Felix Gu wrote:
> > > But is it called early enough before anything that may trigger access to
> > > 'data'? Exempli gratia, IRQ handler in some cases may be triggered before
> > > probe finished (is it the case here?).
> > >  
> > I've checked the implementation, and this driver does not support IRQs.  
> 
> Thanks for confirming!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.

Thanks,

Jonathan
> 

