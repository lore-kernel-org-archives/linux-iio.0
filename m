Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160412FB983
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659113; cv=none; b=J5RLkPge1OZlBrjDY5Gz6CxESYbmSFDsHO0iaMebkpxruHTAjvI3xtEhqFAQLECxoikFtNhE0FBg+CI0l3727JtcaRZUerZnGPYjJTfvZqdiJdWg2E21lBIGBIrD4UVlLOTT5bA/YKjdKqC5lQJQ+PGair4hEzu0t5iV+0GIX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659113; c=relaxed/simple;
	bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIH8UKCAG8cyOPWpQQ2v1Dy2Ryq/4QrR/RHWXFu1Sq/AJOGUde3PCf6/ph40HPVgc1oMVX4ancC99HMlifMlnBhXUeSZlrneULPBHp0wIYw0aDvjS1sAUAIVcGMFEflx6f5iC1C0ZCcrB3IDrSdpn5R0E9iEYkvEvPVnHWxjP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXIeLWjc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXIeLWjc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee07570deso29049345e9.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770659111; x=1771263911; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
        b=kXIeLWjcKXz1h8eOJfl+yKM/oFMrXsv7l3k0WBurPswbX4ODT/2UtqqGRYaM85shdt
         UV1DhyQgabv9B4appezvMYr4NkNuBlPRagy5mpaszpolWRr+s8zVop6zQ9+giNofhxb3
         Vrvx8XH7/zyD9nq8lxS+1WJ6YhXxVnQP5Pa4JF2NO2F9QnimamV4W/sjX9vqyCNMCeXh
         PlE6VpAUqnxdEU9cI9JplOizDDZFRSclK6aUCYqjegDWZqdQUJ4f2roUd9p+QIkMFOns
         qEvdCYUHtvNsfsXlL+24aIgH9KqBgHc1aViqrc2dIeJQfKsXQEWQAdcTQaCLV2Es55vD
         bLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770659111; x=1771263911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
        b=X0/67BlC04AuqfSrTbKif7LmbELtHjYhB9a+1F5t1sayWuMACd+0ztgwTrWEHCbRhr
         DMf15bjKTpBsKp3oG7Sp7Jd9+hivIJOqw37w7N+VJFUYbxPYgtW2kTQqDCEimplv9nJs
         GEKo+BbxpCDl6Gu/1eASz+NdP98y8j8evE62nutYjHvwnyV6thcZkXlVLPG8cq1SnY5w
         JoWHJJPJfl5m4h4taVVrow8O8BtfygDT0SRsbmoL6cxv3RMNPmePHLPMv0S9pqd210xS
         JBiJl4bM3WWSxhkJmZNDgCV71cIqdEQ8cwk3622UImDrvDfmoEtSqGKaxMbqL9q3b3f+
         uWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUhmGK6wKy4iauv0b8w+D0wFsvdSeqB7fSFDGPogZH6IvhgmFG3ZwtPNRa8su7VJqCBhg4qQf/cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Keo5f9o6QUnAmet33W6T5x3zSAn5ZD69SQp20uvitidGODMd
	Gtp6dwHbmtyQusid0AJjtcozG2uGFpBBFlsS2XV5FHAlDvYyooGAH+X4
X-Gm-Gg: AZuq6aIish8pK//Y91p8M7BJZax5MAhP6dlIrr55k0xrPhTW/gwNCQSnAa+RKD0N0b/
	IhfIuDC8gwaPf0kgJ1j1T/crwzpLLz6y9lToL/ShA1kpdoUnPBLOvuuY+6ZY9ZypCnjl26+KlrI
	SgYKKlJmpGtHkURTMUEivpE1bIie55bop+hRcTeN5g992YsUuixfxEtYDiUYOUIhKk+/0ufArx5
	eOSNitZhzcgO2dq8BGcgjcvyByDYA8UIqZ+5LqyYI2LTYrqZc+pEkWlCbmf6MBhWfKBxPSaoEIp
	XLm9ViYbM4qS2Rlt3ytc7/N5PIRQLa54xeSIJ5HDZa2z2aTPdRuRU6DdYFUnzdWBMs5auYUWBNz
	RMgu372fSyXZPMNulqIcbyxsGEtMrJU5j4i8l75V9qhNXPXcfbXg4jPaHgOFJXbadgkBevDWNeL
	dsEyZKEdEDL5Allfs+YKimAgsVeBLq/Q==
X-Received: by 2002:a05:600c:83c5:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-483202264f6mr166657725e9.31.1770659111039;
        Mon, 09 Feb 2026 09:45:11 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e1a5esm3867345e9.4.2026.02.09.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:45:10 -0800 (PST)
Message-ID: <10822a56a8d85d0b079a2a17fde403aca8d102c7.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Mon, 09 Feb 2026 17:45:53 +0000
In-Reply-To: <79c21d77-32c0-401a-94e2-ba4349a7a616@kernel.org>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
	 <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
	 <b3571244f058133a7a0f3b5ca6ef7dc377e3fac8.camel@gmail.com>
	 <be3808e2-ef17-4191-8c1c-5acb53114863@kernel.org>
	 <6b33ddfce874006bd10e223701802dec52fdddf9.camel@gmail.com>
	 <79c21d77-32c0-401a-94e2-ba4349a7a616@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 18:13 +0100, Krzysztof Kozlowski wrote:
> On 09/02/2026 17:43, Nuno S=C3=A1 wrote:
> > On Sun, 2026-02-08 at 10:20 +0100, Krzysztof Kozlowski wrote:
> > > On 08/02/2026 10:16, Nuno S=C3=A1 wrote:
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0 io-backends:
> > > > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > > >=20
> > > > > Instead list the items with minItems, so the order is defined.
> > > > >=20
> > > >=20
> > > > Also looks like we now need 'io-backend-names'.
> > >=20
> > > No. Just define the order here.
> > >=20
> >=20
> > Things are still not really defined on the code side (I know bindings d=
on't care about the
> > driver
> > side) but io-backend-names is a standard property and we might actually=
 end up using it so that
>=20
> And names do not change that at all. Actually they might make it worse,
> because they allow drivers to fetch item by name which people think
> means "order is flexible".

Fair and makes sense.

- Nuno S=C3=A1

