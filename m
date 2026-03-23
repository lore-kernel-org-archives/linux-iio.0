Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A11B424F
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301993; cv=pass; b=fBKPFnJZFdgIflpz7vMV4y9NtyaQbYTlBp8JYCkYERwHTWRPRvGh/Z/ZR9Culh2xD1FQFQhZm9XyrtYZrJBUEj/CBv8PTn+gUrNpqWlkBpzYkqz00qCcrwjYIYGIqTrLCw3BXiQ8kmhPBeC3lRNRi4bXId6uj/s/VtfffG7lnqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301993; c=relaxed/simple;
	bh=6yc22CdzcKPHhtv1K0lLqEnKtQNK1gApls0Ms/xK9XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkCwX3gL7HpLTh5bBJM8ghdhwm2duiWfMmnho+4+MMQ0FhC9kvCgkMmE/aqSMh2SM2pkZ1huMU3cNtf+IHpGWPys3SqLiOoM5HAj8AsqOc+ZexL7e1ln4VZr28+zRODKfdCb5PurxGneqagRtiK32Dwy7QczhRgW0dAe3EPswB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=atGnjibS; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="atGnjibS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04b4974abso6093745ad.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 14:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774301991; cv=none;
        d=google.com; s=arc-20240605;
        b=GEpzi8mZrOZQCpL1kBM63qd7mYjGhgKy4mmw9GcuTG/BaFVXXCr0F9PpCDe3SW/4+T
         NNOIyHxHtU88whwRF2dWXLWt8rLVxRR6ChQbLnTy6/olU6M31121ujqRRwTXtS+eDt8i
         Pzz5U9pABd2i/eM77eSq7uO5iEZro8SfkCxGiBJWuWjyAlcm/xGoOH+7sis1Q32YLJrb
         awXGfdtHqPP0cNcnyUJ0v0EJXGQ3CHDqX7xup0yqFTJitDxP5c7No8RpKBVlAMrNvnF+
         dILd7uPeftQNQTBffsSWcq3SBD29rLio7PuogcwyHwRLPBCIiH7dbIMjLAnW5UqVByCI
         FeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yc22CdzcKPHhtv1K0lLqEnKtQNK1gApls0Ms/xK9XA=;
        fh=ZdMT2pq0WvrsgSaeOAsVrT+3iYQ3g2oGpUDrQk7/crA=;
        b=AwjWZlNtQ0GqZhXvx5/GY8zXqZvN8MkCkAOuzPxXd6+s3MC8DvbGW1pwDraaNSph9f
         JwcQ5caIYoprHhJJT80HUebsCH6zIlWc/t9iTD/C5ZGxthTfh0X8vYqe139bR43sfPxi
         ghnw33Gv3UpakNBKSdNsUC1ZOc1tDSqjs6hFDJ1rzWcZSkCvocelUiccTCg9Q0bWwv00
         afGgFmH+g7GGvI5YWGoTr0w4bJYhdAYefLmQXk79v95DSUWBo5anaaPWQPLXX9xO0AXm
         sipBAWOiayXKS7g965ZIcoeP138UMj/fBRa9RsDFYDNH9uGWq3j06dRtnmr8W/p6mkoS
         v1lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774301991; x=1774906791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yc22CdzcKPHhtv1K0lLqEnKtQNK1gApls0Ms/xK9XA=;
        b=atGnjibSaBMp8wtZ/QqcPP5ZUeIrx28FZNVoFZ5jjiwM9XhqMJH21XzLSPbC4m6WtE
         E5yI/ekHSPE81NeTJ7kGvo4eYuj4S68c8d8Bk1OtTBM7Xv0V/RkWm0Cwey//KU4p+THw
         wSWfNVnns3elZxa3zmNPmB+KRjFRMsSkSzOM7+JIghxCthFNUPaGTwgyIw6NjsvgC9+S
         sJwlyJhmjobg3RP0TnC8rkJSBbkt9nhOz/UvhMxz6JGewyamgNi6nXcG3jPXYa6TCxSk
         N8xnjfRAh+CPUGGjbQtdN6h+SjoEAX8XheIcUF87WCCGCvIRvnkgLr61QKHY08btOhqI
         2FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301991; x=1774906791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yc22CdzcKPHhtv1K0lLqEnKtQNK1gApls0Ms/xK9XA=;
        b=Vgo+Is5FtGu4OJYMnBdgdy1iwEbAE9T5W23OEIRTS67dmBvcyC+Aarzi97QYvJAzWl
         R9qxCivDEu+mfbwqUPRz8oAsh/qhGyFezO1/KBsCzZxd+I/35PzOtEEY1VriL0UrUZSL
         b+xEoGe48dDZCXdjrH2ioR8ePfI3LNmr+NKWTQFDcNeHORfGfq7d5YtZfr+y5fAG7Adb
         dBUO3V+/wrJOziUERbf7CRgtC3Awo8Zh1xRydnqlPOSokr93q9rLeQd5nzpctpbDb0Ap
         6A3lTfpkgAlGErDKrOOyasmB37xF0gQP24Fv8UYtsHz1VfU+eyLzWSw164CZzJLbcGR1
         DE6w==
