Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562453CFF56
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084047; cv=pass; b=cEAYMVO5EtF52TckJPUVC8Zpg9Yq5dfUMOsKYlsvk+8xKrpvVZIlFQTzl7UasQxaKb5lTqmrUN7es0IQAiDaUWA+CYnUgHQi3NCaXlWVj8EzrIuiuo6/+sKYKp7po0K3V6N/mc25P9KGmjAXQSsEgeotT0/giSt1EmLg8FQsuPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084047; c=relaxed/simple;
	bh=TEdCx4Ul4BPkVidIQLKMS6KkTXZps8JZ9GJQJ87hLI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7F+Olm6fEsbWSY/RBeoqqzgHhmZZjq+HGPw6G52Dnk4NBq7Qz/4MTx02EQlx1J1n5iFZ8BnYTU/x0/cw/swClpFcHnyBt1FAh6Q0dFP+UNaUPsB2HNKz59yQZLXn9mmkV3Wx9QdtqWYZysaZrOIhSa7adCYn8jtscapeiMN26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O48KkhDw; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O48KkhDw"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304cf518c9dso8086588eec.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 02:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781084045; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4pnLUi8hCZyW5WT9GQXcC/oyda3Nop7ONLDuQgPZk6tESXu6yTQdS3yfnbBWMysuZ
         Zo4zPNPSiedbwpz7NEin5U+vjTdGV7+c4HnITNbIMo/hS0xDjKXMSFQ3k1fdKS0iR5HM
         KWzw9bq0uoFU429RsYKM9pDyXAJiw+w/fryUFTdMopqE6NgNAfC9QavdFnca9zmjhJNH
         9vJfv4NIaRk8pXT5VPu3UkL2h7BEsFx3hdQWzdA0J2gpyBDbpKNUuwX+ComWGd9lODMe
         qNwdIO0tSP6pjb7jyayb5ctmvYHKMLijuQQ32RlBSbbkX+msYjE4K7V/1GYvuwpz/yEL
         85Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I/WBNx7vmi5VT9dRS7lbKabVM89kwH/AFfI7EJS7Ghw=;
        fh=GyYV5T6OVkG2NZZVAv83O+AdAWsIfuFAAAeDvdhFnh8=;
        b=LYivADq4FPDaz6n5Qh11ptTqD/j3/249qURFFK8DC8nu9UXADhFk0I/VLFwFf9dpor
         LBc80F6BGoCXeMgagm9lSAAgdJ/1HYGarAZjT8L81k2aSx3OBsu9xIMiS0S1ZF1OD/45
         /FdH7Mgpwkp1yRnO1INNydy5UWOEJTuoLpN0hhBLEHcggu3veRp5F1J7AJJlR5F1lfPH
         vOFrh5Nr2tieaXDkpDtFb5nV2x0UO5Rhj5LL9sLImgs8uEBJQzR/IViUsWos8WmwqRLf
         X7ova7dRh16aZoMS/r43cupfp+IuaDgc+kkPH/52HNi2C8tFx3sIQGS7q8YtAxOI87Rp
         JLmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084045; x=1781688845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/WBNx7vmi5VT9dRS7lbKabVM89kwH/AFfI7EJS7Ghw=;
        b=O48KkhDw4b9ie38dSOwhENbOhrKFtAC9GMzhH5sNlNAUv7HMI2IlSijZhcpI98us/o
         DYdZ0rxjcBsXb48g/PYWEZ78JaefrT0mzytZlBBabznYv6VC9LJYZL4t5ZuvqJWh1xE6
         by0Lyhk2R18ojiBi/MX2XC9Jm0RDJ8H3OelBW9ua1Xrq84tuw0iKurPciNNQMczRMaNZ
         1afo/wQ6fr43ySzDaYqgVmqIDV1XV1rkVLScsWilGGN17NOq44srPbMf7f/6RU1K9Vot
         jL/Jmcxqj44P/p21JKikTJhAvy458fhkpNGaX6w5RaqtdPwRXTtVutkueUmgWbGc/QxU
         BotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084045; x=1781688845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/WBNx7vmi5VT9dRS7lbKabVM89kwH/AFfI7EJS7Ghw=;
        b=bCQJPYe4bRcWCU+TWMR+DLHWuN3L99/aUpkAf1B0DYSWLaUcTnxsoBg4dmfdnMsfOF
         tk0RPwleF+Kvt+zJVZM4mO0YLU4mZlQJSelPN3f7cugIzpRyeBsBalUMiyVVGw1wI5Bb
         uJqBzDfJEkG4weSAS9F5AO47xvQYesb2ZYFkSMjfwGdcT0ubeL4wE/isRyuxevgPbwmI
         75F10Ymf0h62J0fuWEFlp2AWAI9v3pSlKIMFrKlEtQ8E9vFOhjJvWtCU6/OFs6HFJTTc
         OVxrD+anzYtQEWomCggoS3IEHcSS3F4++dFTM2NYvek8PUp8+0fe/E1iTk99o2YqZDQI
         jUlw==
