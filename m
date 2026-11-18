Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991971;
	b=sOIm2oOwNfRClVf3aHl4kuMj4lJPmIawG/9etxQGImB9hBoykWR8CDqAJXkARHHkmnyI
	 BwlkeUD+/vm4tVWOmJYxa3uZFlJREvyl58vk/IpwpwFcx29L1DPz8q+ij0JO4Zi29RrVx
	 JJ8fQlGELT7OMGCua6lpvTuX9B5kfuIVd7ksm+qu54IOlPGI6uKL9TmXhNdFJL1Z2Syhm
	 5dadzssVU1byZIrHMt1+iRPvJatRiSVQck/S02RjWTVaA2WRRBw1gOpQeEeBpPMAqj2fh
	 GQ3OHpGfBprv7D53NsJSX+5vhXtcvtEH4gzUdU2A7lEjFeBVPcN8pZ9ZlwmIiBNAqtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991971;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BKdpE8N82YN2C4C12CQTCKi0PcsjjfC5cCXgpPEJ1nc=;
	b=ztDPMlkXLcAprUnur6AotsxbfNBW72NLb644KhvSlw2WRL0aQ+HhVNCUJB8AYeUrLqhF
	 MXole3kmRBLKXB/xI773Mbo0iXAwZdrR2vktBqlXQMrePbro6VX+oJj7MW1BPxBbEiahP
	 2aaElooF8/wWlHSvI0UcqFOe2eI7l+MBLPbyB/SCvmaKrPU7MUG4dzpT6z/BrwXCFhcQU
	 EFYaMeVWPEDiHLQ1kowHcRH/HM3HpTdNZjT22C5j0d6s8OO3sGxmv/XRp/h7JPoh2OiRC
	 nmhQ4wAhfCuFnc3wpbqVo0+SdUotiX86LHY7ERtuDSHmAoyBnjzXrt3Ogq6cwFpkVXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6UxbC8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D6606A31C;
	Wed, 18 Nov 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6UxbC8D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794991971;
	b=12D/TngEly+xsSnJV+dHNtM1liMKEeH+z5M/oJCc9WzVlPDPEZ3A/BpRUkQ+SSDTQ8Rx
	 TXL4PSO2nw7kuZSJ2q6lS24QIxxl/lTy4Yy8RR6FDhXEg15CQfsPmA4a3rfD9Hda4RqKY
	 LQxO9EndSNrx31XlEQ+B75ZJDJyJnerP5WoVi6+NlMinxXpM1J27l9/K+OPWK+LzZOdLh
	 m+PODYsrtp8AnujX/c2RuyywmmTByx0WVYogDlRgepPVSVg2AWEImslaP8HgOHg8mcYce
	 Oy1bQhn38B4rPJxvKn7ivqBQQlMdZQC1u5SgswQuQ0CNhmxkRCwcnIZgcbdTM+5mWtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794991971;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BKdpE8N82YN2C4C12CQTCKi0PcsjjfC5cCXgpPEJ1nc=;
	b=vFUexcnH3P9gTGybj6qoAVqLJEBOXOXJ72BdjzAqkqZJpaqBUgm9tyve9PC5GqH+dZF9
	 Mla3u4LmU5ZZNc+jlos/hRb217tMm6lOin3qbjvsKfCxdb4wsQyZ4b2T86KEN1Xrw3cmr
	 kpoCf43lwyeKAoHxB2B5p8IhTBOAPEzoWGin7qVKsrn4DY2nwSSMs3J5iDXnkR54k4WAQ
	 v/0WsEl0xYYtkOZ3tmKjo4mfLfwmRqndGSunpKAaOZrXarH3W5KWR+1PsiSJM3mSX2Oic
	 WB6OUwEdIIWDW7FL4JX2PKX57h9/uNva2ySOuSNoRzVBCSSdkkCm3QshAwqU5f82XLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 135F21F000C4;
	Wed, 18 Nov 2026 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991971;
	bh=BKdpE8N82YN2C4C12CQTCKi0PcsjjfC5cCXgpPEJ1nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C6UxbC8DmCyKamtjwu5TEoXexPkOqD4B42RMMVBrrPjBYcQfWlD6e2mhqsxIqPLUw
	 DOJyrwCXwsqCWlQlPz9tfcgJaejS6ejMZY93p+sYajPjP2ow9BFau24igGhIvolN4w
	 0xPr9AB8x2HxpzFt1dMQam0zfmji/mSxnA8vEe1plj7IZsNm0OiDQxA4Wbp/1Xv+Bb
	 625efOiVBBixn+p0PrlsIcAib/PZReBwPkQ7e+Y0r/cFpz4o+IrdpSel5lHuZMiUmf
	 tvOrkL5/gO7ps9v/e2dRi0Pc3JokuVg1xJ+BXwF891vBY8rDG7CWHYI+ESv2RsdqBj
	 7ZQ77dlo3jCww==
Date: Wed, 18 Nov 2026 09:52:41 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 04/16] iio: adc: xilinx-xadc: Drop unnecessary
 masking and dead code
Message-ID: <20261118095241.00006111@kernel.org>
In-Reply-To: <20261110050201.1850399-5-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
	<20261110050201.1850399-5-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue, 10 Nov 2026 10:31:49 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Remove a no-operation bitwise-OR with zero (dead code) and the redundant
> 16-bit masking when storing values into u16 destinations, where the
> mask has no effect.
> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
