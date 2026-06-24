Received: from outbound3.mail.transip.nl (outbound3.mail.transip.nl [136.144.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AA30AAA9;
	Wed, 24 Jun 2026 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274740; cv=none; b=EA46aC+VkvF1xcXtD0mAGfCP9+8+g2qd14ea279Qz34E1vEaimU/W6HW52qdsiZHM9hufLNnw/O0udtKdg3a2U/OQbEr07f4dRrdtpPAgShhPpE5IKjH5zKOl2CanEUsqSMsk9hhIU9LateYiyBWyC3WRFHJk7e4alt+HcnVSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274740; c=relaxed/simple;
	bh=rO6RDKpT6Pln80UtnYU28Pws9gouFaZKrGq0ASz37Xk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FN403ZSkM+81eja5/3VZqs55gMdJzBYPlL18nD7efTGph/kZieWWmqXk4OS1lwhjWbuHgUzbdJfNk36TVclalCF8RUw5QJkgZiC8Zy6MrMSd2hy3JyQunaBb+9mRkb2vyxvoSwRQ7xIoM9B0NzutRnDgWhDlm2r1YQCJeg5WDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=CArvr+Qx; arc=none smtp.client-ip=136.144.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="CArvr+Qx"
Received: from submission7.mail.transip.nl (unknown [10.103.8.158])
	by outbound3.mail.transip.nl (Postfix) with ESMTP id 4glTFy1bfLznJHq;
	Wed, 24 Jun 2026 06:18:46 +0200 (CEST)
Received: from transip.email (unknown [10.103.8.120])
	by submission7.mail.transip.nl (Postfix) with ESMTPA id 4glTFx55F1z3fqZNW;
	Wed, 24 Jun 2026 06:18:45 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 06:18:45 +0200
From: me@herrie.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Herman van Hazendonk
 <github.com@herrie.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Denis Ciocca <denis.ciocca@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: magnetometer: st_magn: honour
 st,fullscale-milligauss DT property
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <ajrjRdEkZAho8h1E@ashevche-desk.local>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
 <20260616-submit-iio-lsm303dlh-magn-fixes-v2-3-063edcf74e60@herrie.org>
 <20260623202916.5f5d520e@jic23-huawei>
 <ajrjRdEkZAho8h1E@ashevche-desk.local>
User-Agent: Webmail
Message-ID: <edcf262b530a88ee602fa07edc8382ac@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission7.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1782274725; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=vZzwpkr6YDR/PwERNKa7GwzN/W1k0Qr8Zoaeo1PFPLU=;
 b=CArvr+QxwZbk6ytF/lx0qeyqxldbdmsacI9/qqys06AetieBU2Wx2bSvrc/vergX2fReK4
 1NKodIFeZnOuQrKYnmsmGx/WOPghBhhz1pWm9/HMraA1039OGyiy4R6mVj3zzrUEJCTzhv
 cPfu9En219kITMKOgPTq+dfQ7ptOD5Sw03rE9Xt5HDMmOcCz/vpeWTMPHx0V4FXw5z3424
 PA2vbGVvFg4iXpQxl07Gcl3gK5GI4f25wZPDIibe9smrdVPB4stoIeifRQ1wEJDKO5vmP0
 o538zPioEM4h4iO1xj4DYgHqluFyCNhtWcj35/fiqwDZTbVRBDSvW/rjPB+MFQ==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-23 21:49, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 08:29:16PM +0100, Jonathan Cameron wrote:
>> On Tue, 16 Jun 2026 15:02:06 +0200
>> Herman van Hazendonk <github.com@herrie.org> wrote:
>> 
>> > The ST magnetometer core's common probe hardcodes fs_avl[0] -- the
>> > highest-sensitivity full-scale supported by the chip -- as the
>> > starting range. For the LSM303DLH that is +/-1.3 G; for the
>> > LSM303DLHC and LSM303DLM it is +/-2 G; for the LIS3MDL it is +/-4 G.
>> >
>> > That is the right default for "minimal noise floor at a desk", but
>> > it leaves no margin for boards that pick up appreciable DC bias from
>> > nearby PCB structures. On the HP TouchPad (apq8060 / tenderloin) the
>> > LSM303DLH magnetometer is mounted close enough to the surrounding
>> > power planes that X reads back as the chip's 0xF000 overflow
>> > sentinel (== -4096 raw, the value the chip publishes when the ADC
>> > saturates) on every sample at the chip-default range, while Y and Z
>> > fall well within the +/-1.3 G window.
>> >
>> > Parse the st,fullscale-milligauss device-tree property (documented
>> > separately in dt-bindings/iio/st,st-sensors.yaml) in the
>> > magnetometer common probe to select the initial fs_avl entry by its
>> > mg value. The DT binding pins the accepted value set per compatible
>> > via allOf/if-then enum clauses, so a malformed mg value fails
>> > dt_binding_check rather than reaching the driver. Sensors with a
>> > fixed full-scale (fs.addr == 0: LSM303AGR, LIS2MDL, IIS2MDC) have no
>> > register to switch and the property is rejected outright for them
>> > in the binding; the parse block is additionally gated on fs.addr as
>> > defence in depth against stale DTBs.
>> >
>> > Per-sensor mg ranges are listed in st_magn_sensors_settings[]. For
>> > LSM303DLH and LSM303DLHC/DLM the valid values are 1300, 1900, 2500,
>> > 4000, 4700, 5600 and 8100; for LIS3MDL, LSM9DS1-magn and LSM303C-magn
>> > they are 4000, 8000, 12000, 16000.
>> >
>> > Empirical scale sweep on the HP TouchPad confirmed that on this
>> > board any fs_avl >= 1 produces non-saturated X readings:
>> >
>> >     scale (0.001 G/LSB)  | X raw    Y raw    Z raw
>> >     --------------------+-------------------------------
>> >             1.100        | -4096    44       46    (X saturated)
>> >             0.855        |  -547    37       37    (clean)
>> >             0.670        |  -433    94      103    (clean)
>> >             0.450        |  -266    44       71    (clean)
>> >             0.400        |  -235    34       65    (clean)
>> >             0.330        |  -196    27       56    (clean)
>> >             0.230        |  -145    15       40    (clean)
>> >
>> > 2500 mg is the natural choice for tenderloin: comfortably outside
>> > the saturation regime while keeping useful precision for compass
>> > applications.
>> >
>> > Assisted-by: Claude:claude-opus-4-7 sparse smatch clang-analyzer coccinelle checkpatch
>> > Assisted-by: Sashiko:claude-opus-4-7
>> Hmm. First time I remember seeing Sashiko credited like this. Seems 
>> like pretty much
>> every patch series of any complexity would end up crediting sashiko.
>> Out of curiosity were you just looking at reports, or were you running 
>> it locally to
>> help with development?
> 
> I believe it's the second one, because LKML version uses Gemini (as far 
> as I
> understand the case). At least that's why I haven't commented on this 
> tag.
I have the whole toolchain running locally to avoid too many submissions 
and
feedback from Sashiko with Gemini after submitting. For small drivers I 
can run
Gemini locally as well, usually stick with Claude Opus 4.7 since that's 
what I
have a subscription for. For very complicated and large drivers Claude 
Opus
tends to time out even with 1 or 2 hour, so I fall back to Claude Haiku 
4.5
(which catches quite a few things, but is not as thorough as Opus or 
Gemini).

Seeing Sashiko tends to provide different feedback on different rounds, 
I try
to only submit when Sashiko and all others are clean.

Hope this clarifies!

Herman
