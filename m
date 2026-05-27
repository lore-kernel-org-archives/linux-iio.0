Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584C221DAE;
	Wed, 27 May 2026 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865967; cv=none; b=RK9AREBS/wi0LZVOuHZeElVqrjwka1blgaocalRYGBGDELI20uP+3EL+Vt3zwOQNut9Ns3QULce7N3nN3bn66TWEF3FUV8Qj9+hPX6VdjVoX9O9PPF3qZS9yfeTJe0oBlHa+wEgP2nhFL/AVi9XCQdHHTt56D96a8fH27RdzeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865967; c=relaxed/simple;
	bh=Butec+Eeg62Bee93UFi5/4G0TUHSLyrWYINICHEg+cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIuowD0Y1oN+Tkzg1xmgFXI64gvLybrSGs+dJGHPY3x97+/XMJNrLhr7HdvlVLAf478s+h/v2mAPAdqQzbYofQtb8ZqQYFpTLh+T5I/FcE0/x0vv2mez9kwT1kt977CiXjyxnfDSsf6IeNpcn6pyMDnajIrMYH+lVJTS+8HjrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw7ckMZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw7ckMZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA91F000E9;
	Wed, 27 May 2026 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865965;
	bh=rpTm1xg/glo/LI0C428N1h1oh34Xmyz8JmFzHqKTVWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yw7ckMZN+mbWlczCSnQre/DQOpR5nb5pEzKyRHaWT1iTlRdfEpYUmxL9sFggPKG8C
	 2TX9mX5WgPNCwX+BB+WPqXkplyFj3jS+JG/ypIl1WKGkMpftTIY22G0PyNp5pGdxIX
	 qqE6QPegE19w1nRPMFg9MuKBvFWnBYTIId/YWQR/KEDiwOxuNkvecKX6oB5zn9C1Xj
	 7TNLbf4z7E6LkFyu0nAer+iFAMxW5GKP/Vi1SIrgy43mzH7WOA3CZ1Y2diWwi6Ruch
	 YeAWfjBN9oblD/z4FNYwCQx3pm3q1sAEqJd8YtjBmM6c7Khun66IczA0pDH04yf3/h
	 nrgTyPjUoI7lw==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
Date: Wed, 27 May 2026 16:12:40 +0900
Message-ID: <177986590964.504200.5836903770783127580.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525152137.7428-1-sozdayvek@gmail.com>
References: <20260525152137.7428-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=wbg@kernel.org; h=from:subject:message-id; bh=xKNgsAGgUleYzub1qpTWBYJS7zLwDsVJQikZZ0BTjsg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFliM+1uX3xUl2UQyVt+xdhh4+k3m0Purb9f2NrTduD6b CV/gYScjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiR/kY/hc2P1VguxLP3vj5 Dm9Diewyb6vad0FeV43OvTnbw9J2TYCR4ZNVwv3Ze8JE26avUJf6zqmUZFKR6HZE5kCKw49PnRz qnAA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 25 May 2026 20:21:37 +0500, Stepan Ionichev wrote:
> ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
> before devm_clk_get_enabled(). If the clk call fails, the function
> returns directly via dev_err_probe(), leaving runtime PM enabled
> and the usage counter incremented.
> 
> Route the clk error through the same err_pm cleanup as counter_add()
> so the runtime PM state is unwound on every failure path.
> 
> [...]

Applied, thanks!

[1/1] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
      commit: abeabb5fc6a7d4c347d494dfe5bc9449c4535226

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
