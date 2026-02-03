Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167A341076
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128709; cv=none; b=V7iv6dREW7FLURxNqtBpgkr9+4kED1vszQSj5/moAkIfvk7AxwQ/h71pLsRqEQ+JyvU68WPTCvpsesvZaQScWY+XJeXXdaun1xqmIfIdMdKqCe4mi5Gao4LXiqnJxB6/fj29eSd2iYnMPRX4ZXLrtgGKVIkPn1vp64FwHHRkgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128709; c=relaxed/simple;
	bh=sAY9j2KZbhASSjH4q5rvNxi6gAMjaheniDUO/8eBnV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnAdxehNbg7dI4AjbR4TgxqGku59yjHoaIccsCv4irNDyIWPVrdFqtHftPlY5+BngcjtJf6IDRMWHY+tD1h1/AuoXurFbK0lq9btlG+eN1VqAJATOAVWCOxmkQ+Rsjk35lgSjbCzBZFIOWNoKVr8tOFiA3nTp/9STHTqVhU+Hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQGp3Rtv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQGp3Rtv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3530715386cso4201337a91.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770128708; x=1770733508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7Mm3l4nbWWP8YApz1mcy831DRM/mYgrRVRky5J6vkI=;
        b=hQGp3RtvkGwXy+eaDUXg+9GX9X392AQwXGXb2XaeKJoS07CUJaL98Nt1sy840fcvIa
         W/IXCmQ7+wb9Un6mQc4cbVDhAwAc5oozfyh4koKXEj7tOPilVptM8F2fKN7P2PMXUmAd
         DU7uJmPL/NobUq1MVUXSOCpLwm0bMdm2oR7FjK0zPHlSTya40PwjgtO+NO2YUCFECijn
         LQ1Di1bLTGaCw2kD2UhmjRRcC66BFpFJJggI5SffYXXoxwrsm5Z65Ab2HAzpkCtEA9W3
         Z4EISzBoTDWK1v3Hitt2kYfTrQAe3eQJf+kDXGxkbIzJiAdfEjMHMa4nAfFXNV3R5yUz
         6Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128708; x=1770733508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7Mm3l4nbWWP8YApz1mcy831DRM/mYgrRVRky5J6vkI=;
        b=jOvdxRZAtGk1bntgo+Xt/nDD4Zruk7oo9ygWGHTMflW1oT6hGpKcPOyelUffxCK3oG
         hTZ88D3bb6R0NWomO3BPwsEIBTkexXl29JyaPgoBNp8cffRq0D+yU4G+M2TJrMe+qkZa
         FTchXyyzeSre+FAHzyhiPIVLguUJrG3iBR8e2ayYFfgRDhm//WsGy/XgLVtcT5ALS16L
         I5XUTx8G8nnxbMMVhGS0YI5SlKxVdYnH2AXoprcE9ZTNJhhs1iSJt7yhEAFapAwvALAI
         e80IJJFUVrRkR8oqd9uTkaGicgjCN3jwxDlfoEHoyGhVeivS1tRp7Ck9yR1Oar3Ss3DY
         0TRA==
X-Forwarded-Encrypted: i=1; AJvYcCXcIneOafc/FIasLOlZWdImaU+1PqwBLf7wE9/Gd3vESFElFsBRShrk60hB46gVnjbNho6EJrExZec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TKuhllP8/VJSjiuspXzmS+f1sv2fyqQ83L84rki8dmGMFgwG
	R7IHefCVnZeEynNebjs06e6pnyheXZWdhW3uUEDHb/xdRQ5OWwFhRTqU
