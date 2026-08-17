Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F132B135;
	Mon, 17 Aug 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950139; cv=none; b=X6cOZ3erIE8xZGHkF7JD7mfiF4mXl6tZIJfVBK4X6EoZhFc0tmw3zSg0OCboeXh8AjVL/twmv+ydOli+q34BN1n1Ol+bRJwUUv/mrLaNXXD54FLkHhBGRqd6lxpaHxZQMmycv4TgkmrCbV29kxTeXKOVJYo2kY2dV+iJjqOPCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950139; c=relaxed/simple;
	bh=fQKbD2lHIPLP03+uwtqPCJtAobJ0HwhmQxlf0gGePxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C52a+p3W0jpSHzC9eRnVMObcHujh61GKLzdXHofYH2/3VEouaMhNwzUsy9u/dMDk08Vkm85yMfcrJON5f4tlP7TgKGdQeNpx00yFoF8zN1ReL3klsWjX2yvx2CXTPOnAzuJazCW+z0XaABI+6c46roRYa9QTYimdsVUef+qrsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKoDy8Zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKoDy8Zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3667A1F000E9;
	Mon, 17 Aug 2026 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786950138;
	bh=Xrz4P9LZIvM6r5UqyozCQv2sifV35c/noV8scVQDuzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKoDy8ZvEN9LF+ZNsGefzwNX1jSnZyY4JkVxuxwU/NqpRVmpt5n6UQb09s3uciSZ2
	 gvFcMWlNZvLl4byPkrfIMx9XP2+6A98JS8Y/Iirw2OiKohClMp4YPbmdV9ZzYMPVtT
	 mSnL1ZoGf/tynMBMVQE7nkXKLuAW1dgTe7U3BGS3sRFaHWDjnLfN618OvbRRhNxWtj
	 NN+wU3OoUxqTl/OD+0n7GBk+hrAu96uy2ZfBZ/sWrICuJbJGyABSzqiQSR6kr4IxTb
	 jPI2dA2mNScgf7iPXF3Ez6MmGTLhNzG0SofBZiS8NJRW6T2Lfb2tD0pJcIQfCblZQ5
	 UNB143xcn8skQ==
Date: Mon, 17 Aug 2026 09:02:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 1/2] dt-bindings: trivial-devices: add Aosong AM2315
 and AM2320 chips
Message-ID: <20260817-bouncy-tarantula-of-reading-42c316@quoll>
References: <cover.1786725567.git.nico.antinori.7@gmail.com>
 <cf3671822902e82c133563e2169334dd8c41ceb1.1786725567.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cf3671822902e82c133563e2169334dd8c41ceb1.1786725567.git.nico.antinori.7@gmail.com>

On Fri, Aug 14, 2026 at 02:50:19PM -0300, Nicol=C3=A1s Antinori wrote:
> Aosong AM2315 and AM2320 are temperature and humidity sensors that do
> not require configuration.
>=20
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

