Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9513B58C;
	Sat, 16 May 2026 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928947; cv=none; b=ehrahg2ySFT3zcB+wfa0y0RfkdbUsr6pgZLKFsmjXSzF9n5DTLSzBqDULnUsit4Q8DK6BaPBm3aSvKIFBzENoxlumqwCWvMR6rAw/8cm7AEJVur6Ync9a0/cICgHpPOHpWYj+OUch1VURbPGYmnxKiCd5ek/6GzpGxIfNLQe4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928947; c=relaxed/simple;
	bh=DZAW6duSFBcU0Cx8Sy0azx55iqqX/OCHGZ7XLAliUAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgQzuRq6QYlMeIS5OeJ1rCaOYhGkBc+Z+us20mIb9WDVzGE7pimzF8Whmr+Jh7oyGRl90jIiIaSliG/+uJ+3rmj2EED03n0CNYtkcY5xG0yaMzxXZVxlnj9TNA6LK/07njltN+N+eOShR0dTqKf7L62MaELdY8fOsrIzbbJzTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt6aen//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt6aen//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBCCC2BCC7;
	Sat, 16 May 2026 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778928946;
	bh=DZAW6duSFBcU0Cx8Sy0azx55iqqX/OCHGZ7XLAliUAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lt6aen//YIUk6W6IItIgwoaLKMxGj4Jd4yROiXoOajKhtyITngeco5FIBA9cKZqHj
	 Zv8NI/lfH67lZmrjwAS2SVGNp3kljrOSk/FPRpgSTIhC04dKPEY5fM9ey3ggQvEy1P
	 XN5yRf5JRV5AVhEPUXi1c3wEMad3CwK1JKPoOOSPASDyoyv9QW9hUGC0jvtRNO/oQP
	 cnp42NuU9lLCilKRQ/yY40JpTzxlDPem/Nh1ApXT9SsMLLopF2SCayerO1Uxcdu7pl
	 QnxUsS1ckjQeSoAH2jKD+L+V/dfKaiK175+3zKqVrV/Cp+QGkcw9MSoaj6ORv02zpD
	 DmAKv9XztS+PQ==
Date: Sat, 16 May 2026 11:55:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, alisa.roman@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: fix GPOCON register access annotation
Message-ID: <20260516115536.28569dcb@jic23-huawei>
In-Reply-To: <agR-Is0LLtfvhUne@ashevche-desk.local>
References: <20260513101332.8699-1-sozdayvek@gmail.com>
	<agR-Is0LLtfvhUne@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 16:35:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, May 13, 2026 at 03:13:32PM +0500, Stepan Ionichev wrote:
> > The comment next to AD7192_REG_GPOCON marks the register as RO,
> > but the AD7192 datasheet (Rev. A, page 24, GPOCON REGISTER) says:
> > "The GPOCON register is an 8-bit register from which data can be
> > read or to which data can be written."
> > 
> > The driver itself uses ad_sd_write_reg() against this register in
> > ad7192_show_scale() / write paths to control the bridge power-down
> > switch and digital outputs, which matches the RW datasheet
> > description. Update the comment to RW so it does not mislead
> > future readers.  
> 
> Makes sense,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git.

thanks,

Jonathan
