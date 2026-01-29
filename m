Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66B33C534;
	Thu, 29 Jan 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703255; cv=none; b=jqhLHt11q7j34Enbzruh80ppJnB7kS5JZvCrUWsWLpI4KgDrCK7mpO+bmvAPEzsP+H4tkLSCZEifIfgZDsSmaxcYZkLSHRQ2aTl8aEYV8o+lc4EZtxHYvxCdfun5zO1+QaD7DxIqcBmFd8CNCPPLV9uBVCASfy5zffhVwYyG1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703255; c=relaxed/simple;
	bh=X+b6+F9T2ResFcEoWA9vPXwWaCD4NTszgDDYTeiC0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/6j1NijvUv1OL7JGYYrAAmCYn/jebE9DmAJCnI/V7ce70DHxu8RqXQqQgLnkwwfrffl+NqOmru6Vt8nMOYiUbYxICYOQNyB6i/aMFiBBXMlJJDmg37sL9dIWHNWlNxJwJlyh80df5Pn1ac1G/XXigfibs/eMSOaYopZZu5BMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKEQEizu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKEQEizu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566F8C2BCB1;
	Thu, 29 Jan 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703255;
	bh=X+b6+F9T2ResFcEoWA9vPXwWaCD4NTszgDDYTeiC0aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKEQEizuUpBN1Og8c8jiOuJTQCaEOnlReR/yGMiWzLkJXKnqltlxFd+Ds5l5MlvCx
	 8ltQWS3rBdw73vg8OMqHkm8UwFHxrhF0qo6uFxlgiyiUOoKPsdMA10bFF8rKFQaegC
	 O3o+GhiSkaO7CcAvGRAY57eNZwNP/j4Ei3G+gwzPlxf3+0pTw/WujacDjVihLMAHGI
	 voecv8b1NUpAHb75A4pTH5gv7b8TOPFeTxW2lgMOIXzOfO51CCJy/ykFHQC6ue1C7M
	 YyPRtYJxKuPN5rdrX3PYrMpRlXJT3stgp8CPjTSsxqR2qKbvd7BwinV52uEkDyW2m+
	 3/WZDo0XYVwqw==
Date: Thu, 29 Jan 2026 16:14:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 19/20] iio: adc: ad7766: Use
 iio_trigger_generic_data_rdy_poll()
Message-ID: <20260129161406.4a447483@jic23-huawei>
In-Reply-To: <aXoJoXgliFimSE-r@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
	<20260128095540.863589-20-bigeasy@linutronix.de>
	<aXoJoXgliFimSE-r@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 15:05:37 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 28, 2026 at 10:55:39AM +0100, Sebastian Andrzej Siewior wrote:
> > ad7766_irq() is identical to iio_trigger_generic_data_rdy_poll().
> > 
> > Use iio_trigger_generic_data_rdy_poll() instead of ad7766_irq().  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.

Thanks,

Jonathan


