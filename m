Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A57260D
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590575; cv=pass; b=tQjSs5r2A/2xJYSqCFWhzgBmC7bui+5IzICIvvUNWWvmDRyLp8aU2cQrQrlbXdtdkn6IKUwpaG3+nYl5db1mdMh52djsdf5xzpV5Dyi+glKmhGbny3R8gisjJPjcwVkj3z5r9Bvca/4nXqOr53JNqWwsMGxV8/Qweno93jXKnrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590575; c=relaxed/simple;
	bh=Uazk3xK9wPBFQkKZppbojFNdUVou2Ob2+/OEgBGJQQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8Te9Nd9hVebt+49QMMMJsYkkA/8BBOVb0yaox0kfnK+EW/rTIZ5MxEi2RuKOhnlwkEstD8rhh/vX1pKbwhZxKvPX2PPfjwU7hqSqeDWTpPtoiEbVYULwbp75LJaBsB5HvYAO11C1ZWzNT4a20sddbwBRf9I7X3Rx0/6Tqvlw0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ensqr8gy; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ensqr8gy"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso6158700e87.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779590571; cv=none;
        d=google.com; s=arc-20240605;
        b=kk5yRPDnWv1Uf1BTUoh5gVyZ54f0S9A9/oiJKDfYoyIosYUrPoHFl/2pm7HMVoHs1D
         gFKAOg97yQBZEgFAlyWgKghqNGGzDjFuNnI3eW/qltriJ180iOyvLtzZayCG9TDwAvrC
         Md19SYEEo8m3TIQO7r5Kyh/J4RPw4ZUMPokdWnVLZezGG95SLZiw4RLO57W93UreGqAX
         yMBSe/krIo+LfjY88Kd33Yv2Fc3qBgncq4CVdcSKoVn6c1p97+LqrTFeibd2zXHQHtJf
         2f58+VrocZBcVRz4VEQ5SiiS3pJIjRYil+DeXLkmwqsAZFxJb3lzxQsTcz3xeuW97hFU
         N/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=triryNx+ggLH9l2yeoXzdiA8OekP3cVQgbIoDK/NrA8=;
        fh=IUBVRv0LkA2fTmEdnXJAOpW+T8xzg3AtLoy/R2nvIWw=;
        b=GkgLcVd+I3ppvUXjSm42Uo8iW2oKf/j8W6tEMizuOKAS+qekGrVCoi3BT6fqc0KLIO
         Hx0VBa3kfdreLmfMD/7ZDIW5nJCqMuZpB51b1T9GP09ErjT2W1ZvLVI9sHSHVpnm0CXq
         lGItZM+wwHmQDYJqe1rLksxKBhWSyPo2K0DUbwt5jUvJb6N3P1Qmj4WZ4i5eZG4nOJMU
         I1zDU4eQlvmQ425sgEp76wIbvJ2Nzpw2u64d9vG5SOc6rFdPSUq1XhmFydhnH9yFQvvm
         ZuGadn9zHPIFBQC5r09MLZnyV3juTlxiouM97UDAgonYx0Sk+0XBOBDdS/sIUiKwgM9V
         rt9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590571; x=1780195371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=triryNx+ggLH9l2yeoXzdiA8OekP3cVQgbIoDK/NrA8=;
        b=Ensqr8gyjeNcASciiKepYpn8r1y3sIW0UmqLRsnlpWb7+XvRXiT5mBgj5YkBV9io7z
         ZmCLRkkGEtxzWgNhi6kipkD1SDcBG6YkQ4UEO0bNQNQoLpCc2dFXuV3irjesIUJ2Ays0
         psOWVdOE3ZncDal9viX/ErT1D+P2fJUfUui/H+6UeQrhV/0DN8Si+dSM37zrZUkBEMW6
         YVetdjyczw4DVRCptTE1atQ3Umy81KdBE8jUWGorRZymXTl/ja90i9+xqoMnHmHnoMgM
         irkRBgqOSXY7H/nWB5TDNH1z+msKEpM+KDpVDJ91rGofiEADf6Y8vkoH96/D5Mcduccz
         F4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590571; x=1780195371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=triryNx+ggLH9l2yeoXzdiA8OekP3cVQgbIoDK/NrA8=;
        b=o9PHQO8KGOh+ol3UndZSTFWy0NxBDSGNvu0GXKsGMkM2C/BjTCI9Wwtrf3L8CpOFjF
         1Qj0j+Tsei+2GDKXKoKFFBnrDhNoA1HDLPlpJ1+pffkcrtrsrXAH9TJfDMaDRDkAgxBH
         THX/+kyE5JLLf2rLUX4id2mEozRj7tQmb8ZYTPzCShAA2hp0FRiTwqOT+GuEcBWZSonn
         t+RTdF0CBmCRxdkeyKyuKZy0ka4raSSjdemBoYvQegYM61yhe6p1aXg7BJV+8zcKP5vf
         n1ca3+hjCaE4MClo3uJGTq2/DUb/rpL9uyXqGMSVhRtEIgNFQv7Dk+s93imNLmyUYu82
         6dIw==
