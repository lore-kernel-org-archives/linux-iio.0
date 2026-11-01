Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560681;
	b=DxwJMdMN9We43xNrZF8mlVlkqjyw0gRLEQRvrYcuXWXNHvQBnqho/v3cGyNNF9o2+fVD
	 PCOd7EgNvt1ATEJBYP6mVB3u+w07oHAB/tInuV89lk81xiYiXfLwKLP/YLs8fcnhsyIGD
	 ZuVt704Rs66ph97ZYK2KngaikIY3cJMsG73wUlQbr736YgvCAho0llT7bDjtQmBzAOkVJ
	 ir6v7NnRKFXXiYK5MfBIidr/0z2DPFYsmlUIjrCxi0rm7L20eYTfenlP1COFzodwageBr
	 sydHFMrKpRDnVLC1nalkdD5L7sltsWzfMjwjtkieUfvVHX0nZfSxZdmMDQxpUbelTHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560681;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yEqKod88tqMy3KzFL4t3QWyjMbsr/PQ8POnOuuG0bkg=;
	b=W2vKkOg9ef8pF2Z42dRXjHFCyZUk7HRXKuytTir3IHfsTDypGAmjlMts7W3CBtJCANcu
	 lGTsghP59qXIFV8S2uhMrFfMp0vyDH88xATSEHsS+hTJyIs8IPfXhATwEVc4eRjko7Jvv
	 gOvMJMYe4GBWG5gRSxxubKFp+t0Fb8jee9m9eh0sCqM4BZE5szuRPYFCGAuNjFhyk6fgO
	 rsFp+uEFMqJc1tsbLk9MooJd6ImxdMv6WWDHd2z3FjsSGuOth+kDj2BVj6ttN8etirVw4
	 66fn2uR6AW9mVhdN/58EUkpdMKI90rI1bDWwuraInAenh/TRab9J2Q9Ncq3QIxIcYDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIfWmYsU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45D606A324;
	Sun,  1 Nov 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIfWmYsU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFB11F000C1;
	Sun,  1 Nov 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793560680;
	bh=yEqKod88tqMy3KzFL4t3QWyjMbsr/PQ8POnOuuG0bkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JIfWmYsUZMvzn5iijai7F6bLBXq0WatyKlJKaabq45GXAv7WKIt1txG51TH4jplA1
	 +3e1LJ3ncfqhKuWK0SE0jExv8lHX15hjIksOec2EPG/M0hE+IYNrJFuKDYAq6xW8bo
	 sCR3Vbog+9L3Iy6j7aDVB6SmMz8Smc9/jiHbxCCKXUbcdtUovRdpSKD5Hr2NsAXQ7o
	 ppumkq1c6AS6IfjezF0R2eba+QG5wLbhjhKlPghz+sT4QOtKNr6xCEIkA+9srTfCJv
	 xlbKhAZjLF3zxph7Tx5stx/jkGV9hxeG5HIiqDeAEkck0fQQJSESjGoWhvbvQQXEPE
	 wsJhuS8nzP5dw==
Date: Sun, 1 Nov 2026 19:17:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 0/6] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Message-ID: <20261101191754.32626b67@jic23-hlaptop>
In-Reply-To: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
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

On Mon, 26 Oct 2026 08:54:04 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
> notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
> It then moves the IIO core fixed-point parser over to kstrtodec64(), so
> every IIO channel attribute written through iio_write_channel_info()
> accepts that format as well.
This seems to be coming together and from IIO point of view I'm more
than happy to leave you and Andy to hash out remaining details.

Thanks,

Jonathan
