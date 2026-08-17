Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B202EC08C;
	Mon, 17 Aug 2026 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929818; cv=none; b=CZXc6iR1Xovj7aHk7ZqWu/U9Yvwvwy4+8GGAnHul14PyeJ5bEmQvnP6unuX9Kdm+C5YHjuPNg6ZLBLRaQ4z55Fs6hbh3r3gLX/nemG0GtsFdMaEKhbfogAmNzcTrqebU569f4fzhNvonWgpKc65I7w4i+XslSPUIFjqo+ArMIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929818; c=relaxed/simple;
	bh=BbjBj0JQnrfe9JRqAsIU+pBmin4O+OoE4Pq8mPEMs8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJdd5TZeOnTO/tD/xDi6mEmoTlvG1VUzckL2pf59r1hjwG7iJkke6lAxb8HC4E7ylyTp1CqLBVTDsML/ta+Ss73NK0pvBbIpQfrq1JF66fyXL4Q750RiYgcSuYDdu6pIdCseJrvxH/PuvsVfYDZRnPygUg54HEChx2/5gjYR6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHLrChIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHLrChIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAED1F000E9;
	Mon, 17 Aug 2026 01:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786929816;
	bh=XJ3kuNb3gAxgw0tL4K2dZ+Km7TmTTdqo2/sI994BQ0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QHLrChIqoCeYdoW6U53dw5jxFG27dFf+IHN4JRL3Ghv589a4kviOI8vSrKqrD+8D5
	 OYsuPeZy/7QOtgCNZiEQIRahAhWrmtru067yJ04dEJSRMs019SdB8p1zSNgUybontW
	 tMJ5XTqdVPF4W8AZp+d5Vn6s2EH9GRnuXVq1IVEEzHhfZmkQVeDnMBi0/g+hObbBeq
	 M24WVs7w7TH17CtM1JseIByVJZxUwiKQS4oanxJFDLV3pZ6WRomGcbMar9o6neKSoH
	 kMrZA86E5q0Ft6DOpkZVLx+WLdU8qCT+FzWcQikLU8GCiNiD8uuO5wFWiZGyumhEhS
	 Ah9DilsaKgJTA==
Date: Mon, 17 Aug 2026 02:23:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 02/12] iio: adc: rohm-bd79124: Fix channel
 initialization
Message-ID: <20260817022331.5250f03a@jic23-huawei>
In-Reply-To: <4abf69bc827f57d301839d123ae184cfdfc31953.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<4abf69bc827f57d301839d123ae184cfdfc31953.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:50:21 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The alarm limit register on BD79124 span to two consecutive registers.
> The first register for high-limit containing also hysteresis
> configuration. The initialization in driver writes only one 8-bit
> register, overwriting the hysteresis and leaving the other limit
> register uninitialized.
> 
> Fix the limit initialization by using the bd79124_write_int_to_reg(),
> which correctly initializes the limit on both of the registers.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Applied and marked for stable.
