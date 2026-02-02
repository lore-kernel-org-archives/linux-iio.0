Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD5258CD9
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023411; cv=none; b=C8v5fCr4h1Vue97zSSny6sKD9OYLRavdfwG47iLA3ZpaXz+fNFNE7/rpswAYre6q3n8UyYf0vw08qEDXZVoRUj5L/kfoafeaO+4LymxTs5lOl0mc6okP3USI8wxmZPx/lc+sg0hMsXwiUwTFsj5sJJku6UeI9eXP7a2Q+zoofTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023411; c=relaxed/simple;
	bh=t8NJHcPK+pxmhW/ZiNEjiUTPapZ0kfKBoax9lUpdEOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag0EnAZqVm0FXWInexQmXi47AWs5ejFkXQLgzrlepb529+L7lxCl/n3tJ80dB369fe9hLpZK3UPNyqG54eSDZfx1iq5aVPk2KzCfBKGBT5QesFMsCTYpo8yG/ShR92kZwCX8KVR9h5lSKyk5yCZnFxVrx9dW4FYg86lbPgvKxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7F7BbRm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7F7BbRm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d67f1877so27610515ad.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770023409; x=1770628209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs2hNgTK4MyFkwvTtu2AJ6nbAuS2KHy3U5iGkz1dHRc=;
        b=F7F7BbRmkhM0cY6ua+2hCqKd2yc72YNTj/I1jeV0K/pT6+wEp6+cRh+Xw8KsNWHIxh
         DQF3HdA3MtwRJabCVDAokkCIeyXNAMMftGhP9Zg7g4N5qxd+iHcN25UlomDN4zAODNnH
         Y+QU9doj5UyvCrofsj3zJB0fPjo+KbLtUXS5QZFLYgev8RFHK+7B5rgSI8/iMtVCBnN4
         ytDGqW0EIUKud8fwgOpGmyYvsmFMxebTwAYB5qJJJo/ia8B4n8X36sxTTOLayNe7o8tb
         fuBzdRe3p+jAe5i2q73XcMJCaA/F7IqjsXT3u/vGAYi3G9OxoT/+sZG1WuvcwkQ7uRUN
         4L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770023409; x=1770628209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gs2hNgTK4MyFkwvTtu2AJ6nbAuS2KHy3U5iGkz1dHRc=;
        b=PPQYen82nRYpOUojbpVUuz/2M6Dz0oyz02WRH7AiFiPSVKAkdOF9gb14cQJlWEAf6G
         czOqzgCEMMg2LHHX/RuV0ASKssDZQO0glvzgWp6lbnnox+WEZF4oE+Dt+LdmTnqiQG0+
         9I3drbke3/9x34zxExf58Yo4rBBoyIPG6xGARL9csPeBk+cODihBNyZ9zb3I1wVTqbeK
         EIQir9ztRMd1Zkfycbqfy8mAXhDzfVuRbBsRsfTeXbQS+wFFXIYl5FZHpVICUaBKhYf4
         HqrJBg39AJWuBUVySBILzS+cb7uqVt/VLr81vUA74wJw7zpp7pdUUVHxvNdX/qoQ5rMC
         RMJA==
X-Forwarded-Encrypted: i=1; AJvYcCWHpxkYWaOxRreiVBi7aD8fIRXqnjzh3G+aqh42dulkcXPnaAS0M9AsUI441g6Gva0+JI0sQtUVSJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+Fzngpp+rJh7gTH99xGR+O7Nz0nraJTEY6lQ0fynZ7tDGUtl
	B+9c2OX5XR4Y2nhD1WwdxTMYqB1mJFD46GPC2X+bsm3LVPcPx+prwt7+
