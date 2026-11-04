Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776291;
	b=vw9mWeCsUw77aauXKbcWIp9+BUS3hS4KzTEYh+FQII+HYcDcVmgQ1muEn+qGyrVP2nK8
	 spIsscpnAngAVNDhcL2By81E4hIiXD+3mjA9IIW3qdsdmpFczBIEJZ9q2U6leEeeGWt4I
	 5cq/0Yc+KndfCXtNmZt6oV7bRGIWJFu9DUd1ISSUmvPOUHHjxfryx6YNMzFKCyzNNr/Pc
	 PCIOqxUiuEtmlgzTAYUiNVAOG7AnLlC3gLds3OosBj4OmV/8wX2C5ARp7gtMuJvi3pvF+
	 Qb3McaSB5B8IRdgXXNPSSU+InCS4cqnz0dzfa2qzHvVmFktxvM3QHgp6Xh2RJ6j8NEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776291;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OAw4UAZ8ajUQT/0WJnyn1CLkYUGHPSSyCSm/bvyN5lk=;
	b=tA3XMf2LnCrkv5dzoxhU9As5X9c3kFylFkUJ5HvzcgHXWyl4EHZFOD6r78pumDLEDZ/0
	 WwLH39HTi3RrQZoa19wQaFbz4Fu5pWJU/H3Yyz+/ymQ+Aq7h8cZOCpcaBKQGXhN9OUk8N
	 SuM7adDJS4jJiEDV1pBl3JUw6VdoVZ1tRp5Mzd0YuvtNw4/AmclVOEaK3shYsKqY5e2BK
	 yLYIjWtnN+PR3owpOG4MDAgUSBI1xYv/eBj3Qw7Rb6HSciedgAThfcPr/2JQyvsZgII9B
	 CU0cchwJbtlgaOGoheYw0PFjwX6lIuE7y2Lt7ll/UgzK5zFt4bpdZkjgAU1UVAqZ/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QMws0x/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCC606A31B;
	Wed,  4 Nov 2026 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMws0x/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB7B1F00919;
	Wed,  4 Nov 2026 07:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776291;
	bh=OAw4UAZ8ajUQT/0WJnyn1CLkYUGHPSSyCSm/bvyN5lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QMws0x/sZ0j4zQ5UNK9irM3DgyJPKa+k2QAqKskmuOuw5b3nqCPSRCxBsknuSFGPH
	 X6+FIoXw+dKzozb29tY3X6JvgPq32PqxFqiJJe1o1ywzzuQjLXw09Z1hEGR7V2apSH
	 DFNppGpo09u9oUJEsfAePyspWN8x3vyYj/Ao4ESeZnAtjO1CI6PpW5a+oixSA8Wlu3
	 TykyAB4Ila2i1FFNo7Zf4TOHoT9L3e7Tm2LKB8Dhrll02Zn+jVjCR7fBe//Km5TAob
	 gn22QzOKdJNhUhbZsHNdvyfZ8NRtsr1QaEOdsJJ0D40FchccUI+p7J063iWznRcpFv
	 oNSJrK1lEWKOA==
Date: Wed, 4 Nov 2026 08:11:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	William Breathitt Gray <wbg@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] counter: drop the runtime PM reference when enabling
 fails
Message-ID: <20261104-affable-ant-of-sufficiency-ba1efe@quoll>
References: <20261104025337.1527287-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104025337.1527287-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:53:37 +0000, Wentao Liang wrote:
> rz_mtu3_count_enable_write() takes a runtime PM reference before
> initializing the counter. rz_mtu3_initialize_counter() can fail, for
> example with -EBUSY when the channel is busy, but the reference is only
> dropped on the disable path. Because count_is_enabled[] stays false
> when initialization fails, a later disable write returns early and does
> not drop the reference either, so the parent device remains runtime
> active forever.
> 
> Drop the reference when initialization fails.
> 
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 2 ++
>  1 file changed, 2 insertions(+)
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




