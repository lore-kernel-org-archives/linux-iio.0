Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793952576;
	b=AyasTh2Mb55zcHyqnkedINvYKAnxByH1lgT0Ejjces+AunyaLn59FL5l0Dlf5t3tRaUJ
	 c23fVHBP2cLrowyAnAUCDibHxFojBzjfgK5B4Rpgnj5zIBloNjbnqTa4pg08IZOIuaS4W
	 wFyf3QMIJdXyEcIzH59P1dXPVWWdTigTaEppueFd1Fk9heooAst4cxnzsQZZRAEmq5qt8
	 l58rx75wXb9HplNmZzo1o7CMuPCMFLlpTT6OM3tD/Gz87ZDZHWM0TyAGNWnIfJy/38h3E
	 vMbtoWbgyqXw80/Jlq4fYz8d0OwtwjzY/ExFSdhpCGAKEXkM9hBz1oZ92cV8RvKhocg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952576;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=9DHnHmwgL1OmosWzzTHjck5mwcRfs0MMbIzhWMbXd/Y=;
	b=PuCysPbvmRoCo4QCXLb82FfTRNoguUqVpvbK3TRHJeAesT/UIV0okIklfSxd9qr7AOwh
	 78IdJxMpOwrm6Ex55YFt3qeOmVNCimTS0cNT2bLy9PUX2+/ndhYEsPG5dESiuOr0ZDHv9
	 PHpqEhnBg15ZQQ6p10522VA1YHSvl2PyfqoSRDRq/xpD9y5VGNNJ8lP/Qd7lf1GkG7Bso
	 OuraLiF26Tpb9YdP00PdMwTUKHfpgsny1dWZmmjztBcM06j+LsZYJaXraHPBhrtS4cCUe
	 YzTO4cU0C8fBn3CGWO/WFVmi8700FGmjRF+vYTcpE2ylyObiz6zYBgv0zaSQjwmxgFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XSZLK5m7;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VR0KYczT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD6606A326;
	Fri,  6 Nov 2026 08:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DD6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XSZLK5m7;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VR0KYczT
ARC-Seal: i=1; a=rsa-sha256; t=1793952564; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KzDGjWAAk5BwIVdG/ZSUFgUkmjbh12v8BMzJUsm8hM1gB0Y7Jrl7Cel/aNTdfgwA+/
    M5qFnyGlUwxaG98v+AyhmM1zES9qLRhSnVjyxSWGSC05AxG7DxZZm98+CqDMMyCgTOT9
    PxAvZ+/syKd0uJGD3+J0S7AI/B7PtWCXaTN1jTXOPRmOfhQYZSwqcedPVMg5JhYmVpZI
    jE2L1nMzbJ7MMBIu+eNzQ3BXHjgrSMjIEyLBpZPHD7vcoueheN0L9G+I8BEcBEVet4Bm
    fTO6XNyu2hdkNDsyMvyfaGW7cpyr204zdH/BZdotab3eSCY80DSMJuI/dSX0EdzivH2c
    7AjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793952564;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9DHnHmwgL1OmosWzzTHjck5mwcRfs0MMbIzhWMbXd/Y=;
    b=J+SQY0ANB0/W6fiPh+bcb0y13XHEI0kPxv1C7boLs8vxL4Zq97kenqv4EAc937F/VD
    lcsp6VKRLDhMaKwwUt2fHxgqLs/MdexNKdopg7J7+SG8zHtXukwM3HzclUTw+7bRQBr9
    kU2B0m/Dh8dLH+WnIckTsWid9tzZ9Yz0WSt5L5tPuQALFkfVv7VxVR0tlQO8SJFUnDw6
    pIyVQ7A0mSe6i32xwOG4/dAKxEJU87ldMpD4Jex4vXMKqMt3Bt1CiAZfXky87tq4gvaW
    qE371Fj3IPAcZTy8tqJyR6EFFGjq291LaXOSjyE1q/W9g/iqONnVVsQaqWcY3VztuYXo
    LGWA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793952564;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9DHnHmwgL1OmosWzzTHjck5mwcRfs0MMbIzhWMbXd/Y=;
    b=XSZLK5m7ivHySo9pofy1WJd5U+WdbM8CqeW+C9xI2nzU/0/AqaN9xDf+JpV/AzygPH
    eWDHweBl0oMpByyjmW5637ripqPIPY0Ti8oWEXNgKK/eBezwHETCPMrTX6lAHuSPSz1w
    PwK45teMvNZnTAPdSIxpjXl/UNvH4NiX7iV5+a6pcl8frBkwM5gEM6bfunlVJGGwYmhk
    9H6kKre2QGhdP1bJPVIsZSire8uwUBwXB+za/4sxeR7gsRW7y2d9GtlhHl2aNXNJjn47
    BDGSHiM5JlUPz9BDInneyP4tOrKXaOgBjSn4W/stCgOVUjCXXbbAAdrJaxn/nsvbEA3F
    OGmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793952564;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9DHnHmwgL1OmosWzzTHjck5mwcRfs0MMbIzhWMbXd/Y=;
    b=VR0KYczTH0TT8P2weYRJNCCqnS/z0ls83z+leOYVV/+KWrBoNivmzcoVOTmCG36VH0
    gLgJpEYornESdcLtlICw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrVjZoMy8iN4frnsPsBQ4l+mfK4O7kvgww6TmAq"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A689Ols9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 6 Nov 2026 09:09:24 +0100 (CET)
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
Subject: Re: [PATCH v5 0/2] iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261105213210.87457-1-olivier@mgcrea.io>
Date: Fri, 6 Nov 2026 09:08:53 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <crofts@kernel.org>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2B91AC9-83A7-4BD4-A7C4-DE0205A77DC0@goldelico.com>
References: <20261105213210.87457-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)