X-Forwarded-Encrypted: i=1; AFNElJ+S6IViykSoLW9NgK/QuKe5aVsRnXhHeDvY/PRNYKTM+rdkYgNXewGk5NmKQDC7n5vmOBj575GHxyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qdnmHmWbpz5Q1ZF8K0y94dmFS4SS5L0s39v+n/FlpWPoHJCY
	bGDHkoAnaqJF+P1Z9XlnfOmag5Nva2JYnOsqoAubtfOclCnvwdaLrq+nOBjmUKaukVLQdXmpveT
	kbRTLENCCNOaTdpuZu2/025u2MvO4qv0=
X-Gm-Gg: Acq92OEFmbikxZ5U0xC+SLOILo9bQaKMTxeTkxAT4HwEQtnGukte0y5wLZtF+0YM3lO
	V57XH2cmJJfUtCvd/ZP1fSqR7iK8VEeRUFzYUhOr7lWH+T4+MGb/R5zaYV7krwC3vfw9iVxXqzL
	ytpCpbp2we4ID7jni1okGOSFyeTPThZa0IEj/qNmnzno9dk8TSlhiQxvGgPgbScyRC71hcZQIsd
	uhMQGTiz/VBPltTx+bicBZoQZEQ4ZD3hA2ADDjDL7aSOtO3MDCnwX6lEe8ysYk2pVYn/by6KyKC
	99C8jbCtVyHBbaunzHzaKliueFXoDpevcPxuCPvX9KpxZhqscEH2lhK+frMXn1R9Fud8CORSuTH
	dgTQ=
X-Received: by 2002:a05:7301:22a3:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-3077b2615bamr15346976eec.27.1781084045265; Wed, 10 Jun 2026
 02:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
 <20260607234343.22109-2-kimjinseob88@gmail.com> <20260609-glacial-colossal-38b4937ec620@spud>
In-Reply-To: <20260609-glacial-colossal-38b4937ec620@spud>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Wed, 10 Jun 2026 18:33:54 +0900
X-Gm-Features: AVVi8CeIpvFBux1wEAZY6Bff68TrrIEZ3OnIKWyWrYDouz-MKRCStpTldHFDGGg
Message-ID: <CALMSew+cL0_kG6W15RapxLtE+Fw2_DYdrYoRFSjENQktWw2H4Q@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion device
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Do you think it makes sense to permit a regulator here, so that the
> "host" OS can power on/off the board running the osf stack?

From the OSF hardware side, yes, that makes sense.

The current prototype used for testing is powered independently, but an OSF
device may also be integrated as a host-powered UART peripheral. In that ca=
se
allowing the host to control the board supply through an optional regulator
would be useful.

Unless the IIO side prefers otherwise, I will add an optional supply proper=
ty
to the binding and matching optional regulator handling in the driver in th=
e
next revision.

Jinseob


2026=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:19, C=
onor Dooley <conor@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Jonathan/IIO folks,
>
> On Mon, Jun 08, 2026 at 08:43:38AM +0900, Jinseob Kim wrote:
>
> > diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf=
.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > new file mode 100644
> > index 000000000..a4049715a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Open Sensor Fusion Sensor Aggregation Hub
> > +
> > +maintainers:
> > +  - Jinseob Kim <kimjinseob88@gmail.com>
> > +
> > +description: |
> > +  Open Sensor Fusion is a sensor aggregation hub. The hub exposes an O=
SF
> > +  protocol data stream over its host interface and may report capabili=
ties and
> > +  samples for multiple sensor classes. The Linux driver discovers the =
actual
> > +  sensor channels from OSF capability reports instead of describing th=
ose
> > +  sensors in Device Tree.
> > +
> > +  Open Sensor Fusion is not a generic industry standard. Public projec=
t
> > +  documentation is available at:
> > +
> > +    https://github.com/opensensorfusion
> > +
> > +allOf:
> > +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: opensensorfusion,osf
> > +
> > +required:
> > +  - compatible
>
> Do you think it makes sense to permit a regulator here, so that the
> "host" OS can power on/off the board running the osf stack?
>
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial {
> > +        sensor {
> > +            compatible =3D "opensensorfusion,osf";
> > +        };
> > +    };
> > +...
