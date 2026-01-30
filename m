Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0E309F00
	for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740354; cv=none; b=FG6CTWAywKdBYrzAdNLY+RllhKzyF8LNQQ/+WzEYUIb+nbgP6c4cADds639BLRFnLCh7zqV7CIYxIT+ZiLuV69eGDFGTBJvjUEmLWH45VSMEOFcbfz0hlO+KhoAIhlj26MF4jr2x9H2h6LuxfY0gQdtrmmPCGdf52Hd9F75T8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740354; c=relaxed/simple;
	bh=IfwsXcuLN5tvizte+jDjEw2Jj35Bpb4A7VUk9UXNBGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ9T4rK9ag+PsZKhUzB7Z14Ki6yXbLwBkJYoBxJTGjcbyqbNEGgkU5ivGvriMOvvN8DBYFOZSbAbDCUqx22LwJT0ACbYSoK1cVlXxqC1ypoHmcgdTy1OrdTh4iN0hc/9kL/AA61FMhZx5Ywude0Rg78WXfE5eh8vLIsKwRfqCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqTfe5Hy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqTfe5Hy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c27d14559so903566a91.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740352; x=1770345152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgoHHusRjnnQB2LDG5moC4choM6S4Od9JzHJlpQy1tM=;
        b=eqTfe5HyVxWquJKuuPbJpA0M4hbcbz8fqZSb/yUZ2yPr7Yxk5CeTPIp/oRptQeC9w4
         eD6ZGMP8s406kxeBfphecN+sRp6A7UNE8XoUlQZy/MUMawcIZ4knixBg2kG7hzXkx80Z
         uYlmYGN+C56MB7f6CVMF09eFcBOPo5hSouS9avplVcPkaz1hBV3geDG0METbTlzOFDic
         gm6o6wt7IUWNL3oaI7ZCSwQJiuaNKEHulYsQMvxm2Dg04ikZIjZ2nEITKfpMxmzArixR
         iWEWNnWCXi02nKw3Fauc8YqDHHwi/k0HE9Ur0DMkZpf7IwitPmZxCUILVOvKhz3z13HB
         ZKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740352; x=1770345152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgoHHusRjnnQB2LDG5moC4choM6S4Od9JzHJlpQy1tM=;
        b=DthXwzbL5yCdZ95BWmdcxpdp/OG5xqE1TMm/8DElfliHJnx54OiKsY/Vnnyf6Isb+V
         Hqt5UcdzhusYtSe+rpfX26URYfNs6dD5Pvms91/ksvRwI6wa5xysXD2R/O/Rsm4ENvcI
         JcO6a63UYAQjs9HXfPx9rJdwjnJ9rp9QSN0KuC5DUN4dVyrLH1n561ZRO7zh6xYWGXGY
         W7SZcaJ2xccG3TlPIlAzH7qPewkeTzdCzS7bYqEKRXbYqs2ShCRkB7yMYcUr4dj2Q7Cx
         prJufmwp3nXBCe/cc7veJ7hTHnPdxQnVhTLDa//wCtQsuKIp0rUoZuZXa/3ShGXG595Y
         UQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+BffAoXmMusxqRdvqGPAXiSZFYJhuB2henZ5dqUuqdyttcaBAKrJsNtiod2ashmLy28jC+CD0u/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Oov1hsnzjbuy2t+JDpwRcgCyoGlWM4c2ktfr1TmQwdX+uorE
	87QTSnd4MdV2hzlLyFQp/uLntwIjPahJusvu2j5GnYrS9yXx5j+lMkBz
X-Gm-Gg: AZuq6aJEYGpaO4zWY5K5qy2VK593RoPglRAWGAu5XInonlIYxXvLFPYmUdHEGAaTyId
	+jZ3i3KsKqilbccgokhJv58Xaxru9na03glQPQ9t30WKuP4bK0W+aCeQR0IXRGW6VlQg2QDZ+0c
	2ljzSnJxW7t/VFOKkV1blQKc4YnuJO+2153AfdMp0Qj/8OAzlkZUuqhiArsRqkT1Tr1QPVw3aHS
	y0Qw9mseTteKxpFuQRFx8ReBwrrKlENLNViIUdi2k3znFkFKXDWUg6Dcvz9uMb+jS5VwyvUZrT3
	88zWThcmVWcclAUEnuPQsv9Y/4o17MR0Y9eZzwCPEfmePoL6nvbTFpGdBzkK/6CMd6sRfyD0RRq
	a7FSZLBPwotpzEezyYaTWSM9aTttHf8zz9y28j3Ph9E7onUFEFdUyUGF6hxv4PP+9rqDCAyeOQd
	NFAVMF5U55pKnFHxnBrzcNhUTMSvKObJ4xIbDKxxUJ7uGcu/lw
X-Received: by 2002:a17:90b:3b8b:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-3543b3d65bemr1444392a91.29.1769740352258;
        Thu, 29 Jan 2026 18:32:32 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d4f1376sm258714a91.4.2026.01.29.18.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:32:31 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: robh@kernel.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	jerrysteve1101@gmail.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH 1/6] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Fri, 30 Jan 2026 10:32:26 +0800
Message-ID: <20260130023226.408983-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAL_JsqJHbT9j4hdz141bzurc=CNcapfWhNg23YwLuptvdykHdw@mail.gmail.com>
References: <CAL_JsqJHbT9j4hdz141bzurc=CNcapfWhNg23YwLuptvdykHdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, Jan 29, 2026 at 1:13=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
> wrote:
> >
> > Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part)=
> .
> 
> Please use get_maintainer.pl and send to the correct lists if you want
> this reviewed.
Sorry, I will resend this patch to the corresponding maintainers at the 
appropriate time (either in V2 or as a resend).

Best Regards,

Jun Yan
> 
> >
> > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
> asheet.pdf
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yam=
> l b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > index c1387e02eb82..78f043c38e98 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > @@ -28,6 +28,7 @@ properties:
> >        - bosch,bmc150_accel
> >        - bosch,bmc156_accel
> >        - bosch,bmi055_accel
> > +      - bosch,bmx055_accel
> >
> >        # bma180 driver in Linux
> >        - bosch,bma023
> > --
> > 2.52.0
> >
> 
