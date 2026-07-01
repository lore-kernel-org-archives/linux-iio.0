Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABE1799F
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864464; cv=none; b=ohYMUHPdGfcc7QSS+Sguw8rimUXbuOoS5u4TiF30W9XCPtvLs8bGDdniGn7ZtkLPt16EBtBSNaVPWwShbcHPq6dGXOcrF0iOrhjLha6CToHSiHHFpIZsRH3vjCvqsBqAggBZh1fqEIJKeJQOH9668n7yjheJW1jrkL2qmcoQBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864464; c=relaxed/simple;
	bh=IwtBocW3LCanteFoT+NNAckMo3cx9wkYyfGxfdygQPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odndfMvw3+MpJ4XqRI6JZbcO1gvN4OkN7RqkRcVMEAZv03SXAJ+6OMlJpnCmG1gLD7d0/yDtz7DSMAZwNpRJL24hW7FgWr4zqDJ3CEH5/DEjZtvLG3p5f8h8yyk1XtAPTTMBvdmQtBd/UwtFrtJim0RPPMCsPPOGEmQpTY/Y7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/ybtMNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/ybtMNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFA91F00ACF;
	Wed,  1 Jul 2026 00:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864463;
	bh=BfdkSe3hDv9I94fOthtvd17FrqJP0TjTO3/WTDwHOnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k/ybtMNck1lSw1tRjYN2DopL0U+Dv/isgAo6hb8pRlL8gEtgEY2S2GWeVt+1wCfwX
	 B8vv61YFXM/3HG8f6EHoKMFZA5UiNgqJMaafZmVkfKgTE/MLFlHGv//CCfvz+6fUFr
	 0r2HUa2O+yNtGIILvcFXtkdblcAgS0XggUV3GpSy9a8VGPWCF/dYoZEVaSADdJXD7v
	 xha5yTIIEjz15q56aPQpj3H5/SzJe2mpawtqR57GqNywge2XoQuZaNEOsIQPgVd8Iy
	 /9Ewv6SQy1GD7x8T25lRVQQGEPevjr3ypmv4JFaGJpBsNhP+c2L3GSQ9P0/AVYZDC9
	 SsleUOvlknccQ==
Date: Wed, 1 Jul 2026 01:07:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Erick Henrique <erick.henrique.rodrigues@usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, joshua.crofts1@gmail.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: dac: m62332: header cleanup and
 guard(mutex)
Message-ID: <20260701010738.5ccfdecf@jic23-huawei>
In-Reply-To: <akKqDEjzUV5CIqpF@ashevche-desk.local>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
	<akKqDEjzUV5CIqpF@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 20:23:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jun 28, 2026 at 12:48:08AM -0300, Erick Henrique wrote:
> > This series cleans up the m62332 header includes and converts its locking
> > to guard(mutex).  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

This series is fine but your fix needs to go upstream first.
https://patchwork.kernel.org/project/linux-iio/patch/20260630021309.36636-2-erick.henrique.rodrigues@usp.br/

Then this will need a rebase for at least patch 3.

Thanks,

Jonathan