X-Forwarded-Encrypted: i=1; AJvYcCWgZNt+vHiyDx/IYf3/nlUyYZ45zknFqc8fEoHwJKk19hDgo/In+9n20AD/n7ztZKlv5oFR5JxiRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGzOUlJipG0Or9rdqBDUF04Cs9o6ypeSmmE8UdkmxUzG4Suct
	J9miCICRXNmLAUHpcYI3Vthjh/K+npQQcKskTmjI6IWEtUtkZxLtX5u0oBBqWI2jOy6QgE4RJyH
	tLSq6p0TcY6CXvH68yuicxIX2cxlGi+eUsArT
X-Gm-Gg: ATEYQzzpWOq/CB+0NniNfdqichoYxTwA0SWjrOG1oVsiVXddykb/oMJOiTumzAGbIOV
	RkQlV5yZuTYZwCxA9c5p9l3nBVsaOoc6a0LR3SxT0NmiwaQSV5iwZxJspq+wWo3ya/xLyoxjhHr
	e2meP7LOJ2HfBCgRepeeyf48YZKEOX7rD2NhGgpdrnIGLoArpEqmLmWvlYXL5DAlisC+oPnBRGC
	w8qTJ/WoEdxNZWzVLPBqvVVvm11Rv5GemLbaB4gTz6czDhLJhKmbacCq7H64leSfIoiXrzOa3hS
	KKCvpSUGhOAApD+so16wOQ7LIu+XwcK0geRHc7NZ
X-Received: by 2002:a17:903:283:b0:2b0:5bfc:8af4 with SMTP id
 d9443c01a7336-2b0827a4001mr128486395ad.34.1774301991602; Mon, 23 Mar 2026
 14:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323013408.429701-1-nick@khadas.com> <20260323013408.429701-2-nick@khadas.com>
 <20260323-saffron-cobra-of-perfection-731c8d@quoll>
In-Reply-To: <20260323-saffron-cobra-of-perfection-731c8d@quoll>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 23 Mar 2026 22:39:40 +0100
X-Gm-Features: AQROBzBHwpJgqdryfoMYgGeaKe0N_FLrFJ0DYVE2fe5meqjo8yYkKZdDC7I4VPA
Message-ID: <CAFBinCARQWQCjDFVyy3XOsae00KhcO2qpgLjH_r85cVxST6xtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org, khilman@baylibre.com, 
	jbrunet@baylibre.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 8:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Mar 23, 2026 at 09:34:05AM +0800, Nick Xie wrote:
> > Add the compatible string for the SARADC (Successive Approximation
> > Register ADC) IP block found in the Amlogic Meson S4 SoC.
> >
> > There are no known differences between the SARADC on S4 and the one
> > on G12A. Therefore, it uses "amlogic,meson-g12a-saradc" as a proper
> > specific fallback.
>
> You should explain here why you are adding that comment.
What do you think about:
Also add a comment indicating that "amlogic,meson-saradc" must not be
used for new devices. It's a made up compatible string that does not
correspond to a specific hardware generation and is not used to match
any driver. For old devices we keep it as it's part of the ABI.
