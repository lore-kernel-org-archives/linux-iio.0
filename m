Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09576312812
	for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739905; cv=none; b=OplolfnA7Evf/aVzbhFVDzWpsLEPgNXFaQLNlVhtsDiHICU0KVeawBbCd9OAIwXKp9WuA+YLA6P16Z36Edjr3qN1iTY0CkDMzOd0yR583PS+EL+xMuAMZjyYAoPZsMIMOp0JpGQgciOUHiXbTBl0C+InM3JzG11+uRUIIVEJLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739905; c=relaxed/simple;
	bh=kzhYXhREn6RwMkSW9qMIW70BzIlZYBjvRf7ET1u2KQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLDeM57B9wieAMFCcx6kkVNEO9PupknaQ9AaeJlazYU+Ej0+Xp8MmpihHbhCzsUc+NG/9+C3mLcYQlQVaTJloZ0CBsGxtW0/HEU7CrDnSYb/5OGxMsnReRuQqSNBi1CRR7CORZ6ySyqASU7fKr4b+fZnbUDGINIMhpAs28+EWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS/WDgXp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS/WDgXp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso7882425ad.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 18:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769739903; x=1770344703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ3D3414B66E+5q6RJr97VOs7kC63to24OAz7xg2T/I=;
        b=hS/WDgXpSBe0MnBRo3snhz9WL/iOGp4bLrG3xEY5/XR9VGrvIPeytB3umCDaXbMg1B
         pPOnwpGBk8K/qDp5rn7YFtI3m6iD2pF59FcBBbL/uG2qTzoNpqviKluBEfrcH0aEp3rg
         mIWkWGPssg36m5o7Pei0lHUTOwStJzNA0D+synYS0NQtoYwAZxQDWx4hKf8BrEYXjrpQ
         5KpjJd5Xdd8EGzVzRsM88qkFXZCVV2LN8uAXk4/b9i5qjIRDnOI69p49/aJr6j/T07zP
         phVwHJwCW84+KnM2HsHsz0g6ox5j/bQ2+PtfxRYMCj13BleI9Z8vplyl15xiTSP20rMQ
         id5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769739903; x=1770344703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJ3D3414B66E+5q6RJr97VOs7kC63to24OAz7xg2T/I=;
        b=BcgYAdORoM1gOTw5NQuDgpIDK0kpDkk854tPU5W4BIiSLJ9W/7yq9E/nqBrTSSKMMe
         PYmN/qvMBhfhJOeD9/exDd8RgcST6jsaWuWhjHmjExrz3F9uZBweKUWQOOLypCagCy/I
         8VZn9CLAcGy2n4U/ZECGv9hYilnIna1Bf7LGqDlYHuFFFxNxPbq78e3jAblELZIruQF+
         zd/Y9oQeO1aT3K+HSEH6dpYCLaXBOC4e49UZIZ3txlR9i0H4l9kskNfh9HnKyO+xxfTb
         jO6OlbhQuBfaukuHpJSMh2And82kW1eoDve98BXIwlnUP2M65liGBKyy3Cq6jMZnh5BF
         IMcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpjZvBrpsWXoceSRcJ5s3gBrqoPMY8j1dhntoq/6kCTNR/PGMAApHv7yDNJWzeLZ0bV4/uxq5s0bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjAh5sM347xBHmPEFxYiihO2iSBH8EoVwRgHW+7zcLbY8LidW
	/TfhMkhQMsNePcTAmXi6L7pkhXY2jIQO6m4/nzoHLLwGsRgLLssVWdN6
X-Gm-Gg: AZuq6aI41nl1abRdid7DECXttQqRnUMXnazNEJ67bFiarBjVP7grj5xWkDUimErCLrm
	ajeL0BpvUTT4GRjIfaPTZ0eVwY4As5/j6yM/Sjdv5qDR20bjPAzd6klNJk9OtoWYPXM4hsYdtUb
	o2ngQaosUofD2O2uCupfQYl7eOy1ARQR2lxWTAgcFRubb4IgflWHaNVNSDGCZV3EutmfkIXrgz/
	0ssj9gGngQuOw/WC+fH7yNvZh/2/FuJimV/wkkNNng2UpjB2xk2/4CYFGenCAE089nQfH0QzjIL
	B9yP4MZBC1h+e+KT+iqFaq6Z7/q5LQOIu8UjYr6DlX1wy9IHVYjPPbI/cwV2HUQLhuR5+8QKV1j
	21LBjtTwt/TIsZX5s37Seh6Cb/nDbRuFb9YD+Am8eY8li1lcKWZoYWjQcZgUq+cX2wUTbP+g7rj
	PbG5qZ5lo02FMiVphYLfMbw0F17GoW7/OIoMDvkVOLAcsKPuZt
X-Received: by 2002:a17:90a:d64f:b0:34c:27ad:71e7 with SMTP id 98e67ed59e1d1-3543b41d457mr1354053a91.35.1769739903069;
        Thu, 29 Jan 2026 18:25:03 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6129426sm9557402a91.7.2026.01.29.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:25:02 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	jerrysteve1101@gmail.com,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope binding
Date: Fri, 30 Jan 2026 10:24:52 +0800
Message-ID: <20260130022452.408784-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129184621.749d6450@jic23-huawei>
References: <20260129184621.749d6450@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, 29 Jan 2026 15:11:01 +0800
> Jun Yan <jerrysteve1101@gmail.com> wrote:
> 
> > Add the device-tree binding for the bosch BMX055 IMU (gyroscope part).
> > 
> > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> 
> Hi Jun,
> 
> Is there anything stopping the use of fallback compatibles? 
> It seems from the driver that even the chip ID matches.
> 
> That is, can we have
> compatible = 'bosch,bmx055_gyro', 'bosch,bmg160'.
> 
> or something like that (I can't remember exact syntax) so that
> if we have a newer DT, it will work on an older kernel?
Yes, using fallback compatibles is a better approach. So from my
understanding, it should be modified to:

properties:                                                                                
  compatible:                                                                              
    oneOf:                                                                                 
      - const: bosch,bmg160                                                                
      - items:                                                                             
        - enum:                                                                            
          - bosch,bmg160                                                                   
          - bosch,bmi055_gyro                                                              
          - bosch,bmi088_gyro                                                              
          - bosch,bmx055_gyro                                                              
      	- const: bosch,bmg160

Or in a similar format?

And drop the change in the driver?

Best Regrads,

Jun Yan
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml          | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > index 3c6fe74af0b8..907fca4e5895 100644
> > --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > @@ -15,6 +15,7 @@ properties:
> >        - bosch,bmg160
> >        - bosch,bmi055_gyro
> >        - bosch,bmi088_gyro
> > +      - bosch,bmx055_gyro
> >  
> >    reg:
> >      maxItems: 1


