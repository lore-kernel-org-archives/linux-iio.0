Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821004;
	b=G2JOJ+vFWpkZ4wAOE03tUVjZG7ti/T58XJTUQho/OkVFhj0vAmA7eooltbZAt6PWmNlY
	 Z8d9XF5G0Rz2HeR91SxYkd92BDwAvNRlQY0xY/U6onZv+KWCC2yEGb0K3acd/RCIHywwC
	 z9kt1wGFbvX1kn7LgGh4MswvxALBEJv4WUmKV9AuCMGQF65uqAbk/Q8EaZIRK48rM3SFa
	 Y8nxnokNmJ4KZd2vrpHBPXSslX80slu0VLg43yem5U/OQFH9pXmcxvpfdKgKuIB61F1mJ
	 qo6nM9qw6Gr1HN5/Qy2GEgaUXLTbSQSYNmrf0x98zcHzum/AhGzguMfvXPND5HqO2nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WYqYPAHwYpTDfKAOTQbjDeLb2E0sp/g0pKrK+eYHLeQ=;
	b=oHQFzcjpXtu/m7RxlOXityOIMaRsCdqV1Bg/6fZgNeWGjZOV5jfWU5ABb1Z2kSV9smfE
	 Y9ZsisU5+GHvIhvUeIY+S4WHMW2fevWfAqItyIyHQeGj3dXBF4F/Dox9ptm34U+hQt5LD
	 kLste7vJfUFsPpadjizTl5b1dRXOFwSVQidahS4f0BucpRyuKAxGyN5cnHVOCmaODKA7s
	 J7tmhFAkm7YhnZeCt+hgeE4TbRtsq/1GLGiiT01QsEMcj05iFR90LLOtXm1HHrjGg9/lz
	 6LJMwIKKQVeSGAi4RGBUtP/kwQRtj/+1uCiGiHhuBYKMxUPpMKKwiS3giAkVGJGlo3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFIS2AQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60050606A324;
	Fri, 27 Nov 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFIS2AQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF21F00897;
	Fri, 27 Nov 2026 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795821003;
	bh=WYqYPAHwYpTDfKAOTQbjDeLb2E0sp/g0pKrK+eYHLeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aFIS2AQw1WQjTllmJcWGfuturitoVVyva4BaJsbAja17+rXfk9/QOjzXh9O0AeZhr
	 Bu7WUTnhnSubOq4QLX0lEe4QBsZGmrLnYB9b1MrN07HWUDfBrdHn6unAsInSrYCqv/
	 u6Q0i9TtZVoJ/gks67H4/Rxv2CNxT0cpMu/W4vDA90Lf4RljOby2QUx4sUCIeFHxxf
	 EIeGa+aBWB2TNUo7qtJIYH5RA7ovhLlMaH+jCEjFjK8p5OLer9IdixpqPXm5r38Qx8
	 alO0nfGEGSG+IXkTd0wRpTwRynyz6MohEBjJhJ4qGNTyCK11RvtuN2s/SLxfVSuiZJ
	 jUGypctNUxSiw==
Date: Fri, 27 Nov 2026 23:09:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nishant Malpani <nish.malpani25@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: gyro: header cleanups
Message-ID: <20261127230958.4d745fa9@jic23-hlaptop>
In-Reply-To: <9ab635a3-a786-4bb2-8ac3-131ad62b5426@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
	<20261126013331.0e6bb05e@jic23-hlaptop>
	<9ab635a3-a786-4bb2-8ac3-131ad62b5426@kernel.org>
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

On Thu, 26 Nov 2026 10:14:54 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On 26-Nov-26 2:33, Jonathan Cameron wrote:
> > On Wed, 25 Nov 2026 20:24:01 +0100
> > Joshua Crofts <crofts@kernel.org> wrote:
> >   
> >> Remove any kernel.h occurences in gyro/ and update the headers in
> >> accordance with IWYU (at least loosely).
> >> 
> >> Signed-off-by: Joshua Crofts <crofts@kernel.org>  
> > I suspect we won't get much additional review on this lot
> > and seeing as Andy already took a look, I'll pick them up now.  
> 
> Ah, well Sashiko had some remarks to patches 2 and 3. Alright if I
> send patches for you to fixup the applied ones?
> 
I forgot to check Sashiko

Have dropped those two patches. Send a v2 of them.

Thanks,

Jonathan

