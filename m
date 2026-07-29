Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC4347FEC;
	Wed, 29 Jul 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345986; cv=none; b=DIy9kEGpCKt95Va88pmvsUp8SPWDDWpLpQ4KUGhumxLux5dONDccE4jOIyaAGNec8yobeJeB06+xkFHXvZ0cCx9/ttprnZQyX26JGkzlkhHZPAqr+cdxN1TDL0rQ4ys8aO+fBKGMyTrhnzYC6MfCEUavE88Byrwyqf/0VtUenuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345986; c=relaxed/simple;
	bh=nMjFaRoJNGnbz+t5zveKj4iOLSf/Wb8jM6TD9XURS+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jo2ronRGMfIlxXXGXlaOAqUCCyGJmLN92yUnwxgHSybtIaG/4b0EiZTtkuCGU6BbuuCSMBLSNI7RfF29nOaSCDmGE4JO+/2QGct6G4h0zwOe4LSBGiF3z+qU4y0xszjDCOcanxhu3x0qJ+i1igNNfiZbm0kpKL6xBaT3j1fD3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PsV07Bat; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PsV07Bat"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5516D9D7AF;
	Wed, 29 Jul 2026 19:26:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwPuHWlpuxWt; Wed, 29 Jul 2026 19:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785345980; bh=nMjFaRoJNGnbz+t5zveKj4iOLSf/Wb8jM6TD9XURS+Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=PsV07BatffL5jN3ImqbbcQv+gur5q/xysu6e5JICwMI9lxzOvSI9sCAnqiZDA7QVT
	 mPkbxMsSjpCE8PgzaamveMgcSu2pGBcQKiFCQK7lhxICTjuLPMlXX7f+DuERrWhB/I
	 WU3KR30ZAnEVnwMIboFqSPZuXmYqka4DutprVZ42NCi7g8w+oN0W04f2Ly1ul5fQW2
	 I5Fzs5skSlgupEx4jRX5z7+UHcjONQATcj1ui0fLwuIOnVhzw8TNino8U05W6LfFMT
	 3r9wNwBcZ1YhChkCUgdA+NRVCb7VyWBV39o7avsjXGKfHUerm4lBc8vIRNsLzeQtUF
	 yfKpi6wGkGD+g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 22:56:07 +0530
Message-Id: <DKB8BQP42BAT.3TZICIQBS85Z3@disroot.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org>
 <20260723-gp2ap070s-v1-1-b8ca3a4c10dd@disroot.org>
 <20260723234751.5ff138bd@systembl0wer>
In-Reply-To: <20260723234751.5ff138bd@systembl0wer>

On 2026-07-23 23:47 +02:00, Joshua Crofts wrote:
> On Thu, 23 Jul 2026 22:58:33 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>
>> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
>> Corporation. Unlike the other GP2AP* schemas, this is strictly a
>> proximity sensor and NOT an ambient light sensor.
>>=20
>> For power supplies, it expects two voltage supplies, one for core and
>> other for driving the infrared LED which is used to measure proximity
>> distance.
>>=20
>> This chip has been used in production mobile devices such as the Samsung
>> Galaxy J6.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>
> ...
>
>> +  vdd-supply:
>> +    description: Voltage supply for the internal circuitry
>> +
>> +  vled-supply:
>> +    description: Voltage supply for the IR LED
>> +
>> +  proximity-near-level: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>
> vdd-supply and vled-supply are definitely required.

Only marking vdd-supply as required as some chips are able to draw LED
power from vdd-supply instead of its own regulator.
