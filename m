Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E42D662F
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127323; cv=none; b=LviaxPc9IYp3Mf85om8s5kHfd3wLav1zIdGebiG2k4puDd/GNZwLJNR3jwHpgDhoOLMYgiR38aL9azKOHgafqaA4nfcSS3WiPX7LS4qjh4L4nk9UW22g0etatNEUotwoQhAKIAgnIA3vnRW7T0+un8qTBpkZJnVnZZfKH26KX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127323; c=relaxed/simple;
	bh=52nisSQEiyRjz8WPI4rroywhZ/g89YpQ6p1jMERq/as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grUSDpmJyRc0r1j9v1C6jpPpr+AHUwhrOvDMnX1eEfDIQsGu7SyL7QEyovdcz+8bcV7+2g8r+kCBjVNGeQScb3NT3AnHLkdKPfNnKvt6TECvxK3IYK7hGLEng6NWI/WXUQyzawATzYT+B0egiNaVUk5nVqZjSIfWrwV87cSaS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWydPdqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWydPdqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C08DC19421;
	Sat, 21 Mar 2026 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774127322;
	bh=52nisSQEiyRjz8WPI4rroywhZ/g89YpQ6p1jMERq/as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JWydPdqG0wzNucvmbLAKIbl31DCHJBYwY3VrK1hZHwtP6hA+JDfKvMCcpNlAs2i1s
	 7dSRehYT4b3tcnNgNxPv/T/h3FCE4hAAT9Sc5v1skqW4db8XqeXTSrLCtEbCagiXbI
	 tKPAjSciMgsi7C54ITfLpQZ0GRS6EGDAMC6VbO/qayzLnyXOWKo9Hi9Iza3ysqEyBY
	 wzT7PSmyfiJDIjw/Jw+qitdiivfZ7GwluAtyRQn/ArQVoZ8JF6TnIS8n5hoBAnQBxg
	 Qp2nVkk1Gfpt05il+YgKxG2dV8hEv3hKCS06c+zRKKjpXf/mP/7wRpVFUjBetGe8v1
	 JamMDAseQJf5g==
Date: Sat, 21 Mar 2026 21:08:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
Message-ID: <20260321210833.7268a3b1@jic23-huawei>
In-Reply-To: <abfVKws8hF4bUbv5@ashevche-desk.local>
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
	<abfVKws8hF4bUbv5@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 12:02:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 03:12:53PM +0400, Giorgi Tchankvetadze wrote:
> > Format the multi-line comment in ad_sd_set_comm() according to
> > the kernel multi-line comment style.  
> 
> Assuming this is only a single issue of a kind in entire iio/adc,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

I'm not that fussed as long as it's the only one in this particular
driver.  Ideally nice to clean up any others though.

Anyhow, applied as is without confirmation of Andy's question one
way or the other.

Thanks,

Jonathan

p.s. I'm favouring clearing patches this weekend even if not
necessarily perfect.
