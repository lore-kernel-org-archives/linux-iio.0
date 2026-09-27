Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC92171BB;
	Sun, 27 Sep 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536683; cv=none; b=ln5V8E/rvqpPiR9MqQYIEvSfTTVClVfa6cYbGl6hkbPyVP35nNigQ5333Gq8orhQTHUKlq67NlO40+twObusaCHWrpYi/5f40PeHBTMSXMc4pLnKWMsUai0j4YrN4Nlsl7UTxWA5PYrqYdHU8SxhSS+5BwvGra/z1ckweOUVyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536683; c=relaxed/simple;
	bh=ccuAZ66saLJnwuRvOlt1Ts4dKac6PEYCM8ZLAmP5v9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUkd4f+5nfLkhyR+7w8/5PUKfzqpwg56tTfoscVM4YvsGlBY9TgXhI1NxJJo2J0BGxe//CqepeMNOL7L36Ced7HFuxKUuDtFKjixO1d4nFw0J38JMSrmi4Kvk4Cxus18yRC3gAcYVULdyDo1eTGLxx1xXOS9KlhrVtTISX1T35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtJBR2Xj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtJBR2Xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9441F000FF;
	Sun, 27 Sep 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536681;
	bh=lqmtThrEimp4BWdBMFWluEgJ9+vptRj5+rpO8LNzvHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EtJBR2XjG3tQ9ZkF+7/fepdV5oRyenQ1+Or1DRsYlErS5DxGJTrY9B/qEflSUlSUL
	 3RfGZ8C9/GHb/MlS8JB4mdFX44SN94JcKEnmir6yd1m/uV6USav7pQ1doNgVF8Ty4K
	 pCSgev2qIYyHXuyXXMWCqigFqUk68Ulst4kXx1WfxykdbrJJ9+PubgMPKcLIFhXor4
	 Kvb62At2Dab+Ru8CAfIU2LFJ4L5OKV1GQI53ucUxE7rE85UtYHcGRfwa3RBxmGab8a
	 dq0FjOkAL1TAPA29ClI1boHH0ZhBzGXib8AhEL5mJHjYmkzSfkA4E4hqojVfRYgfZ8
	 cFhevhvpXffNg==
Date: Sun, 27 Sep 2026 20:17:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 02/10] iio: pressure: dps310: use a local device
 pointer in probe
Message-ID: <20260927201757.15378287@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-3-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-3-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:24 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> probe() spells out &client->dev for every devm call. Take it into a local
> instead. Keeps lines short as more calls are added later in this series.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Applied.
