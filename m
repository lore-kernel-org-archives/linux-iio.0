Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313823B42D3
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887594; cv=none; b=c9ndNSIdhofuTB8HAk+7JZKzS28Xslz4qpO2C3Snzl8NOEFiqg8MivwWPFIsdZTtQT0tSMHKEsXOmP77IXzH5zkUFYELdlF/THbHhgXlBTIRjoR2Y2DFYd1lYz5eOx4InST7nggXJBILS7ONNWEttXeCYmubMmTwpwjasXE6SIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887594; c=relaxed/simple;
	bh=ydErqryufbSp4JR5LfordVoaP44V76N2SqyLsji1CLY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WQSajKOJb01bISUVme0riXJ26TtZW1oywgIxDvTHgdVjg3O3XdWH8bzVTbh4twU+j94yP7gAvsPxnrUTJUyVoO3OWt7S5lE2wg/pb0uczF2pMdBFBROOHJUfMhqCrAhyRlvgM5qhUqYlU4jF0e0Fe12cP3uOItmsp4qt06axsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDg0EokY; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDg0EokY"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bbc6c99c3aso1691337e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781887592; x=1782492392; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUJL1hpjWL5/WFjB+cS49WeZgfqaRuQjbx9N+bg8FNM=;
        b=aDg0EokYqtu21dPMMjelf4iuWhGvULAOSHQfjBqW2C1b/XPTqxWfkFgkF8ZpFsgySa
         zHXwBG0y8P+Z8rkQRwHe2D5xN7luHgPiXlJFqnvNrEM7bJVCOVBFeeg/I9dGRoiLiSY4
         1SWUSMYORFQ74/8sN6+veX5wMsNPLYZPgLy4VcXO18B1kP6RsJ6btGrTZlv0yXo1BYTs
         6X7t9aI5AVNl7LwRDuKMCA0k5MVcPfOhB/ABmMBHttACDCehwMgeBzQ8bk1w2TAnjkqd
         BE7KCYgOLu89h1aSN1o3zL0y2Agqf1bUEgC2Cpo2AC78yrCbuRET6cNtBhWqnvULv6G4
         IY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781887592; x=1782492392;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUJL1hpjWL5/WFjB+cS49WeZgfqaRuQjbx9N+bg8FNM=;
        b=pRkZdZuRwz9j2+0Db3OJF5BqAxsd1lCVFi0zBAQs3OUWhfyppbm1CwkyGa2BzqXHfl
         Y+SX7i13kxD5cdzPutm5RmhqrEUKfqiyNEJzDi9tVWpft0J2AN86I4MCWmEph4A9I5aI
         S8uXu0e6QdRBvE8Xesx8vthOnORNBvkBkZ++3GTF9gApbagR/qrBFDQ9BbGBpmOSD+Tx
         4GI3WADlsd0dWcuWxYFCQHv6X40heTr2d1ZX6tGk836I7Zl8MdH2oT/nsrlRv9xnwdJb
         TR+Tjcg8RiX723xyLRwBOWilOWDjyUYFDwbBSuW+pul99AvP8TeQuAbNnvGWXfbUqkpC
         smcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ABV5IrFw5ycE5hKxy8HYOCTSeU4KN4CmcQ1Nqkuho6LSiiDEcq9Gy+3omc/WW1sqIxe6wue7tVZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBD2v8hBiAGqu2HWjY5wsFW/q2H5Z4B99TSDKWvbEyELL4t8J
	y1kYAx8KdjV1eHIHAiDYp5W6IIKjgmxG4bZpAKE9VhXQ6PLWNFM9zkGa
X-Gm-Gg: AfdE7cm5/khCMO9WsoC1SGwyqUDb6jvVlGiQU7U31OajJl2CgKh7w5uOiB8WhCL4vTP
	F5R8esuX0UoIGt4xxFQjeHF92rTpcj7+7EfTDs8dWEc82IX8z6IRbs3n6pA5zK/o7UQIFAkpUg4
	zvdoDgKFAZZ0KglqQlntLWn840YEAXapYFrLEg/tgP4SQp6sjgs8Yp6YGzaRzFM8Lfj18fa0Hts
	IbQt3FEpk4WLBVe1VjGplaCP8Cb6s6lOqMb2PKGNvLuv3hPsqhV8VPtB+8e4H+r/yhLCPe6F2Vp
	v1m9B5xqk8EigVRCl5ICp2W80D3gyF2ou4Oxo1T6cv/36ZScblRxgDytaGSwExYPj9os4ElSL/l
	o/2lNyEgZ4aoCI0KDOy4m+gXLBj9Sxw7NOIZZWmDACbEvEhD1Nre6UG1XymXVqiEOuxu93sS7ye
	l8/wo=
X-Received: by 2002:a05:6102:f9c:b0:639:1e8b:ecd9 with SMTP id ada2fe7eead31-72a03d9e389mr3148036137.20.1781887592125;
        Fri, 19 Jun 2026 09:46:32 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72a342eeca3sm2081276137.3.2026.06.19.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:46:24 -0500
Message-Id: <DJD6FJQUX2V7.SZWF8VSKBCPX@gmail.com>
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
In-Reply-To: <0831356f-76ff-4eed-befa-7a35ffce921d@baylibre.com>

On Fri Jun 19, 2026 at 9:28 AM -05, David Lechner wrote:
> On 6/18/26 7:33 PM, Kurt Borja wrote:
>> Some ADCs incorporate burn-out current sources that provide current to
>> the channel's input pins for open-circuit or short-circuit detection.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Docume=
ntation/devicetree/bindings/iio/adc/adc.yaml
>> index 106b1e317411d5..6b63aac9ac04dd 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> @@ -106,6 +106,20 @@ properties:
>>        This array describes the current configuration of the excitation =
current
>>        sources or the single matched current for all sources.
>> =20
>> +  burn-out-current-microamp:
>> +    description:
>> +      Burn-out current sources provide current to the channel's input p=
ins for
>> +      open-circuit or short-circuit detection.
>> +
>> +  burn-out-current-polarity:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Burn-out current sources provide current to the channel's input p=
ins for
>> +      open-circuit or short-circuit detection.
>> +    enum:
>> +      - pull-up
>> +      - pull-down
>> +
>>  anyOf:
>>    - oneOf:
>>        - required:
>>=20
>
> This doesn't really work with chips that just have and enable bit to
> enable or disable the feature.

Maybe those devices can use burn-out-current-microamp with a const
value? Is that okay or should another approach be taken?

--=20
Thanks,
 ~ Kurt
