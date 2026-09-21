Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543648594A
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992000; cv=none; b=Ts61QFqTtZjrRePrjy8fmT3nPaR5+x7F70ti/XGAvCQ/DX7O1qVNeumbmMgtGE2Deg+ZkPEcUJjWx+7HogMDaMTauCsWtJkpHyOalukknq6QSqoOlI8EKC8dEaTcKGjc7584vt2bIJdbagYyWWBnox85bm9OVGO6Zf1gp55SLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992000; c=relaxed/simple;
	bh=bEPzRIyIzB0IF+0zjejBOzqxA+2cdOa9NJ/Zly89bAI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ehwQCWGVBf3VCvW+p03emVL3YVemWHhgy/fm+DH7kYvsPd0iZP3a1in9N/++EjsJLe7hDtDNYrQO0myiLqvnPDcF3pU2Mr7f8qSsZcY8PCk/jjKoszmU/XtyA4kFap0qMxHNU5Z9SH7OohJB4P0f+DQ0PqhYcZO9jQC/PjOn46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie; spf=pass smtp.mailfrom=conchuod.ie; dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b=BPPz4J5q; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b="BPPz4J5q"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f56039dso372399966b.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google; t=1789991995; x=1790596795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vm99IYdaFdSFEgRLWbOM1gyDbfw+zjAxHYiDcpK5GD8=;
        b=BPPz4J5qUJbxgD7iIKL0SLMwKlXYaEe66n6DuChwl9Bu8fECKtyH5K95L0F7hmdLyg
         36C7rzq9E3YxTGtqdpPWhHdXSRDpGlk1qfi860PsbV0WeWjitFq77bXvlR7USfE79jLS
         RG4SY6xHOlFPk58mJ36rmc5JxpSDGZe1m5ahwBHwyTlLh4w1G+oKGCj5sgIX8NPNYXJE
         xZzL4yTxrlpGTJz1kUS1sX09ss9vL3JMVLd+3XsI4tASFs7X9Eb8kr5aUk3WaBBlhesh
         6EW+dcAo+EXgAxtT/nMFFYo36YZ4FIYKDmYzT1CZugSknZsOgdEqWaJaBhv7CCPuE31j
         v9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991995; x=1790596795;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vm99IYdaFdSFEgRLWbOM1gyDbfw+zjAxHYiDcpK5GD8=;
        b=RDcwiB5wtxzI+ds2mugwC3eseGqa7QwK0Xir+wDqWzQq6SxDG42HdtUtgw9ggwax5h
         RgEIq77pHO8r0ADnKBLDdKeEKnPrkDRI9HSALtTD3N6kJ46i/4XBAzcTerOBvNq/r60b
         NdifResqbM6YIlPbfTqThUMPK+88GnjOfZuz0nEvsX0zxjn7v9Hos5M0LC2bcaXTbIzQ
         QJVzI1zb1EaGq6hHlKJjceXNHU4wcdLhH8avXwwE9jyvqlB/K49rhqXpyJh3gUX0cEKr
         /eRS8mDl/fc1VxninhDQIoF80JeB091fpEcNnLbwA5QUqOpojCflQqpcMpn5xWbwz+ma
         09EA==
X-Forwarded-Encrypted: i=1; AKwUvBxVmkxsG23jMp4ujK8/TtlIkrl3lJ87El3CFHLXW4foYdXhsqc2KmGndpvEoyiFqfOAd3xXeJigDic=@vger.kernel.org
X-Gm-Message-State: AFuF++km+873CStcEjLXEUSsR8KjtoX4FJgBeRSQEST+/hBcgoB8dyBH
	uxg9Ik9MlQY7H/nDzq5mb5iFe1ynpKNcXsQud4Hhqygy00cvGjWT0yzn3Vgk7C6ism0=
