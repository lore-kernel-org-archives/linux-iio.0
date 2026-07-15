Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8E1AA797;
	Wed, 15 Jul 2026 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148406; cv=none; b=MbLNIQh9jD1CiVD//TCiJcIRfGVQ2ffQYfaPGkPCvrsBhu70WeT0WcIHEKEmfUEWRqFvCXDQsEA+Jdp6+khgol6v4pr2OXADFUkir2ltnneAgdMXew98RjCD5XdPhiyry420O6os4B6kDU0DWUSjSkCUyV2ATuhDwrYozmJ3jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148406; c=relaxed/simple;
	bh=fs00jeQA7PKqP5FDn93vdJhuU2LPWJKZJgUIfJEbYWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+O41PX396kZ5BhMWVVIHFWwjV1wc4FQLLrbyrsxbUS4g5EFhu9xo9nzcNfA1Ae7H1KvyqsQkKtItPRcDHNSVTB9sA2ib3ol4StZdcJ6p+QeINnUrmA1eAhOxbfGhMhFhVft2XuriI9jY2TSI616PVG89qhVWdcOrA/5xpSFLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-08 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4h0p9q0tX7z3hhTD;
	Wed, 15 Jul 2026 16:46:22 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Siratul Islam <siratul.islam@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Date: Wed, 15 Jul 2026 22:46:16 +0200
Message-ID: <20260715204616.46517-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net> <20260714202842.340293-2-jorijnvdgraaf@catcrafts.net> <03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Siratul,

On Thu, 2026-07-16 at 00:32 +0600, Siratul Islam wrote:
> > +  mount-matrix: true
> You could add this prop to the existing QMC5883l binding. See the
> comment below.

Agreed, mount-matrix is a common property and would fit the QMC5883L
binding too, whichever way the file question below goes.

> I usually don't bother with bindings. But here I have some thoughts.
> You could reuse the QMC5883L binding. As for the device lacking both
> interrupt and vddio pins, you could exclude them like
>
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: qstcorp,qmc6308
>     then:
>       properties:
>         interrupts: false
>         vddio-supply: false
>
> But you would also need to remove the global required vddio-supply and
> make it required for qmc5883l.
> Or flip the logic of allOf. Considering a lot of the magnetometer
> bindings look very similar anyway, I'm not sure if it's worth
> combining them. Maybe Jonathan or DT maintainers would have a better
> opinion.

I'd lean towards keeping the separate file.
The two schemas share only compatible/reg/vdd-supply: the QMC5883L has
an interrupt pin and requires vddio-supply, while the QMC6308 (a 4-pin
WLCSP) has neither. So a combined document would be mostly conditional
machinery - the block you sketch plus a second one (or the flipped
allOf you mention) for the required list. And as the two chips are not
register-compatible, there is no fallback-compatible relationship to
express either.

Happy to fold it into qstcorp,qmc5883l.yaml in v2 if Jonathan or the
DT maintainers prefer that shape.

Thanks,
Jorijn
