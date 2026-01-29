Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271226ED28;
	Thu, 29 Jan 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706682; cv=none; b=ZQKlNod4r6SXs5cAIKIugg/m9/+Kk9Nh0EmGs7liSMvpum4gNWhm44swbGBnbISijH8sXrvNmxmTQH/4XePU8jP4okpKI8f2w8Fe4bbnRRnZcMgaspWhe/x8uWFTAe6CqMGT2Rw23jXpj6wM4a3F9Askd93Uh3UY23RDxFcvqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706682; c=relaxed/simple;
	bh=shNIhgwazY0CXUgf4JtZWWw7jpOwNtAOZgeREQXsvkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK0o5Ugotqq77JblPTQzQz31CFR/raIlX7PRRvmi3+zFQsbflkfggfr0t3miBsvnM86B7/HvA4ky4GJ3Is6L7NoNCrvP5wM4vsn2AI6soCSkRZFY+DkL4W9FU2XdgaS1SZAvKMgEBHlLW4dU2H9YHHZPyJQkVl0QxuErnWCfmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV0ESjek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV0ESjek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E018C4CEF7;
	Thu, 29 Jan 2026 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706681;
	bh=shNIhgwazY0CXUgf4JtZWWw7jpOwNtAOZgeREQXsvkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MV0ESjekHxhkgLeNNtIo/n9fAmxB13nb0txHgSgNvz0z6mGArcvb02SMxu5As2lhI
	 Zegmfhar2da2E8q7XekGrxFSvOZbEIspU5zHayKN1/AcfmESYt0Rzqxq2VPB+6SnfK
	 7Uu/QvnhX2qx2rX5dC+g10vByyifiQjsVDKOtIIkoORGm2PgI8VTR9wwFNiTntCxq4
	 g4PIzIH6niRyGtBU1eqSmKY8PJGuMIF2o2rEFVme57h21wGv8OPdQU5lVK/do28zh0
	 S8lPVg5/jcDba7Nsf/lIIiPxU9ThOgJoTGG0A+vKe0f5rCq1/+CJAXk0yJOh98HaFm
	 4zHPEFQnKqQjQ==
Date: Thu, 29 Jan 2026 17:11:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: ad9523: correct kernel-doc bad line
 warning
Message-ID: <20260129171112.253540c5@jic23-huawei>
In-Reply-To: <aXnaI6B3panV7QW3@smile.fi.intel.com>
References: <20260128062539.404595-1-rdunlap@infradead.org>
	<aXnaI6B3panV7QW3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 11:42:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jan 27, 2026 at 10:25:37PM -0800, Randy Dunlap wrote:
> > Insert a "*" in the kernel-doc line to resolve a warning:
> > 
> > Warning: include/linux/iio/frequency/ad9523.h:47 bad line:
> >  LSB = 1/2 of a period of the divider input clock.  
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 

Applied

Thanks,

J
