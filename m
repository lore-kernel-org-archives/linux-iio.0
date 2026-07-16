Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02743911B6
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218523; cv=none; b=aIl9MxmvZmyCFNjQAdtcN+tvsIlZLtkae1fXROME8+nWFRmtSubvFQjQWzWIiRe0bJJLidoUTQB5Fdt7eY43qBhLvV+yH5j+9yWlLnQhja9YvW2t5ZiXic0JUle26NA0HcaEr8zITb3BgkV5efnBN4jGiuSoHvLJZyKHYqUmyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218523; c=relaxed/simple;
	bh=Jy/8jWfrqQRWC5KZFuo4TFcLu0qLfSMheSJmj0TunEA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9RyShpg6XvQbyKspboa5K+bHLNKIXYMvaWRDKxtYBO0N3xHZhpx/OqJ1F0QU+6oqlZ8h7/7p9THyzBvICDVJ8f8F99yB4sX1H/7oCjYuQI+qwOpdgxZyuN0Ao8Ep7EYX0xiUq5pXpaSByKfBfc9opRZ4Ff2u1kvYhtbjAvImbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=F1yMLn7W; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="F1yMLn7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784218499; x=1784477699;
	bh=x6rQX4SckDIaVBvQ/9PzUnazCHR4T4eYErwAgV1UfFk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F1yMLn7WlhlWrP/WIih34v2ENuDo3LJqHY6ppsUfvjpc1SSHQlg8WeGaZ/JnogTzo
	 h7nGVPkAiFOB2+cth/bDPdyJKoZKS5Do8MCKUr8Q/Yp/X6JHeuyDYTfe4kMqKAorMT
	 lTiMOxpHpn/2Cnv1RccL/IDrrFOax3qegatQVDo6unQedAwCY4My5FDjArujeJKU0f
	 aKkxsI6bcbMjwFY1BEQOl+De15LBuXhhKUFirMS9+1hiipgem9ybH0HYhtGmP9tN6n
	 1qB9KKz1W5ZW/WjLsMuJs9l0hu0TFB8c+iTYMD1FlQeNgFIJfrDoIDi6ke1OERo+1w
	 AqdmxUA4BFWuQ==
Date: Thu, 16 Jul 2026 16:14:55 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329 compatible
Message-ID: <pnxaJvFlsLehHV30SMlmWECZnbQ6Rqb2cvWWlVbjYKsg9v0i_Wyu28e7U_OYfV1XooewL13ZLUMBjODBTYnBuiI0t9m-bxt8AdKsz9oizok=@geanix.com>
In-Reply-To: <20260716-adept-kraken-of-calibration-cddebc@quoll>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com> <20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com> <20260716-adept-kraken-of-calibration-cddebc@quoll>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: de336009eb527baac4bd43ef384db311d61dcc5c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, 16 July 2026 at 10:07, Krzysztof Kozlowski <krzk@kernel.org> w=
rote:

> On Wed, Jul 15, 2026 at 02:27:24PM +0200, Esben Haabendal wrote:
> > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> > without interrupt support.
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > ---
> >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.=
yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > index ab9bb68dd736..76e81eba7ea4 100644
> > --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> > @@ -19,6 +19,7 @@ properties:
> >        - liteon,ltr559
> >        - liteon,ltr301
> >        - liteon,ltr303
> > +      - liteon,ltr329
>=20
> Do not grow lists at the end, they are ordered alphanumerically to avoid
> conflicts.

Placing the new entry at the top would produce a rather strangely order lis=
t:

ltr329
ltr501
ltr559
ltr301
ltr329

Should I add a patch sorting the entire list to avoid this kind of
confusion in the future?

/Esben
