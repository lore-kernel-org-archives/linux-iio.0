Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A883F23CE
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301886; cv=none; b=kK7Nl9A5+eoMMl21SoI1z6KR749XmSLowNuohKWStRu2ZlXU2wQ6FECNTQlT88k3RQpNmZgfOpjJls7A3tXhpcNtAoqi5NyuO2j23abmJ74JBKFNx9SmTZj7NZYfEgS3ntVYlW3Zyo+p2y7tDWuOk0SO4TIujBGyHGvamAVo6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301886; c=relaxed/simple;
	bh=JZeAuuuLafuGrx3L2sq9FAK/OZliEE9nxDyzt2d7O8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlEbQqYuC+EAQ44eKgAtjhyDEwlHJh7awz4ImAyu+B/2B7VQfiF4FXfg53xTZFksxA3WnEBSHDrlqXriX+TRdkEbt7J9pIboHzFAF3UZPw1c3mqMTnY56I3VIesAM8I1gCCkCdHUs47UO7BoWS9+22w3HMyaxZQ9SAFBU4RwSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn04vphs; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn04vphs"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c9f47e1e8so369667b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770301885; x=1770906685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azsr7YK6tngJTMSrKOLWG/XzxoPwzNWngFRjXFfu8Kw=;
        b=Rn04vphsDCUt2te0KdQdG/5Su9mZvjzZjdr2IgU91BFZOpWe7q5bvdiHuF39Mxjc5+
         1lkd2ZyjIqwHraMX/mOweNuaGqttTXDwpwQRvsR6hrIkpR3OIqpOsyP72RitPVLqnDoj
         ED8NdAWZMavuCtZTWaDBSPeXekRbgWzmBPjHXljQncFP98hwRq815thoJuccbgGiF6MO
         IdeX+sOXnYdlS/yt87PcP+GwBakxdD5bfKLg4iQULzXuaEqnWOZBMUm8YBFs8W5+Z4oM
         rXAnhEa54h/YGmEJf3IN4c429NTKSq7Enn1eeESEwEoX3pUljUNwTsN6usCUn/fX56hF
         bNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301885; x=1770906685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Azsr7YK6tngJTMSrKOLWG/XzxoPwzNWngFRjXFfu8Kw=;
        b=wHrC+9uZ1J7GyXfWBTnxZ7Uc3yQZtpgiVRxHQ76kvJPCycxAYQlXpJrSqMS37mWFOz
         rPkUrmm4z1F+QkBnej7wndUNhp+DIJXgBBSM+JP5XjqeIjeIKuoEIjTaZuBJKCrGzbi6
         9Pzn5tLCUuEMDZveFwonp9DopRRf07pvM8fQeVHpad50tMe/7IvxXNxeMk/AXXstbTTa
         HlhgCim00KXZ1R/NJZ5wD/KxpVnRwp/27BgSmkuEc1V3nRaiMbmiGZeAdZqyHAVZmYYT
         vTqdoadUuMeIByf86dUQE7iv8dGQexJa8KvSeiks354sePI5E1PHQwkubWpYdoSIAjK6
         XcrA==
X-Forwarded-Encrypted: i=1; AJvYcCUtCZVZpIdOsrpUE0sV2wDiPklI0Ddx9eEaaG76HMk168b5oZ78TE6l/Eb4xu78Hk1o4jO4gVt9qNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0q7JDYQHUSSINg9tUFV+H9YS5jX7Qi/HZDXOV+0+gO2H1aCx
	IA9xtP+oyc62q1Xc7PlbAj7hrX7YvnVnXzZprE/Sv4FAtI4i0/4oHUQj
X-Gm-Gg: AZuq6aKeTI4WhQpmA/vyaYM8IYTkv+Z/28x4iCRGGOwku7KpqxYJsGYsWnWbs+Bh24Y
	JaI9T5VoYohUGL/7kDKQ+7tX3PWODzEsWkxbkAV0kgiuU1lTszD0O+pKXrrQGYE1anUAg7FcPG2
	WuKeybpyVKkG8+/TqEaRSygVeODucXcmHM/2orKM3eaIzO3P/tfttRLjbqrHWZGj4S/eELfh5tz
	BtQXWFN2/QiRw60dj8/5yZQQpr/AjFH9WttGR3xJBDJqphBHz9i4p2z9y+/7U5+/zSJzXgUyxbQ
	Ws1ukxy9mBDoYRNTefMByy/POXy17g4RUi9ZoW1xtSOT9lAoID4eD1jDGYDEiU6+/AA2uNXua7O
	ZEWC6OwbRnmhWg9xVLeYwURsi7UdhhOZB8mwk1deXLmlGBB5AgWIQ13wcB5Hw8FULHMvENTkCSi
	o6rEACOe0hkWW/sTVpumGWYwuV
X-Received: by 2002:a05:6808:1395:b0:45c:9785:bd55 with SMTP id 5614622812f47-462d5aa1bc6mr3195208b6e.54.1770301885160;
        Thu, 05 Feb 2026 06:31:25 -0800 (PST)
Received: from arch.localdomain ([117.147.91.117])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a590fe5f7sm3625224fac.9.2026.02.05.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:31:24 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: conor@kernel.org
Cc: devicetree@vger.kernel.org,
	hns@goldelico.com,
	jerrysteve1101@gmail.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	stephan@gerhold.net
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magnetometer binding
Date: Thu,  5 Feb 2026 22:31:16 +0800
Message-ID: <20260205143116.521460-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204-venus-dweller-20e2c228acc4@spud>
References: <20260204-venus-dweller-20e2c228acc4@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
> On Tue, Feb 03, 2026 at 10:39:42PM +0800, Jun Yan wrote:
> > Add the device-tree binding for the bosch BMX055 IMU (magnetometer
> > part), which is compatible with bmc150_magn.
> >=20
> > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
> asheet.pdf
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > ---
> >  .../iio/magnetometer/bosch,bmc150_magn.yaml        | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc=
> 150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bm=
> c150_magn.yaml
> > index a3838ab0c524..09d1dc861d4f 100644
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_mag=
> n.yaml
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_mag=
> n.yaml
> > @@ -21,11 +21,15 @@ properties:
> >      description:
> >        Note the bmm150_magn is a deprecated compatible as this part conta=
> ins only
> >        a magnetometer.
> > -    enum:
> > -      - bosch,bmc150_magn
> > -      - bosch,bmc156_magn
> > -      - bosch,bmm150
> > -      - bosch,bmm150_magn
> > +    oneOf:
> > +      - enum:
> > +          - bosch,bmc150_magn
> > +          - bosch,bmc156_magn
> > +          - bosch,bmm150
> > +          - bosch,bmm150_magn
> > +      - items:
> 
> > +          - const: bosch,bmx055_magn
> 
> s/_/-/ here please, we don't permit _s in new compatibles.
Got it, will change _ to - for the new compatibles.

Best regards,
Jun Yan
> pw-bot: changes-requested
> 
> > +          - const: bosch,bmc150_magn
> > =20
> >    reg:
> >      maxItems: 1
> > --=20
> > 2.52.0
> >=20
> >=20
