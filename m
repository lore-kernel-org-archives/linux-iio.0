Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167987;
	b=EcDgNqE4QYxc8hgTEoVo/k1ZItt7fj7AQ8/HddwR95rNKTEa2hHo22tPPgw23oHiAMs7
	 KgiLGp30fBdEF8yIlO2t5+V1Emly6FAbvK2qBxBaCycWLW9NumWuxk1iAcJJjw0SRAsMR
	 UFwW63oq2lI9/d8O1RrvkaZS/wPf5aBELwWy5lvETcn4UwCcNK4KgBaabKeX11LM6QSx9
	 rFqh3ZloVqFyipy5+6DxnoWAlxHR7ZrbzJxoVN+YBiAmaYblsQKr4m0No5+BsdlfHXuoa
	 9lKeRh8sTDph8i9B338/5lrU3ATo9C1JPT8K8b0O4FhXqTlPTQesyKoR2lBo1Io+FfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167987;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ExjJ76jAE74dDjJXDu9Wff+tlFHksTRBgQM/uKNU67o=;
	b=5WoSkIa7j24Aj7F4laNGai9/96vOhbk1/Q7yEp80JXHnR5rOstBQ8AQRCGjYfgcZZkZH
	 zyBZ+9F3dJYCyyMtLSjcp6YTRIjiuasDG5CW89Pl8W0tNrIPuhI40GHdoJ2tWpFv0+qs+
	 N5PlRzeVZkrIdU4lYWjycAld3O+lqeF1kJSaRLRZR13pGB5OQd0EEr2lktns2h321rfhj
	 iB0yaTeEEOgPGodq/zBaBhObG/hs9M1od2ygw4TKvvC3tOiULTHXVuFg0ZlPi4onxMHvi
	 AgQcHkn6IWjdq9YdyDZz2WM6okgHI1Ijl15PaoK4qjGHHhPbn57MAqwD65aXv8MAJhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPhdRpN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B2606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPhdRpN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D521F008A5;
	Sun,  8 Nov 2026 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167986;
	bh=ExjJ76jAE74dDjJXDu9Wff+tlFHksTRBgQM/uKNU67o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YPhdRpN49+gyxmojWHtoE5+Uv4WF4FIthrIp+kQ1O/I8V1CM0Jw10idkaicPER/ZB
	 KWnlxZvgLr3fTAfQUJSp/Wq8+zjrMlQ1OONE81Hhz4rN/rgkILfRBGvDcS44YfFZLw
	 Xe1pL3lgvYWXpyl6VbbFADHA/UyG2r7URdxKravkpfZbNs9KT8M5amdFyZxnRv2j6F
	 tVQ4ptKn9wHPlx+HCZZXDqKtpVtmd2skHHguQSe155K28e3m15G9mgBWsjx9eDTDcC
	 VexeC6DpMb6xwY/Nw86f9ex/m33a/oKQUi0kmlWkMyovEAxciaiCmNOatrrY4Knhrm
	 ffjqugDogzEkA==
Date: Sun, 8 Nov 2026 19:59:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 21/39] iio: adc: ad7766: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108195940.6b51f9a4@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-21-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-21-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:39 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts().
> 
> Replace the data buffer with one declared via
> IIO_DECLARE_DMA_BUFFER_WITH_TS().
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Applied.