X-Gm-Gg: AYBFou28Xnmyjww844Qh8jtAmTNCgsErgu6G0gany4UhcQUuJs3YFhi9+rLl6BQ6LKh
	DWrlwc/pmEi9pbynF7VloERuvLrHLK6Zhql0RWlPe+GX+N1sxlzoZK7hl6/1QTUA1kR0CJEk3B6
	Il6fuZylgvag6cEkO3GrTHWd2CaDPdjyGLytB7/7vcZpW0oV2p0/zGcy5zrmbn2jGijkJ5jyyo6
	yn/BvTO7V7JhD4mv3C5dmwovv6jRNgtHUmsaPP4+t+hhm6Af4rruxaqv02K372aL/GzLwYFxX8O
	8rIpCDuN5AzLN180qVSNfoMvCEMYSfpo26rDu5xv5/VZqT0Q3DgiC2XjFybh/jZgG5fWSkiA0vK
	DtQ4vnDsQqdGSbMpZ+SOJM3KXBd3FhldcF7UJrvDX4HcpY0SCs/RMM/MZ0bZcqrhfL2HnAtOX5+
	Z6kwxRcVtMHqnio1w+xmrQ2FoliyHHTmDdoYNx6cxPDb9lkvN1QW3fDFYAzMA6Tpnves1QuiuD
