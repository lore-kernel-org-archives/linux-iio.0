Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB316A956;
	Sun, 15 Mar 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773578883; cv=none; b=bvczysXr+P8wRAV0rT8w7JGjHRkcmkXyuRTR2ElglzC+Ijt/Eaqi7wlbcoieXnqcdoazDge86ugo5KITgon5acP6n54dIwOcKXNlhAu8vzL6tBpXp4itGP1B2OQjfVyg+dTsgLY3B6et/uzjuN41XWpaO6WXh717BSyxKZHZhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773578883; c=relaxed/simple;
	bh=AHSPkjbvikdiUbPznKE2W85/Sg5iCrjfks32dN7tDbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMr7GO/aMZSN9kZhC86RBy0b/hvrJ6L0qoDd9dYa8Oa+PSyuF8bEEFKGw7MORjje6a7AU24jbXhF3uQcsxC3a+A+rJCu42iKEFPB2cDJ8luy6iGX45GREvRBI0sNq+TzCPbpp6UnHMCFPgndLjsfzC6TsAmWCaFpXw9QA8joBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwvBDtWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwvBDtWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D95C4CEF7;
	Sun, 15 Mar 2026 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773578882;
	bh=AHSPkjbvikdiUbPznKE2W85/Sg5iCrjfks32dN7tDbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwvBDtWoHl2GTc5IeYNJKQem6ykzJSJ5pYpbQGSOKvP7i5IlN5yEkIQFGxhKLF74V
	 RoOlEOvwmCcaMdu0KnAWHnpd/9WG8XNw8yr2qa8dLJuxFX23JHZuzCcCHkiKdmkXBD
	 oRWUKyYxv8XzD4+OrVPVtKrEkHThVv1PFFI6Muf2XvnuFRaSHMXev3OppWGDhTfMnd
	 siePhaGU0C0xrM+3U6mZuZloOKdUPMoXcU+zgrC6QawrfCLLNty7cFUfT7k+G32eQ/
	 kJw8aKM4qcY+BsPoitJWiNaR+Biyud2+UqtHXLOiYG/wv7SX3hVevB+EqA4tbc6lIp
	 q2AUfcphhYJsg==
Date: Sun, 15 Mar 2026 12:47:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: dac: ad5504: sort headers alphabetically
Message-ID: <20260315124742.01884b7d@jic23-huawei>
In-Reply-To: <a5073d33-a077-474a-a7de-2d568e80727f@kernel.org>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
	<20260310174835.24209-3-0rayn.dev@gmail.com>
	<a5073d33-a077-474a-a7de-2d568e80727f@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 21:15:16 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 10/03/2026 18:48, Taha Ed-Dafili wrote:
> > Rearrange the include headers in alphabetical order to follow the
> > standard kernel coding style. This is a preparatory cleanup with
> > no functional changes.
> > 
> > Suggested-by: Andy Shevchenko <andy@kernel.org>  
> 
> Where was this patch suggested by Andy?
https://lore.kernel.org/all/aY40-0v9tbXC4tPY@smile.fi.intel.com/

It's one of Andy's favourite bits or 'whilst you are here
feedback' and was given for this specific driver.

> 
> Best regards,
> Krzysztof

