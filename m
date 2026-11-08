Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100990;
	b=G891IcEQSHzAUDQzhGsEZ9r/+WZaRaNYxTzaK7VpgBZJ0ORt3eAXFTy4Ktu7Z2obG3ox
	 I2WVQwy+OoG0v1GlO7uYKs908KRBSxcaf8TI0u9uQSb7FmopIapR/ug1J9kkUDc/Cz4AT
	 jRnDaheX3mOa+GzbKE3UdsUsJQDFTVGIvDqv2C3hj1WswPEDPwd3d+uqsiKfySgA5BHYo
	 fyeILCEn5tBmaM78QQLX+HKJ/sEv+C+Apdz8uf1dO7GZTFnOCSHWXeE/8gYsNkgi0Y8f6
	 leLBkdVUipH/kdmzg8T1nPRXBLddHtVQyKV2FlEJFlPIkslpytcZkNQFw+7gDaP4+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100990;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0Hhx1lgBK0aFxl8xffENzmOWdnlm69gGFSyOYkCk8Bs=;
	b=E9Mwp8Td9dF5veSBniZhJc1DTYyedYausyZgaVWjbpRPrsMryzjb1KtXpCKJyfjy6rj8
	 9pfuFwaNYrQezTTLsU2aymSckQS1+1FS6Ux1vTIdqLbZOloHOJP3TAYPBj2ZBbcL3lC5w
	 bDhSXrMh1S+xN6xWdupBNuIp648Ml4dp0qffzoFReaqdrMbqFEarw1kyAAn3ZRcCuDbMT
	 cdUH0bOMZS3ECLl33EHywP1YOvgMTcqnlnqbMzif+qapgvC13qR6PZgr4VBR7dfQeee2f
	 bb58BD1nUHGx1e4FpSzANAOUMPYU3g6/CEZc9/YXtxSGqkCp0iflQhB1Y4cU9OnY39A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+muTwgu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EC606A326;
	Sun,  8 Nov 2026 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+muTwgu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655A91F0089F;
	Sun,  8 Nov 2026 01:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100989;
	bh=0Hhx1lgBK0aFxl8xffENzmOWdnlm69gGFSyOYkCk8Bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m+muTwguWiOr2UBmGB896Epd8SufPKQhf/KvRFs8937FJzyCEV1hq39IJ530y8U+s
	 lxHfrHoyQnC2tS/lsEczkGy3jRsL7k48VX9tZYXG1VGy+Sv46obHUJc8IDNSn7+V1Z
	 wfYeR8dAVGW5fowR9V6TMOYTtDAQ+BR9hwlvlPvXLn5oEab342LqEL9SDrzoo0LptI
	 R3Ad7NAQdgqqs6s9xQhD9faNtqLVkrPY4EgyEg4oJgVVljkzEhusHhCqONBVRJUM3h
	 9kNOEssyg8uDsteeowyLFZDUPEptQEItVX7Tp5ubHd7njoezfDza1STRFUP9PwWJBa
	 IgcOmNa8vclDQ==
Date: Sun, 8 Nov 2026 01:23:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Eddie James
 <eajames@linux.ibm.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: put the chip in standby on
 remove
Message-ID: <20261108012302.3d5be612@jic23-hlaptop>
In-Reply-To: <20261104091415.710751-1-paulius.zaleckas@gmail.com>
References: <20261102072755.17043-1-zoone.rupert@gmail.com>
	<20261104091415.710751-1-paulius.zaleckas@gmail.com>
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

On Wed,  4 Nov 2026 11:14:15 +0200
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> On Mon, Nov 02, 2026, Rupesh Majhi wrote:
> > Remove resets the chip, though all it needs is to stop background
> > measurement. Write 0 to MEAS_CTRL instead.  
> 
> On a ZTS8032, unbind leaves MEAS_CTRL at 0 with the configuration
> intact, and 20 unbind/bind cycles read fine.
> 
> Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> 
> Paulius
Nice and applied on to of the other series on the testing branch of
iio.git. Thanks,

Jonathan

