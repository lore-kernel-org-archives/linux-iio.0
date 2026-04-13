Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DF392828;
	Mon, 13 Apr 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068435; cv=none; b=MlVOPCchW8IsANqyelq8P7w3XDyiELVnNj7TlAeGkOhtwtPLOM4mj+Tlq15RwlCJToXX+BwvrW2uzpzZBYp5xqaiOeADrMBBvwKXDcYHR+ypN1T3rRk11pbe5nVqA+BHSFWYo07A8W4oZquihPDXdl1dzGfwhwTKNrbY40w9obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068435; c=relaxed/simple;
	bh=W27WMl84+IzwRaMfyrbEg3c9ya9XL0Jz/3iyZOn8Tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJMyUTV8W59z3JlJ2oKj7Ba0rEWo4hWvmodoI4YQc93FeAZTyAxIUWQaiq6zyuSwdze342lWeQQ3wy4KLSkooZOhqUngtOmONiUoSJf7mKFNQiK9mx9HSJj/c5Aazll5wzd2LkBtTvxa1guO9u7kpz18YyhZ/C1StNBpDhJLwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASYZ+7GT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASYZ+7GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67015C116C6;
	Mon, 13 Apr 2026 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776068435;
	bh=W27WMl84+IzwRaMfyrbEg3c9ya9XL0Jz/3iyZOn8Tjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASYZ+7GT2WLrYZZZsQeZsWp7/f4bqvikryjxEeszOilfha38p8drPj4Wtk3ofYgX7
	 bK0AhE9UuxrVSJT1cIuKp6zXO6krqNlbyfJGZf8533XEsIPvJ7UX8QyRvFwvHoYGDX
	 w7eRRP+PlCUY7ObyF17zuWqGMWEf1ZXwBzjIFqge7O8m5l28BAlwgaYx2wxU88ITDu
	 3SJ7eLdV/3s2Turwvg6jSEtAhUXSdxA8WBP/GJyCSNUBIf0KfsmIzakGXHVd1Cd3zX
	 xQodO/awjZ7LTaW20MB6Z7kaEuVc7gDY5BaDRg7RihrznnZpo97hg5rPKA+81avLIj
	 GXQn0SLbxdxRg==
Date: Mon, 13 Apr 2026 10:20:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marek Vasut <marex@nabladev.com>, Kael D'Alcamo <dev@kael-k.io>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: Add PixArt PAJ7620 gesture
 sensor
Message-ID: <20260413-antique-bright-gerbil-87674c@quoll>
References: <20260413000308.7618-1-sainiharpreet29.ref@yahoo.com>
 <20260413000308.7618-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413000308.7618-1-sainiharpreet29@yahoo.com>

On Sun, Apr 12, 2026 at 08:02:55PM -0400, Harpreet Saini wrote:
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> This is part 1 of a 2-patch series proposing a driver for the PixArt
> PAJ7620 gesture sensor. This patch adds the Device Tree bindings and 
> registers the "pixart" vendor prefix. The driver patch will follow in 
> a succeeding branch.

No, we do not want bindings without users. The driver patch must follow
here. We also do not work with branches, but patches on mailing list.

Please read submitting patches documents - both, so also the one in DT
binding dir.

I finished the review here.

Best regards,
Krzysztof

