Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31E3515D7;
	Fri, 14 Aug 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687941; cv=none; b=RM+jrjEAu+ZLbMi7hE4uzm29/9ljUNVlWYLsNEG1T9EOaatTVjzIz0ZVOfi8E7j005q0vHRBi6P9dMIDSKqr2Muy5Iu+f3DBmLd+D3ygKlSMxTf3qIJ4FIGTaQThl9S65JbjIlYmR6J5rBBXllFyjrEihxUXR2UJc1V4iF6QFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687941; c=relaxed/simple;
	bh=WjqnQGfHPc15PT7e+lW+CbJ3X3+jmUne3/ncbU+LgsI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsuaEdnnz0tC52XQTyF74f1vHE9Wp9/LIxmTNQKHvG5BFwAHdY9YCgnN7FoXLIA/NBWifLEo8zzkHkmhQU+sijABabIysqiRQ+zwFB5yb26bRWzyp+Pfxpo6RPDJ9sZ1PEWfYKEZmy81nZOWigNf6YIUaL9iGikMgkPS8B9JOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=nzT0hw3l; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="nzT0hw3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786687926; x=1786947126;
	bh=xGfcKB9DdSCCR+/7jLQMbEf4DzknJ9vz02C+NrtXbZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nzT0hw3lpj7ezfI081jEdKyezNqPGZkx3EEL3tsqNqf6SmPyvTxPNMYCGOdXrQQEe
	 KVPJlzP9S3Ujo3t4h31j4i29HO9vbJJoWC0pFk/vx0T2Xw3LAQIr7EhAfLcEOnqaGo
	 MGnEHi2GpgUBwo3yO2SUkec/0lIOXEF2i23dIGajnOQXyqkXwBwliehflHL3h1asLO
	 K350zJGk0eprWceQcKsSc1OPPuoC4hP1qg4mqb816ViGBpdZ7ETdrL/fBKwQgkvDJi
	 VJP32w8yVFguy60Mj4eJFQD5QkUZbyxqFT4pgbMioJIZO4m29OvnQwJ87xYm8g6aiz
	 i34389926NsEQ==
Date: Fri, 14 Aug 2026 06:12:02 +0000
To: Rob Herring <robh@kernel.org>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329 compatible
Message-ID: <TAqA2mz2fgZ5UrsUyUjXaOd4gGVruOoArXOJ0kxOjOZhzbv5tLaiehsA3DhRQFaJp2vrWOTJ1jnrLeNGZBz5Xd0Ou7UXv9XW5GZ4VtNzDR4=@geanix.com>
In-Reply-To: <20260813192052.GB1981719-robh@kernel.org>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com> <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com> <lLSnPCriXSWAjaV4ogTOt4280Fj7hoZxBDkJC70ETVjxbUYNhCi8Ii6pDv-7YQ5SKb_Hz4Aj4JwtYPGwPH6WwA==@protonmail.internalid> <20260810155006.GA1815611-robh@kernel.org> <871pc3y0id.fsf@geanix.com> <20260813192052.GB1981719-robh@kernel.org>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: f1bf34eb711c13363d27704e9c2994737f3905ff
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, August 13th, 2026 at 21:20, Rob Herring <robh@kernel.org> wrot=
e:

> On Wed, Aug 12, 2026 at 02:41:14PM +0200, Esben Haabendal wrote:
> > "Rob Herring" <robh@kernel.org> writes:
> >
> > > sashiko issue should be addressed.
> >
> > I will.
> >
> > I guess it is best to add the new conditional statement under allOf, bu=
t
> > as we already have an allOf block at the top, I would have to add it
> > under that, which would place this new conditional statement related to
> > specific compatible strings before the list of those compatible strings=
.
> >
> > It should work fine, but it looks a bit odd to me.
> >
> > I could also add it directly  as an if statement, but that would only
> > work as long as it is the only top level if statement, so that looks
> > like a bad idea.
> >
> > Should I just stick it to the existing allOf list?
>=20
> You can move the allOf to the end.

Ok, fine with me. I will do that.

/Esben
