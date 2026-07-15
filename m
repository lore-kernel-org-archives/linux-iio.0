Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83054EA397;
	Wed, 15 Jul 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140396; cv=none; b=FGKu1fyxi3cdcKl5YQHYhMEYIYL1RgWzSLtAxMiYsx1f+TXovemTAsPWNBsTzd2/tgqZNUvDr+X0tObN+ajFVxLNPYr/H7d9MlzsXtUEtcfOz0zlHA6j28Y7BD+IhjBa5sDL4pErPrFtSIeiIZ0MHSgKxAYz7ksA5k/c+Ib54vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140396; c=relaxed/simple;
	bh=BnYkMCFA5QWjwqSMwP5QyiRAwtUmcnsukUpRvPinjyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgCrLjB+pPDHpEjx++f31lpFtDf5t0/Og5p5XpaF/1dJ77WQAQ6/RyUP/KUS5iOFxhTqLf6xHvCT/SJuTGDqHvI3KPYBxInciYvCxQGf6f/KbrYOgA8QmEHd/hgmS0IBtKS7ceTCEnGn9Vk+vj+zKxrVI4j40N8LTBaaHtmmUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYfE/yRZ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYfE/yRZ"
Message-ID: <03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784140363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7XjzZnPvtVLTm2rYMPVvwWRO5304PYUB/Nmj95wktg=;
	b=SYfE/yRZWpHea6Z52Xh+9NZRbuVscNfGBbW/kyQkl4jlF8TYk+/tZZWHQj/r9vzv8Py+TR
	64JhLzcq8GCvtnJ2w248Q1E/zOwi4N43vFvuIOCn6a2GGGNsCcyoLSWR3eaKhTJ6kVdmkD
	uO977fD0prceyunOA1z9l6c+VYM0hVU=
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 00:32:20 +0600
In-Reply-To: <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	 <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2026-07-14 at 22:28 +0200, Jorijn van der Graaf wrote:
> Add device tree bindings for the QST QMC6308, a 3-axis AMR
> magnetometer. It is an I2C device in a 4-pin WLCSP package with a
> single supply and no interrupt pin, at I2C address 0x2c.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
>=20
...
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qstcorp,qmc6308
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 vdd-supply: true
> +
> +=C2=A0 mount-matrix: true
You could add this prop to the existing QMC5883l binding. See the comment b=
elow.
> +
> +additionalProperties: false
> +
> +required:
> +=C2=A0 - compatible
> +=C2=A0 - reg
> +=C2=A0 - vdd-supply
> +
I usually don't bother with bindings. But here I have some thoughts.
You could reuse the QMC5883L binding. As for the device lacking both=C2=A0
interrupt and vddio pins, you could exclude them like


allOf:
  - if:
      properties:
        compatible:
          contains:
            const: qstcorp,qmc6308
    then:
      properties:
        interrupts: false
        vddio-supply: false

But you would also need to remove the global required vddio-supply and make=
 it required for qmc5883l.=20
Or flip the logic of allOf. Considering a lot of the magnetometer bindings =
look very similar anyway,=C2=A0
I'm not sure if it's worth=C2=A0combining them. Maybe Jonathan or DT mainta=
iners would have a better opinion.


> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 i2c {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 magnetometer@2c {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compa=
tible =3D "qstcorp,qmc6308";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x2c>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdd-s=
upply =3D <&vdd_1v8_reg>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0 };
>=20
--
Best regards,
Sirat
