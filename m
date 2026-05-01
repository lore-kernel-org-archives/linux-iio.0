Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A33750C4
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626255; cv=none; b=foc+QgWGrum7zoCEkUSGVE/qWHdwKpqMzqLhRPJreSi+kPHbMaI3BBgD0Rj0trYcV1IIMcCq2sUAu111Hu59WwLeG2FbwKM7wh7ODakH3UJFoMyaZmCqoAIQNalPa5c3do/PKyWIyphstgDsqTlTpPK+pTxcVpGxPL/YKrwridk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626255; c=relaxed/simple;
	bh=aUH3xtkadvRrYk+f9QtLJOTQAh+FCx5YX7x8oGjwbeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=citurtURODpQ4bey9UGTTWJEfSTXNlVsmFbyS7QPIvLYcJkpuFl8SXZAPUzLQea7HifZOd9D0GNBOV9B5F/1DuC/oaTnSfbdlQQErtF8EzPdz0lOBCuvtBdtfKJr34G1Dmw3ukTAU38ZCf8Zo9VanutSnJHGdtoaIbHftZjKNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juK4+Acn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juK4+Acn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so11100525e9.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626252; x=1778231052; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b2A4p6RwYbOfM1GnZzus3Wu0hNftv6R2bMB7RdvIFcg=;
        b=juK4+AcnC13mDY4VznC6+p6ejO6UD/80JSQ+1jjTeqFSi6xwgKPz5JoHAWij1zK2lA
         NWK5nRogyfkpHYv8XHxKXpXFdsCl5tU4K8r5oGHazf1qkhiBUzrgE4BMLzk+4H4ntO4Q
         yaTWR3vMs6fiU4/ACpgYwbB17y6sYYLnBcZfeKfvVPguBubRLopmfdzo+pHcaBiv/6OT
         MSV7xf2FhMKbxQmFgL8pfKPQYapZhaTZavO2Pd6XkFF2CtnZarERWxAlu0exwaUonm1Z
         DoE3415nCjEKuaKCE3yjCU+Zb8c3PLB/az8uAAZgv02ndzFOzq9kfKPutPzuGGVycKOP
         c8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626252; x=1778231052;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2A4p6RwYbOfM1GnZzus3Wu0hNftv6R2bMB7RdvIFcg=;
        b=bhn+7KzPLmbfi79XGz9Lm374VNB+l4eok/22kmNezMe1wbijgvmbO1jVOnICJVJ5y4
         Ap+OQaU3OeLF308B63dR0y2v4kCSj4NGezI+JNplH3+DeHJepa8UGJt7yT5JW8/YXca2
         YeVDFUUWhqxXZ60facZ+nDYCMeGgGwc1d58tOmjrXj6/AHJcshLfIzHmd2c0a5SMxyFe
         hZ/idEQ0sO7YajfeISZSYyUpebsTBMD05M8rwyJdUXvVYORHDbRK92NKEXPQkenCIOtE
         Xq5XPzf20jw2YogX8qLDMv5rX8InR8eW/+nabKGC6XvFL1qbmtbO9o6zBmruTz7kL0qZ
         ay4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/yPbMBZbf7lM99LipnL06cPvJPpDYcSoTy85eukAioKmSNL74EyX4nWePKyTwmduvTPr5DyZWfdbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgahuerfsqNekCFdVss+vLz5Gl90ncrWBQ4iAxMSxV7JDjnDHj
	raRO/Z0ZZ+3dbp6vrT1bRAiwuqfZ4XsFzxVSZJqURiBRa6HqTR99JlIA
X-Gm-Gg: AeBDiesf3zvWVXARd84Djm03ZH7L5EbTiLujXN87Bmz/Kz9qrH+S++iiB64qi0gFgoh
	DJDg08/PaQpwfAjolUgDRUBWbFA8Dwt7xOXKtFVZ7ylJhRvsIC3pNPPHsBbrgT9+4goaABc6OZG
	qC9InqnwRlfJF4ZPB79MDzhorik+bA5xBrNSIFxtKz9uD3MtoeYesDYMZnzqiX/vN95TLsGTzm9
	kak1+Ga2AqcBvvcwMuKh3Xc/uYsfyj7Jd7091agAGLBOLNGKrpLJChGOm0Qjkl0N+pjE3kMUwbS
	LdBoG0d+l4+hoE8GRll/qGQZu9kDPKk5qPfBxODbwb15nuYkrmvdfXNGWZjr1gMc9fg21NwU2iU
	W4AOWxgSN/S6s+A7Bt8+oS/4CFBmN9oUJy6I6RCx2H5KRZSMXvYmA7ubxJwOWC5aNkTd2UxRENt
	trBjU1gu/DERvboq/u9Rh+GG9KfapFaTO1cCyisUFyra7zkvcUtciagojXVuR51sdyBuPIIU1jk
	pY4tRWlvcZv
X-Received: by 2002:a05:600c:4f52:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48a85e684a8mr89587625e9.6.1777626252167;
        Fri, 01 May 2026 02:04:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm137632165e9.11.2026.05.01.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:04:11 -0700 (PDT)
Message-ID: <d859d9d22fea4af4dd23221d407aff055ad52524.camel@gmail.com>
Subject: Re: [PATCH v4 1/5] MAINTAINERS: Update Analog Devices IIO drivers
 entry
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de,
 andy@kernel.org, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 01 May 2026 10:05:11 +0100
In-Reply-To: <20260430190642.3434650-2-sanjayembedded@gmail.com>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
	 <20260430190642.3434650-2-sanjayembedded@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-01 at 00:36 +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Lars-Peter Clausen is currently busy and is therefore removed from the
> ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.
>=20
> Add Analog Devices mailing list as contact for the ANALOG DEVICES INC
> IIO DRIVERS entry for coverage support.
>=20
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> =C2=A0MAINTAINERS | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc42e1cacd6b..34b67d010e87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1861,8 +1861,8 @@ W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	drivers/dma/dma-axi-dmac.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC IIO DRIVERS
> -M:	Lars-Peter Clausen <lars@metafoo.de>

I honestly got the impression that for the entries that had individual main=
tainers,
we would not touch them but maybe I lost track of the discussion. Anw=C3=BD=
ways, if we are
just relying on this, then I need to put in here given that these day I'm t=
he one
taking more care of the mainline stuff.

- Nuno S=C3=A1

> =C2=A0M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +L:	linux@analog.com
> =C2=A0S:	Supported
> =C2=A0W:	http://wiki.analog.com/
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
