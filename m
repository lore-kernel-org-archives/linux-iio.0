Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793872256;
	b=W1f3duFbw716crF/xXVYTB4iljeJpiX/R2NgxDi2p+jQOAu/QMnKLTaWrkBb9DJ2fxAL
	 uIlFV63xJRi3lK/lS87NJTi3AovjC7L0lO73DFO3V33Hl2PhdISd4iE+lkZa5raHRxyif
	 MDjxGSe9hpXR47ZUSDEEAsumDWDYjyPXAp5iD7VX+oHbj8NVPxdWsBevjNuktxIBA1bEq
	 wqTJCwUASW4fCaiqVrEDxJ5Y0SR1c+yiSHtucKtUwaXXtqJ//hNclm8hDSxAH+5yGyeF8
	 7V7haOVvq6wHcs7HuJfpv1xOoFx8nWPgwYPAP5Wz3aTlI0oamWI0fwbDS4oRAAN74OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872256;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=XSaDscozYZ8SMksWFMf70AsI7Ua2SyLtwYoUK0Lk26Y=;
	b=wh12bevWbaXJG6MQQveB+DwZYiP3SV2Spwhek+EaRclu1jiIzFgZGb9YD4J/JheGwgDC
	 1JuqNveeLI9XXtB6jfdMlQ1BPSYyUVN5lu3zgQk81U8urB8m56fY+zAmb8zKdRq2d3/BF
	 D1x5GYPqX6lYLoVxepd31YSXmCZUBcpH5Y4b+9FjtcHAYeAD1O3U9CaKP3qyG0KkEYg99
	 r+lCxTsPqb8cseLAuMVscStKsglIXZ73FjSJBzfD7GFbj9I5MWxk1wu7D6KdtGrwLXD5S
	 bqfrU9zdDW9OVuuLVJv9GAgCs3o2XNsSPlMihwi59g/XcJoCHrRZ/OBsX64xwPx9CvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nDO01GAL;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zQtF6CQ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F94606A326;
	Thu,  5 Nov 2026 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nDO01GAL;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zQtF6CQ7
