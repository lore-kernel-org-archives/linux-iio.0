Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8A13790B;
	Mon,  7 Sep 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747642; cv=none; b=LJwEfPbcyqNQPCpPFevpXsaz1h1UsDVqq/s06WlQofrDgDjsB37VJDzyIhQUqoKNR3ok7ESZInauT+czcBPtkSAhWv6VrxWgPCLzCaOyVGFYCoT4KTyL8olHo55+mWZ8oWMbWi+rrbS07SwavpxkSI74u5AQcSxz5vhXa667mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747642; c=relaxed/simple;
	bh=hSKy8Fhim6gOjn+u8OKIe0rp7G+0D3nfuAmvvbax7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjm1FK4YjYqI3WMVU0C7lMAPPlL48hwSMWTj1N4Y3NDlKjd0HHyf3D8sx8qj8MC6b4TZ5O0s0dG0GxcfMQfSGRC3EKkyP7QXxddjSGAipc/IJZ1ZxO3FOP7oOHOL79NZMINE1OreAh/MCNwGZAcxrIkB5jMti52yk9OByXbLkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCoxQXF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCoxQXF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624451F00A3A;
	Mon,  7 Sep 2026 02:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747641;
	bh=HV/tFkxWGTXlhJ0ISNKA8q4/L9JDlzze0Q4zK1q9mN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DCoxQXF92jSYPa1pzCANJiVdWOM+2ixwyWvqHqNmBxl/OnoxVF1KvNnUxufHf4lQC
	 wwWgkAyXjSr9BjOjtwDQ8yQ/yZfoaqtDI1bzSXi6CItvddp++vhl8td6rihuz0rmJL
	 Cx8xz70BM1i07lCczLKfpPDJMTKF5t8SpvQPgpQIW4DdspdzcYrYcUZjcJ4emMNNzw
	 /eVapFbglDEV3rQmGmMXTX2iGe4zDqwSsYmxOAR+OroPpnonDPFilAahl9SD5YCeRe
	 ve6XxTj0SdHBSXo6QaBwsV1wCpZnKuHx1RIspGUrNLziaccOJJFIio9N78z2V8YZV3
	 q5haVmZpujGyQ==
Date: Mon, 7 Sep 2026 03:20:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16400: Check return value of spi_setup()
Message-ID: <20260907032036.15a115fe@jic23-huawei>
In-Reply-To: <apl3pwAZezUgEs0e@ashevche-desk.local>
References: <20260903122733.67109-1-salah.triki@gmail.com>
	<apl3pwAZezUgEs0e@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 16:35:35 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 03, 2026 at 01:27:33PM +0100, Salah Triki wrote:
> > In adis16400_initial_setup(), the return value of spi_setup() was ignored.
> > If SPI configuration fails, the driver would proceed with the
> > initialization anyway, leading to undefined behavior or silent failures
> > during device setup.
> > 
> > Check the return value of spi_setup() and return the error code immediately
> > if it fails.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

I assume in practice this never fails, so treating this as hardening
rather than an urgent fix.  Applied to the testing branch of iio.git

Thanks,

Jonathan

