Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840684;
	b=bHqibBDJGE7gyKgUoRqjDSpMo1mAHHWZ3M0/CCuW5t2MRg6FZKWrwBRk6lpJ5xMe01b7
	 lmhRVn9BS+TEoe7ISeX9t3Dv4oVeaW2ADGQ5HRBv8e+kSJkNnkKeY09sgxlQIFO/+8D5o
	 cj8daX7u8YK/iXM4Dv4wKVNtJA9U3uNaDYN7eQSOVY0R9Dt4D/Ipja7jKDePQwFhm1txg
	 qIvGfdn7q7IZ2vwc6kKPS+16ujVnfDl9Nh3K8rqrm0KPGthrxQzdmQd8+Tvv1b74v4JBS
	 pBugqdVT7P2rgbm0V8zi4YRWdH+kSHjajEgxBMBIo54JVZ/J83Egf9wdpmZmUuGo1Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840684;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=N6cwWO2g0D5Z9VuuT1Npo2iJj2ZV4U5twK2MRGeEqAQ=;
	b=RtUHCeg8U1uXRnIl7MZa5jp1pyUFJuW9Dvyv7wA2IbvzM1NGzv0CWv5QKJPgdCQ33QaE
	 UakP3dcXV0h7P2QTfTy/LKVwXFY/fhwqSkxmkWNTwjYvx2JfOd05TnBt5tX54MkZkrxCs
	 ccCmPve96lk+XQ6bP9rrWiAMcRW372uSeJCn7A1HHdIevrFHmJWR8qfApRD+/2hWInlwQ
	 36Hj3x68ndSNz33W54KOoFkrf90Ypm+qsqvYAPn5hD5aY0i1OH02ugz+vDfAUPQP5uzNu
	 juwh9eFtC7UNHG6h/ZQos+1dXoO7fDwLNFctaJA+QqENM9cLIpxpM/OtnyHUvy0msPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adBHKwIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB4606A31C;
	Sat, 28 Nov 2026 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adBHKwIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE701F000C1;
	Sat, 28 Nov 2026 04:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795840684;
	bh=N6cwWO2g0D5Z9VuuT1Npo2iJj2ZV4U5twK2MRGeEqAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=adBHKwIomaFsOK/pBShYnV8fAjOjr5zjJAqPtvyAO8bO6zpaknZz5SS8V93JMH2Rq
	 9SauAVZ80xBRbw0hST2j0x7cSPw8oL4TLJ1XVn3CJOiFobUqST9kBpbbpMxOg/cSVv
	 qANAwIBNdj7VEbAQcr3fXhdzLFeSUumvsbqH7i97BBSarbjTiJQQj8zUS87qs6uYRv
	 uGAT0QLbGfk4mA+6oRalAFZMX5gHgL/0thk+3MscnwrXmLqYwztjtp+oBig1f3dIM1
	 lPcNaHpOwO1vnnJ9Vy/x1S+pIThSu3YQt8ahsvYgKP9x5TG7V9fcuh7QGTpIE40t0N
	 uY7rOfXPGQIhA==
Date: Sat, 28 Nov 2026 04:37:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 12/16] iio: adc: xilinx-xadc: Add clarifying comments
Message-ID: <20261128043756.44cb2303@jic23-hlaptop>
In-Reply-To: <20261125171045.1246381-13-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
	<20261125171045.1246381-13-dileepkumar.nagavarapu@amd.com>
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

On Wed, 25 Nov 2026 22:40:26 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Add missing comments on struct mutex and spinlock_t in struct xadc
> (per checkpatch.pl), and explain the non-obvious FIFO-drain loop and
> Zynq alarm-bit reordering logic.
> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Applied patches 1-12 to the testing branch of iio.git.

Note that for next version you'll need to list the dependencies so
that sashiko can find them.  b4 can help with that if you use it
with an appropriate base - it will figure out the message IDs to
add for the patches I've picked up.

Thanks,

Jonathan
