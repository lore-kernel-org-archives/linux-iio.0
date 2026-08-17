Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1C1A0B0E;
	Mon, 17 Aug 2026 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786928621; cv=none; b=pwMA8WCIU25QadC231e3VwbDTt4GvFM+XmWu9NrqI2K9efOHPLTPzhCbHPDk7D1vvrU8SAyScI0gmD8/fWk1iKA2GdolU+xyRtViVaQFzeGXJhZtjkS1Asue+h57PRasZJu0e/9auWStPdciGlNoiIktbpD9KKUV8CdiXyvxi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786928621; c=relaxed/simple;
	bh=H3fkb+EVLqt8HFnWYqycAmB1fZyYSsnXsJTh93czKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rncqAvqqJiunlG+EYo+uK3iQFVHTP1BAXqeUgedeboytGk5Mmnwr4w6RqK1eX/qOu55Xt8jHCixUBO+7rAb4C3Y6fdJv3nxdRXiweR7BwSF+mUieRQ8uD9haaE344ueD/wFTCeK79WFHM7GYqnmevMbvu/RFDKPqpR6X+vRkJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHHrH+A1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHHrH+A1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E7B1F000E9;
	Mon, 17 Aug 2026 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786928619;
	bh=ac1Nmd26Os5zmltOkS7HthDxQCtfJPN8z5bSG8AdnCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MHHrH+A1/kL8RryqoBWGTvVINQJzP8BEdg/e1BxNhHmJrQkVRpws4qCfEvS+KK4oJ
	 ghJZeVF5MZcHuvxAfIQRwSJaEkmqP9Dh63JshuUyLDE7E4yAQ55iDW4l60Y+uDGoUv
	 7KeLBewxJkdC5gKTUa9McPa9qSdsWqof7DAiFMybhmWV7VBA3ugg1SoVenOpEnZijv
	 /pkKC7kunxMk+xSs4xD0l4T4Ofs9o6MzI3sEdzhK6HUzT0e3zJrbIyzMHl+fYgcQaE
	 lcsqutWGJu5yxbuJVPir4tGJ319JjPVoFZ6hp5HMgbce2uv9aj6g7LVf+y/ggOgHcz
	 EDnMYLpaaDZxw==
Date: Mon, 17 Aug 2026 02:03:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Cong Nguyen <congnt264@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1363: sign-extend bipolar differential
 channel reads
Message-ID: <20260817020335.347796c4@jic23-huawei>
In-Reply-To: <anoElwDzKRBoHTcA@ashevche-desk.local>
References: <20260810164446.2555239-1-congnt264@gmail.com>
	<anoElwDzKRBoHTcA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 20:04:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 11:44:46PM +0700, Cong Nguyen wrote:
> > MAX1363 differential channels are bipolar (scan_type.sign = 's'), but  
> 
> The (...) can also be dropped, but I leave that to Jonathan, no need to resend.
> 
> > max1363_read_single_chan() masks the raw value to the ADC resolution
> > without sign-extending it. Negative differential readings are therefore
> > reported to userspace as large positive values (e.g. -1 as 4095 on a
> > 12-bit part).
> > 
> > Sign-extend the masked value from the resolution bit for differential
> > channels. Single-ended channels are unipolar and are left unchanged.  
> 
> Now looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Applied.  Amazing that's sat there for so long given it is
a reasonably common part.  Oops - that younger me wrote just
as many bugs as the current version ;)

On the fixes-togreg branch but unlikely I'll do a pull request
until I've rebased that on 7.3-rc1 in a few weeks time.

Jonathan

> 