> Am 05.11.2026 um 22:32 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> A driver for the SAR ADC of the Ingenic X1600: four auxiliary =
channels,
> 12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys =
are on
> channel 0 behind adc-keys.
>=20
> As in v3 and v4, this version is X1600-only. The X1830 and the X2000 =
have
> the same register layout by their programming manuals, and a chip_info
> with the channel count and the resolution can add them later, with a =
test
> on either.
>=20
> Changes in v5:
> - Binding: the reference is the SADC_VREFP pin (X1600 datasheet: ball
>  P12, 3.3 V typical, at most the ADC's own supply), so an optional
>  vref-supply, and the description says so in Nikolaus's words. The
>  driver takes the supply's voltage, and 3.3 V without one. The ADC's
>  analog supply (SADC_AVDD) is left out, like the SoC's other supply
>  pins (Conor's question; Nikolaus answered it).
> - Binding example: reg covers the 4 KiB the programming manual's =
memory
>  map gives the SADC (Conor; Nikolaus on the map).
> - The driver's declarations in reverse xmas tree, the timeout macro in
>  jiffies with an if/else on the wait, a blank line, and clamp()'s
>  bounds on one line (Andy).
> - The clock stays unnamed: Krzysztof (on v2) and Conor (on v1) asked =
for
>  clock-names to go, as the block has one clock. A variant with more
>  would come with a compatible of its own and could name them there
>  (Andy asked for a name).
> - The name stays "adc" rather than the vendor's "sadc" (Nikolaus): the
>  JZ4740 datasheet calls its block the SADC too, and mainline binds it
>  as ingenic,jz4740-adc.

Agreed. I wasn't aware of that. So let's stay consistent with the =
inconsistency :)

> - Andy's Reviewed-by on patch 2, and Nikolaus's Tested-by (LX16, =
driver
>  only, given on v4) on both.
> - Rebased on togreg after -rc1.
>=20
> Tested on the HiBy R1 with v5: without a vref-supply, as the R1 is
> described, the scale falls back to 3.3 V and the three buttons on
> channel 0 work through adc-keys; with a vref-supply pointed, for the
> test only, at the board's 3.3 V PMIC rail, the driver waits for the
> regulator and takes its voltage. v5 is also built with W=3D1 with and
> without CONFIG_REGULATOR.
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
> v4: =
https://lore.kernel.org/all/20261102201155.10948-1-olivier@mgcrea.io/
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
> .../bindings/iio/adc/ingenic,x1600-adc.yaml   |  59 ++++
> MAINTAINERS                                   |   6 +
> drivers/iio/adc/Kconfig                       |  10 +
> drivers/iio/adc/Makefile                      |   1 +
> drivers/iio/adc/ingenic-x1600-adc.c           | 269 ++++++++++++++++++
> 5 files changed, 345 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c
>=20
>=20
> base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
> --=20
> 2.39.5
>=20

