Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C04A2637
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448787; cv=none; b=e3r1HYjM1pS6Cef6YMwY5mgUzvL1q9Iihot8upVVuZXmR7OKIkGF8njMnqonTZRWkEbCFa4Ow5IvH6WOoHQhJ9nftwg8WlIGLDzfkA1FhhNej67QDZAQCMpx22ZbUX38VAuX3r4g1KQqo0IxIu7PKTNDuRf97ElnGFRSgha/1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448787; c=relaxed/simple;
	bh=nbUSOnH/yAvzACxNcixvd9qpwb8O+QZ2GQHLOMzuIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7dKmIS9stw8+2PVWlkjxGW5qLOkxoGafb2uZ1ElisKbfH/goKkWnT3/Fts+G9h6kKiw6gY+w2aKXVyVi/WdfbJDJ8bRZ/eRQX7YJxjV45HWUU6DkVZ+JSP99XXVzNxWo4oGOeFA5y5vhIp5EM0LcR+mp1ewg5wC3ronlfWQBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ7q/53U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ7q/53U"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2544ff970dso376843866b.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448784; x=1789053584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/Qt/fPdwPC3wUdBHPi4+U/TKrcXHOgncT4srAq3Wek=;
        b=nJ7q/53URt/69k208sxM1yKudzlYB+L0/JyD4ElL255rqI9h+qVygVbjAAmMHxc2Fm
         jO3hmE1Sk/w3cfsVNFKERUWj4KkNj1lt1dyWZh4ZNPI/fu0gKOyJWk/kwAcSEEZrx52/
         oOlNtjE6LonmH6+llRBje4XOHbFQg6Az9LMaXoBiIg2663j6CGyQwb1cPMO1jwZ9Sx3V
         KFz/MNlkJJOuP4jWcTsZgkSc6Ds0NzZZ9ReG6hWXFxDv7hsa6HpcOsaNx3gE72sCvLPk
         6zS+u0TMTxGqSJEWWII2gkGS7REnC/ipy4RfNerlfXrxClD3L/XPlXqyCmWXGRawzSWe
         7onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448784; x=1789053584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/Qt/fPdwPC3wUdBHPi4+U/TKrcXHOgncT4srAq3Wek=;
        b=WxiGAVMmxosqbCw7Q9fHvFIfnM/14DWMU+A5dPk32nwbxQYQZZL0rZXDBRJX/TSVpz
         htdvvRZbk9CDxZfOutOmry1wxUnzi8xL7qL/g+vm9+eQ1Zxi+/kHMCx4rtaFfW75cxHY
         MBDBJ6p627ZbjXTDq8jxEWKWCRvQYJ4scS1cIezqIgw3QRyPmJpUMQuRzU1BX6WSXxwy
         K0z7+6fROcFFFu+FSOZxnJSXK2MDi2w86YjK2GCBdu1DsjNu4q96oTAey9vREmjU2jEc
         IP9CKwmmQ0XRYVhAc80f794pUcn712QYgNKSvjTYYSuH+ZAIvWQNMGKcumlMwmwzPOhO
         rLtw==
X-Forwarded-Encrypted: i=1; AKwUvBz6vjRy1C7PSWuWXIjfTlerRbv4KKjfOZIzNI6Tags4LSg9dySqnlBmPhYUG0Vd9nXn/xRW1IgwjPk=@vger.kernel.org
X-Gm-Message-State: AFuF++lnjQbrhA2+wovOCjl1WX6a0LdcNIHG3JN4nyRgRCil6BEeK7dk
	sWcFyXdtfQEWdzRct+aEhKqPSlqcuIfNnPYr5KO8N9GULc1brbzSy9Lc