X-Gm-Gg: AZuq6aLsA79a0gjPJoM+Bas9rSsfVeP+aqPRteJqNB+zjGMNTFGQWdcgRIvcAcQfWa/
	83c06+Q3pkEmwWBR47ZrzbcVjsa3Y5+k8/aJDuoapwPOo77w288PNBh3EIAEz4tOoZaRuv575rP
	9IUyLqF8GQahIoOcKWDeaPOHlbeTlYgcpe7OEQnmgBOEUxC61YXuppkTx9nDw4VJix7UPEbzXbC
	ZCNA+8cFOsXPdx499ZgIHxMmMYgfgGZr9zAM3Li6d6OY45SRUzV3BeOuNkrwXzhpfP1lwgXE6qC
	MvZC9OZ/5Cp1Wyyalk/3WCm8ZvQWP4hbJZUTfiJ6HhBSTgWA4Htcu88zpspgIP5uJyelhpE75S9
	+4aiYFpvG9wYZP9uuoNc/1/FR9rWkyLriZP2+4mJ7xRcrot3Iw/WYJVN91MPePm0G1UNWPK1j1T
	i8LgJi7uYvhNKPdGwDMRk=
X-Received: by 2002:a17:90b:50c3:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3543b2fbcb8mr15459255a91.11.1770128707866;
        Tue, 03 Feb 2026 06:25:07 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547f7a682csm2084189a91.12.2026.02.03.06.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:25:07 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linusw@kernel.org
Cc: devicetree@vger.kernel.org,
	hns@goldelico.com,
	jerrysteve1101@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	stephan@gerhold.net
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Tue,  3 Feb 2026 22:25:01 +0800
Message-ID: <20260203142501.297003-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAD++jLk=TxX-zMOudMTniydopMFcvWONBMahSFhmA-7CD4-xKQ@mail.gmail.com>
References: <CAD++jLk=TxX-zMOudMTniydopMFcvWONBMahSFhmA-7CD4-xKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Jun,
> 
> thanks for your patch!
> 
> On Mon, Feb 2, 2026 at 12:03=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> =
> wrote:
> 
> > Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part)=
> ,
> > which is compatible with bmc150_accel.
> >
> > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
> asheet.pdf
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > ---
> >  .../bindings/iio/accel/bosch,bma255.yaml      | 43 +++++++++++--------
> 
> DT bindings must be posted to devicetree@vger.kernel.org, please resend.

Acknowledged.

> 
> >  1 file changed, 24 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yam=
> l b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > index c1387e02eb82..5c44b8cf156a 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > @@ -16,25 +16,30 @@ description:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      # bmc150-accel driver in Linux
> > -      - bosch,bma222
> > -      - bosch,bma222e
> > -      - bosch,bma250e
> > -      - bosch,bma253
> > -      - bosch,bma254
> > -      - bosch,bma255
> > -      - bosch,bma280
> > -      - bosch,bmc150_accel
> > -      - bosch,bmc156_accel
> > -      - bosch,bmi055_accel
> > -
> > -      # bma180 driver in Linux
> > -      - bosch,bma023
> > -      - bosch,bma150
> > -      - bosch,bma180
> > -      - bosch,bma250
> > -      - bosch,smb380
> > +    oneOf:
> > +      - enum:
> > +          # bmc150-accel driver in Linux
> > +          - bosch,bma222
> > +          - bosch,bma222e
> > +          - bosch,bma250e
> > +          - bosch,bma253
> > +          - bosch,bma254
> > +          - bosch,bma255
> > +          - bosch,bma280
> > +          - bosch,bmc150_accel
> > +          - bosch,bmc156_accel
> > +          - bosch,bmi055_accel
> > +          - bosch,bmx055_accel
> > +
> > +          # bma180 driver in Linux
> > +          - bosch,bma023
> > +          - bosch,bma150
> > +          - bosch,bma180
> > +          - bosch,bma250
> > +          - bosch,smb380
> > +      - items:
> > +          - const: bosch,bmx055
> > +          - const: bosch,bmc150_accel
> 
> Maybe drop the Linux-related comments because DT people seem not
> to like this. But it's not your fault because these comments were there
> before.

Thanks for the suggestion! I will remove the Linux-related comments as you
recommended.

I will send the V3 patch shortly.

> Yours,
> Linus Walleij

