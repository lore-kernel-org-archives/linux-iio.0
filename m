Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257F426ECB;
	Fri, 15 May 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843043; cv=none; b=OLDgSm5A1cWteDZWgYhmuzq/DghjUuyDWAaVLz8ygOdoPzbrayK0yTq43sh2uZQEwVYgjkN4CsFBuWRPg04H7lsMTd7NtqFde9bD/k1FhWstXn3iKyDTherQMp48LB3v/9ACB153IwZUEsVrsxnAz/u6ux/5bWEh+jjN6vted9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843043; c=relaxed/simple;
	bh=pl6rBVUQVRKMyewnivlNOKajFYT0SQanIWO378xSorc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYpWrkzm2RSisJdXUURtujoppygOWqjlZ4xC3L0v423N1diLYkpffujM003OduWIoQM5h/cM8phdGw2YwOZdP9TA4eHOxS7/6xKOexD/w7L+VjujITcAqbDNBrq5uesIaYj9Gmxn3rIouuow1hniSJ4GDygfWFfqbKzThEryagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6WpO4TS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6WpO4TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CC9C2BCB7;
	Fri, 15 May 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778843042;
	bh=pl6rBVUQVRKMyewnivlNOKajFYT0SQanIWO378xSorc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6WpO4TSoQaftPV3FSQuWlYj50zLmA50Q1iY1mKNJPp/cUMShMgeg9Ii/bDZLpAUG
	 GrK5+mWIDbk3LC3rSlfVRGl4Xwq/8Yl46W6SsXQi2sx0gg6IMJ8t7XQkxdAhfVPbi5
	 LhsdfqJYqwtCd1nKJEpcKGgbR3u56YjfMStuTYs4CCzE2fXpbheKTCyOSFa2u0+lVC
	 SFRrDvHsYYBXD6Avc8x43Ec2WSiWe9RM7dYkERfhRjhyveYKpPQrHvUBXzNmxrjWVI
	 i0V2N+7efBtsvdzetg+16sbwwKoibtiKRfQTwK9wRmJIdHJs1MhJzFYaQnDl5HtQ40
	 /yncUzpAfG0Vw==
Date: Fri, 15 May 2026 12:03:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru-Catalin Ionita
 <alexandru-catalin.ionita@nxp.com>, "Radu Pirea (NXP OSS)"
 <radu-nicolae.pirea@oss.nxp.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: fix division by zero in
 write_raw
Message-ID: <20260515120353.4f9d08de@jic23-huawei>
In-Reply-To: <20260420153418.21ef8f03@jic23-huawei>
References: <20260401152924.58073-1-antoniu.miclaus@analog.com>
	<20260420153418.21ef8f03@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 15:34:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 1 Apr 2026 18:29:24 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add a validation check for the sampling frequency value before using it
> > as a divisor. A user writing zero or a negative value to the
> > sampling_frequency sysfs attribute triggers a division by zero in the
> > kernel.
> > 
> > Also prevent unsigned integer underflow when the computed cycle count is
> > smaller than NXP_SAR_ADC_CONV_TIME, which would wrap the u32 inpsamp to
> > a huge value.
> > 
> > Fixes: fdee77dea4b6 ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
This tag is wrong.  I only just noticed when running final tests
before sending a pull request.  I obviously missed running them
earlier but please be very careful to get these right as I have
to rebase whenever one gets past me.

Correct hash is 4434072a893e

Jonathan
