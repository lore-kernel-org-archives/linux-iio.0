Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E13777E;
	Sun, 19 Apr 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619999; cv=none; b=qYtrxUAT1WPVQHck/BOWKg6xgBzWgAPfr8+2Np0igu3QyIDRE4J0ODAIISw9hUIc+LhYr4DnEmSpqUXNIh5Su/2I7QgZDi3DWol9JPWC+P376qZgps/NYTfG1D4vlBNxraQQ+l3cCBX/NBCDp/RR0mKIg2/T0d5RcCmwL5HJV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619999; c=relaxed/simple;
	bh=i1pmlLoqELmYbKsEHe3eukxqNMsLns7Mcr0bfI7ekvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQZMXMfLqW49okQLvDvHl6n2jwjendU4KvMI0B1CNBv/ulvVYzGps4uzkHQV6I+F+IlfwxJnVczldi/xrWY9/pl0Oz7IM5lRlSoBAWXL6R6qlsN+VvZ+Uvuv9BsfmGJp101S6BhxxCqaF/SMc1M9ckt3e8IYkHzIlFnowNzM9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHdd1+Jm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHdd1+Jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDA5C2BCAF;
	Sun, 19 Apr 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619999;
	bh=i1pmlLoqELmYbKsEHe3eukxqNMsLns7Mcr0bfI7ekvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHdd1+Jm0EAsErN3PaTQ2MCsLA62fvsbIblN6CwQl1o3J3FdjEF6OD7K/2Vva8NB1
	 Y30msr4BsG8wQE6gvY1X/sr4B0EFuhFaFLWPRlII9yCry1zcwqtRoQG+W1OUJk/pAj
	 bzqRXVQuSn80pJKhwoK3n9py4DK3hKXrcCk8KQF6IlsfhV4a/S/WHmTjBpzoX9IpkY
	 EzUEfC0/7VzONsf0Wepbj9BS0LhlFTtkAbSkGb3lGr8pvNHNSIfhYN7mtRbCQBDUOB
	 vPSgPVU4iYQuKtdEYTAjVHYgxchypCOSfJx1MI52McIPxb02HaXfrV3OcsoIKBtBC+
	 A5bYXLmfmyzEQ==
Date: Sun, 19 Apr 2026 18:33:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, tglx@kernel.org,
 christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iio: ssp_sensors: cleanup codestyle check
Message-ID: <20260419183310.2a2cec25@jic23-huawei>
In-Reply-To: <ad9XBFb_xCw3mShv@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
	<20260415050749.3858046-3-sanjayembedded@gmail.com>
	<ad9XBFb_xCw3mShv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 12:14:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 15, 2026 at 10:37:44AM +0530, Sanjay Chitroda wrote:
> 
> > Reported by checkpatch:
> > FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> > 
> > CHECK: Macro argument '...' may be better as '(...)'
> > to avoid precedence issues  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.
