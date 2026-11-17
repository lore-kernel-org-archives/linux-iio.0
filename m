Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886319;
	b=myFuEslpRfh9Z2v5bR6Z/yNz3487fuYSNrhTpLfmecJO9tGYBT8H+Ax2xH6rUs5mJ7jY
	 2M2EtKr2LDqPP11TT0JMoY4exu8Cpp2NRNh1m9nKP80RhOXNJ70kHQCKspOkE3vtNDjFO
	 bqAWkYxcHDXzzpP7+ZMMg5qj+zXD5BLvz9MHqFY0Mq54p1Etk0qyPxEnthDLBg7r9DfAz
	 RU4xkPFdHkDbyGRhe5XivC/6cZcGA789bckIxGA1zi2vkylj1BFgnqC6T4MHGkNSws1OO
	 qYTjuZA7qnCu183eEE3aUhH9tXgE2vq26gumgTPpE6EbbTILpCKVxwX5QNAQgaxC4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oSa8DKGJbrO7qKyJh6L9FYHF+38mZpw4ma/aH6OBT2k=;
	b=ojnm0T90jNCPdTHzXFjypF7pcp1lg3k0yZhBIpPAJgpBK6O3WsLRmjeIMBiKTj8SxG2U
	 4SBsr5uDX85PUkQ1gGj+WA9dwElq+db2xD3e9/dacLb+pD+SxB1gr5Rj8jQwHSlClZQIV
	 7XyUmGtO/8gW2FDof9NBHKT6AV69HLrIe3v8AxsKRO57Q88s/yFf08kG4bRkjmuq6WhuI
	 deB4Nhps8pj24AeJSS23Cy81Q7Q8bmC/8ayI0VYU/oA1ZTnKGine4c2GXpcFPhw3H8Q0x
	 fkTpQ/31UoNbBkgU1nMSZ/F2hO/3ayvt0pJ09H0zn1cC+GnNPwAVEPSurpVjuljFUxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB+me3Bd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC8606A32C;
	Tue, 17 Nov 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB+me3Bd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB081F000C5;
	Tue, 17 Nov 2026 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794886319;
	bh=oSa8DKGJbrO7qKyJh6L9FYHF+38mZpw4ma/aH6OBT2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bB+me3BdrUvsPmQFN/7JkhUs+/XWzTb1AXg11RzO5JYwrnx+OFJj1t9RjIsUCVmck
	 owfllMebAVA5w5lP0Wv8mRPOYh1Cs7TaEEsm4oK/LiLxCxj5l2IrOBkfM+Av4w8ICS
	 SPqpxLV2UnkZa9TQgccU5EAZCr5gg9Ouni9EKk/+aw34/rBf8fzu8Qdeg5+z2tRDoB
	 FpQp4NOW6bvkQnFEpI1+VuhH/pm+UCnkVs600zs2RbrEP/Wz9+lwlnrI4PqloO+PQX
	 LzaL+GhOuxe3ZBDVgtsv9beGkzzTSrm14Tv5sFBRrcN7KhRBtUu7BV1jyJvqLtF7xK
	 9vHQSBl8Ctnrw==
Date: Tue, 17 Nov 2026 03:31:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Arnav
 Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new
 temperature in trigger handler
Message-ID: <20261117033153.608b124e@jic23-hlaptop>
In-Reply-To: <20261115223817.10568-1-zoone.rupert@gmail.com>
References: <20261113230241.82046-1-zoone.rupert@gmail.com>
	<20261114013817.476f8fb9@jic23-hlaptop>
	<20261114083525.11972-1-zoone.rupert@gmail.com>
	<20261115010203.2a939bd6@jic23-hlaptop>
	<20261115183949.11591-1-zoone.rupert@gmail.com>
	<20261115203150.7faed0b1@jic23-hlaptop>
	<20261115223817.10568-1-zoone.rupert@gmail.com>
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

On Mon, 16 Nov 2026 00:38:17 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sun, 15 Nov 2026 20:34:11 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > That all sounds good.  I tried to apply it to the testing branch of iio.git
> > but I'm getting some build errors (+ a load of fuzz). I guess this
> > has dependencies that I'm missing?  If they are fixes, then I may just have
> > to wait until I can merge back into my tree (after they are upstream).  
> 
> No dependencies. It is based on fixes-togreg. On testing probe
> hunk no longer matches and with fuzz it lands in
> dps310_fifo_interval(). git am -3 gets it right there and it builds.
> 
> I can send a version on testing if that is easier.
I actually looked at what was messing up this time.  It was just that
int rc; had been dropped.  It's just used locally in this patch so I
put a declaration in.

Have just merged rc3 into the testing branch anyway as a bunch of
other stuff is queued up on it. So hopefully what I push out in a minute
should be good.

Jonathan

> 
> Thanks,
> Rupesh