X-Gm-Gg: AYBFou3L/fGmYvrqxl4t/lnTDUn4Fm+H0DrN96uMa9bpU86tDprQs9OjnW+jps8V/NM
	3hXZoyBUlA0xZuTCwslb44hBulDL/U4doovNEpneD7n1UK2Qybiue3aw4pcczp3MrivlpcZ5Dn1
	ZCKATARbsb0QAJL9YiDfHMtScoDJyACGR2oLRksVt/KhMk6urhvXjPhfYeGPOATGhEvVUVScaBt
	h4AyjaJs5frzLRnplrq9S+tE152ZShrUz7Jt4b9K1jtIjUjHukqKCldLk6PhxikeemBFh2BTeX5
	BsVn8RF/LCDr2OnpQ01Dbx4C6IzFjuraV61gvUdgG0Q8etFL8JIl7GUWaQTYMnYtlPUMybTlgxj
	3yWpdwT7WnQxyeroEQDLig0g5JV0JCFeEPz/GhF/2Xesze/OaUXdw7eG+y6bgmkOWwKCSpz09PH
	mdIWaWCSmHZJ0U8QdHgZJsCzq4gYndLLkdrIUxKJb/ihucNLBpEapuCs/dt5QOLKOz/Yl0LP7x9
	6J6vBkEnBphUns/aVpgxdHGE2A/QV5YMMeIfQ==
X-Received: by 2002:a17:907:3f88:b0:c21:450d:cd7e with SMTP id a640c23a62f3a-c25d53be168mr861775766b.9.1788448783664;
        Thu, 03 Sep 2026 08:19:43 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e13db0sm14634897f8f.0.2026.09.03.08.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:19:43 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Thu,  3 Sep 2026 18:19:39 +0300
Message-ID: <20260903151939.5117-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <60dc58c6-dfe2-4377-9a73-f65cda56179c@baylibre.com>
References: <60dc58c6-dfe2-4377-9a73-f65cda56179c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:31 PM, David Lechner wrote:=0D
>On 9/2/26 12:22 PM, Flaviu Nistor wrote:=0D
>> Add support for an optional label property per channel similar to other =
adc=0D
>> chips. This allows assigning distinct names for each channel which can=0D
>> match the schematic signal name.=0D
>> =0D
>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>=0D
>> ---=0D
>>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++=0D
>>  1 file changed, 6 insertions(+)=0D
>> =0D
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b=
/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml=0D
>> index 718f633c6e04..777a75c21d7f 100644=0D
>> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml=0D
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml=0D
>> @@ -66,6 +66,11 @@ patternProperties:=0D
>>            - minimum: 0=0D
>>              maximum: 7=0D
>>  =0D
>> +      label:=0D
>> +        $ref: /schemas/types.yaml#/definitions/string=0D
>> +        description:=0D
>> +          A descriptive name for this channel, like "vcc_ram" or "CH3".=
=0D
>> +=0D
>=0D
>Apparently this chip has quite old dt-bindings. Normally, we would have=0D
>included adc.yaml to get this and other channel properties.=0D
>=0D
>And we would have used diff-channels and single-channel from that to=0D
>describe which pins are associated with which channel rather than having=0D
>a magic number for reg. And the ti,datarate looks suspicious as sampling=0D
>frequency is usually we control at runtime.=0D
>=0D
>Anyway, none of that is really relevant to this patch. We'll see what=0D
>Jonathan says about using adc.yaml here vs. adding a label property.=0D
>=0D
=0D
Thanks for your feedback. I can also use:=0D
=0D
$ref: adc.yaml=0D
unevaluatedProperties: false=0D
=0D
and move additionalProperties: false at the end of patternProperties block.=
=0D
Any other idea?=0D
=0D
Best regards,=0D
Flaviu Nistor=0D
=0D
>>        ti,gain:=0D
>>          $ref: /schemas/types.yaml#/definitions/uint32=0D
>>          minimum: 0=0D
>> @@ -125,6 +130,7 @@ examples:=0D
>>                  reg =3D <4>;=0D
>>                  ti,gain =3D <3>;=0D
>>                  ti,datarate =3D <5>;=0D
>> +                label =3D "CH3";=0D
>>              };=0D
>>          };=0D
>>      };=0D
