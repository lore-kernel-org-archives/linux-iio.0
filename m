Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EA125A0;
	Sat,  7 Feb 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770481245; cv=none; b=TSydtHE10tmZ5eOOXj/sU1PDC/hupMgsEV+YeDCkZafHVlG/GtWjzd2JGVMbMTYPJrtftHP/SHJ0mLZ8jVCanhfIYwgjdACWbq7N9A/cZpY38dUj7oxtybh4xEJzFP9Ndo4QACIg8SW4ZfjzYXer5C4O+pKaayPBFOtd9UXIH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770481245; c=relaxed/simple;
	bh=ejJfSQFOA01ro05Yn7RiAuT1mEsViwjJwvaaoi8RfEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0xLSzKcChbonOpfy+lYZNRKPc3Um8TKTImdEvB4kWlJLREHdNt4AD+TZsyGGEqy0VbjvswvfspTbpZlxfNveq1Rt3gPkmXXh6yX2qz6K0KnRWHDeeTuX5RrTtlNF/9gl7LJEs7K4XcSkkfnx9lVkNNcrrqFmQENhlZJt9Uv2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd/F6S0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd/F6S0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBAC116D0;
	Sat,  7 Feb 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770481244;
	bh=ejJfSQFOA01ro05Yn7RiAuT1mEsViwjJwvaaoi8RfEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rd/F6S0GAlV2HjcPPhLbgHBVk4J/Rh4lQfHW63xSSBKKtL4fTG/x7M8PvQXnHISLY
	 nOWFeaosdU51RhNCfVIw9pZilmty+WCUTIV1SSb7KXu/j5UD/lNdfq5G3XtEKRe19e
	 3HL42m5d5gVw/oE1VxxsMSOqNya+HVQV7icBkikp4PcHgDLCEzVlWjWXUmzYsxJ5oo
	 N7qFuHpicMnkhir7ZzjvAN/2LukL+kolA5WXgJR5tvEzgYQS2xfC3jHXKZUIWerRG5
	 pWKEnghQVYdf3+Z157J6f5gD8Ej3G9zwI/1G9vOicM1yszNNX/MYjmz8/WpzalmxVl
	 L5sOQ+QRZrIPw==
Date: Sat, 7 Feb 2026 16:20:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 rdunlap@infradead.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] docs: iio: adxl345: update math and examples for
 scaling
Message-ID: <20260207162035.16533a3e@jic23-huawei>
In-Reply-To: <20260201183320.27023-5-0rayn.dev@gmail.com>
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
	<20260201183320.27023-5-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Feb 2026 13:33:13 -0500
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> Update the documentation to reflect the addition of event scaling
> and correct existing technical errors inscale values.

Trivial but please wrap commit messages to 75 chars.

> 
> key changes:
> - Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
> - Correct decimal precision of in_accel_scale and
> in_accel_scale_available to match actual SI unit (m/s^2)
> values reported by the driver.
> - Add sysfs example showing how to read and interpret the
> newly implemented event scale factor.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
As David suggested, better to just document the scale attribute and not
add it to all the others.

Jonathan


