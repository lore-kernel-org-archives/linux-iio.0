Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673F34574B;
	Tue, 23 Jun 2026 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193087; cv=none; b=BjGSDRl/KfTjO+FbUkhe9WaFwBx1gOgZBfOCCZWbY4ZdgAY3c2OI4DqQybRB8KQPEZ5UrUD31itzqDILiTebSLl0WOveyuKM/zz8Eu62dP2m7zBvkwJC1SCmyQDOUY+A5CayOfW2nxUObI2xDu1i81t2oVYRerq98WvzT6xo4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193087; c=relaxed/simple;
	bh=fSlXsmtduOo632A404s2f1KOxF4Sgvn19HBOe3QMr/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXQPP94prsntP8eS3XQQwHxC6IzLzM/hXHNFAE2DbQezGYxJDnmrliZ/D9Q8N6Lmqo6ER1BlKkKaiQh61naalz+pQnscVUeBWGp/4GkkvBbDaDLHnsGtiArNgRV1TM8MNCvIS+ouaLIdsvv3IfAZwW3qnsWGTj8NHngsXw+hqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ+khwzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ+khwzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB5C1F000E9;
	Tue, 23 Jun 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782193085;
	bh=9XqQY2XCM9PJYXxeaCmLp6Mj6zmOd5xGvltapxjirDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQ+khwzSkve0u2pjb/QK0VlmLf4qYBGDV543Q6ttnWa6KU7Cde/IFReyHlyDLI1KP
	 Y4U8S+XsZWGsAniRo0+ai0+ZaddvaSnqg0b0gxVj0MyLfJfHJfDSZTlp0sEapCfU/x
	 gwoEejYnTpGmRqRpZiFyOlCVBcZJ28iGbvc2rcDXRwOWT5rh1KN/u7rOpNVv/RjQ0Q
	 sb+3Z+r4nAp4sElJpQzkAdi2FbfGZ4PEAPT3+hu5fhSgWbkSnK/c3LEBd1WJXKTMpE
	 ocBudP6qCGgm233OBcy1VZOlD5mCI4g8TQyEOCD93foGSq2zA18xdxUzcESGhSw4tc
	 R9H/F5daetkow==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] counter: add GPIO-based counter driver
Date: Tue, 23 Jun 2026 14:37:59 +0900
Message-ID: <20260623053800.120909-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622205210.10317-1-wafgo01@gmail.com>
References: <20260622205210.10317-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146; i=wbg@kernel.org; h=from:subject; bh=fSlXsmtduOo632A404s2f1KOxF4Sgvn19HBOe3QMr/k=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlW0hFHb0wK08pJOSc+e+qTs0p71XuPi6facn1zCYv4b h50fZpNRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjAR/juMDDPvzFboWvZfWNa7 6cln1h+rbKQSXwvubBC2vBzJHfuhkovhn8ZR4Zhf83fOlr72yWs227rCmPwlLy9evPh40cXIRy7 S51kB
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 10:51:40PM +0200, Wadim Mueller wrote:
> On Wed, 17 Jun 2026 16:49:25 +0900
> William Breathitt Gray <wbg@kernel.org> wrote:
> 
> Hi William,
> 
> thanks for the review. Three things before I spin v6.
> 
> > One change I consider is whether to make Signal B optional. [...]
> > I wonder whether this is substantially different enough from
> > simply using the interrupt-cnt module on the respective IRQ?
> > I'm CCing Oleksij and the Pengutronix team in case they wish to
> > comment.
> 
> I want to keep signal-b mandatory in v6 (if no concerns from Oleksij). The single-line case is
> already covered by interrupt-cnt.

All right, let's keep it required for v6. If for some reason we
determine it should be optional, we can address that after v6.

> > In such a configuration, we would have two Counts: Count 1 [...]
> > Count 2 supports only increase/decrease modes with a Synapse for
> > Signal B.
> 
> Just to confirm, plan for v6 is:
> 
>   Count 0 "AB Count": A + B + optional index0, all 8 functions
>   Count 1 "B Count":  B + optional index1, increase/decrease only
> 
> One counter_ops, dispatch on count->id. Per-count state in
> struct gpio_counter_count_priv (value, ceiling, preset, preset_enabled,
> enabled, function, direction), held in priv->count_priv[2] as you
> suggested. prev_a/prev_b stay on priv (they describe the wire, not
> the count).

Yes, that is correct. However, I would not name the Counts "AB Count"
and "B Count" -- it's possible that relationship will change in the
future if we add support for more function modes to Count 2. Naming them
"Count 1" and "Count 2" is adequate enough because the Signal
relationship is apparent via the Synapses.

> For the second Index in DT I would just let index-gpios take 1..2
> entries (first = count0, second = count1), no new property. Ok for
> you and Conor?

That seems okay to me. I'm generally indifferent to the DT so I'll leave
it up to what you and Conor decide.

> > Hmm, is it a problem that priv->enabled is changed to a false state
> > before the IRQs are actually disabled? Do any issues arise if an IRQ
> > is handled during that brief period of time?
> 
> I guess it is a race. In v6 I will reorder:
> 
>   enable=1: enable_irq();  lock; enabled = true;  unlock;
>   enable=0: lock; enabled = false; unlock;  disable_irq();
> 
> Plus a mutex around enable_write so two writers can not interleave
> (disable_irq() can not run under the spinlock).

I think the race conditions still exist despite your reorder: after
enable_irq() an interrupt could fire before you take the lock to set
priv->enabled to true; similarly, after setting priv->enabled to false
and unlocking, an interrupt could fire before you call disable_irq().

We need some atomic way to update priv->enabled and enable/disable the
IRQ at the same time, but I'm not sure how to accomplish that off the
top of my head. I don't want to delay your v6, and I'm not even sure
this race is actually a problem in practice, so let's discuss this again
after your v6 submission.

William Breathitt Gray
