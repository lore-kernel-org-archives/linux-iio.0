Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792830189;
	b=ODnA0BRS8x/iZGyOEF8XxWiep6MkPExQ0AtrrKua+9dGXtcOPi4TqSzhlHMfkrsqDMkE
	 nSaDuuvuqaNgSLKRGHCRa96fgw11BoEKjfsPDl91gMOaKyzTO1aartNaIyBmBNb02SPl/
	 UWiaMbSiPjVKvTI1XQY5m6M6Z/KXUPUL0KxVDLYo2AsT0zOYm3Ry88+bn0APsj+uRc+kc
	 7bZV0RqmvHOkS57dLnImrTsXL/SjMzVO41qlMi04BlMm8mUMFEPQD57wx97kI1GUhabyz
	 BWY+L6wmG7HipN2Kt2gtNpYqNe/lmA0yHBHXnRQilDFpLrjUPTV9GfLaoK/q5c6hyUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792830189;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=F/Qrv5HNX1QraYhmI2aGxi+9HcgIrW3DX/bT4ArG3eI=;
	b=btAbFoQTj1oLNvL8xBfmPMnngq6HUy2pQdWyaIJUIOLgRZJcIhZbes1u2reGKbc/9ls4
	 JB6D83Y5uaeJfzdGBwDdyDMt06Rk61S4FfNfeFpwA8Ojpb+pxXBWDrXMxdQKpceHsltqR
	 8HCCbeR261vJxMEXdyMLr46tBAEOXAG/G+QW7ypt8YYnZI8VPHM1JEDxjDC5MfPxDSbER
	 R7pJM+BUGUXrT7ZCw6iiaJiO7jPwFa4nHr5nwczWETOYoE2O0I0DGD0ZHxkv7s3W7s0KD
	 Vhx3bdsrgA4jvaDHvkLdWaA8TeZz/Lq3cEt0MVlBRIq7l61rvw+DFxIDJF8FvnavCHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ewz0SQBK;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iZ3rjytW;
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CC606A31D;
	Sat, 24 Oct 2026 08:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ewz0SQBK;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iZ3rjytW
ARC-Seal: i=1; a=rsa-sha256; t=1792830162; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iQJsjfbJMxpXE1DdpFwrGdEjDUgp2jPVTW4FVxuYXDDvBkDCs2OBQggqRozc2xYHYd
    zl8bawHG+GSnOPnq5rAlddwvugYcLunF8tvSq78o//oV70l5mmaaWN9/qgpETN2p3GIF
    dGA9oW46/pWm7ja/Umd30mssxwSVhYfk8/DcIpnbtWlI0+BQJNA457d/G9mfJCSX/LcE
    0Kq3INOYXbRTCkmPeTVmW3Gj9YdmFhKPgRjr/+//avhNd3utcgW/KOBuEjsThx/IDPuS
    b1WXmYJCR9KZl4paN5OdXYzg7AAMB5qN8JwqKjPWGknEgKkOuuKVQUqhdHOF0fm0kbfn
    qpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792830162;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=F/Qrv5HNX1QraYhmI2aGxi+9HcgIrW3DX/bT4ArG3eI=;
    b=BfIwc8xZhGZtmm1ZtOLTnU8F9okZGxo2QZxFFJprNf8PLTQ7uxsoQMVoxo6rRJqZX4
    JJKN8i3tjkirKTvpZiZOaJxutK/xuVhHLkVx/+jEAirimZz3qMOBFDVoFyXzwQZFz8lT
    h2I9eH8ZCKJEQjlKwbvUbBns2sFNIKpsZdZxmiqTgH2FPRHmiC/atbvxEGLbwJNhP1iI
    cPG8QXLFbzqb7KVm07H0Ifd8QfbQTa0a7dU4ZVx5u4cTp+JRTRdYvmBIsQBd+dPzqqMF
    1Rn0bVdp6Ou6nx5jFrRajaPcbxcfpiBtlTKdHwREDUErJDrBfQsgYY/Lv/nLKbDzJSka
    q5bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792830162;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=F/Qrv5HNX1QraYhmI2aGxi+9HcgIrW3DX/bT4ArG3eI=;
    b=Ewz0SQBKI9xjG6fbHoUS2zURQbpZk/f6qAYZHCd3iDb2rSgnoEWaFgklRu+8VmoL6+
    PEM/5/xn38GVfl02iODRL8yjS7i2kzY5WlIqommZgK48xWtc+OM4rxDo69pw7627UrHG
    BOgsaS0a0zoEhhQ9xzGg6hYqnXaXITqOG/WZNJn2gfKIso/eiFYJkkRlCo6KyPN40VyZ
    ZuqJgitTVps2u8LfQbkZs87+QbVA3jM/rWC4gzD+DGzhwYE/iUz3S+HJSlAxdD1cbwj7
    OkVGbDKKdwM3QX/G65wsDLth7d8dc5z7ASMrygtGCYjj8QoSSbJdtS7suS3/xizpqYv1
    4N3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792830162;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=F/Qrv5HNX1QraYhmI2aGxi+9HcgIrW3DX/bT4ArG3eI=;
    b=iZ3rjytWh6zqKBqxxwTvoevyS5G0FCg66imV26P8AbqHzDLX8vxOmACOods6S9rN2V
    kxEa/H00rQF8ruEo4FDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzssJZVJ1W1pIJ42bR3YaapQ9RNEb"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229O8MfvmV
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 10:22:41 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261024041357.34346-2-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 10:22:30 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EC261C8-74E7-4F0A-B739-6851D6BFCA44@goldelico.com>
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024041357.34346-2-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

Hi,

> Am 24.10.2026 um 06:13 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> There is no datasheet here: the register layout and the clock dividers
> come from the X1600 driver of the vendor's 4.4 kernel.

You can find the programming manual X1600_PM_20220117.pdf here:

https://github.com/Ingenic-community/datasheets/blob/main/X/

Chapter 19.4 describes the registers.

There is also an X1000 PM to compare.

BTW: we have tons of patches for the x1600/x2000/x2600 (and even jz4730) =
waiting for cleanup
and upstreaming so we should avoid double and incompatible work but join =
forces.
Please refer to =
https://github.com/goldelico/letux-kernel/tree/letux-current

BR,
Nikolaus

