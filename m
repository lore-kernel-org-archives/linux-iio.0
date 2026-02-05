Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7213033C5;
	Thu,  5 Feb 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322459; cv=none; b=RvymxAC5ygqWMPb7Huk8uPzsomyXu9QB3K1fPMOfazo4thK3PmVD8Z8PC6ue10+DfK8yJTj7itoauSEXWEx6uWTQ8UAnxykmWakvizWF0jE9V9nvlAsZgB2R5v3qpa3ZX0k5iQ1qSR+30ZtFkFXYpXBaz7uFjlTOFz960tJvPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322459; c=relaxed/simple;
	bh=PgJpG8jr2NfzXi9Q3YG84UPq3HanUzBqbDKrydlPhi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFOKTmxaGUFT0zWJ5mTDMLV/FMKXu4JrEkt3X4tdpzzNsYW8lr9qc4oveE+ZdpOiaKlz5wDBz74MQEF4USEljIq1NbB5R+kqxjVA68pVCjkUyCDuJRE236McwLWKAz+bjg944rF37DGi4PKO3Jzsm290vFkI1s+tGnp6P4JTVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPv/xFjm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPv/xFjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0AFC4CEF7;
	Thu,  5 Feb 2026 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770322459;
	bh=PgJpG8jr2NfzXi9Q3YG84UPq3HanUzBqbDKrydlPhi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPv/xFjm68TR1o64ZfI0e/CeQhkjywHsBw4jCVEMiP1ojL/6Pw4bNI1Pv8Z1X8g6B
	 Qcoo5UKwSLNQQW2+aEr3Jeht0AdmD7vJDrYwK0f+VW7FRVGHJx3OPQiBIUtD2npBC5
	 dBhkeuqBEXX0LqFyFjGfjam+5JjN8/AdpgKG6Y/h9l7ga7jgBNYEGFwGWHwzznd5Sa
	 BMUJNYvRJ25tCh8HgC8+msxEl3MagBxSJt9tz0YMSLj3nR2hndnh+N2B86Pt6WCIyw
	 f34jxwsvtNP6iUTs24bRhjgDd6zixE2y7V7nf9tplu4w6wjs2Qwg1ecvtH2ok2U2Ha
	 Z/p0yi64hyxfA==
Date: Thu, 5 Feb 2026 20:14:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <20260205201407.7d6a6dfa@jic23-huawei>
In-Reply-To: <aYNUJyASwD67oOcN@smile.fi.intel.com>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
	<20260204140045.390677-2-o.rempel@pengutronix.de>
	<aYNUJyASwD67oOcN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 16:13:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 04, 2026 at 03:00:33PM +0100, Oleksij Rempel wrote:
> > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
> > in hardware (7-bit magnitude).
> > 
> > Previously, passing -128 resulted in a truncated value that programmed
> > 0mA (magnitude 0) instead of the expected maximum negative current,
> > effectively failing silently.
> > 
> > Reject -128 to avoid producing the wrong current.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> (as agreed to use S8_* limits for now)
> 
Applied to the fixes-togreg branch of iio.git.

Note that has a weird base at the moment. I'll probably rebase
and do a pull request very early in next cycle.  

We might have to wait a little while to pick up the rest of the
series as a result.

Thanks,

Jonathan