X-Gm-Gg: AZuq6aLvODZd2NR9Jxvt0J18QPra9Az14HKuz0LIa0JUokSNUCXamyjnRA08Ij3Aeff
	++93u8GKTXmjj/fHSF4KGqp0hGwxkQYk+V3EbJvmy7KJ9C9E0D6fhvAeVBjiRJ9JTdCKikacvCd
	9kxxpn2b2qL9Ng0/mVnVhx1oSOqNhuUypUyBhH+OtV0dPPhVPk6X2kUIl09wdOGToIaX9xdUgH9
	+XwNaCOBCElxDk5tp9/Z1Zsuh9yGVUBxcW3eHGYPB0w23IEH6tVfD94vj26y5GttwYyIF2BVHz8
	/avYH+Ly1IOd3zVivwQw0ootjKKfuwL2C9Rv8y90C+huymznBT3jR3Ft2BkBkQL2sCEIFHBdgiT
	ceWdHYKseSKiE+tGotwXYF+jc4A+yfbZEmAgzeSgfQNm1rBKtxHLry5nu7VeFznAQRorNSH6Hom
	G5Iic5nGUJ
X-Received: by 2002:a17:902:d50e:b0:2a4:8cd:c3cf with SMTP id d9443c01a7336-2a8d8181601mr115472795ad.49.1770023409408;
        Mon, 02 Feb 2026 01:10:09 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef68sm149413095ad.16.2026.02.02.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:10:08 -0800 (PST)
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
Date: Mon,  2 Feb 2026 17:09:57 +0800
Message-ID: <20260202090957.228021-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131182205.5b851204@jic23-huawei>
References: <20260131182205.5b851204@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Fri, 30 Jan 2026 10:24:52 +0800
> Jun Yan <jerrysteve1101@gmail.com> wrote:
> 
> > > On Thu, 29 Jan 2026 15:11:01 +0800
> > > Jun Yan <jerrysteve1101@gmail.com> wrote:
> > >   
> > > > Add the device-tree binding for the bosch BMX055 IMU (gyroscope part).
> > > > 
> > > > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
> > > > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>  
> > > 
> > > Hi Jun,
> > > 
> > > Is there anything stopping the use of fallback compatibles? 
> > > It seems from the driver that even the chip ID matches.
> > > 
> > > That is, can we have
> > > compatible = 'bosch,bmx055_gyro', 'bosch,bmg160'.
> > > 
> > > or something like that (I can't remember exact syntax) so that
> > > if we have a newer DT, it will work on an older kernel?  
> > Yes, using fallback compatibles is a better approach. So from my
> > understanding, it should be modified to:
> > 
> > properties:                                                                                
> >   compatible:                                                                              
> >     oneOf:                                                                                 
> >       - const: bosch,bmg160                                                                
> >       - items:                                                                             
> >         - enum:                                                                            
> >           - bosch,bmg160                                                                   
> >           - bosch,bmi055_gyro                                                              
> >           - bosch,bmi088_gyro                                                              
> >           - bosch,bmx055_gyro                                                              
> >         - const: bosch,bmg160
> > 
> > Or in a similar format?
> > 
> > And drop the change in the driver?
> Explicit matching can still be a good idea so we name things
> correctly etc, but this driver doesn't bother so indeed
> there shouldn't need to be a change.
Got it
> 
> Whether to add only the new device with the fallback is
> a question to the dt-maintainers. We'd also need to check
> if any DT files in tree need an update for that.
Alright, I'll redraft the patch and submit it to the corresponding
dt-maintainer for review.

Best Regards,
Jun Yan
> 
> Jonathan
> 
> > 
> > Best Regrads,
> > 
> > Jun Yan
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > > > ---
> > > >  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml          | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > > index 3c6fe74af0b8..907fca4e5895 100644
> > > > --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > > @@ -15,6 +15,7 @@ properties:
> > > >        - bosch,bmg160
> > > >        - bosch,bmi055_gyro
> > > >        - bosch,bmi088_gyro
> > > > +      - bosch,bmx055_gyro
> > > >  
> > > >    reg:
> > > >      maxItems: 1  
> > 
> > 
> > 


