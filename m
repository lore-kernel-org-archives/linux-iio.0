Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A472618;
	Sun, 12 Apr 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021274; cv=none; b=PevwSkskJC55EICg6EBnTBlt+rTChE/AegMWZiev0y4uePPpN78f6x0V8W5Q1HYeqffYL9cS04A22do7aaRjtgL2jAqqcQoD0gYZoIppRL0bApHztwanDxXAIxQbus2kpzVmfQ3YgYDLduDXfMAUSsiMZOS8aNHDbvNCVyHW2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021274; c=relaxed/simple;
	bh=9q3BbFRsuflLTgk0E7/x6jOaA3ZnBUs9kDD0P948DTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKWubrqGQAm2rWCkUqxzzyv2WRRpZFPYZhEtxRmensh9D1p5hp2OEq+H9DulEtIHE//TJV7d7bHv/7AERQ3XDw4ES/+bFXtOrE16w8cVgIbJ/BOj1ggV3N8grTWcoSdOYhGPyU+YcOiM6qP3ev7KuG1x2GaHhPVORpKn91s7h2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCCn+4qY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCCn+4qY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC89C19424;
	Sun, 12 Apr 2026 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021273;
	bh=9q3BbFRsuflLTgk0E7/x6jOaA3ZnBUs9kDD0P948DTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCCn+4qYsVtE0hmr7aHcVAseXHMg56c3pBsk8rliDFcFgse4aRFGOkKfwg2YPpRKu
	 nH88WNJPEKU5fF+veOzoeXPZriVLkzyM4JbqjsyaiqZmriDU/dv9cdLsg7v6Hm625E
	 LVzAYLEWn41XGKn2XB6h1oieQerrIZe8SSc9hKUQ6ts5xpVjY0meT4s9H4Inkl6Co6
	 tMQKgKhJf84rgpgce0VuC52rEbw/VtsSQpFVD831F5iZ4+tqBSSU5q+r/2zUq2DT0M
	 HQVm0xYiDnHYluThiSLpWnmnrk3rXhjbR4mj9ECPAARj55v7OUFcOcNZ1xB1qfBqom
	 AtvR+HXswtT0A==
Date: Sun, 12 Apr 2026 20:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: grondon@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <20260412201425.2333ec71@jic23-huawei>
In-Reply-To: <act-G43FAjg_6BZm@ashevche-desk.local>
References: <20260330181527.65362-1-grondon@gmail.com>
	<act-G43FAjg_6BZm@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 10:56:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 30, 2026 at 07:15:27PM +0100, grondon@gmail.com wrote:
> 
> > Convert the in_voltage_scale_available and in_voltage_offset_available
> > attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
> > IIO framework's read_avail callback. This uses the framework's built-in
> > support for _available attributes, removing the need for manual sysfs
> > formatting.
> > 
> > Precompute the available scale values at probe time since they depend on
> > the reference voltage which does not change after initialization.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> (Still BIT_Ux() may be used to avoid overflow warnings.)
> 
I'm fine with it as is and I'll assume Andy isn't that fussed
given his tag. So applied to the testing branch of iio.git.

Thanks

Jonathan

> 

