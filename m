Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0A2DB7A3
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782085446; cv=none; b=cCdrmn6n+SS07fUHYV5aRti3bbk5Ff4VijFt4ZidH1ol3UM03tXRY6a7D0PI79cbM04UE6ztrN4DVFglCsqSluYzw/w8gUbopaC0nU7CP4R9/U73Q/8a0kSjZS/LRF8D8of6+zq2+wv+z2SmgAYJSoZv5+4snTJh1jXcUyK3u4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782085446; c=relaxed/simple;
	bh=qC4ItL5aFduGXaZLJdmviE/chPrLA9OluRNtb03xoBM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sqdWLvAsHKBfxCsFc1OJsvO/qkzSBVp+KLvuF1miVUN1379pyGjSu+O1DNFjT/CKVif75uGHcTyFHs2EZRP6CBHGucA/I7Upz/rbg3ZxQIFIM3hNthfipwe6fbl4MvqszZSTa/TLkj8idND8JFRvnkwcMtRhhC6JRJTzlLsLedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdBDrtA7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdBDrtA7"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bbc6c99b5cso1049872e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782085444; x=1782690244; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMTEZuuJVYsmFX5xK+dFlO+dYqsMUYWoJOQqbQ9vGyA=;
        b=MdBDrtA7yti3wdyYxt358jnfjrl3ONeaSjROjPbBzqrpOrfmAyui46fPFzJW3D7unD
         4i2+NphgSzfUMeeL3gDy5lIPxNfSju1NXgcd2X4FXQrFsr1dAy2/+tVzpamQT0WgECQF
         Z5OwtXdUyEDaHxg47ywJyDKUInj0hYcNThwUmdcIfo6SAnihIpjjIQoFT3CI+PQEi6so
         /Uo0fgQjRvCxfkI69dYP2hkq7InxsVw0F0tzpEm/9k8fhhbQ1stICEj3cJ6MRNZUtEdx
         b7nu+4Vk763OWYpBRqhKZXkaqkNSJDH7ZNJ7FHUNlOipr8U8J/piRST/2Bv+2WihT9aV
         oU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782085444; x=1782690244;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMTEZuuJVYsmFX5xK+dFlO+dYqsMUYWoJOQqbQ9vGyA=;
        b=mUmShYVtfo6aEUCTmhK5AZyrIBY79TKGBKdyn3IAhnPIE975YEiZaGfW700WrMZVLh
         0xBnbqEAC58u2XOrx70Iy3tgeYpX7Pz3QvsPOKFohAHGCL4OJX0kpcA4cTxN2tWi3bGw
         0D7DDnjJd4XWpjZmIn5jDs2RsO+2EjoUscUd9X/AWqvY7pGJWGOcERyjdG1Fwp+m3WMn
         loWc26Gq7N1XN7PI7DeRcpjUshtyqjxUbSlgpPIPfXDmghtTSHJ9uCwnH9Y0KgcXTfmh
         DVLlUitmKPEg2ETxtc2l5Ohb/+yJ/z7FVY1CGhKK+QDm9fag/A15z9OXi2i/GMb+Kg9Z
         PujQ==
X-Forwarded-Encrypted: i=1; AFNElJ+l3cGgm1uKyNWAwMAY4xQqEEUusW3+t0XKb9KTeMwRembP+qmS5TMWGU0l9e0swUlbrqnQwhYDYeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPFbHdMqSs6fBXFKB50EkrafkPZyfXdcK1TJZASV4bRedFXuN
	TJ39MTA1LU4IVTaS8FETejKiv2eL6xIdTxHJCS653luLYAa86Tv6JEfD
X-Gm-Gg: AfdE7ckR7otHb8T9bQ8TJZwJ/VoDvDF21b2kaCvFXyL4Vyzt/9EkcIEkaGmWYDMtALS
	FizeLJldGHasRMknk0w6PzKARKk/cqmFYkjK0wgUatufwaU81whSMKvTg0KZRP0sgf606vVQUbe
	GDUzJJ9QrXlom9bpspvujqZYzJY0iWXIzdwCfB1JY7qGYZBvrqQvdGrwzMoIMl7zzKiOoo1lGad
	nG2AnDRXtwyjC4NN0D/tPYa2tZS1Q40tuCnAgVY7d7F/i4oiWJN0Y0SuKVj0OZk/jXuy30qJAM3
	Ym3UjUIlz80mWB0KgIDHJS2RCd8YjafYpPWkGPxWNaNWxvyvVS++rDnuNd0vvQ5Bt0mDwa3n/BB
	PBqRqy36aR1w/oslGLTBSkjGRcI0j2I/lM8mJulaGEU/+9iNmcff4LloaRaCGkUuQVmO1Jli08T
	fYVeg=
X-Received: by 2002:a05:6122:d22:b0:575:352f:eac0 with SMTP id 71dfb90a1353d-5bbebb8debcmr5801964e0c.7.1782085443832;
        Sun, 21 Jun 2026 16:44:03 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb7d30besm5441275e0c.2.2026.06.21.16.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 16:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 18:43:55 -0500
Message-Id: <DJF4KBA0LX3K.Q3XDAO3J1HMP@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] dt-bindings: iio: adc: Add burn-out current
 properties
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-3-963c1b5cf40a@gmail.com>
 <0831356f-76ff-4eed-befa-7a35ffce921d@baylibre.com>
 <DJD6FJQUX2V7.SZWF8VSKBCPX@gmail.com>
 <38c5e5eb-2113-4a5c-ad14-348dc7966a1c@baylibre.com>
In-Reply-To: <38c5e5eb-2113-4a5c-ad14-348dc7966a1c@baylibre.com>

Hi David,

On Sat Jun 20, 2026 at 10:57 AM -05, David Lechner wrote:
> On 6/19/26 11:46 AM, Kurt Borja wrote:
>> On Fri Jun 19, 2026 at 9:28 AM -05, David Lechner wrote:
>>> On 6/18/26 7:33 PM, Kurt Borja wrote:
>>>> Some ADCs incorporate burn-out current sources that provide current to
>>>> the channel's input pins for open-circuit or short-circuit detection.
>>>>
>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 14 +++++++++++++=
+
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Docu=
mentation/devicetree/bindings/iio/adc/adc.yaml
>>>> index 106b1e317411d5..6b63aac9ac04dd 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>>> @@ -106,6 +106,20 @@ properties:
>>>>        This array describes the current configuration of the excitatio=
n current
>>>>        sources or the single matched current for all sources.
>>>> =20
>>>> +  burn-out-current-microamp:
>>>> +    description:
>>>> +      Burn-out current sources provide current to the channel's input=
 pins for
>>>> +      open-circuit or short-circuit detection.
>>>> +
>>>> +  burn-out-current-polarity:
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    description:
>>>> +      Burn-out current sources provide current to the channel's input=
 pins for
>>>> +      open-circuit or short-circuit detection.
>>>> +    enum:
>>>> +      - pull-up
>>>> +      - pull-down
>>>> +
>>>>  anyOf:
>>>>    - oneOf:
>>>>        - required:
>>>>
>>>
>>> This doesn't really work with chips that just have and enable bit to
>>> enable or disable the feature.
>>=20
>> Maybe those devices can use burn-out-current-microamp with a const
>> value? Is that okay or should another approach be taken?
>>=20
>
> Maybe better to just leave this one out of the common file?

IMO burn-out-current-microamp would be nice to have. I don't know how
common it is for bindings to describe this kind of properties with a
single const value though.

On the other hand I do think we should drop burn-out-current-polarity,
maybe it's too specific.

--=20
Thanks,
 ~ Kurt
