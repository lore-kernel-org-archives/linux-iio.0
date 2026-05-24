Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CC14AD0D
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590769; cv=pass; b=AJH73454P5m1CcC3B8Lb1MMzdzK/n82dSPJarT6I3eeYXFUqekMjjpopP2aHaS4VgX9V9OW/x1psEh0Nd0pN14z7KdFueAcV80H9b5heCx4dtSLolqKPzl9ZZFBmidkg+dz/zSP2Wr2zfjW3yA2jkeHndBN6ZzJHBwEvLwmi5iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590769; c=relaxed/simple;
	bh=uZPUt3363aHN0DUEbP/jucw4ks5E7ZQoG8cHJtLqzDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9LF1ar//JRDOa0NnuUAj2NH5J1+VBGkJ1wHry5UsnkIMHtTXkxvrmnKywjqzH4hPLbmGsZ5vGzKRz9dSITrgW7+m+zd5pHOy5DiOaZW5WJfCqV5q6t0TDPXJj/yXVGcKZ0IZkIr7zl1CAMJs14q5q5oDF5yRRMiyGvcto63SJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjNIMvZf; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjNIMvZf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393c40246afso97184831fa.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779590766; cv=none;
        d=google.com; s=arc-20240605;
        b=X13B8AAcT24WhLn/KkyCNHEE7uilO1rbBPKm/NIM6moVTvFaTGzFQ1jWuzHNvblIuF
         rJCwBh/vwMjhGBGecMz35u1yhHIxSfV759daOdx9tYV7/yEQBk5Srt1ony5xbOyPUBgw
         pGB7UPBhQVZ5Ysdffvw1JKk14CSxw5y8/io8r+ycvSOpu4os1EkIgbSFF6pjpq+gnJOm
         72Ppp1c/10JPzyQ3/OCd//vGwDwrmeNEQjxA09N8BeYRH81aYtT2d/Qh59Y0KO2jCtyM
         MXiwOtzFfhvdTyEhbpnAosudhmZTCg/fnQLR9g5pR05C+qqDD8QyjQEwV8kuVPvrCFpo
         KryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LGTbgaUXa1T8NXbfdSHyyWoA5IWhzhn8eKyNnFZGpns=;
        fh=IUBVRv0LkA2fTmEdnXJAOpW+T8xzg3AtLoy/R2nvIWw=;
        b=MUJKZA4LaVAfRZ0JJJId4QjpWMYPJ+iRYpIhQKRE0wns/XHD+8hgKaA9Z+egy/VrsU
         ON6sXCg122IMy/um9w8LjIPxsWppQhAKYZwTVHCdI4dLJsQDlQp4/Bis2PSdDQLRpURp
         bwlFmdsmNikdEZw/g98SGJc0h80+M4gBXgvSojoSJ2eFMh47MMpVThReBzTbubxUQt65
         xb6SHIBNNHvVjAKgMtsjenWTSmsQ181NG8MQWz/xelAhuSy+RCbwxcmCDungGpRD7vZ4
         LzALBZpFc8CfcebN3IC8x8cAe4r8H6OJagY5LhYgWySlVeaqh3ZceXq7XJxFDu9dpbo0
         REKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590766; x=1780195566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGTbgaUXa1T8NXbfdSHyyWoA5IWhzhn8eKyNnFZGpns=;
        b=gjNIMvZfdP6RSA5wSHZzZNH092wnoUZhK5ztlpRgmqAX/m4je9YeQyMXcLzBgurGmd
         9A/OkCWtaPXy5Et/npv2mDPQD/GjFFcCUNS703vjurazVkZaVX4ClqeMvAumoBNvm3gK
         hSv63CGMrlig5QeIruGp58PPzeVUd7a/OJjgr9pbOP9DyDNNqSHvA5I+zhN0bdHxIVQJ
         aHDYVWxMtl3sTKBufKn7/2S+PnSUdWpSNyGzZd7QR4DqB0g2tQUMi+0gvZ8kghwDqAaE
         ng3HVXe9f9dgw0jsMT/orXd+8/y8Y0c+RJr6pcCrWO2UIogPW5DiwikOZnIWl9swr3cE
         UiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590766; x=1780195566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGTbgaUXa1T8NXbfdSHyyWoA5IWhzhn8eKyNnFZGpns=;
        b=R39/6Tym9hxDHHE4MIb8rvWX+f3whtXn3QwWNWgTAZfVj0SF0pgnCc6NWbUoZNt9C9
         mU7sQwYfm3NZA+SHmV416eBRZx66Ohd5ORGSTcucetYYTn0WtEe735qM8aFK+JxAwsup
         bWt6YYqqqlD46BP7qUWjs87pzBmjubyK3LdkmTRIva89i4qE6jn3/jNsQtqOskcaU7Ln
         6IhRGpvWehk9Bj/VQLqqsx9hX532vB38dcNNFQTp+NRXpHgpfRj8yQYbG6lY0fd0/JTg
         oYvjr0SuGqta5FGc2rC0SGM8Pejav8ZI1QU94Melvpf2uE23cGbodyTL5wEUutto1GON
         Cdxw==
