Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168710;
	b=Heaoe7l1gyNaPJgMkqeelQRzQhpOfqWnhmIYlrfVY6UKtPgXK+KIUdhe3vZIcWpV/zdh
	 RZL0XnhWg+oSGQmaosTl/3KM3woUPQw6+Z84P3zVav8PmkuIP5rxXG1ra59naoQAtDlnu
	 DdtTCkLHMy9Ueyc6gaL7++v2dT4dI2NfrzCmm3VwyJUuIpkO2cz+geSEyaBB9ODwObkgf
	 IKLVMVYv+ZY1ri3urzg/t/lMZ/0RjUAFkruPMRNBMrWq3pN/gOapt2vcDoPlGVqWBoWCy
	 pdSdgskZhz4KFvhFsCdN8ej4g43wvW7kkS+UmHg1vAm6lFPAwsFWxCnT3qfp0jkLmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/MZsQ+kGKXYDvCsZnOcwj4fy+FaeuGboj7mY4vsl+X8=;
	b=q4pgd4rejB3JhAx4n7LEy+f1ffI6cCUCD06C3l/5hli6z1t0ypjMdhryzRMG7zI85RF5
	 JCkGQ/86Z2G/uYMH494bxMJoVeE3Hdo8xYvrBbj6PkfOR3qxqOwqQ2ZiJXeRN1NEu6mJx
	 VDrdZ0wyMWFOL2KJA5806mWhjwRSpeau1AdxhecDs98WUAalUGRNIy4Uk3qr2Gje8JV7w
	 aJCADfnCVtVnMKSNVnnb9QColtCJ3z3qDkqbY+4bJLVgtmXuA5d71fVIbxa1VuF0nJI5g
	 JRHGLvM0vsgR95ziyfgh9RsgO824BidIj8GGgA7FC9gYi1yyG/yFDRViv0sHVt2QagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqSboKZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD91606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqSboKZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A75D1F0089F;
	Sun,  8 Nov 2026 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168709;
	bh=/MZsQ+kGKXYDvCsZnOcwj4fy+FaeuGboj7mY4vsl+X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gqSboKZmFYch23WLd9FojoKPGn30P/F82OrmjXsN0IUh6kLPSbntmObiYuO6D+/dC
	 EzYoR4aC4sydR8lfTTC6PbemzJtFnTbvR07P2dRC2fsq06pTmV6JqGPxK7SIKCDLSD
	 /DidPQV2C1wyRbSc4jOHTg0FgTCqyve7psu7ZE2igZKAKjU881aWQdZoY6WspOc/OD
	 4qjIf69buiyG4D8wQyc1TcEhy3BmRFubcrXN8JSVT4GaQw76d/1icI26rpxW0GqzAn
	 T9ZvNXyfQS4DuLdwG6GqMcAbaXerd0Y4D0QtShemmW3fGwiLUrTQ0jnDeMI3/G9yCG
	 VsovOAlXBvMTQ==
Date: Sun, 8 Nov 2026 20:11:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 28/39] iio: imu: bmi323: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108201142.688d5d07@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-28-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-28-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:46 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Also replace the two for_each_set_bit() loops over
> indio_dev->active_scan_mask with the equivalent
> iio_for_each_active_channel() helper and remove local variable
> that did not help readability.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied.

