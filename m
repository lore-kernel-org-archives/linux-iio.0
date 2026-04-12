Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D83115A5;
	Sun, 12 Apr 2026 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775989972; cv=none; b=U4rxxC1yAnq95q+cY3XGV6xCu2tS64/Glcj3ZqReQEGjbjHMT42P+dggv3zLcwqjDtoQfembTUpXiH0grjvxtR+1a9914ZR2cIJPPZB/tzTdHZuEoQcwffyplnLKWbN+OjOmuK3ejeNolPuRHgEFXJ6ppb8LG1NLugs0nRkLbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775989972; c=relaxed/simple;
	bh=wk3BGoyGsAECEZxkOI66VMDkKXo75IFkm+llSwg5bbg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9/ONArxGf5D775fRQaP+1sNPUcWrNqKtVOh55kwv77c0TMS6kTzEPUEael/UXLdoqfTmpjUTZgKhHevZ8YnR+IRwygfXkdBs4HK0fJFc7kWsCBE2aTM1K+vMbYghDJbyNLsG7ClBjgjlR0JopPnJD/UQkNJrEhPCMYNaTao4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VEuc5Vba; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VEuc5Vba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775989968; x=1776249168;
	bh=ZpyE16O6h/+S2BzxiY/C+GAig9raTkBCi6nBpgcS+NE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VEuc5VbaM7YzUCRyT4BBbrl9ZlBGo7r03lmJCc+mW8fubSlfKijxyzQpPuzg14EjU
	 Pc+oWqo+ulLEdY2wON7Vc44/Txd1Zm0VTG3SR7/zNTHJU6y0mIcPup6LUmmgpq3IIX
	 1eLRUhhN1kFb78LIWJM1K4IMWmUtxL2a1Tfnn/q92ykkixAiJuw6WlXGZx0acmECkB
	 cwC/Tv+D2Ps5kIlg3/drjh92juYV3at7JTc55I3xtnldeleLYXv/QXoHFpC7FioB+6
	 LKWKmpamSv2WLMXNoTkctCYgfbtG1CpuU23ngU8pcjGGTmU6jodTRoWddzGDAAGvY7
	 2d+Jwg6mOOvJA==
Date: Sun, 12 Apr 2026 10:32:42 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
Message-ID: <DHR3W9Z5WF2S.2SDGFQZ6KJJCI@pm.me>
In-Reply-To: <20260410-deft-mottled-petrel-fa22bf@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-3-hardik.phalet@pm.me> <20260410-stimulating-happy-terrier-e82dcc@quoll> <20260410-deft-mottled-petrel-fa22bf@quoll>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: a0398ca5ee1b09d902942e2e940f13a00d864201
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 10, 2026 at 1:36 PM IST, Krzysztof Kozlowski wrote:
> On Fri, Apr 10, 2026 at 09:55:24AM +0200, Krzysztof Kozlowski wrote:
>> On Thu, Apr 09, 2026 at 09:07:29PM +0000, Hardik Phalet wrote:
>> > Add the device tree binding document for the QST QMC5883P, a 3-axis
>> > anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
>> > communicates over I2C. The binding exposes the required 'compatible'
>> > and 'reg' properties along with an optional 'vdd-supply' for the
>> > 2.5 V=E2=80=933.6 V VDD rail.
>>
>> Drop last sentence. We can read the diff.
>>
>> ...
>>
>> > +properties:
>> > +  compatible:
>> > +    const: qst,qmc5883p
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +    description: I2C address of the device; the default address is 0x=
2c.
>> > +
>> > +  vdd-supply:
>> > +    description:
>> > +      VDD power supply (2.5 V to 3.6 V). Powers all internal analog a=
nd
>> > +      digital functional blocks.
>>
>> Supply should be required. Devices need them to operate.
>
> Ah, and since I expect new version, also:
>
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18
Noted. Thanks for sharing the link.

>
> Best regards,
> Krzysztof

Regards,
Hardik