X-Gm-Message-State: AOJu0YyNP3Rb6nIUUD3gmOhUCWl1P/POthc23WaTFCkw9eJ45rgUPnc5
	twa6Bu68FtUT4+B0j2JLKIkMOe1rTt8gwMqC1scFABm2uZ6Yh45g+4M1jlK1lepHMfoyYwK08YN
	3fdZUv7OOKu8YJoF8iPtjTz5iHw19U4QPhk2t
X-Gm-Gg: Acq92OGXsE+trnnn2Q5HP2C83BoaNwDMh1uckzXfxhOXzkrECqMuXbGOcjZTkoU4mIN
	BtFfV49HyCPrRAftvXBLLuJoG20kU9H+oCQt9aQ6CnJ7LGNYuHz8b7vsavxBuxL4pgzR4n4MnHS
	9LIHAvk0Pntvy4CKoEBsHg2bsbvBb0EXuh8takwwRX+JWlzFDOBNVvh4T2p2UvV4UZ+ny5C+ZHI
	+BYVPV8gRW5fdNyQtYE+bmq2oRix1O8cq0o5RaId1cFy7eDKcUp0pwcGRtoclzIkd+S06S3jswJ
	9cWKObEF66y2WbheI4Hh4orhkDIKloQ9jUOdehl+
X-Received: by 2002:a05:651c:b0a:b0:38e:8503:6fb5 with SMTP id
 38308e7fff4ca-395d8a064e7mr36272791fa.30.1779590765592; Sat, 23 May 2026
 19:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
 <20260518220228.63322-5-piyushpatle228@gmail.com> <20260520111919.5e99fe72@jic23-huawei>
In-Reply-To: <20260520111919.5e99fe72@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 24 May 2026 08:15:27 +0530
X-Gm-Features: AVHnY4KJEqvKtPhRF0o7fAyR7IdmJBiIwmlz-vGVAM2-cM7MNI2rCTM-8DJbIB8
Message-ID: <CAMB+xkYUC-OqncD+SxOo9K36ZR9iC-5CFUs6wKojz2j+M24K4g@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] dt-bindings: iio: adc: hx711: add HX710B support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, 
	Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 May 2026 03:32:20 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > Add the avia,hx710b compatible and document the HX710B-specific
> > DVDD and VREF supplies.
> >
> > Add constraints that forbid HX711-only properties on HX710B nodes and
> > require vref-supply for HX710B, then add a separate HX710B example.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> FWIW the only thing Sashiko doesn't like is dvdd is enabled for the old
> parts. Move it to the earlier supply adding patch for hx711 and we should
> be good to go!
>
> Jonathan

Because dvdd-supply now lands in 02/11 as a shared property, I will
remove it from 04/11's properties block.  The allOf constraint in
04/11 does NOT gain a dvdd-supply: false in the else (HX711) branch
DVDD is valid and meaningful for HX711 nodes too.  The only things
forbidden for HX711 remain vref-supply (else branch); the only things
forbidden for HX710B remain vsup-supply and rate-gpios (then branch).
I think this will be a suitable approach, right ??
