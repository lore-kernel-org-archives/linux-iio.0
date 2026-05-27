Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A5376497
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910073; cv=pass; b=ZHxO71pHHLuxn1wxCX2PPXCnXcCSbsrTTtjRS7pkThB8yA0bE7CC4xW3e6sMoS4KCyEDQvUX6mL4SxKWofsLkDpb/4L924V3PwUWn7eXwbC6wr+w4tPDl7vahz4B7juP7p3u3fe4lWAt44LM/UeK9Fm29gtprBuVfxXme3cYwNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910073; c=relaxed/simple;
	bh=xrhZ5oxZCXb97/ZGhQC8My4TSkqxG17a4S+H8PAGKfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+p/sR41ta+imM+MQU9RDyaGKPPbN+n6PDofN8RNmUAjXjlPJkEXMOSJUrUMTH1ik50bUkzSEqR/DImmT5z62R8MSWoK4rDxbxs4SX2eFWiwRRVq/7va8USf4Axy7D4qFFQ4dfW9SGjWPKmGb5uWpfmVWr1ef3V1uKd7RBOLe7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdVm2T3B; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdVm2T3B"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c21049dafso11117047d50.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 12:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779910071; cv=none;
        d=google.com; s=arc-20240605;
        b=dSM/Py/MBMO3oGmHqzg/2V+QBdsMFHr8nUJZQLa31wcltssygzO7xKVZnMvZO+kkkX
         ACewu6MPNFBsycKK+GlWekNSvlcboATvwhhNJFjuSCX/19rVvyRrZwK6AzeRj2xJyXUh
         wDHu4AHdBRxa3B7UzupmjJDwfkHIsp/F1C+531oi05eXluR6bs+AIB/ijLyVpOhRvt8S
         qTEVHOdtFJVMfnbtD4vwXELkFau/tyTjzsNT1HgRzPsqut3IjG96dGghIEdL6YMeRElt
         ZKjIZrSeKyPmviix3hidTimX7ZnGD0JcfzAhn7Q8vyltE+y912uzWDsm7gcCHU2sDDUG
         YNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yt4usbXpiajtncrBUtIlmsAyJqULlwkgHskpaEwIYo=;
        fh=+N/6WbHGRXWPiUQ9ahOMDY6izaBiCziCswvRaXn1NGk=;
        b=f5vfKicvaZinoAEUIgDi/cJwEsdfkTRbZFRbcSk46Ub/XGQh/KwlTvpGX0SnESwsrg
         nzb1txd76B7pyQVK7BU5dwIg4UmLcrfc0gtbBeItFHQ+F/p0/GX+yRFM4LShOHhFkuZb
         R98pnMT653zgWvRDd+jd3TDXzpCZKhU1nBFckw0vEeluXYX8IqNsEoBeT624kz5/lB9K
         l4IWCZla01LX8QFBmEupEi8Q9D2KcDMnaWyrDi3bxiqKwp2Xatw/aTNNp4FeB32ZSbIh
         F7i139OjfcG+RziGgFkRV2iwGrqZjjJCzAkmNFiIeXjROEVuIu/PKfZLjM8bwSzErrl9
         b6mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779910071; x=1780514871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yt4usbXpiajtncrBUtIlmsAyJqULlwkgHskpaEwIYo=;
        b=kdVm2T3BnTU8fw+bDisy1fZ/pnNybWMObaVGeipmuq6EPS3ez7gGplWW+AvYVQWj3O
         y8cjoK96uwY/UU4V5Ao8o6IgtyENUg2cersVZjAHuxcaBD1CGBHQ3k3H5DHHQjh4j8b0
         g2uNGYn489GL1VsbWlEksjBa1iBM/q09/bvulohviYavjNHYPtmVjxgm97LxUXeiMJVh
         qDtErf/rSPzBOofgnNOdqJoC8JUoiE/XcNWRXsbwJnAC6GaXyWSaDt3p3+MFCLtkHgIC
         YceDKbcLw280vH0rBaCQL3ENEQXgkuGRUiB/oOsNitrTBYVWfh3bTHuoSkOIUdaIXTaM
         OyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910071; x=1780514871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yt4usbXpiajtncrBUtIlmsAyJqULlwkgHskpaEwIYo=;
        b=Yb/4P6mTYaouUv8bcL/yhM9xo0D/xLTLDXrTUuxxv1iuiMNE6THLbaJVGak0tWArDT
         BaqZVPrzkEF8rA+MpGBFd72c266fCtzf2G7sMZjh1dwjKmlXw8cHi1GKgXWTCWaifb1Q
         fmNmtGqalbc7hAhLsW3hkZhLgg4Mpi0hk5gb62kyaDMEjQ1qdSrJ+pLsLPeD+SeyyyVs
         cjfdk8Zwpi2i3TIwzJSizoxulAvQyVI7DkJmZViCHRYXEiwy5juN1hqDK+FEHAnCJWyD
         SLjxNOIVlntpcZ06MBk7KqMUPzJ7dPSWtZlyUiWAtCvvNddIc0QUroFqWNFT4yomG/QA
         8Wfg==
