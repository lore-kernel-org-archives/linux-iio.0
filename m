Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41B1F5858;
	Sat, 14 Feb 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094095; cv=none; b=T/rLqip1KprGH/CNW1RWdsFsA5yKT07vzFZ7KWEP6AB3UBafBJNUJsBpKXEzMwZcNMWxrqA1uBpPYYfwTlncadko84GcARPc/KZDWiolnpn+atNNrKtnwx5NCDQg9AUra0MD3ERJdRz9LoVbbsxlsOp7Clvz7NhuNqPCRe9hNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094095; c=relaxed/simple;
	bh=/xEXdCcot9p/GcKSH+u0yYfTTzkJIkGxfRU64mzjorc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpTmJKjDpoklLofdaLk6RUrY1rStbMemiPkGGl2OegrfjD8wktRkx5VFSC+Sp6fR200Z5rSDThIOd9qh9cM5qx9sjtMk6yaEAASqhzFhuil11V+xQ6E6LkTt9Ksyy79RCnEnSB6U6919FX5IESIcfe5pZbtOPlacWQA15EmmRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1Be8dYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1Be8dYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB90BC16AAE;
	Sat, 14 Feb 2026 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771094095;
	bh=/xEXdCcot9p/GcKSH+u0yYfTTzkJIkGxfRU64mzjorc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1Be8dYm6cNwRlkgT1YC3jreRilsEanpTNMMHMsbKTcemg+/iIs3XhfyNVlcA74yf
	 mU9MQamj5v5Kiz7Rg8OisVdrpG/xwAOmSkLfdCHJLOGdVRlftxOWXkCX5sgM3OtiE3
	 hkzMG6sXD9zrZ8zZP4AmCMZYWMhc7aKFNo0lVJzMNfU4SvJQjRzk2g8rE3fXl4DuBP
	 sw/ncredN8BIERIdgFZbIuFdl60zrskMLlZGdXSC8EI5mPrFOmf73S871Z+3N6IHa7
	 GL4x7D4KwR6P/hoF+Sjrb8S4Prf0WxYzlKOO1MUhoUpzQvD16e6jzaBSSfGU0/3j/T
	 WB0lyqrSBGQJw==
Date: Sat, 14 Feb 2026 18:34:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 04/11] iio: amplifiers: ad8366: add local dev pointer
 to the probe function
Message-ID: <20260214183445.3c9d1bd0@jic23-huawei>
In-Reply-To: <aYuO_7cot_MAVyPh@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-4-15505f7b15b4@analog.com>
	<aYuN_Myx3FhmyQf0@smile.fi.intel.com>
	<aYuO_7cot_MAVyPh@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 22:03:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 10, 2026 at 09:58:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 10, 2026 at 07:42:04PM +0000, Rodrigo Alencar via B4 Relay wrote:
> >   
> > > Create local device pointer in the probe function to shorten lines,
> > > making the code easier to read.  
> > 
> > Only a single place to convert?  
> 
> *Yes, I understand the intention, you need to explain that in the cover letter
> and/or here in the comment block.
> 
Consistency matters, so once you have this local variable use it everywhere.

There are a few others in the code as it stands. If you are going to happen to
remove all those lines in later patches, then fair enough to perhaps add a comment
to say that you haven't touched them for reasons of churn avoidance.

If not I'd expect all spi->dev usage in probe to be replaced.

Jonathan


