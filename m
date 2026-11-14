Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698782;
	b=hVx9OsMWReXs2vDyznPWv6rgGb4feCFh5yCCNs5SSLeuJkVKc4nP3ETHD06zidcSRf2F
	 TefRmkiq4mrBgNiTtK5wb02RWMRFc6eaAJWTcXP22tMsR7Q8CqRVPdRnOe7c+ppZ7kgFt
	 SwnMMBhkqu1ivqCifysvI1xC4ltpdAgtIGpCABhVVsNyw/edszaGAbNR4qobyIjD25/p+
	 FJiZODGlVcts0M4MyTcoeqjRHwZNmTy6I/VJbX5V8iIiksOn/X5myvOSUCi4GrPpDMND2
	 qlNXMKxaQglp3mB8XlCkIB4Sz0nWekhq9DyLEY5EtSOO77JiLgcp5Ov7j4FC/TRXXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698782;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=md8/w68Qk5y4TzolRmrG6rKjSFu5xCFzfOYx20vBHXs=;
	b=RMDNAGCgIU/S/MSmGB4pONK7jVgmEmUn9nMbSLixOcULwtASXml7jVZCiNTLoEVbhAio
	 0CphQ+sJYA22OlHKKYi4Bajk/brhe4ySjj8E3P0TG84lKVRWZgNZWTHVPqG41SMshgcN4
	 tGc+QIrnwhoH3nyyiQAhlfcRcsmNoffwx1V+11iHrG5SxJg/ycSyyGOr5RNXNNnlWgDN3
	 AGy2DrV7CWVdLkcbe3mB0I7o2Gkfd+zwBfSsxNtPJokKPVNq9u9osSSSCBaQDWojVlpr9
	 qegquZkTkSMzmhCHg/z9yhOL156bLf/GkboS+v8s4zk7kuEI6G6EGt05uPbQi1L+EcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC3Anx9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1F606A32E;
	Sat, 14 Nov 2026 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC3Anx9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7121F000C4;
	Sat, 14 Nov 2026 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698781;
	bh=md8/w68Qk5y4TzolRmrG6rKjSFu5xCFzfOYx20vBHXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IC3Anx9CukfrjdAVZLBiozNZ9JJl5w4P/FW4zQvgKfTQstCz4FuXsn8CFcsI52s6y
	 +YCrlic3afH7XamNeZZbY3fZ+GflErXCW+j/Kcx0xA6mnaMCchO03ubxUoYr7gpPcR
	 pfOoURprHj53BvAyDbwM7N2bwJk6gYJUeMJCyfrVLTIncVvt1VvMoKJbFJ/2we9FGa
	 nbrok3bRr7nhD2BqLu3PM9KWrbx9Kdi+zjzquikfcb/4BVNNhck8dSiWHf08gTBPfm
	 bcSUqh3E6zAsYXc17qA/KSUyd7NUJUVfLZT66p3w4q6y9+FwE1FBnGGTMVNIHk34LJ
	 UXM+9EWPqch5Q==
Date: Sat, 14 Nov 2026 23:26:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ti-ads1262: use umin() for excitation array
 lengths
Message-ID: <20261114232616.389ed8e7@jic23-hlaptop>
In-Reply-To: <20261109103553.00004a85@kernel.org>
References: <20261108-ti-ads1262-excitation-umin-v1-1-65929a66394d@gmail.com>
	<20261109103553.00004a85@kernel.org>
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

On Mon, 9 Nov 2026 10:35:53 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Sun, 08 Nov 2026 19:55:51 -0300
> Kurt Borja <kuurtb@gmail.com> wrote:
> 
> > min() rejects mixing the signed count with the unsigned ARRAY_SIZE()
> > unless the compiler can prove count is non-negative, which fails on
> > some configs and breaks the build. count is already checked to be
> > non-negative, so use umin().
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202610241549.J9R32Wf7-lkp@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202611080814.7RmHoQ6e-lkp@intel.com/
> > Fixes: b0b43a26dfc9 ("iio: adc: ti-ads1262: support excitation currents")
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 

Applied. Thanks,

Jonathan
