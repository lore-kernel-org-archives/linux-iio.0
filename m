Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216853;
	b=KeJK49/oQQrfAR1d3i5zeG0eFqzEslRVPcJuiDdcVG52raMVjcToqDMoIX92buK/4rBG
	 GGBg3XDIWil5sSfo4ndyYfjiMut9iA1HfDREso4o1UcIK65Y7n/nCac2EB8RPTh3XRqju
	 Lza+3SapwSyQAOMCDeC9064u3Is1FrL3L6LHwLa9C/4iCF7m3L1ADqjP794IVfEeyf7vl
	 uqj3/dTog8C7cvtg128sh9VHaJ9450I/LnqnaqoGFsYpbd8AwtCywO0dThT9jpPcrYc5T
	 hDcc6VJVM5RHm62yMXn17/vzzHskt1eZ+YLVb2cjmQv3fE3KWdLZ9P86sGPSGj4B1LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216853;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/2TSwr5Ws04kwWFHYd/kmVLZ1VCqBmMqj6jylfx1BQQ=;
	b=dBRSxLfazzeSvwGdRz6TJjMGrBK1PjeDcnvxvjAtXv8o7xwhGXsaH0fS08k8yINN2D8G
	 yeFM58uuLyohJnu0RDVzkRDZKnTtHpLYT1UDIViWiK6SJpmKUrjteeGBEaYbkhh6IqFFQ
	 nYA+RwwcvCTz5Uu7OAvplTety+aCOel5CBBz+S8UOW+NsxO8B2H7X/bSGHRaqHzKtaf0J
	 uivqo/6DM8cGzOjYwRqQQ/nPF4Qtg6sHccoT+NA5IoroWHRkLFPTGRgaVKZh2YfUk/UCT
	 FzuAbP2aluTjz9NPfimRMBMfE8CoI7w6PXsIer7JzddvJIN1i5nFVALouAn4QR+qrOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA2isnI+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F7606A31C;
	Mon,  9 Nov 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA2isnI+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216852;
	b=Nf4NjO01Ju6q/aK/HDEXbisWLhi9YaZXCiEd6pZqObxpmwaOMdWbqiG94gyQE3UnZa+6
	 58sK50M1HQm9D0ukFXG2HzqkxfPX8H6HYeME6xSIi4HVVbgvdGMHa68b0r0oYc0up2xA5
	 pWpG1GOG67TST8hUNq1CtUF0HOm+9emk4KSsZ0r2SH4sdbMlBYAFkJvzG/lNV0B+M3aA1
	 USqpzXGtyGB4jjveZSfvnWKcNBye33MNy7GbYlaSWFz96vsIOckwnup4cZNygFJgZ6oKU
	 q98LmYq5YcxI+O0EwBuv6+OYdZD0q6W/Cmvtz8HgaJ9An03JJpCqd6rvYJl3EuHLuAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216852;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/2TSwr5Ws04kwWFHYd/kmVLZ1VCqBmMqj6jylfx1BQQ=;
	b=0LzPfjO6Zs3qApu/XNDx2f2xCKVj1ePCE90YEXr6/UZDXg57DUcT7rvBCFzvky4Yu0ui
	 SfyRCzFDtJ5yumMbR54fa8CgD5wRsrSeSYNgxnURhvuZZ+VanENnj1RntJ34ebldgRIwU
	 g5jMzJ7nfTBwex0X9bGaB7MYRUCqJY5GtTaP2YdBCscjOdJHDFxv3oPeztL+gyTMaEGnP
	 HNPludAgpJQxoQTdRV6F8/VZNc+7Dv1Os8mHdKNi/SZrV9/eD1zSgO8IVhvNTzEajOIcB
	 RlLWgjK4pEKlgxmhB9iHLfsreQ4Sjali2mKZahlRoPkjXDzisD10UOPiZ2+VKwEHhMg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E51F008A2;
	Mon,  9 Nov 2026 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216852;
	bh=/2TSwr5Ws04kwWFHYd/kmVLZ1VCqBmMqj6jylfx1BQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HA2isnI+HMsi6vJeaASJxpAqyQb3rOIgQN0zuYRGpy6UeLEmV1WnqBGKJkHwllEg0
	 jGanu4nxhqGjxUlsmToMuunR/KNloVXW7kgUBdh0qgJ+TAdb9+eMGATut9WqEHep0u
	 sAySWgrb4HQf/vXi18AyfkdJmnTC51Ehx/p4azFGL9DBQ24ULozXYgd6wm39OIACtF
	 Mkk4wZMSFp6kDSRHTedujVrfUECl8TvtnbNzjsLx88ZO+PGM8gJI85UfgsCj9GA+r8
	 rcXQYb5modOzNvBnKdAy7pgQ2OSDV6EyP8uzWbIzhHq7dxRppjj6gTjtUVFZzn5t+P
	 GFsPI1ZSorVow==
Date: Mon, 9 Nov 2026 10:34:04 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: adux1020: use guard() to simplify lock
 handling
Message-ID: <20261109103404.00006e3c@kernel.org>
In-Reply-To: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
References: <20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com>
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

On Sun, 08 Nov 2026 20:16:13 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> Use guard(mutex) in adux1020_read_raw(), adux1020_write_raw() and
> adux1020_write_event_config() so the lock is released automatically on
> return. This allows returning directly instead of jumping to a common
> unlock label, and lets adux1020_write_raw() drop its ret variable.
> 
> No functional change intended.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20261107222957.5332237b@jic23-hlaptop/

Not sure if the link is necessary, but can be dropped later.

But looks good to me!

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
