Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640816;
	b=F2ClLCc09Cs6mkzP19cSaq5YDdBAIFHEDnEYfsL1zDedW0SxIgl040/BqVeVb/6D5pfi
	 RyjWyIprWa7B6qRrrHXpgWqErB1MCMmVyexgnSzDn4ue5krhjsIBIbY1Nm5bFMene7MRh
	 TAo7kiHPo2QFpAlIvPlpVlDHXvPhHbWBV/aYcWashNLu2RQ6OzX5dvCMIzhJWBvpDS7hi
	 YbzyvKxhHyzH90Qxe7XljMGbHbNM1wIqgGDj2LpHWNU4xyScDVbN99uLx1QpCfENyGg9U
	 75WIN/yzr3FlnY94evpytGUKf8/6JVjokWy77mRDYyG2i0/FO2hDZlxLu1zimjXApRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640816;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=i8oK4KfpGAw7G/U1RRs6h/PYqDNVqJbTSxkqZMs4J/M=;
	b=tLfmdHyYoq0WFmNe8Eclz6qLPSZqNi5AD69zsmEBTqKdh+j3TE9zB9PRk3nVlSPm0QZk
	 E4akazQ1UgsRn9SjjqHgHJYtl9SyvYcMOSmm3PPbA/GNQNjtonmIIEISfpPIs5fMoVvhj
	 0h5O4hJuEW7aBxyYeZkWKnLp3Iokqpv4GoGkV7Yycpen4EqmJO06J+7KkZBdWQhIsmBv/
	 IQbeU39ACGcnOIa2F4z21cf+QcWUu2DRQljsyy0fEASCT1HMY5mS3HAOaO3ElmmKGd8aS
	 6ersJWE3aZjxjBZN0Th0vqqZKdtMb2FkcVhCAYZs2AIYbf/oO7SnhbftaTyipMAG7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xvq0Foz9;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF640606A597;
	Mon,  2 Nov 2026 17:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF640606A597
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xvq0Foz9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793640815; x=1825176815;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fArsY9hKt91feQrTd7epp7TK81m2EQTLr8FWybs0efY=;
  b=Xvq0Foz9OI0H7WFjkePXlJs0ljZ4zKdQW7cUv3tHvfE7qwj5F45XcE0A
   PjsKV0J2tgjXGWw5gf7WN74dlo/eLCeLJVPiH96RzgY5OLfXb9tx1WZN2
   dZscsGjkTLvLW5phSnqGPOWiSf+zAQ8udBZ5oY+ujdmY3y94JCiajC9BD
   DOwMGN7CWSCP9IXCAsMf+YRjKxeanrGmtTIY/4e+GMfiW49W8M62swbks
   6yvRUwnXyX7WnmR4PBCbnjjNNOxr7g9GnTB5yBMr7H2/dark9Vuw7PXrK
   NRsvOUS8QEsdpmW+eqYQrT275Hjx0CW1q9OnFCIdOo1FYlpyIokoLrJzW
   g==;
X-CSE-ConnectionGUID: X7KC2j+KR6qWvsMJxHVTTw==
X-CSE-MsgGUID: gGpoFtibSASadCF98arhMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2337753"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2337753"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:33:35 -0800
X-CSE-ConnectionGUID: BZuv6bbXTIufvBEHQF6bAA==
X-CSE-MsgGUID: ZFqCaQV7QumlBqJqm0axAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8022066"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:33:35 -0800
Message-ID: <b06c4c02844b9d16dc5bf4dc050687aa4e99094a.camel@linux.intel.com>
Subject: Re: [PATCH 11/15] iio: hid-sensors: fix a division by zero
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, Sanjay Chitroda <sanjayembeddedse@gmail.com>, Shi Hao
	 <i.shihao.999@gmail.com>, Jiri Kosina <jikos@kernel.org>
Date: Mon, 02 Nov 2026 09:33:34 -0800
In-Reply-To: <20261101021729.4a0df058@jic23-hlaptop>
References: 
	<20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
		<20261027-llm-char-misc-iio-v1-11-0d818334f6c7@linuxfoundation.org>
	 <20261101021729.4a0df058@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, 2026-11-01 at 02:17 +0000, Jonathan Cameron wrote:
> On Tue, 27 Oct 2026 17:19:15 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > convert_to_vtf_format() divides the micro part of a value by
> > 10^(6 + exp).=C2=A0 The unit exponent of a HID field is a nibble and
> > goes
> > down to -8.=C2=A0 For -7 and -8 the argument of int_pow() is negative,
> > which
> > the unsigned parameter turns into a huge power of ten: 0 modulo
> > 2^64.
> > The division by it is a divide error.=C2=A0 The exponent comes from the
> > report
> > descriptor of the sensor hub, the value from a write to the
> > hysteresis
> > attribute of the IIO device.
> >=20
> > Multiply by 10^(-exp - 6) in these two cases.
> >=20
> > Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and
> > trigger")
> > Cc: stable <stable@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > Cc: Shi Hao <i.shihao.999@gmail.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +CC Jiri, and Srinivas given they are co-maintainers of this driver.
>=20
>=20
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>



> > ---
> > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
> > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 9e7c26e37880..3b0985d500ae 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -140,7 +140,10 @@ static u32 convert_to_vtf_format(int size, int
> > exp, int val1, int val2)
> > =C2=A0	if (val1 < 0 || val2 < 0)
> > =C2=A0		sign =3D -1;
> > =C2=A0	exp =3D hid_sensor_convert_exponent(exp);
> > -	if (exp < 0) {
> > +	if (exp < -6) {
> > +		value =3D abs(val1) * int_pow(10, -exp);
> > +		value +=3D abs(val2) * int_pow(10, -exp - 6);
> > +	} else if (exp < 0) {
> > =C2=A0		divisor =3D int_pow(10, 6 + exp);
> > =C2=A0		value =3D abs(val1) * int_pow(10, -exp);
> > =C2=A0		value +=3D abs(val2) / divisor;
> >=20