X-Received: by 2002:a17:906:c10b:b0:c26:19de:9138 with SMTP id a640c23a62f3a-c2a15cf34efmr955118766b.43.1789991995191;
        Mon, 21 Sep 2026 04:59:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([80.233.32.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3523816dsm290466766b.2.2026.09.21.04.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:59:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:59:53 +0200
From: Conor <mail@conchuod.ie>
To: Chang Yu <marcus.yu.56@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shi Hao <i.shihao.999@gmail.com>,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
User-Agent: K-9 Mail for Android
In-Reply-To: <arCp0DQpBiOk3zvz@zephyrus-g14.localdomain>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com> <20260907210042.32552-2-marcus.yu.56@gmail.com> <20260908-dinner-shelve-1d61e19ee3b7@spud> <20260913014203.2bae2222@jic23-hlaptop> <20260915-gleeful-jester-c8114edf28ff@spud> <20260917034823.03940ac4@jic23-hlaptop> <aq3rdBcMw1XcHnkL@gmail.com> <20260920010448.114fc597@jic23-hlaptop> <77D15400-6ECD-4661-8733-E1F4F85077AF@conchuod.ie> <arCp0DQpBiOk3zvz@zephyrus-g14.localdomain>
Message-ID: <0FB27C18-FADD-4791-8159-41FE6D04D8F3@conchuod.ie>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21 September 2026 05:51:44 GMT+02:00, Chang Yu <marcus=2Eyu=2E56@gmail=
=2Ecom> wrote:
>On Sun, Sep 20, 2026 at 03:14:30PM +0200, Conor wrote:
>>=20
>>=20
>> On 20 September 2026 02:04:48 GMT+02:00, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>> >On Fri, 18 Sep 2026 18:55:00 -0700
>> >Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom> wrote:
>> >
>> >> On Thu, Sep 17, 2026 at 03:48:23AM +0100, Jonathan Cameron wrote:
>> >> > On Tue, 15 Sep 2026 18:11:17 +0100
>> >> > Conor Dooley <conor@kernel=2Eorg> wrote:
>> >> >  =20
>> >> > > On Sun, Sep 13, 2026 at 01:42:03AM +0100, Jonathan Cameron wrote=
: =20
>> >> > > > On Tue, 8 Sep 2026 19:13:55 +0100
>> >> > > > Conor Dooley <conor@kernel=2Eorg> wrote:
>> >> > > >    =20
>> >> > > > > On Mon, Sep 07, 2026 at 02:00:41PM -0700, Chang Yu wrote:   =
=20
>> >> > > > > > Add binding for AMS AS7343 which is a 14-channel multi-spe=
ctral sensor
>> >> > > > > > with i2c address of 0x39=2E
>> >> > > > > >=20
>> >> > > > > > The GPIO pin is described as a generic GPIO for now=2E Bin=
ding design for the
>> >> > > > > > more advanced measurement/LED synchronization use cases ar=
e deferred to
>> >> > > > > > future patches=2E     =20
>> >> > > > >=20
>> >> > > > > Unfortunately, you can't change what you document, so pickin=
g something
>> >> > > > > correct now is needed - even if the driver doesn't use it ye=
t=2E   =20
>> >> > > >=20
>> >> > > > Definitely needs an outline of how it would be backwards compa=
tible and
>> >> > > > an explanation of why not now=2E  Sometimes a portion of the b=
inding is
>> >> > > > so uncertain that we do kick it back from initial version but =
we 'must'
>> >> > > > be sure we can extend the binding to new configurations=2E  No=
rmally this
>> >> > > > is one of those we are fairly sure, but not entirely sure case=
s - or
>> >> > > > picking between two options where consensus isn't being reache=
d=2E
>> >> > > >=20
>> >> > > > Chang Yu: This sort of things needs discussion and is one of t=
he reasons to
>> >> > > > go slowly=2E   =20
>> >> > >=20
>> >> > > Ye, I note that there are 2 more versions of this since I left t=
his
>> >> > > comment, but you seem to be on top of that=2E
>> >> > >  =20
>> >> > > > > > Datasheet: https://look=2Eams-osram=2Ecom/m/5f2d27fff9a874=
d2/original/AS7343-14-Channel-Multi-Spectral-Sensor=2Epdf
>> >> > > > > > Signed-off-by: Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom>
>> >> > > > > > ---
>> >> > > > > > Changes in v2:
>> >> > > > > >   - Add the LDR, the interrupt pin, and the GPIO pin to th=
e bindings=2E
>> >> > > > > >   - Fix node name and unit address mismatch=2E
>> >> > > > > >   - Include MAINTAINERS changes=2E
>> >> > > > > >=20
>> >> > > > > >  =2E=2E=2E/bindings/iio/light/ams,as7343=2Eyaml        | 6=
9 +++++++++++++++++++
>> >> > > > > >  MAINTAINERS                                   |  6 ++
>> >> > > > > >  2 files changed, 75 insertions(+)
>> >> > > > > >  create mode 100644 Documentation/devicetree/bindings/iio/=
light/ams,as7343=2Eyaml
>> >> > > > > >=20
>> >> > > > > > diff --git a/Documentation/devicetree/bindings/iio/light/a=
ms,as7343=2Eyaml b/Documentation/devicetree/bindings/iio/light/ams,as7343=
=2Eyaml
>> >> > > > > > new file mode 100644
>> >> > > > > > index 000000000000=2E=2Eb06d445b92b3
>> >> > > > > > --- /dev/null
>> >> > > > > > +++ b/Documentation/devicetree/bindings/iio/light/ams,as73=
43=2Eyaml
>> >> > > > > > @@ -0,0 +1,69 @@
>> >> > > > > > +# SPDX-License-Identifier: GPL-2=2E0-only OR BSD-2-Clause
>> >> > > > > > +%YAML 1=2E2
>> >> > > > > > +---
>> >> > > > > > +$id: http://devicetree=2Eorg/schemas/iio/light/ams,as7343=
=2Eyaml#
>> >> > > > > > +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml=
#
>> >> > > > > > +
>> >> > > > > > +title: AMS AS7343 14-Channel Multi-Spectral Sensor
>> >> > > > > > +
>> >> > > > > > +maintainers:
>> >> > > > > > +  - Chang Yu <marcus=2Eyu=2E56@gmail=2Ecom>
>> >> > > > > > +
>> >> > > > > > +description: |
>> >> > > > > > +  The AMS AS7343 is a 14-channel multi-spectral sensor wi=
th i2c address of 0x39=2E
>> >> > > > > > +  https://look=2Eams-osram=2Ecom/m/5f2d27fff9a874d2/origi=
nal/AS7343-14-Channel-Multi-Spectral-Sensor=2Epdf
>> >> > > > > > +
>> >> > > > > > +properties:
>> >> > > > > > +  compatible:
>> >> > > > > > +    enum:
>> >> > > > > > +      - ams,as7343
>> >> > > > > > +
>> >> > > > > > +  reg:
>> >> > > > > > +    description:
>> >> > > > > > +      I2C address of the device (0x39)=2E
>> >> > > > > > +    maxItems: 1
>> >> > > > > > +
>> >> > > > > > +  interrupts:
>> >> > > > > > +    description:
>> >> > > > > > +      Open drain output active low interrupt pin=2E
>> >> > > > > > +    maxItems: 1
>> >> > > > > > +
>> >> > > > > > +  vdd-supply: true
>> >> > > > > > +
>> >> > > > > > +  ams,led-current-microamp:
>> >> > > > > > +    description:
>> >> > > > > > +      The driver current for the external LED connected t=
o the LDR pin=2E
>> >> > > > > > +    minimum: 4000
>> >> > > > > > +    maximum: 258000
>> >> > > > > > +    multipleOf: 2000
>> >> > > > > > +    default: 12000     =20
>> >> > > > >=20
>> >> > > > > Rather than a custom property, the tsl2772 uses led-max-micr=
oamp:
>> >> > > > > tsl2772=2Eyaml
>> >> > > > > 46:  led-max-microamp:
>> >> > > > > 81:                led-max-microamp =3D <100000>;
>> >> > > > >=20
>> >> > > > > I wonder if the same should be done here, or if there should=
 be an leds
>> >> > > > > subnode? Perhaps the IIO folks can comment on that=2E   =20
>> >> > > >=20
>> >> > > > I don't think we've ever bothered with a subnode as there only=
 tends
>> >> > > > to be one of them=2E  Given the enabling etc is all hardware c=
ontrolled
>> >> > > > I'm not sure a more generic LED binding makes sense=2E I don't=
 know that
>> >> > > > much about the led bindings though so maybe it is worth doing =
a subnode
>> >> > > > just to use the leds/common=2Eyaml definition of led-max-micro=
amp?   =20
>> >> > >=20
>> >> > > Could always just put a ref in to leds/common=2Eyaml and not bot=
her with a
>> >> > > child node=2E I'd stick with the additionalProperties: false, si=
nce
>> >> > > there's lots of leds properties that probably don't apply to a d=
evice
>> >> > > like this=2E
>> >> > >  =20
>> >> > Sounds good to me=2E
>> >> >  =20
>> >> > > Cheers,
>> >> > > Conor=2E =20
>> >> >  =20
>> >> A quick heads up, adding a ref produces the following error when run=
ning
>> >> dt_binding_check:
>> >>=20
>> >> properties:led-max-microamp: '$ref' should not be valid under {'cons=
t': '$ref'}
>> >> 	hint: Standard unit suffix properties don't need a type $ref
>> >> 	from schema $id: http://devicetree=2Eorg/meta-schemas/core=2Eyaml
>> >>=20
>> >> So it looks like we can just put led-max-microamp, and not add the $=
ref=2E
>> >
>> >Ah=2E That's a bit irritating as it is assuming the ref is to get the
>> >type rather than to make the connection to the standard definition
>> >of what it is=2E  Conor, what is the best way around this?=20
>> >Maybe a comment to say where it is documented instead of a $ref?
>>=20
>> From the error, it looks like this was done incorrectly, but impossible=
 to tell for sure without the snippet=2E
>> The ref I was talking about would be at the  top level
>>=20
>> >
>> >J
>> >
>I was doing something like:
>    led-max-microamp:
>      $ref: /schemas/leds/common=2Eyaml#/properties/led-max-microamp
>      minimum: 4000
>which gave me the error=2E
>
>IIUC, Conor was suggesting something like:
>    allOf:
>      - $ref: /schemas/leds/common=2Eyaml#
>
>From my limited understanding of dt bindings, the above should not be
>used together with additionalProperties: false ? So do we want something

It can be used with it, you just need to list the property in the schema y=
ou're writing - which you have to do anyway because you're setting constrai=
nts on it=2E

Cheers,
Conor=20

>like:
>
>    allOf:
>      - $ref: /schemas/leds/common=2Eyaml#
>
>    unevaluatedProperties: false
>
>Or just stick with what's in v5?
>
