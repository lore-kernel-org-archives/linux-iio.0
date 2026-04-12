Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31F26AE5;
	Sun, 12 Apr 2026 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775989918; cv=none; b=m0LEGd9XSsDgyR759dF3POKJnMKYSNIwIjEliNloiLPaXqrFl1C145NrAWyxjCDh2QLDx1QuzWqqg+40iN8g8NFlMmwLMxLf2cFfsJi5c4xfrxiS/RjJ7enSANcKkOuUJFwHs5O+CYnl0RwuMy1aD1LTySor0be4HMwLLEuyVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775989918; c=relaxed/simple;
	bh=88BixglnxArX6bUntpCeseJl1MafvNYfupMjNPZuIYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqyNOiozg6PTzl9tuoL6l0sA7z2ZNxYgdWhQV1L8NYz7S+YBzs7OodmbNZUoo14+Qjs78I+Di5d9yj28zBkOWBT+kaiBFbCpl+lKC9sQlvDUaMxscuaMO75f9XSBHXZvti7g+xCVwg3TKZzTkb4CnQS76uh4CmR3hOmCdxpubcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DhXGqu1E; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DhXGqu1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775989915; x=1776249115;
	bh=EigJ4dENZ2gOcfvNGk9gr6kUHQSHcJD1sW6Ib7i72yM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DhXGqu1EB908oSCxV3m9lhE0fq0uOYEGoLQkZY6wngQXy9NKFx/GhVppmzabGdZjk
	 27+t82Viav6nusTGDO598DVwBZr+VBDSRib9wu+LLbf2hWw0uDQx1uEknRXbnK5YFS
	 uMmBcFKkjvgXZErx14D1lm/dq0RGTOv2KzOuEPw8/0X7NVXad49WG52xNZ9eWMtD0q
	 5lrUsiukWs64H+diq1qnnYJXZ8NyddE3eQeXY3xsINinf8DMfjZNmCPxvtYOBfJOqT
	 xtnjnYTAXTHq+/ERn7vH/7amH+JHRx8RlM874JRoMgISXgY5Y4JHqGBYH0HoF1AeOQ
	 CJnh+0mQzwtIw==
Date: Sun, 12 Apr 2026 10:31:50 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
Message-ID: <DHR3VMPNVUYG.15X09OF3SOTSO@pm.me>
In-Reply-To: <20260410-stimulating-happy-terrier-e82dcc@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-3-hardik.phalet@pm.me> <20260410-stimulating-happy-terrier-e82dcc@quoll>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 04473d8cc5ea5bdc86829708f86ae4835e7ef19b
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 10, 2026 at 1:25 PM IST, Krzysztof Kozlowski wrote:
> On Thu, Apr 09, 2026 at 09:07:29PM +0000, Hardik Phalet wrote:
>> Add the device tree binding document for the QST QMC5883P, a 3-axis
>> anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
>> communicates over I2C. The binding exposes the required 'compatible'
>> and 'reg' properties along with an optional 'vdd-supply' for the
>> 2.5 V=E2=80=933.6 V VDD rail.
>
> Drop last sentence. We can read the diff.
>
Noted.

> ...
>
>> +properties:
>> +  compatible:
>> +    const: qst,qmc5883p
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: I2C address of the device; the default address is 0x2c=
.
>> +
>> +  vdd-supply:
>> +    description:
>> +      VDD power supply (2.5 V to 3.6 V). Powers all internal analog and
>> +      digital functional blocks.
>
> Supply should be required. Devices need them to operate.
My bad, I will fix this in the next series.

>
> Best regards,
> Krzysztof

Regards,
Hardik

