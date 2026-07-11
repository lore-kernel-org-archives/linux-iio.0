Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4B25B0B6;
	Sat, 11 Jul 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771705; cv=none; b=ILSVez25a6hh8or4EGOO1mL81QkFRaQhdxTFKg8cnVAh/O9pi5islxTPlHsyDfQWelxImNngoDq6fnfFTCXZs836U9gR48iZI0rkBQvg1N7h4pbyjMNYNhExU+VlFTIvbBJpPKedkA5fj2bmFJ1vQeLxIzwzHft3iSu98yqRYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771705; c=relaxed/simple;
	bh=DixWUX7W0Hz6Lr9CTdNnhKLmPtnFbPV8w5I7pDJW9Uo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XFBRp9sHAVtitGQi2E2ok/48qAZsGBS1N4pJc3gumh6lBWGk+yl4at0IOwTGutE+jgW5ziUyx71rT2t/15IjoGvTfX7jBW2jsM/B+hxw+JhLJ1LB9cd9QOjyRqAKg4IXwmRkOB+Uu2glZott2EHGKCZEb2Uv4DN04djbPYGqp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+SBJb2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+SBJb2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5624E1F000E9;
	Sat, 11 Jul 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771704;
	bh=DixWUX7W0Hz6Lr9CTdNnhKLmPtnFbPV8w5I7pDJW9Uo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=L+SBJb2tRu2Eb34agpILCqanwCju16HbaGvLvCvCBx6ksszn9mi9RqZqA64NJ8Zyy
	 22FOefYHR8tw9gOiBfEo10uZOFClzjh5jWucDnuN8bNnsraxKnOFaAZnir22R/tgnH
	 dNoJ6o0JnW9eNeRHY/Emlqb7j/UdBLYD/Gp5h8RCiPSkQzpz7vmfDkS/Ph3gI9jjBH
	 d50rdJqNBreW2mG+PHHvlpoIAyA1weECyuyNeUijZvJ9zz01zstaKsdM3Cc9UUntD2
	 rC9pMl0sm3L/NQvN8DqRVZIRdVwFwU1Xg0pgLlRAi9O4D9oN8sXrBfAMCObN/Ime+e
	 +s+E36zAJr7Yg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:08:20 +0200
Message-Id: <DJVQAMP6ZPH2.1X68IDVBOMXGQ@kernel.org>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
Cc: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <andi.shyti@kernel.org>, <wsa+renesas@sang-engineering.com>,
 <ojeda@kernel.org>, <igor.korotin@linux.dev>, <branstj@gmail.com>
To: "Muchamad Coirul Anwar" <muchamadcoirulanwar@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
In-Reply-To: <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>

On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {

Independent from [1], this must not be implemented for any DeviceContext. I=
/O
operations require at least the Bound the device context.

[1 https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/]
