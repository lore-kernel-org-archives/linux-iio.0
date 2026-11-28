Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795837323;
	b=HLMaQbeRDNDY4sZxB5Qc5SvutebLZoyVxoEZsV63H0p8Nydi7jVsIdUB3IZDEU8GcNJL
	 b7GeTxZp9wxLPGrRwwSDoq6eJaidXGXSYNBs+I4fefvQ/4ozt+nxxgpZ7fgEIa2SFeYoH
	 itq/8faWcoJtCFYCdLcxmQmJL6R5a6JmUfDeSI3QmXZflNCgWt9QTnhTytl6E3FmQ6eoL
	 Qt0mBHX5RqZKD4TwAdaxW4uVk3/iL50ZgMfPOCF2+8ilvgKPo/Wv89n19B0o1sXkL9e3Y
	 q0hfc/nQss9cVz2Q/TZu8XN8YbvywB6LGpsgyXtTqX9QA3xVv+45oVQmS7CclVU2gZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795837323;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QPUAqIg8Ant6oS4zNUlje90AJh7NTVdfBF+4zutqGHs=;
	b=ZGyIuA4htkCQ3VxEAZ8rWNxeFBVxBSXohYQ1bpHZcEzDlFVbPUVXTvdiU6h32wkj5y29
	 W2tSPNQ4VHjipdVZBhFTG02AEIrGr6/fQPzLohpITzlUgjsedRZs8FDxQQmWnWtPZVWCZ
	 HuO9HPM3gLF9bDtg3ucwbgBVIua8a3Yk7kI2O5ZKOaYLIn9GunkTWGO/jRDyFqaNeO+fU
	 IvSxvPKrvs0nwQPGB9ZppD56h18qQ64A34kwnuYbEvNTsZ9OKqM8lpF8Wj9PtXuIj9mRo
	 2znsDYr5viuMUMqOKC60S5x+uqmM2kxoHT/6GMtCJRQxPJH4Rs30CGCT+LzktB7nLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdDOs6fW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005A606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdDOs6fW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6737A1F00897;
	Sat, 28 Nov 2026 03:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795837323;
	bh=QPUAqIg8Ant6oS4zNUlje90AJh7NTVdfBF+4zutqGHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KdDOs6fWj6FI1VIxmZh7zYSAFiLvKqFowsjqeHNHhfpWyAQFW11huQlzoShj34IVK
	 pGdA/ZgWK7MC8f4l4ixbhWUZwfkitCJK2+SfAV6xkUlQHq3nZ4DyLh2B4P/crwW2tR
	 xTDvgsNUraiYHaaWkaadReWowDobLeYZAKUbtteZqmH0x+2PCAqRco2y7zdoNAO7uU
	 TvLmUkVkccUiOqXSqZKmv6JueEg2OJ9nNE991EQf+LH4HzlkkncWfCxQpRS0L36/m9
	 0jys1ch9F4JUjcBDE8N2DQc3tOBP/yub6x+UMoROFz+3W1r/GxfPcRzY/AZx16buLB
	 6A12iiQ97iZqQ==
Date: Sat, 28 Nov 2026 03:41:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Rayan <mohammedrah1289@gmail.com>
Cc: linux-iio@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [RFC] iio: magnetometer: rm3100: compatibility for the TMRC
 0x9e rate
Message-ID: <20261128034156.773f1e07@jic23-hlaptop>
In-Reply-To: <CAECerH2yi45XUYex7f+ReVqO5X04uZXADDf-g5QDKi5DggiQHA@mail.gmail.com>
References: <CAECerH2yi45XUYex7f+ReVqO5X04uZXADDf-g5QDKi5DggiQHA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 00:23:51 +0530
Mohammed Rayan <mohammedrah1289@gmail.com> wrote:

> Hi,
> 
> The RM3100 driver advertises 0.015 Hz for TMRC 0x9e, while
> Table 5-4 of PNI's breakout-board manual lists approximately
> 0.15 Hz with a 6.7-second interval. The driver already stores
> 6700 ms for this setting.
> 
> https://www.pnicorp.com/wp-content/uploads/RM3100-Breakout-Board-User-Manual-r07.pdf
> 
> I would like to correct the advertised rate and readback to 0.15 Hz.
> The register value and timing would stay the same. A direct table
> correction would also cause existing writes of 0.015 to fail,
> because the setter matches the requested rate exactly.
> 
> Would you prefer to keep 0.015 as a write-only compatibility alias
> for the same TMRC setting, or have the old value return -EINVAL?
With it being simply wrong, and the relatively low chance that anyone
sets it to 0.015 deliberately I think we should just go with fixing it
and not worry about the broken interface.

If we get reports of regressions then we can always put something back.

Jonathan

> 
> I checked the current IIO branch tips and found the separate TMRC
> bounds fix, but no rate correction. I have verified the mapping
> from source and have not measured the sensor cadence on hardware.
> 
> Thanks,
> Rayan
> 

