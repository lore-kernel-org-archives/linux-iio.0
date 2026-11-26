Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702751;
	b=DXVyo5P6R04DYiBrqRi0FnPp1r+p9DK3jO5uevGsu6QEFnbuoUOp/TF1xBYNfQISGDWD
	 P5jhvvcP40KiOu0r39ixwP63naMJT/2cJWaLZS/DpaS4kVjLN836lofD49DomYGkF1sut
	 AQcD7VfrZ2GdAo83b3+dKiEIJyg/DCY66ZkcQZ0izzjW42IHDyDI/VCnYHLa2feJEUby9
	 BTK5X3GPbdo44GumsS/Gxw0PPTEiC+c7QBlIiWWlfPueC3MGiTiK96Ci3iInJb05xUmlx
	 Z52FDEIiPip6KRAbHyuLmGm3hTESwvvue3hMY9dcevh0nPJaAT346CQE/tr9BH7X8kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702751;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T+N8n9wnvLOehBwPggweHP1pPFrz7O1NbGwbuAJ/dDE=;
	b=qE55jJmnsrNkC+yQaap4gFfvCpMWTEHvwfgCCJkVU43R4w4e+ot5wj8cu1zcrCilTYTw
	 ah9s0d0BdNpHf35lHlWA6lpuY2yAL7m6AElDLQ11pgt1tNOol700RBIwSyF1pWYX03mAB
	 nHvQxfQ1n+Y0mAC6AvJXhuhhtFrBRHlzBuc4EtWCE82+nzedHk35/9qdVnFi6LLMzDKxA
	 gjEdw3oIxRbDfqrbnQdfr03j/GYy81ExSDnwIc35XAz+lcO3pNw6BTwTRcui3xbfOGcA8
	 M5kFbNXIQ3BdlbIdUF4AESfcsmkx2C7sb8fK+qBzc8Fi9rpu+p/qvBUWzxxwfUbM0VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csdqY4aA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20296606A31E;
	Thu, 26 Nov 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csdqY4aA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51751F000D1;
	Thu, 26 Nov 2026 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702750;
	bh=T+N8n9wnvLOehBwPggweHP1pPFrz7O1NbGwbuAJ/dDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=csdqY4aAlywdvdqcwhTGOBzBoqErQ09MM1iAjQrmdhNNLE9v/y0vgICWXFx4cR+g8
	 zhfEnIaiTAFLHhCg+ni/Vq2Qc+omM09HC34yo6DoF4nEeOj0uPTvXaBQXY85SQVnmi
	 g5AfKbWCzdLpqvDdq2Jkd2fJ6bHY/cxOo+brskVybTi3ABmCEkwwpw8vukJMG7agfB
	 pAiy5Pwcf9zNkH+8a9vSxjELDz3tRdGeUU13BAB6ULe7Bw3AM+xfzJIzDrkejz7hD9
	 LCw6eR5Dn+83yrT/tWO/NdEA1J5W3YwYNjh+Wo6U9JbXsMahEw6McsWAydlEl96LhN
	 d1s9WNOusFy8w==
Message-ID: <7951c11e-b7f3-4a1a-ac07-87e231e7eb68@kernel.org>
Date: Thu, 26 Nov 2026 15:19:06 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-6-zoone.rupert@gmail.com>
 <065da662-2670-4f7c-93dd-410e9c11d18a@kernel.org>
 <awg42TwLsgf_Xp3U@ashevche-desk.local>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <awg42TwLsgf_Xp3U@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 14:49, Andy Shevchenko wrote:
> On Thu, Nov 26, 2026 at 02:17:34PM +0100, Joshua Crofts wrote:
>> On 26-Nov-26 13:13, Rupesh Majhi wrote:
> 
> ...
> 
>> > -	usleep_range(15000, 55000);
>> > +	msleep(20);
>> I think it's safe to use 15 as specified in the datasheet, as msleep()
>> guarantees sleep for the specified time + a max of 12.5% slack.
> 
> Wouldn't be better to have some margin still? You know that time goes
> differently on different CPUs and in general time can go backwards (in
> computers), so the long sleeps can (I haven't checked though) go both ways,
> and a minimum sleeping time can be less. Also on the other side firmware
> might have issues in some circumstances and require slightly bigger sleep
> than specified. That's why I proposed margin.
Sure, it's just that some patches add a margin and some patches ignore this
and just add the default datasheet value. A lot of times slack is an adequate
enough margin. I was always for just the default value.

-- 
Kind regards,
Joshua Crofts
