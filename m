Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F33D4131
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153829; cv=none; b=nDKCndBeaNAuIpqHegNVUNRpigMsmZxCwCAA3WvHKNByoQfV2P+qKdJ//aEFSVv45uQ/mUoykqn+mael7B4rlq46P/STHvfcWSksZUzscL1MFb0RdW+jYSSqIc8sfo+I3E51LyS23Yoi9mtQfiSuS9BZDPH/Ega1ZRhrIOuKsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153829; c=relaxed/simple;
	bh=FDVlO5tSaEwSxfvQ6HvHfxUWtGS/nrgF1Ikig5cw/Lo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=NLtPm6YZek0fxHdZpm+hxXkNzvAdmDz5c4hjkWAxp5sAXQzmi/qxDLwvOapFdcVmIgSTMgOsiwvXBVee0qx//w5GbyQAj6bqSrUoW5F1i8WA+OFW6DpcLgc8Z5I5JRsQjUl/31YMRdAMjLpdBi1uKjIhdgGFWK64ZgIO54ioors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTyh4Cql; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTyh4Cql"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784153815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbP4SKUJ5RstmNDJ8N78oz8tYVwl4xkUKV40KagWBv0=;
	b=cTyh4CqlaKnAJpBUyOZniIbqQNkR4jlvbMT7u4gDppv1bw4dYKx86EmDekKzvbpYtEo+Iv
	9GZNjdS0/8MH2lgFj3q85hT9Chngwk+E9Twusgpc+mlzY+urdh+qXrhtKrIxAGJJwfW6cP
	iX1D+xEhtokhfLIqxO7JeI90C4cN/oo=
Date: Wed, 15 Jul 2026 22:16:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <989a9b6a2024415ce29c1aef162c6a4d341dfa45@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
To: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "Jonathan Cameron"
 <jic23@kernel.org>
Cc: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "David Lechner"
 <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260715204616.46517-1-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
 <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
 <03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev>
 <20260715204616.46517-1-jorijnvdgraaf@catcrafts.net>
X-Migadu-Flow: FLOW_OUT

July 16, 2026 at 2:46 AM, "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts=
.net mailto:jorijnvdgraaf@catcrafts.net?to=3D%22Jorijn%20van%20der%20Graa=
f%22%20%3Cjorijnvdgraaf%40catcrafts.net%3E > wrote:


>=20
>=20Hi Siratul,
>=20
>=20On Thu, 2026-07-16 at 00:32 +0600, Siratul Islam wrote:
>=20
...
>=20
> >=20
>=20> I usually don't bother with bindings. But here I have some thoughts=
.
> >  You could reuse the QMC5883L binding. As for the device lacking both
> >  interrupt and vddio pins, you could exclude them like
> >=20
>=20>  allOf:
> >  - if:
> >  properties:
> >  compatible:
> >  contains:
> >  const: qstcorp,qmc6308
> >  then:
> >  properties:
> >  interrupts: false
> >  vddio-supply: false
> >=20
>=20>  But you would also need to remove the global required vddio-supply=
 and
> >  make it required for qmc5883l.
> >  Or flip the logic of allOf. Considering a lot of the magnetometer
> >  bindings look very similar anyway, I'm not sure if it's worth
> >  combining them. Maybe Jonathan or DT maintainers would have a better
> >  opinion.
> >=20
>=20I'd lean towards keeping the separate file.
Wait for more feedback before deciding, since you have a few days before=
=20
you=20send v2. DT maintainers usually prefer reusing the same file where =
possible.
> The two schemas share only compatible/reg/vdd-supply: the QMC5883L has
> an interrupt pin and requires vddio-supply, while the QMC6308 (a 4-pin
> WLCSP) has neither. So a combined document would be mostly conditional
> machinery - the block you sketch plus a second one (or the flipped
> allOf you mention) for the required list. And as the two chips are not
> register-compatible, there is no fallback-compatible relationship to
> express either.
Register compatibility is driver specific. Bindings are only for describi=
ng hardware.
So if there are reasons to use separate bindings, this isn't one of them.=
 A fallback-compatible=20
relationship=20isn't needed, as we are already using an enum to list whic=
h different sensors
the binding supports.
>=20
>=20Happy to fold it into qstcorp,qmc5883l.yaml in v2 if Jonathan or the
> DT maintainers prefer that shape.
>=20
>=20Thanks,
> Jorijn
>
--
Best regards,
Sirat
