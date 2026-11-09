Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216088;
	b=EA2/i2zrzwz80re3fbL32TYR6nFgvZPqjm5ahN8kcmhK/Rjtz6x/7VsTBugTsLqFa+GY
	 7Mzh8SJhzKxrghfjHmSJaHfiBxMkbU0IDlNaIVgoNYJzU7UIcpy+q9Z5uz1YhGqDpugSQ
	 ZGHbE7ZvGT9ORozQ/s1/4c2FIr70947bFDT89QeDhmxmwvBKa2T6U0teAxmVEEyRtFUE6
	 oq232/TBDbiB4jVUz6grpWY68vdHvdHE+fDA7HAwPXK1cCW7A4WehxcehdhmldBqytyRq
	 YUfCcVlJGqzvaXHqpIlCm27xSY+qDfL37ee9SWfobVQ5t9nCBnUHW+m1EjYgqV5jgag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dmz1IxPhEUTn+emB1TXocVS8QI38hBL9NaVv40544gM=;
	b=mKpmBfdKzC1E17MMXij6uEOWvJG33OWhFAhy5yxCZf5jm5Z8ovGVKANZa9QVxnd/QEnW
	 RLldd+OUAI+hl05K8RDVG+DPDkTulqukQg1nENm9GQDNgyca0mu/C0YhCW03lFy02wEdk
	 xHoAXFIjkBjOzmnv2OOViK05YEwnCYvEPzBmbmWldmxly0HTwCJk+8d3kszDuQislCu+h
	 5FfkOicN4OUQqMnNrCMqJR+OmNcmDGVU/i/WSpDmy9BrE62kXOZXc/oGpoNxeMMAShztL
	 9RCLAAePkN7c3AHBZkwsfApxkvW1mRITLooLBkk9CTjr1lb81HbXWP7+t7XHw066XLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvDL6rFn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FC606A31C;
	Mon,  9 Nov 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvDL6rFn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216087;
	b=mKkXy9f1L59BG4i9Z4sil2CRBc1iWRhFHqT7lga8T5x5kMmhYrkcex/ynDJo7r5pN5AK
	 mjBp5CZ7a8n4+41pxr/MlyUtbuY8009V1PQ8yok5AH2R/aX4ckUTmcSmymuA5ISXD4dwp
	 10LK4AHZa3z9vMhiDs6Iy1oVtd9JMaPj3y1xfnXq2a4xbpZ4wDppmmkGAcRkVTQeUWNiS
	 xzKWpRxuRZwC/LR9CS4gBGuoXpp6U9nFaJahfIGm0CS1R3i2ZgogFygqu85ailk4QWGsT
	 L/OnNZfS+ou8ZxmtDUpuy8fxoU9YKaqfIt/W/5hxBgcd4WiECEZEJxsr7RYRuhCS7oQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216087;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dmz1IxPhEUTn+emB1TXocVS8QI38hBL9NaVv40544gM=;
	b=C8EnBIqqc+kfen0d5Fh6tPNoT7ELd63lmIm40M+Co0990UQang6nLgVzr016L9xcmBAq
	 gUAEZqVuvhgJgcf5yMXWTpznxvU3tBxc07PL8iIN8/HS0aIEZf9Q+4aEnEBW5nG7LL2sa
	 9pc1t4skGqrA94tKUipD1fjEsDPdZR88gydGZ9mITfukHBHp1ybnmiy+M/1V2hVNpIziP
	 n9OQscb+ysfufcVewrOfho7L79bNQTtOC7J8lRdtCp3Q77QqY+/pPwNht5DtvZZW/uOPl
	 Klf/6T8Pbf9qJzWbw0QZYogoqyuPXZEuHFfntsba970j07exUJLHBtet4uEjOnsjB4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 545CD1F008A5;
	Mon,  9 Nov 2026 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216087;
	bh=dmz1IxPhEUTn+emB1TXocVS8QI38hBL9NaVv40544gM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EvDL6rFnM0wUURkvzKD9+NykYX4TGthpWGaJuD9CzQTYKnvP7/1dJyuJbZ8OoH5LM
	 Mw/+luzKEAXnrSS87N3gjuo7wg+j0Zfhohv3Jo8QC9vWenQC0eBqDp2jj6B+r7qfTX
	 Ar7SafpDsi+6Gln8dGGjVLI6Qs0Mpk/udlq23coEibmrdv8vvM2t+30tvrT1Lw0nu6
	 Ectvq/Spb4a0jazSzjIQHRw4AgKN0iUqhId+bsGO5Djz7fT2tBRHpZiwi66T7hsVYw
	 PA33teAUJhC6CGQ7aw7NqkpMTvuMLV3tKtuzgqSr9+gvnKiYge+6U7HZIq4Mg2FAaG
	 zHf8NU0Y9XmsA==
Date: Mon, 9 Nov 2026 10:21:20 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: light: gp2ap020a00f: Enable the VCC supply
Message-ID: <20261109102120.00006301@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-3-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
	<20261108-gp2ap030-v2-3-24eaa1b9fe59@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Sun, 08 Nov 2026 22:44:01 +0100
Linus Walleij <linusw@kernel.org> wrote:

> Enable the VCC supply before accessing the device. Use the managed
> helper so it is disabled on probe failure and removal. Let the regulator
> framework provide a dummy regulator for an unspecified supply, and
> propagate errors, including deferred probe.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