ARC-Seal: i=1; a=rsa-sha256; t=1793872242; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pqgbLHzJouvfrBA7VQI2YCkyciUIpXJFgMys0UJYRWWX2N6OakMN9CtnBseyo76Cgd
    NhnI65dqDpxBdoqYilG4h1f8sAtMHxw4sLNT6s+Oo9nh8fUvakK749t6lQN606EJQK/l
    68P+yNstwUOZiLwm8T+2urc6fEnBj2YoT//hvESd0xfazWm2pz0K1rHq2Y/iYAGex5kC
    AzjDUVq3j/rp131Y87Znt6XBSLA1OiWmX4UCIRaHcu80J43vA8of1/NXWkNayynxgMYZ
    waEmQecHO2J61Jpn7jsUOg+ZIGHd7ubsIahyW/o5ckOtal7oreBzX0K2Xs8cIsZWfAvc
    z8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793872242;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XSaDscozYZ8SMksWFMf70AsI7Ua2SyLtwYoUK0Lk26Y=;
    b=GJHqcBF3jA9j/KE/oKwCUurjjGdov88kKAI7b8axHAsGg0mX6xSPSiXyyM2xLAAAxY
    pK/uXASqLNvVFB0L28EgPvlntblGMt5uzyRMWlcfT6uqDSj6qbeXTL4MFC3H0zA/ODJT
    FP/SN8TVlYgrLdBerZa1qkpKsywQ8vyoZwXtXa3qylC8sF9WThFmkm/p+MrjrL0v5M/T
    /ceETs0KHMTX0K4HDifKVs6I6iSkM4MyGr9VOZwPt6+AsdTuMLPfB2IXQ3OoQ1OTDOkj
    /ArQamBQNdY2MIFadhVvUX9JM79kIaGzupNfo/0kxg1JfRMQqHON/Qsg+spN2ezzgrtS
    IvbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793872242;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XSaDscozYZ8SMksWFMf70AsI7Ua2SyLtwYoUK0Lk26Y=;
    b=nDO01GALfOZDtxTEyMM7N+YDA5kHjugbfb7HFW6jIREXvPMeEj3p7BvRmB+G/+dHrq
    OPanrFAWrDYlxjBaB2+gqcVZj9J/1pNJAB/7hN3GNNvUomQ5gN6sKZrZa5PrI/x9LDok
    TKxucYHyqD4Cd6bWWDjyFEBfdYKN61z/MYLhoZpvVWd9nVOfA9/fbCuVQbxzStBaOZzv
    j0PaXCGrJAEXtYFnvJ8Yp5wFMzQDuguBhRWS0Be9I8H/PYA/bjlBT2JEhzSurgr5N+az
    uZlnAYlkwDC6k0Woef3J2rFyZRO0sHUPr/uptEAw4b//6nkUedVM1jDLE3ExNH/TovPz
    mpxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793872242;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XSaDscozYZ8SMksWFMf70AsI7Ua2SyLtwYoUK0Lk26Y=;
    b=zQtF6CQ7VTY0UC1XMsXZ1iWLjMg4IOt7ybyGDPRJ4h+YBGNsTmFnjT0rnUZBpnv22R
    ox4SHccfSc/UDWLCEyBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A59ogi16
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 10:50:42 +0100 (CET)
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v4 0/2] iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261102201155.10948-1-olivier@mgcrea.io>
Date: Thu, 5 Nov 2026 10:50:11 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B790159-827A-4699-A48E-2313C04E3413@goldelico.com>
References: <20261102201155.10948-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 02.11.2026 um 21:11 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> A driver for the SAR ADC of the Ingenic X1600: four auxiliary =
channels,
> 12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys =
are on
> channel 0 behind adc-keys.
>=20
> As in v3, this version is X1600-only. The X1830 and the X2000 have the
> same register layout by their programming manuals, and a chip_info =
with
> the channel count and the resolution can add them later, with a test =
on
> either.
>=20
> Changes in v4:
> - The Kconfig prompt, the header comment and MODULE_DESCRIPTION() are
>  the same text (Andy).
> - The read computes the data register's bank and half next to each
>  other, and the two macros take them (Andy).
> - X1600_ADC_CLK_RATE_HZ (Andy).
> - Read and write helpers that add the base (Andy). Plain MMIO rather
>  than regmap: nothing is cached or shared, and the only
>  read-modify-writes are under the conversion mutex or in probe.
> - The device clock rate is clamped before dividing (Andy); the divider
>  comes out the same for every rate.
> - Binding: the description's last sentence and clock-names dropped; =
the
>  driver takes its one clock unnamed (Krzysztof on v2 and Conor on v1:
>  their reviews and v3 crossed).
> - Joshua's Reviewed-by on patch 2: the changes to it are the points
>  above, with no change in behaviour.
>=20
> Changes in v3:
> - Cover letter (Andy, Joshua).
> - MAINTAINERS: no list line; the binding's path in patch 1, the =
driver's
>  in patch 2 (Joshua).
> - Includes for what the driver uses, copyright line, MODULE_AUTHOR(),
>  reverse xmas tree, open-coded return, no message after
>  devm_request_irq(), a blank line (Joshua; Andy on the return).
> - fsleep(2 * USEC_PER_MSEC) (Andy).
> - The ADC clock divider is now even, as the X1600 programming manual
>  has it; v2 wrote the divider minus one, as the vendor kernel does. =
The
>  divider fields are named as in the manual, and the two clocks only
>  repeated sampling uses stay at their reset values.
> - The probe comment on staying powered up no longer names the keys
>  (Jonathan).
>=20
> Changes in v2 (Jonathan):
> - The comparison with the JZ47xx ADCs dropped from the file header.
> - No mod_devicetable.h include.
> - X1600_ADC_VREF_mV.
> - The status declaration split from its readl() in the interrupt
>  handler.
> - field_get() for the channel's result.
> - fsleep(2000) instead of usleep_range().
>=20
> v3: =
https://lore.kernel.org/all/20261026083631.48406-1-olivier@mgcrea.io/
> v2: =
https://lore.kernel.org/all/20261024041357.34346-1-olivier@mgcrea.io/
> v1: =
https://lore.kernel.org/all/20261023204209.48556-1-olivier@mgcrea.io/
>=20
> Olivier Louvignes (2):
>  dt-bindings: iio: adc: Add the Ingenic X1600 ADC
>  iio: adc: Add a driver for the Ingenic X1600 ADC
>=20
> .../bindings/iio/adc/ingenic,x1600-adc.yaml   |  53 ++++
> MAINTAINERS                                   |   6 +
> drivers/iio/adc/Kconfig                       |  10 +
> drivers/iio/adc/Makefile                      |   1 +
> drivers/iio/adc/ingenic-x1600-adc.c           | 257 ++++++++++++++++++
> 5 files changed, 327 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c
>=20
>=20
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> --=20
> 2.54.0
>=20


I have added this driver to our LX16 kernel and it appears to work. I =
can see
some slightly fluctuating voltage values at e.g. =
/sys/bus/iio/devices/iio:device0/in_voltage0_raw.
Since the BGA balls are not routed on the LX16 I can't test the =
performance
of the SADC and/or driver.

for the series:

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - driver =
only, no real world test



