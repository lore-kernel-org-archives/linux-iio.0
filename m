Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169145;
	b=os2w5C16qJuJfNNEKzWHK2WFpjm/sL3UJB1In8BOzpjGb3h9yEZzsXYv6FfuqHYz9gFf
	 zMzIXmEuts2gKtJIlQbQ3pPjgiVtICO0JtaIoVqY+XKX0m9dnLQxsZr1kntTBT2CfPV3w
	 tVxQlCffmp1qm+Gdb2cnZT4dsqqwyqdB4kU3xujNjDWAevNk208V84SP2lTiF91AqNIue
	 GCu9AZ9f3HmUS/g/L0GqsK/r22jXZocUd6GxvL1kbjzuVIEBh7Y+j5Os7xWroQFlJ6/H6
	 rO1wzx6/yMVkZTOVcJQRA+D4hRtG+NIV9yTUXqT6Z9iaWzAqO3+l9h6trDOhZQnSBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mWpaxCKb6dkIjHDLT8wwQ210OgC7vt5NrC9e+F43WlE=;
	b=ld/p2a/NOSjdYtB7PKf4Y0A3mr0HEhV0X+XXKDpJPWc4nOCAJfh3hJ3jRvlS+GmYpz97
	 K8KJl0CMgED7rnPZ+HvFvNPdkcAgoao6sPVAwprPHFO+EbXBJo++h1CLmdfmzGn6U4kDB
	 NQbORT0y9GHa0/ZREv9ybb5RSpuWR2xWnN8+0gZHO/TGvtBYXpf0QNDMCCPiKnLiO8flC
	 eBX2vk4nPZcX3VPs+hGxkaFe7ZtZFfUjf7tfVozSsnH7AXruPVQP0f9KEKq+mgfa994p9
	 pASH3SfoU8QzEXLphFSb8XxmdTLOZrGeV50ERFRL3FHfxA8tzXTduFJuorVINw/+rDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jr3Z+Vv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21B606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr3Z+Vv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C10E1F008A1;
	Sun,  8 Nov 2026 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169145;
	bh=mWpaxCKb6dkIjHDLT8wwQ210OgC7vt5NrC9e+F43WlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jr3Z+Vv/VI+FEycBtSrWFPGuzdNdrd16fKdAbeDyImKqNl/jIE9LmD1TIOS8e6/7m
	 5y8yYUuEbxAlLP/D7LdYy2obtSD/Lm1mFu/RpcX7SAW4r5QJ96Lv0jBvE6COyOibkH
	 lv2M0L4qnARVIA4qPGt99atY6nT4ry/GWTXz6ho6p8acWIOns0CN/+FNswUfAn1L+r
	 mI4A/8WyGx58P4xrQeeoutG0VZQ4PIBUBSU7no+tqhqQJc4JZds/fz0SHvh4lwoO1i
	 zuUMJiM0IW1lEU1kch6KCaBCAaz3QYzzkTLZYrRcE+9v7btxjdvgqTNgf6U1Hbufc2
	 48UWJPCFkbc3Q==
Date: Sun, 8 Nov 2026 20:19:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Adi Nata
 <adinata.softwareengineer@gmail.com>
Subject: Re: [PATCH 34/39] iio: humidity: hts221: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108201900.26135df5@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-34-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-34-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:52 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> Cc: Adi Nata <adinata.softwareengineer@gmail.com>
Applied 33 and 34.

Thanks,