X-Gm-Message-State: AOJu0YzobeKN+stKiafJY+wxKFmiwuEvJNc60V97XmgzTfTtePQg+gPw
	ipC0u+JetYMHP6pBdcUjWHVrvuWY26HfMzz8ZIpRA/MTaYQOLdwNUKKre402mv3+eUjwI0rN2g1
	pSywoIC1wA0/HAY1Phz1+foeRn7Q/6dY=
X-Gm-Gg: Acq92OGij8ZNhRXSAM0kx3WV1MNVWLwm4FjmdiaBK+g/1UrBTF2XV2825G+mCwtofQx
	UVd8+x3Ur98pVhlk+6+zNiPVC67mu7rX2H9EJySSXQHCtaFgtFcXz2a7F+Eg+nMTmJPzy3XurKf
	wcxI/Kam04DwgldPzdIlNQshblNYmSQoRJoBCtOtBgm2oc9ok+jE4xL4sq3cf8EMnzOwMsix+sy
	NetJtB3QHT/T37sjJZ2jEcDeVCxi+JMR0ouRwkNg8X05CFERnFdZrPNacMqk9gfr4vxCuE8AEEY
	JtczclgtC8phgUudkAYikD/hk5sQ/q4=
X-Received: by 2002:a05:690e:d4e:b0:65c:27b5:415f with SMTP id
 956f58d0204a3-65ec98a9d80mr25933836d50.36.1779910070752; Wed, 27 May 2026
 12:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com> <20260527164312.355729-2-jakubszczudlo40@gmail.com>
In-Reply-To: <20260527164312.355729-2-jakubszczudlo40@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 27 May 2026 14:27:38 -0500
X-Gm-Features: AVHnY4JV2Hp-wuWeULBMYYxJj_2oHADTTVVtEn35piKyOh6tDR0IgZhA5Aiegqg
Message-ID: <CAKqfh0HVzRnNyn7BFW8OfVKkYt24L=X7qXeZbPTj5mGzBSSfyg@mail.gmail.com>
Subject: Re: [PATCH 2/4] add ti,ads1110.yaml
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, May 27, 2026 at 11:45=E2=80=AFAM Jakub Szczudlo
<jakubszczudlo40@gmail.com> wrote:
>
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1110.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1110.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml
> new file mode 100644
> index 000000000000..7dfe07acd3b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1110.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1110 single channel I2C analog to digital converter
> +
> +maintainers:
> +  - Jakub Szczudlo <jakubszczudlo40@gmail.com>
> +
> +description: |
> +  The ADS1110 is a precision, low-power, 16-bit analog to digital conver=
ter (ADC).
> +  It integrates a programmable gain amplifier (PGA), internal voltage re=
ference,
> +  oscillator and high-accuracy temperature sensor.
> +
> +  Datasheet: https://www.ti.com/lit/gpn/ads1110
> +
> +properties:
> +  compatible:
> +    const: ti,ads1110
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@49 {
> +            compatible =3D "ti,ads1110";
> +            reg =3D <0x48>;
> +            vdd-supply =3D <&vdd_3v3_reg>;
> +            ti,gain =3D <1>;
> +            ti,data-rate =3D <30>;
> +        };
> +    };
> +...
> --
> 2.47.3
>

This and patches 3 and 4 don't have commit messages, can you fix them?

best regards,
max
