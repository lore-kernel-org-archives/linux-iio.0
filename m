Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C814AD0D;
	Sun, 14 Jun 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465431; cv=none; b=qWbCG9ZeRRedMbzAyt9GDEcQZpL7YGD5O9IVN0AQt4FARIT+geWlOZvTtR1IMMOl+gVA/BRulFDW2h0+8LS/n6dRqSz0N+IaUe41zuZoiTo9LCOiZciCWQDtUvhS86zcq1PNWox9OrdZ3pejQsvWID7bbpUdR/i1BLnn86tQScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465431; c=relaxed/simple;
	bh=vEyJApIJmOsTUwgK7KgvnaPCC+VlLGMzfhLcCoq+DQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfOsSiC8pUf7KQOnrMpYsXSajfxbwoxZ1bc0Qx8FDu8cxPFXZnpnIQLWAPugyGGy1dNXjhxOtnxqkHEwQtfnxt0EsDWxsy+72V5+dov801GAJr/S4tyx5Af/CmkwxzLFtD9ZZcnlAKpcVEFb04E5Aln97qGecQ8RHWZjD9wlj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDvuaJo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDvuaJo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BEB1F000E9;
	Sun, 14 Jun 2026 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781465430;
	bh=Ki0nmJ8Eg1PdjAFmqE4jTLjE5ThGE49A4mq2/pwzMsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nDvuaJo4IJJEW/ec/cHsTz2f1K0adyM+U+NaGHx4dG7JCMWx8YA+YLu05WtGKF24B
	 c62npQVyLicQ6gq1TBuAmgMAy+BQKm02pBaBAIKiw9X73suk1UR2nW7LCBhyjGE0Q8
	 j7TMVYAmzknvhIvG2cQmwAqVJNURDF3o7DeN1Gktc/zoRtevjovOTmc2aTZK7C/fX0
	 KQmD3VGMeN1XBj9wvEVQE7+/5arWn07C5q7bVV0DlHG3Gz37ZzrjHZA1Y5zm5+Kegk
	 R9hmURIPiLpPPkvB0Igm/j4AtGQKOHhi/+jfpw9Gd53EJ9BpucGFp5Wk5rXwKw9MDU
	 FY9Kes1Yd9eUw==
Date: Sun, 14 Jun 2026 20:30:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miao Li <limiao870622@163.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, dixitparmar19@gmail.com,
 waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, limiao@kylinos.cn
Subject: Re: [PATCH v2] iio: accel: stk8312: Update includes to match IWYU
Message-ID: <20260614203021.647baa2f@jic23-huawei>
In-Reply-To: <aiE9GGtvgBY48LIw@ashevche-desk.local>
References: <20260604070053.299221-1-limiao870622@163.com>
	<aiE9GGtvgBY48LIw@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 11:53:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 04, 2026 at 03:00:53PM +0800, Miao Li wrote:
> 
> > Update the list of included headers in stk8312.c using
> > Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> > and add missing headers such as array_size.h, bits.h,
> > dev_printk.h, etc.  
> 
> > Meanwhile, sort these headers in alphabetical order.  
> 
> Usually we do sort in a separate change, but here it's just about a single
> unordered item, so I believe it's completely fine to combine (in _this_ case).
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.

Thanks,

Jonathan
