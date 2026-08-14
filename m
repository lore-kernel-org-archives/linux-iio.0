Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B201A8F7B;
	Fri, 14 Aug 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688352; cv=none; b=bp8IH0nl9hyZmJObUnR0JYkergyKrS9VdoxKy4dnzimfOBtHrAtPRlxs1wtH+AZp5Sbz89mNacz+wQ9XeAlZALX8f+JTSdBYhWZxRZmpWC9OGdp4RYVMhFJTJe80amNw5zI8Fk6shVS7myf8Ay+GFWwnTFeL7ncAhnwTQCpjcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688352; c=relaxed/simple;
	bh=qjJK/3P3iIJV8ZVyw32KrGhky1o2KV2ZwgkjeGCWR/8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn1ynbJiyO/52ts9fv3e9lyALMJKN2z29NrAzB3MTD7L/6lfHYz1ei3UFkEs17tcovQMf62bROXiEUH3eFck9bhPrL/2nXWwE1AjTH7Eh+7C0MHwxnFJS171/lyXWr8nnNxaa7BBuD3J7wlYMTn23bf7D1BkfopC5eFxc0mkAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=j2xXklnc; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="j2xXklnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786688340; x=1786947540;
	bh=8F3rqHUjtj9NlK+ZV/7qV2o6iGHSdw2InApAQtmbDHM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j2xXklnct5eeN/AGKDES6w7BV/Y3z507NHSpU/qfVO0W+DGdkB+NwGT/nu9ZBOe94
	 rr+WBf5kIql9jVMwKzKhr+NWjAoRP3MhFZ+vLO82SRULFWieNTZUWAHoa4/hrUUEbm
	 Km1tg0YE4ryjZYRxUDDifneH0QiQmNB2Rhf6Pet/cUV5mAv4+squ3Hlswi4fFJU85k
	 JlrV4mC9Vh6jQU2PP+m9xgPnJa8ewJm1QKS8/Deph444yL9WbQ/b742rAaMDzPJX2U
	 pogcOSI7Rp9bMdQ38WT8/4dh+6FPLdbDCtZtr+9MBGhXJYMSdcOWvlSq4OCc56IWVT
	 mzP/v6imWVgCw==
Date: Fri, 14 Aug 2026 06:18:55 +0000
To: Rob Herring <robh@kernel.org>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329 compatible
Message-ID: <tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
In-Reply-To: <20260810155006.GA1815611-robh@kernel.org>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com> <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com> <20260810155006.GA1815611-robh@kernel.org>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: 4a614bb21d73bc19542bfb4dfda3c644304e944a
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrote:

> On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
> > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> > without interrupt support.
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > ---
> >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> sashiko issue should be addressed.

What about the suggestion about adding `proximity-near-level: false` to the=
 condition. I am thinking something like this is more correct

properties:
  proximity-near-level: false

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - liteon,ltr501
              - liteon,ltr559
    then:
      properties:
        proximity-near-level: true

As it is only valid for those two chips, and it seems more logical to do a =
white-list than the opposite.

/Esben

