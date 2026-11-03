Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703309;
	b=cqmywwRr94bvkIWxpekD95QUTnXXMuMYW/ZBBtiGqYxS2We/+JCj/gHXR8BH1rv3usSn
	 buIiqh/mVdklVB8TNpXdE4oyTcaOpKUZx2OOvRmgDv/sFmsnk/PY62zto4TRQY5jEd0fH
	 Hup4UlspBMdEYcnPYLwUgPEQVfW/mVet2nFEXkZXSh6aaWjbwbkAliuoeCTRn+hn8CKdk
	 p6JvdBplkHyFoqVrsBg3gGtQkRi+3haXgIbMdSuRIA0CnTcLhpedHbtneHh44QccKGuvL
	 BEpGLemsm8aoKc+N/1o7Ucr0nC/wI/kusotiYM3FZmd4d5AMo2QWB3rNip6qCKkweoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703309;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=w876MNRRdwRCJnTU1Fel47UMgeqbTWjT7jcDrhfNJKE=;
	b=kQdqrBwkSe097ubYEaSQEUXK5ICnRxBYu3PjJtQ7mCd3YLDc4F2Bq8ac918v157b/2W8
	 Afi+3XSuH0i+WiIgBn1259K32zMhv5lKyEbWN5sckRrD5TLxWynhxvaKIg7HTybPN51Su
	 JIRTdFHQDkmREBHT+coy5u2Q0FVEA/rhDstGzPPqmGSuzZjkFCDvwdG8QDgjtERh7+rTk
	 hRVl/FDS6sWUnh/ACsSikBLBT7uxokpfuRVcmcvvjY3yTkdJYueiBnFtqYmAFMKJ9YNHG
	 /DDOiCFzNLlIYm01wQYCIE6530ssD9LZQRj9CvW/ZtDNxWvJ0XbDsemMrWQDcwrLOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGhmVNVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82494606EDA2;
	Tue,  3 Nov 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGhmVNVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8ED1F000C1;
	Tue,  3 Nov 2026 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703309;
	bh=w876MNRRdwRCJnTU1Fel47UMgeqbTWjT7jcDrhfNJKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGhmVNVq11sVz2YuESBLrONEKvK0ZNJjI2SHX5sTBYCcFcs6FWJ2YiCm8aMGrjwux
	 Do3wZjHshoAa6omlmPqTLhWZF0pvwEnaW2N2Qsd7a2rYtB3q2hvkBPnE89nQxaUAXG
	 KA1f3vqz+yXjLuYZORRIojBR8XP+z98A0jTh6+L70t4FynniyE9KeBNEcK2+01GuAK
	 +odVFY3a79WkD40N+S0Nk7lLqxLAtHBGG9WaJgGU5sEJ13oj5y833SlGKQbWYnkaZo
	 uaUxhiK/X/RBATcHVtoMX9QBmqijVCgNGdBp8LUC+q2goVfK/RKhl6RCOoIMZ4vk9I
	 q7X2MQ340Elgg==
Date: Tue, 3 Nov 2026 11:55:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261103-accomplished-real-cuttlefish-b6efdc@quoll>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
 <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
 <20261102-barista-haste-6f219aa98c81@spud>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261102-barista-haste-6f219aa98c81@spud>

On Mon, Nov 02, 2026 at 07:36:00PM +0000, Conor Dooley wrote:
> On Mon, Nov 02, 2026 at 11:25:40AM +0200, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> >=20
> > Add device tree bindings for the Analog Devices ADIS16607 Precision
> > MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> > gyroscope, triaxial accelerometer, and temperature sensor, and
> > communicates over SPI Half-Duplex.
> >=20
> > Two variants are supported, adis16607-2 and adis16607-3, differing
> > only in gyroscope full-scale range (=C2=B1450=C2=B0/s and =C2=B12000=C2=
=B0/s
> > respectively).
> >=20
> > The binding exposes optional properties for:
> >   - An external clock for sync mode (falling back to the internal 8 kHz
> >     clock when absent)
> >   - A hardware reset GPIO (active low)
> >=20
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>=20
> Why did you drop Rob's tag?

Explanation in cover letter is confusing. There is no difference between
v4 and v5. There is some description change betweeb v3 and v5. So was
the description change something forcing to re-review?

Radu, please carefully read submitting patches.

Best regards,
Krzysztof

