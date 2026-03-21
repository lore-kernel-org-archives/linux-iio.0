Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE721D61B7;
	Sat, 21 Mar 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107577; cv=none; b=b9vzos7iQwLyn5Vp0pDO2+1wK/35usQNrsLV6q7TDmIR/Qtxh8V8ERaLAw43bUnCcfbmKKlcFBnjtKxlAN3vy0QRu6c/5GfWiBNhmBG/IEUlgyJb891xKlNmqmKC9TymZw9UcRMltsJfl2uvZYvHke3oFZJtC/B3o22y/G3I0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107577; c=relaxed/simple;
	bh=YdEVlxJWegfkCY1bhv5Wf2qdNZ9WLCnJprixhPrXtrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbmEr6Dpf5uDFAwrESPHPGQbr5l/Cuqhi6rNd3X2pjxk6dJpXSBGHiyvWF5KJztUwEd4PeO/3eFVH+H4Ixaxm6Je6Q0sZ84coqnF6VzQk7FTCyaFHX71+YLazuB54oQrQpZV2a2qoyMnA2Zeq5p7KIshhGIVV2kh/BNiZfzLoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5GTTUAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5GTTUAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47118C19421;
	Sat, 21 Mar 2026 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774107576;
	bh=YdEVlxJWegfkCY1bhv5Wf2qdNZ9WLCnJprixhPrXtrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5GTTUAaGk7D55zYZB7zDqwCneLqVyvIZUnpJZ7pM5o1rklCtiM9VluvweszUvyoC
	 Ej7O1kFrhtTWWvXQ+KxHUeX3IgYoZWyDFN/MQyJaLv48UAiaQPBMo3KDJPQvMJbYdb
	 g4zWEtTIXV6zGdZj/fU0OIp3Q5uBiwFmVcKm70nSb8UoR9SApDmP1uY2j+gi4zitMi
	 wxgJTFCVHfJIvTvy1gXJM3GsKVvKm4JZAxdZ8BoVbCzyisCtZv5NZ9jyn/cSZjdrDW
	 SaxYM/Q1rUXLSbHXDuIV/AlgAJJOGq7WF+5NLuwdEb4rWEJEt7hqtwktJwa4l5Eilf
	 g+3mzlEJZeMZQ==
Date: Sat, 21 Mar 2026 15:39:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David =?UTF-8?B?TWFyaW5vdmnEhw==?= <david.marinovic@pupin.rs>,
 andriy.shevchenko@intel.com, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: ltc2632: add LTC2654
 compatible strings
Message-ID: <20260321153926.6dc635d0@jic23-huawei>
In-Reply-To: <20260320-doorway-rack-75f58f141999@spud>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
	<20260320150957.105571-1-david.marinovic@pupin.rs>
	<20260320150957.105571-3-david.marinovic@pupin.rs>
	<20260320-doorway-rack-75f58f141999@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Mar 2026 17:20:28 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Mar 20, 2026 at 04:09:47PM +0100, David Marinovi=C4=87 wrote:
> > From: David Marinovic <david.marinovic@pupin.rs>
> >=20
> > Add compatible strings for the LTC2654 quad-channel DAC family.
> >=20
> > The LTC2654 devices are 4-channel, 16-/12-bit DACs with an internal
> > reference and SPI interface. They use the same 24-bit SPI command
> > format as the LTC2632/2634/2636 family.
> >=20
> > The 16-bit variants (LTC2654-L16 and LTC2654-H16) require new
> > compatible strings, as no existing compatibles support 16-bit
> > resolution.
> >=20
> > The 12-bit variants (LTC2654-L12 and LTC2654-H12) are register-
> > compatible with LTC2634-L12 and LTC2634-H12 respectively, and can
> > use them as fallback compatibles.
> >  =20
>=20
> > Changes added for:
> > - lltc,ltc2654-l16: 16-bit, 2.5V internal reference
> > - lltc,ltc2654-l12: 12-bit, 2.5V internal reference (fallback to lltc,l=
tc2634-l12)
> > - lltc,ltc2654-h16: 16-bit, 4.096V internal reference
> > - lltc,ltc2654-h12: 12-bit, 4.096V internal reference (fallback to lltc=
,ltc2634-h12) =20
>=20
> No idea what this section is doing, could probably cull it if there's
> another version.
I dropped that section whilst applying.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>=20
> btw, please don't send new versions in reply to old ones, can cause you
> to get buried in people's mailboxes.
>=20
> Cheers,
> Conor.

