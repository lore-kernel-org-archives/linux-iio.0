Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12A35A93D;
	Wed, 28 Jan 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608460; cv=none; b=JHSe8SVTERaUOhly/YWA1uvH7BkXUw60NeCPS8zVMWRwnkArdBO57zM8Cq3ho6D93OpJ2gJzJRVsaJYOZjv3zaWj8/mpwNSqBn1nL9GAfL8phSzHQQvyOpdseQ67CDtcd6Kduo2tVT2EGYmXi+ITKiXJ2eVfz0l/1OloJfuSXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608460; c=relaxed/simple;
	bh=2QcDNGyNgBkYWykeDTplf++Ayzs/pq2q0ljJ9L3KqGE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aLLmg7OSreqaTfAnIDLlfFeMHnNgBueMLo6RFK6B1RYr6RhG3J6RPl1OvIZ87k9NZCW+m0oE15jFDVV5R/Ra3L7NBPhmG7kiEIJ22ngeMpg17GIRZ6Y+eA59Lt2NAqYC0lKk0nd/8seQjByr8QHmzoYmUyU54GN85gQA7nqaTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7JWRdK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7JWRdK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D29C4CEF1;
	Wed, 28 Jan 2026 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769608460;
	bh=2QcDNGyNgBkYWykeDTplf++Ayzs/pq2q0ljJ9L3KqGE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I7JWRdK5ZBXgNUdcCMLUdyjVYf2GJtxanzlxs2pr1j2CMszWXT1Fnl6+zmPqj2Vjx
	 TRxPCZtLyajWyL6SF6LijJiN5XOFU4a1MxJoNzZkhpyMg4JhtWm1hCdkxE6t0Fp6x1
	 vFQV0WP4M5lzu+RcFMnBy16dwKidmNuf+6KFWS6QvXgE4R2/ait+2LpNubQrBqxqh4
	 Dnnvt677lZfbKNJ0N0PHu5DEk64BG4gqoV30imCS6I91W+Vv7bMc4lIHksrcD7tbpr
	 +6I8jv+kEto49AzVAkKHmKR7qJcodynMZCW+z4rb9MVSn7XDUOCyGPNF4nlg3dCurj
	 Zg+4Qb+U38TnQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98F5CF40069;
	Wed, 28 Jan 2026 08:54:18 -0500 (EST)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-01.internal (MEProxy); Wed, 28 Jan 2026 08:54:18 -0500
X-ME-Sender: <xms:ChV6aeDOtGQ6J7EITg0m42Fe4EJxXCvebl0aCqzayqgNK64hLVWcNw>
    <xme:ChV6aTUp6CSYCIENRLJR3gXaWUrWw-hskJlVNE4OGDISB-GS7Pnm5BfEK5JIvNaZ8
    sEx_slsTzW-3xb1jijcb3t6XVp7SDu9ilUvSM5JrIjcig7W3zheiEVH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhonhhs
    thgrnhhtihhnucfthigrsghithhsvghvfdcuoehmrhhitghonheskhgvrhhnvghlrdhorh
    hgqeenucggtffrrghtthgvrhhnpeevfffgvdfgtdeufeekuefgudffgeeihffhvefhgfej
    keetgfekgfefgedvkedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmrhhitghonhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqudeigedttdduvdeifedqvddutdegjedtleeiqdhmrhhitghonheppehkvghrnhgvlh
    drohhrgheskhgvrhhnvghlmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrggvlhdrhhgvnhhnvghrihgthh
    esrghnrghlohhgrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlohdrshgthhhmihhtthes
    rghnrghlohhgrdgtohhmpdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtoh
    hmpdhrtghpthhtohepughlvggthhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphht
    thhopehguhhsthgrvhhoghhrrgiishesghhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hrtghushdrfhholhhkvghsshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehnihhs
    hhdrmhgrlhhprghnihdvheesghhmrghilhdrtghomhdprhgtphhtthhopehnohhnrghmvg
    drnhhunhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
    hhgvnhhkohesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:ChV6aX7V1_8HCqYRZn8gEQOGmUuxonsUTfhQTxiY33Az317g6QzkxA>
    <xmx:ChV6aakB8fV7cTVtUyI-yeX5mIWN3nwtoQCm5uaPxzs2bW8kwpdcBQ>
    <xmx:ChV6aQN1Wqi1_LjF5y6KLn78NdQgZDXY4pzdR1MKo8MK1XLiKP5QCg>
    <xmx:ChV6aUo91Od22UhRy4_16F4XHetm_vaT8VA2WBVlCr-QjfRVjr9gcA>
    <xmx:ChV6aRsrAtHZfF9hAu9YcTNrWl6RlThiP8k4qnxHOionOuUnesXKAHyu>
Feedback-ID: i40364868:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7135315C008F; Wed, 28 Jan 2026 08:54:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARb0NMl4zKKw
Date: Wed, 28 Jan 2026 08:53:58 -0500
From: "Konstantin Ryabitsev" <mricon@kernel.org>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, tools@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 "Thomas Gleixner" <tglx@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Puranjay Mohan" <puranjay@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Marcelo Schmitt" <marcelo.schmitt@analog.com>,
 "Marcus Folkesson" <marcus.folkesson@gmail.com>,
 "Kent Gustavsson" <kent@minoris.se>,
 "Gustavo Silva" <gustavograzs@gmail.com>,
 "Nishant Malpani" <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Message-Id: <c064a31a-a2c7-4e35-b8d6-063684f48869@app.fastmail.com>
In-Reply-To: <be27fa4404511cdf65a9a0f212653a7f1fcd86b6.camel@gmail.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com> <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com> <20260126101034.lnGGQmUD@linutronix.de>
 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
 <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
 <be27fa4404511cdf65a9a0f212653a7f1fcd86b6.camel@gmail.com>
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026, at 05:45, Nuno S=C3=A1 wrote:
> Since I have you here, I might ask about something that I'm not sure
> how to handle. Might be dumb but here it goes. One problem is when I
> send v1 based on a branch and when I'm starting to work on v2 that
> branch was force-updated and I want to base my v2 on it. Is there any
> good way to handle this?

You should be able to just rebase the b4 branch.

git switch b4/your-branch
git rebase tracking-branch

You can do this at any point, not necessarily between revisions. Since w=
e have the tracking empty commit, we'll always know the base-commit auto=
matically.

-K
