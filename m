Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D43A7F7A;
	Mon, 20 Apr 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707453; cv=none; b=eM1Cn7R+Gb6uauNkG6Zfl2m1Aq68OyxjREoJJzjQ5M4R6NjSjiuDqbn0jGO+HgyArttz1emGouQ8XKRok2RXsGrmnVmgWhohneKcfharHYjVL2VbhjE13QVDCEj9CWmRwEd1M1AlWXNvK/jwNKto8E8eUFCVMhttS6u7hXSrnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707453; c=relaxed/simple;
	bh=CuQAegIw+nPBte5JY4CByxDJTeC1l/+vdsF7Qfn+BUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsZFytokjGtDB1YvfEGjMa0ypkBS+oWtBV/D4lnz5cGTQ6HGAlYaOibAXy9HWoN34xwlQK6ivmyWDhlC+5LK5YdVpgv86CngEU8oibP3wMNj0p5klrU/lZF1g62ozOwpzWfhO8LgWw/zls4cByniXNbK9gPvRyO+rBlpWXkXTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI7c+6bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI7c+6bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632D5C2BCB0;
	Mon, 20 Apr 2026 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776707453;
	bh=CuQAegIw+nPBte5JY4CByxDJTeC1l/+vdsF7Qfn+BUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aI7c+6bbU5meiafvLAOecPMhdp1Otpl84Qau/d4n7ScBfgKzVPNXmtbI4E2vPEhJ8
	 fGATP3wYhEgBt7fCxhEdKONSeYva8/Ap83oxaPO2yI/OSgZW+TNiLo4azjLiC5l3LB
	 HF7/ibQx5tIbkeEIcIWykgKYdFrn45heFGPPktXzyxsZUXCS5bBo1ss0WE5m08P3pL
	 n8TMFoRmlgyn1ox6O1CDlIfaUZiD1dtL5Ce4nA3dJZGtgKQXwXq4NYpUxC7KQjNzD0
	 wdlZBjXE6xWinFz15cU0jdJ7j6YCyPqnBB04ii3siPpXORcRVzaDUuY9y6E8+sFJie
	 JhbXWMV3hKxzw==
Date: Mon, 20 Apr 2026 18:50:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Advait Dhamorikar <advaitd@mechasystems.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: st_magn: fix default DRDY pin
 selection for LIS2MDL
Message-ID: <20260420185045.454d6dd2@jic23-huawei>
In-Reply-To: <adUd1Zs80z9xjqR8@ashevche-desk.local>
References: <20260407072059.222597-1-advaitd@mechasystems.com>
	<adUd1Zs80z9xjqR8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 18:08:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 07, 2026 at 12:50:59PM +0530, Advait Dhamorikar wrote:
> > The device tree binding for st,lis2mdl does not support
> > st,drdy-int-pin property. However, when no platform data is provided
> > and the property is absent, the driver falls back to default_magn_pdata
> > which hardcodes drdy_int_pin = 2. This causes
> > `st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
> > sensor settings have no INT2 DRDY mask defined.
> > 
> > Fix this by checking the sensor's INT2 DRDY mask availability at
> > probe time and selecting the appropriate default pin. Sensors that
> > do not support INT2 DRDY will default to INT1, while all others
> > retain the existing default of INT2.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Note I'll be rebasing that branch of rc1 once available before sending
a pull request.

Thanks,

Jonathan


