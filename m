Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778099;
	b=HdMRKSIf2DPp/rPWk/0LasTIrnB//hQjmuRbF8mWv0HN/baLTPc9IBEdAZ8VJYNMf700
	 CnIeWk83qN1dXtBZ6tSt37sK994XVe4POBN6eYFZbsuimKRMDDUZZ3hHauOGHQZ4yr1+w
	 /V1cgoCQtcGabn+0Nl3KWDEnxL5jPjl5ligJNlE43hZwPoyvpgCyujm7DLySp2huqWzWE
	 gG9yhUDKgMy/t+qku6dtQvzfjAGW921GOUWlF8Zxr6bNfx7IE6z6zh9rzjDNpHVHbDRQT
	 7Oy4JBKvSzYQh6eHjGhEEowSSOYIHKav7cOz90rI399X6Jwe5QBTni3nsHJe5gYT2wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778099;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f9TDP9ZAAL0jNGfDmc2ezgxAJYOk89xJX34Mawzxnbo=;
	b=X52W03mLNLpTY6dKNTsLmmI8LlXxowpbJzlc6hfBsNq6x7gQcpei+8Z/yY+Nxs364vPk
	 z0C8KT1RK5Sva0M2fpqXP4ZtaECFUDFHdvPhxJ5apXSOxu30SIUU5uiKIQdraNg3ylThd
	 hUxUCS5fUmFbmD4oxuV2SEhH2pU6NxBYKIit4m/+mhqyR79opxZLn70rvSPnAp1VQBc//
	 uNn3TXu/ZqnAGEYxcCr4yCup3wMkzGQaEot1yNYdthC5q9NJHurDz0/ubaMdlzm7eiS56
	 WJ7+VOUHBQKlSZ9brguvpSV7iUE8SSlh1sG0An2RfpU2s2eNIJOI6LtDUOPf9X178Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAxvmmvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE0606A331
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAxvmmvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8821F000C1;
	Wed,  4 Nov 2026 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778098;
	bh=f9TDP9ZAAL0jNGfDmc2ezgxAJYOk89xJX34Mawzxnbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gAxvmmvdoyWokoA27XtiZOh1uFHRyI84Vr3UakheuKTRrmbRsc82p5oE4DsoBexwc
	 GRizUx6YnljbSx1jD2SyMgKXd7/YEJntInWUFgmw7UbKgiOqsrLmQiqpTAdq6egA5u
	 x1aknT9IXF0vt9NADnD6QimqU6Jxc/cU19UOURuKf8Sr2Wz2YCrwHLt1sJP6xty38n
	 lG95EmFpAmh0ofhnvCa5dW7H86G8NvdUIRJZhWlynPdFRi6ohinUpcsYrj+Vi8ZW7V
	 jTbxxKGBnmJPOSfVr6JqdNTx4MDCrKwoUi/7GKMicGZu5KWVMDEt3+C2eA/+4wmXad
	 yJttc7SLKQo4A==
Date: Wed, 4 Nov 2026 08:41:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: William Breathitt Gray <wbg@kernel.org>, 
	David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: balance runtime PM when the clock
 fails to enable
Message-ID: <20261104-misty-tricky-sloth-c45407@quoll>
References: <20261104024056.1508805-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104024056.1508805-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:40:56 +0000, Wentao Liang wrote:
> ti_eqep_probe() enables runtime PM and takes a usage reference before
> looking up the functional clock.  If devm_clk_get_enabled() fails the
> function returns immediately, leaving the usage counter incremented and
> runtime PM enabled; a failed probe means ti_eqep_remove() never runs to
> undo either, and devres does not manage runtime PM.
> 
> Drop the reference and disable runtime PM before returning, as the
> counter_add() error path already does.
> 
> Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/ti-eqep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




