Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42E42E011;
	Wed, 27 May 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898438; cv=none; b=MMHNuIo+2Ew+uZBRkeLyeDF5ngWzqwZnqX3KXc2NgTwWehqunLzhtGSHe8lm4xmAp1XgJ5GEHHeZ55GCUhzrNpIh6JOgojWEEtqYMF+GSRU6Z/KwCj9Nk2P3xUYKl/MY+/cEl9hcdBTV1hCcrdoWGUd2gW+dAoUL/JL6m8gyhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898438; c=relaxed/simple;
	bh=5+b7aehwltK3e0au1eWjSTpjlZ9Eska5vE+KGUFS3TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NY1IYOf9NVjBItz/a1DsyzaQ+UYlthuacDwietsaGuheltr0fULn5LDfXfZS+J5rgqs12L27xi1v6L/rHvRRytl/WZo8ZCI4l+jTg0ymW23TRo/kGGSZ5qGMLyasrpQ7VQ0z5ru5gMHXjDaqwCnBCPI69s8oHU1Lx5GK5GlWyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6yKmKQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6yKmKQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE431F000E9;
	Wed, 27 May 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898435;
	bh=COrXQ9shHaB3oLIHBn9YlHc0LVXLowIstr6V7BjtCAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B6yKmKQDA03GyTZH/7z/kXs7GfrYlrI4xYzTqUosUMSFc3NsAQilkN/1Kug1AE8xL
	 ApQsNb775vVP6cnKi4LvTmzwyUJZbM2fp+nnwjE43aVUPV596CxrW95Fk0057WDwJz
	 2Sg8GA2YeVEdT9iWI2dvletyfgX3cRknrjza/rYHHT53wF5xV90uv+jN/EvsSU3lpD
	 X/lZ5N7eWNv3AtgVeMvFDElL8WPqhh/+NYnBcfB5gPupQWZwJQ+F9wcOKAK3m/DHVT
	 LF1/SP2p2M0E3IigLJHn0ZK3REIztTJfxWTUWsI0Vt99Pa/Lx9F+afHS+yGT9jAPys
	 H0MjEdkya2IVQ==
Date: Wed, 27 May 2026 17:13:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v4 3/9] iio: temperature: ltc2983: Fix macro
 parenthesization and rename
Message-ID: <20260527171348.1a1fb45d@jic23-huawei>
In-Reply-To: <20260525164013.118614-4-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-4-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:39:30 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
> LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
> macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
> to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
> LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
> them being confused as related.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Applied.

Thanks,

J
