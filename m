Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991233508B;
	Thu, 29 Jan 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703076; cv=none; b=uOzcLPqaiW2PR1FLB9QSj1ZK6OU9x5CgMPRDqQOY3H09AYpt6tlxGELuyDNmyKfZPLw3LzCyXrPyD7KqQ8AhoCRjtovxClefRrWdAQepQJeAXQ/U9E2PKOEVkMAaN5WdZ3kIjiZkfSHzUtanl71VU4zW6tkPUTg/17M2vtZ2CXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703076; c=relaxed/simple;
	bh=euK3N2PE+sYNIqe7z4g287DsQ35uOLspKLRZ1IF4lPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvu7Htge0/lO7t/hVi1pffpTfAwswK/zqOfkObqPSyPJz2GW7Z2r+4D9nWE0Ovuw8KKHrV+kKaaoBB7JlItBV8WB9gn17293IHjTXCK6sP//TUO7P9h4qBebP3ozanGtdXVukquxNGjpYl0s7romx3ZW46+tZbS2GnHTTVHJAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAM4q81u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAM4q81u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833E1C4CEF7;
	Thu, 29 Jan 2026 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703075;
	bh=euK3N2PE+sYNIqe7z4g287DsQ35uOLspKLRZ1IF4lPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IAM4q81uS97vyglRZlnndYhoVcF4/LMVdh7CSk3+glw51DhWgVtPNEBj0qBjmzKDu
	 hC0W7lEQ0CSzRZN6VuvEhfATbZKnhbpDJf+/T0cGQlG8BKwCNcuNe/UqDNxbd90M9v
	 Bd3qD2hC++yxs7lZoROldOv3QRrhEFgkAYwwJWzJ/2sIsf9zVIUY4C0jk3B56W1zQQ
	 QVMn32hx2Mtmco49hyseHan7UvAvZuSMa5KavMNhQRidUWYfZQ3gwSixC0palkN9j8
	 X/CnWRJH5bzxX3aXarjrOu3f9YEqJM4R3yWG/7y8Jk82tYOh0FCH4G0bC3uPsLalih
	 +L3W+lwVCfUbg==
Date: Thu, 29 Jan 2026 16:11:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 16/20] iio: Use IRQF_NO_THREAD
Message-ID: <20260129161106.4c4b7430@jic23-huawei>
In-Reply-To: <aXoJCmySAPIWlXYY@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
	<20260128095540.863589-17-bigeasy@linutronix.de>
	<aXoJCmySAPIWlXYY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 15:03:06 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 28, 2026 at 10:55:36AM +0100, Sebastian Andrzej Siewior wrote:
> > The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
> > other interrupt handler and this supposed to happen from within the
> > hardirq.
> > 
> > Use IRQF_NO_THREAD to forbid forced-threading.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.

Thanks for fixing these up.

Jonathan

