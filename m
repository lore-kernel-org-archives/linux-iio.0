Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3D2FE056
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887497; cv=none; b=AJr5Y9d3d1m4boqJFXyDB4yL17cV7XMsVDEQTLQp0uh+ckc87mZS9Gp2Xs64Cg6dsAGVO7va10WlSqsv0Afqvzo+nYfJ5Us/Ki+ocwh8zFYgOK1efC6ZrV605OHUDXX6YOAep/QAJaZYBvzvJEHniBOHoDVkBhre9g0DvexUKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887497; c=relaxed/simple;
	bh=53nrFR+5P147jRMcGHp6GiQfoQU1K9VkWGdViL91Arg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UUOEy9/bEBCtFOV9Y9YT89QLuRKG9YvHxVS7FUX7uEaUUMWFi6emPNqDJ4ZyeaVlODU7eNPxTYOGnvomxgwSx/4hXF0Ru0m+GXRSN12W17UpCCKEqUqWER7M+HOdMOSGFbae1DqbAC7GkFBhhOIccFjthz6XVJCi8XLtNcWWOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlNdfxJK; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlNdfxJK"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59cd803792aso1452492e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781887495; x=1782492295; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL55HpULYFYjPZKBpHgRb83VpApz0ytowSZF8pFlahE=;
        b=JlNdfxJK+kgquLHHhr1PrZExom24RvvjqdpKpF3M1gt1oUnspm3rTF17EkzTE2oOw+
         3w95wiwiHKwjlwUqf3UruE5fdF8rgxv0HGgFDu4xEan/qHtKf1ScnLPaAD3PK0DuWjUw
         i8ljcKxAPcm4mBSfNj18+W1WPtY7A10KnzC14Gs+zLsjEDcwU0CoKN2uoP3mHDd5hlaY
         Jiy1oQusq2KzfYHOs5k6486L2F5K/I1SVWaOq5fPCrl2WLRsxY/JdoW2qEJKVu1dbudi
         MI4sxuy7Kjh6gnCldLXB17C7OK7CpkzZG5M8M7vw6UpACVAoZoYOW4ONYUNqsldudD/I
         JL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781887495; x=1782492295;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL55HpULYFYjPZKBpHgRb83VpApz0ytowSZF8pFlahE=;
        b=WvFv1McKRc+ZRsJpvzYvlfqr8iEJAVbyDkLkanw/jAq/qsbfwW3DgOXrdWnKKwr9Er
         wn/xYIh3q5RKWERB2BxCC8IGk3w1L2JIWly7Pbt7AV/WtRCzVPUfDiZJipjPyf8+t7tU
         HJIAS3X+8BBGJMxl/SucoGPJ4RScRuw4EI7KoAdoknQVRPf1QtUIj+CXfPy9fya5DToY
         BoVndOLscak/OAI6v3wgBKBMUddq4sLJ2Ogz6YEyksEYNpubpv2YLLpVmRqb7wRvVZ6S
         leZF6XNKvZmE3WabgTLpa4oUosoYybPpPYKtxf3uaS2DLKaE4fxhIavUI0DGXN4meoLQ
         NyHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yMrzK9AFmyewZSmHP+qVg4zjY9ffkUtSnu9lt3qWIPnPH3L7xtGpzPnumKLBDEAOUc7R3uzRvgG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yZsnkH1Fb2xG3tOLZn6sqD18Qt9qnmZzRkqyiHt/7yqKM9rH
	CAoHwSguUdoKUH0X4FkFWj7XuHQehfAQk3EvFiHwn5tjnPvRaNzQ839j
X-Gm-Gg: AfdE7cno28K0gjQ4CCD8on+0HTRcnMR57ELIa0xbKyKYLeDfERSNwS50eaxVTN61BPR
	o1KY0Oi2DkEQU/G/xGSnKyHyjvRrWHxDzL1KvF9RHCh4l0DrqPrKEw9k65EFO3XZEnHBkbLnkNk
	CZ3q/2YeUmIEP2IN0rmVz5ijby644dNjGejNJZKuKhm+wmr1uVWdAnatJ0ga4hBOhk00lCaTixr
	d2n6I/8c/ZnEbRgbKYYehlmz7Uh9c/GtP/cNWkjYURyKqPYx3x1ILcX/8hjqcXOzKgYVRzT/JQ9
	oCsj+QS2dS0agZNU7XESmXSC46L/oRJngydbFdNV6ZdmWR2sVrsLtS8Zqiu6efe7XP0AqjJbfrD
	4+BU2HF9d92F/uv7+4D3799p0X5Y0ap10OCYetT8NExE29XN87Izoh/SmbKtq9WEveVa0QwXgqb
	6DEcg=
X-Received: by 2002:a05:6122:341c:b0:5bb:dc6a:249d with SMTP id 71dfb90a1353d-5bbee6efcbbmr1938741e0c.11.1781887494797;
        Fri, 19 Jun 2026 09:44:54 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfbab451bsm119607e0c.18.2026.06.19.09.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:44:47 -0500
Message-Id: <DJD6EB7J90AR.20Z61X02BHAZT@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-2-963c1b5cf40a@gmail.com>
 <073b0a89-65af-4a21-837d-851d35e3e294@baylibre.com>
In-Reply-To: <073b0a89-65af-4a21-837d-851d35e3e294@baylibre.com>

On Fri Jun 19, 2026 at 9:27 AM -05, David Lechner wrote:
> On 6/18/26 7:33 PM, Kurt Borja wrote:
>> Some ADCs incorporate current sources that provide excitation current to
>> resistive temperature devices (RTDs), thermistors diodes and other
>> resistive sensors that require constant current biasing.
>>=20
>> The maxItems constraint of 16 is arbitrary but should be big enough for
>> most devices.
>
> I wouldn't put an arbitrary limit here. The bindings that include it
> can extend it to add a limit that makes sense instead.

I agree.

This was partly a misunderstanding. I thought -microamp properties fall
back to uint32 not uint32-array but it's the other way around right?

>
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 23 +++++++++++++++=
+++++++
>>  1 file changed, 23 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Docume=
ntation/devicetree/bindings/iio/adc/adc.yaml
>> index c74c2084fdb68c..106b1e317411d5 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> @@ -83,6 +83,29 @@ properties:
>>        This array describes either a single reference source or a positi=
ve and
>>        negative reference sources.
>> =20
>> +  excitation-channels:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 16
>> +    minItems: 1
>> +    description:
>> +      Excitation current sources provide current to resistive temperatu=
re
>> +      devices (RTDs), thermistors diodes and other resistive sensors th=
at
>> +      require constant current biasing.
>> +
>> +      This array describes the mux configuration of the excitation curr=
ent
>> +      sources.
>> +
>> +  excitation-current-microamp:
>> +    maxItems: 16
>> +    minItems: 1
>> +    description:
>> +      Excitation current sources provide current to resistive temperatu=
re
>> +      devices (RTDs), thermistors diodes and other resistive sensors th=
at
>> +      require constant current biasing.
>> +
>> +      This array describes the current configuration of the excitation =
current
>> +      sources or the single matched current for all sources.
>> +
>>  anyOf:
>>    - oneOf:
>>        - required:
>>=20

--=20
Thanks,
 ~ Kurt