X-Gm-Message-State: AOJu0YzZFAAJ2gwDZfTTzOC6AryfiGyOgFZMw1GI+Z4Q5cOrxMX+s2xK
	+y3XzIyho5w8kjAL8J2IqtK5uq+xCDxzre6cFrIZH64yZRXXDO/GpLH7YVEMzzAr/xct+tgiEpj
	OQ6/UJtLVibjyzCAh1kor378xmKo2B6UmiRNp
X-Gm-Gg: Acq92OHgbm1B1gdE78wnGbAXtS7vsMVQyUuQMhKMIK8k9iw63Umx0WVTWpczjCB516t
	ERYjTj9/k3AYxOAQ21a4rFM14tFVLXGIK4Vyrw2brynH6jb1Ph3JbD2Dbff5SFRlPIZHpUYcbKp
	20LYQRoQJlwOwxhdhJ6xjhqBem2D7SztFJnjt8IAnn/51EeFy7nA9GN5Z8RznPkFp95pca6pMkH
	XdcS1b45ZTIIoR0j+AOTwAXjnQhnn8gHMIXmN4RYZwfo6MvpeQXFQA3UBaNoc3WAuN9JthCZZL7
	Lau4rtGG7EaHEPtODJlTmhgAIyj17XX0dIJuupaL5dwziKaMXCXy98a1uko9Mw==
X-Received: by 2002:a05:6512:33c1:b0:5a8:88f8:9ed4 with SMTP id
 2adb3069b0e04-5aa323cb975mr2733941e87.30.1779590570698; Sat, 23 May 2026
 19:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
 <20260518220228.63322-3-piyushpatle228@gmail.com> <20260520110948.167c8e14@jic23-huawei>
In-Reply-To: <20260520110948.167c8e14@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 24 May 2026 08:12:13 +0530
X-Gm-Features: AVHnY4KGBDlPvL31bQmSmt-ZqeZ2ql2ufzbcRWI3PNEFr6Hx3R0iNdLqT5g0tew
Message-ID: <CAMB+xka2uJqf3E69r7XhB0LEkT0bWy4XCW2rCztTST9JX+KYaA@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, 
	Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 May 2026 03:32:18 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > Document the optional VSUP supply used by the HX711 on-chip regulator.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> See my reply to v8 around dvdd needing (I think) to be in this patch
> for the hx711 not later in the series.
>
> > ---
> > No change from v8. Already applied to iio.git testing branch.
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml =
b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > index 1ea60dff98d5..a8eaa1f18de5 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > @@ -33,6 +33,10 @@ properties:
> >      description:
> >        Analog supply voltage (AVDD).
> >
> > +  vsup-supply:
> > +    description:
> > +      Supply voltage for the on-chip regulator (VSUP).
> > +
> >    clock-frequency:
> >      description:
> >        Controls the SCK bit-bang timing. The value is used to derive th=
e
>
Acknowledged, and sorry for not acting on this in v9. In v10,
I will add dvdd-supply in patch 02/11 alongside vsup-supply with a
description that makes clear it is the digital input supply of the
HX711 (and not just a bypass capacitor point).

The description will read something like:

   dvdd-supply:
     description:
       Digital supply voltage (DVDD). On the HX711 DVDD is a board-
       supplied digital rail, distinct from VSUP; they may be tied to
       the same supply or driven separately.
