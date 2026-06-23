Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C52372680;
	Tue, 23 Jun 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241043; cv=none; b=aPwTXpvWovlGplwGTgcZqWSHBqPpVdTRPt1/Jnlh4tVYfJE8Rd0i0pT9UrZLFABijVyg1XdTmlDGsyf0OurbOAsnZlL+ZV/cS6UIrxNSmi4CDf0Y9JoLT8gBqv8bAFfz3N/LvsW2e85xsYGyDLLRwTohNOoXBxul5/bZRfQPiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241043; c=relaxed/simple;
	bh=MseKKHtyq3ClZr/gFs/+eAbJu7VdtsNopvNLmvriv2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCijbeEwnRROzOTU9foHXXrx4pv2h1/bEnkYJYfJAFShx0kmexJB1ZQpeV9p3K+RVcfHRG5Klw7Gy3TYPNrSftkckbdHVK/ASMC+tkRjHGtY0wYKhCie7a+DHQUhMnnfi1FTFNY/Clw8Zj4dwn0Pq5JxglTwONwOSIGuH6GEBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkwi0Mvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkwi0Mvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4181F000E9;
	Tue, 23 Jun 2026 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782241042;
	bh=5MxPG+OXj6sbfK6pxJEYJ3MwHVcS3fQbBOeGVW42EtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qkwi0Mvs936+xRbwSUk2rFe9/4ZK+e1Zpbg8B6ZaFvGQGvTXaZsVrRV1mGCceZJMW
	 CUKuERKHbjO0m7NGwK2kdnJVnRod7K4rNLkhuO7fURfD5upTyh/dyNeZneByn9HKDA
	 Y9DGKMdz4HmLsWbCO31vi4bQUcBZehZEO6hQfHSC3UXuN8O6DDfAPfiEI/c9rWiXJv
	 1zaw4u/rE3AIqtTuM+BJc2RpEfDAN6npaVla8c/FXhcpDZsIxopYodPky6JHUpFdjn
	 PFrwMyO6SzAOWh0j7rSzIaVMwTzGuhxfsmF2rERWsVL4cyaeEM/ZH+rRSuTyH2IXs0
	 3jOBHgyGe9Zsg==
Date: Tue, 23 Jun 2026 19:57:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: andriy.shevchenko@intel.com, Achim.Gratz@stromeko.de, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 sakari.ailus@linux.intel.com, salah.triki@gmail.com
Subject: Re: [PATCH v2] iio: pressure: bmp280: return on runtime PM resume
 failure
Message-ID: <20260623195712.69ce7f46@jic23-huawei>
In-Reply-To: <20260617082058.30659-1-yashsuthar983@gmail.com>
References: <ajJFkNWEdLaIMUcX@ashevche-desk.local>
	<20260617082058.30659-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 13:50:58 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> v2:
> - Restore the blank line after the variable.
> - Simplify the error path in bmp280_buffer_preenable().
> - Drop the bmp280_pm_disable() change, because no
>   caller to propagate the error.
> 
Applied to the testing branch of iio.git which will get
rebase on rc1 once available.

thanks,

Jonathan

> Sincerely,
> Yash Suthar

