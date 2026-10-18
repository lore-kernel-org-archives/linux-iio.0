Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7B1E5B70;
	Sun, 18 Oct 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365263; cv=none; b=oFzjHWgRzqXJdxAwM9DSdzBXy3W4Zmsxaro8jdMNuR6+0drjTZkFH41rPro+A6vEr/xCOJ6uKvPerOjwoVDkCVVMKKWHedIOOZYHG311zMezLX99/SioiqicOt4jQ03InkO8NdMpjO89nzRuAInjmHB3WA1eZIfllGbOEZcryvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365263; c=relaxed/simple;
	bh=pQz5Egxz7FD9XDhVvhzpBwE6DXHo0SRipPJsF+pDgIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INzMi4nYIHAH8Luto+roNTR/IO8F9WXgOgc+ELq6xDswJoJzzDn0j6lIFfQlnKDaXJ5Ifx2LVBAZxHqpnq+KFaLbcDM1PV6thMumsTztWDLxgrJmQhxpg3AGOHLu+xfx5xuK9PgmIIzkX0r8L6+v2fVDHXHINmS+t1Jjm9uFw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwn489ZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwn489ZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026081F000C4;
	Sun, 18 Oct 2026 23:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792365261;
	bh=T3XzDoQLuFucjxlUXIHS2DUJnltl4cAMHYg/ui3GJGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bwn489ZUMJf1IdZPPCKfJtGKAnd38mcCep7818ylYm7zZxwCeUKBuM8E0gU/ZxdZ9
	 VbEzUOiamWejRDLXog/1WGG6UP4jtxhmqumARlZaAw9ix4p9q/IHH0bLzvTHd3Hg5z
	 Ubd7XITWyRQG9CfzppT9qoKDyBRQO35K4D25tmWeursuXz6fqjiBSHaknJtEjPBPSA
	 CKL0uCVyMrODu9vV+zrBJhVwsXa+sdj3VCOWP/LWQlFQVF3OqBqvjuvt96UDZ2xz2U
	 PhI8K8DKt8bB9cX24EkMD4OLB363Rb7qqpHf9aUenNYzvdb0DYfEoUNt6MbBv1S+oU
	 V2lSQ0eHSPBsw==
Date: Mon, 19 Oct 2026 00:14:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 07/15] iio: adc: xilinx-xadc: Simplify common coding
 patterns
Message-ID: <20261019001414.1e7d6544@jic23-hlaptop>
In-Reply-To: <20261005094205.1045874-8-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-8-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> @@ -749,7 +746,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
>  	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
>  		return XADC_CONF1_SEQ_SIMULTANEOUS;
>  
> -	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
> +	if (!(aux_scan_mode & 0xff00) || !(aux_scan_mode & 0x00ff))

This looks like retrieving a pair of fields.  The values of those fields
being what matters rather than no bits set?
If so I'd keep them as == 0.

>  		return XADC_CONF1_SEQ_CONTINUOUS;
>  
>  	return XADC_CONF1_SEQ_SIMULTANEOUS;

