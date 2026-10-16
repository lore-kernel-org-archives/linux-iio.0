Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86D3DFC99
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184494; cv=none; b=dXaX+lIQAYflkh+Iv4yMO1VxJj3gG3IZd0k/otAcnukIEGYUjajhIl3OxPx3swAj8q6/hYnmn7l0idtnQkFObvOParmf5yXzLeHo28Ov93zocjZoM61QcW/uiZJIYvEsBMvNLQ64Hm5q8XbXM7yS9HGSmZI4dyk+qwL3lbU34w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184494; c=relaxed/simple;
	bh=x84aPTx8609GVu9kidYl7vrHKXVzx1OJjssGI8EzzJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It5b/+uPt0WlxdC9WAN3SdDk14vRzOwuQjChgsU3e86CPg5xTrXnNcG+4MksEwUsKeGgTphL81yBbZFwATnjnmLVeBb53+CI3BfITLa+NeFMl6W/6TE4dGgpdES3aiX435XUVRTAlln95NZHcXI7X0wMLACsjKrrtRbHkjJZNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQIdYXNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQIdYXNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDA1F000CC
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792184493;
	bh=Q3xG/vQ/oHvjXvJdtmtHwaYrf3UPIKtY4II7aIFXNyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JQIdYXNAJpbOnKH+UIdoqS3ZvSD3gjaZhJstTurUGZgal+yb00XIAuzJvDFJwiNTI
	 ytm+Zm0SR+6HYMwgo91bpC97Ae7q2VwEVSoRQnbZLR85DXI6tk8eoS7q6y/6JAnkiL
	 AjNuEVmiA8d/WWRw0UYGHX+59g2igBu7hOnaLN0RNVihDil3vvuCgcQp5DksrdtVxD
	 aenroIN7NCV12CdEGtZbo9et55CrZdi/TcJ8/G7AAlhoOgxL19rUEfMKnQB24zuOqL
	 YLVUeyk9g7eCIl+IHuKJoNDGGMxf0cLRYnSrcupvfV/4fFQMJ7dU61oCkqi6gLPTYN
	 SsPuMLRfNipow==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so1681051fa.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 14:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5b29W6pK1mgQkAoIvrsnRWA0iw7VlvWSxL2hYl4y1CSxOBeQ7KIAxFTw1x5/bKT0bNeCo/jz2mUE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVaJauQdaL9Zaf28NJGykCfLA4yfxSuWZHMjaTrTqes8gHSava
	AovVG24Xw0QxupVJPecjdB0n31BTMFThU9cC9d78W89FeHF+GtQamuioSGQP7KN0goYCxl1tjng
	3DT0+P0MUfpfNacCsNfHT0NoJl0UnrJA=
X-Received: by 2002:a2e:be08:0:b0:3a9:9b66:c5fb with SMTP id
 38308e7fff4ca-3ab2940bda6mr2317381fa.29.1792184491585; Fri, 16 Oct 2026
 14:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com> <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
In-Reply-To: <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 23:01:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLkSjbMRV_53rjpd1D+vxg=OVVWzVwiddUL0eqmSBoONHw@mail.gmail.com>
X-Gm-Features: AclHuK_-uCiG2lo-MUzDBEEJ29WextQc6K-sVKLlU4i1vx2eSoj4AmldZKoXnFQ
Message-ID: <CAD++jLkSjbMRV_53rjpd1D+vxg=OVVWzVwiddUL0eqmSBoONHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: light: Update DT bindings for GP2AP002
To: Christoph Rudorff <chris@rudorff.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

thanks for your patch!

On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Christoph Rudorff <chris@rudorff.co=
m> wrote:

> +  vled-supply:
> +    description: LED power supply a phandle to a regulator

What datasheet is this from?

My datasheet for the GP2AP002S00F clearly has only
VIO and VCC, enjoy:
https://dflund.se/~triad/krad/GP2AP002S00F.pdf

There is however two *outputs* from the GP2AP002S00F
called LEDA and LEDC.

These read "LED Anode" and "LED Cathode" and is where
the IR LED is supposed to be connected.

I'm just puzzled by this patch.

Yours,
Linus Walleij
