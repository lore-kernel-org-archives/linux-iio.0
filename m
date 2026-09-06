Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0324C06A;
	Sun,  6 Sep 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730599; cv=none; b=RdjpyThd/0ZHfeqIsV1TUpT8m9jp7MtMhk3OhADvIyJZEMkoVcoQzcnWQwOn/yLhpG/23xB3a8JB10D0NmKtJOrPnmVIdA3+MyO0+JIFsPiX7wxszYA0+d0b5tNNdPd7uGlvTKW46EIOuU8GAVaWzg1uSgo/SlDpKwoEl9dnNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730599; c=relaxed/simple;
	bh=nF+v/lRMKEfljFkGiK1oBaMEkcoqQodWjysQmYztNq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMBn8wEAC9ogpETHjXi2jYkFw8Nln2my8kxEIxlPbZBf1rEkd8NOqlx506J+k5caaT3cNPNoqm7TGXaySlh7hcMxwm4sdBNQ0zIM5S53yGCKfVVEJqNCoUztBy4RUdqUgofApOCgv+N2W7HxSF+ibO7b16t3/KXqkXRRDN6CWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/0daPWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/0daPWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00201F00A3A;
	Sun,  6 Sep 2026 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788730597;
	bh=5yCQBkIvVv0VXC6i26OsmNG2Nw8eJRd+InNsZpZdurM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B/0daPWQih/2i2D7BNoIVFPQsN4Sz4h4rnbFt63aWEo2vhrywujpDZW2Y20rNxibC
	 fhwxxWlj2auoi9f2ljGmLh9NHizT/VnMwMZwUpIjvH0fCE/TWqhVjI6qNm3B8Ycmq+
	 SfbUSFEPrTeSa1WW/+WRAcXnHSQN/NYGBA5D0/5LPWEklvUoCXfBQAjfkS9/R9DnHU
	 QWk5d3ArUjyoCp/0hN2jS1a7VXJMUeJu45THMoFVFh6oxGpFy+QsspV7PwC32gjx/k
	 Varj7yAvE63+Uwsbk0KYQjEJvqKwZLFpremgZs50BDFlSRVZano+JrXT7OquupMmFJ
	 zIF+kaozQiAzA==
Date: Sun, 6 Sep 2026 22:36:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: kionix-kx022a: Prevent memory leak
 and fix state
Message-ID: <20260906223632.04168b67@jic23-huawei>
In-Reply-To: <d01b5c2d1aa3dc06dac7cb69e44b4caeda0936aa.1788336588.git.mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
	<d01b5c2d1aa3dc06dac7cb69e44b4caeda0936aa.1788336588.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 11:49:05 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The driver allocates memory for samples at buffer enable path. If regmap
> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> allocated memory is never freed. Furthermore, the state information and
> previous hardware configuration(s) aren't undone, potentially leaving
> WMI interrupts and buffers enabled, or driver state flags wrong.
> 
> Free the memory and revert the hardware configuration and state flags on
> error path.
> 
> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Applied and marked for stable.
