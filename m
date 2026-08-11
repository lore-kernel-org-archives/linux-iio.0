Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D624028E8
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480307; cv=none; b=OF2gsSEb1wHaJpdmuEHcPM+rjxGYuMxzFSUsPWGNg0CQe2Bj64XLG/G68NohklrkW8DAOvtmhtCeeSX4wR82wly/saePMZrxf9sRjZUiPjWtioXIYTYO+GQBHsR4cI1LzXRg2NSvAfpm1eQN/jpbJSgJJeTJToGBE7nafkD7t84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480307; c=relaxed/simple;
	bh=55glILS0uJhCxGhmHzJrvqNOxv05p9rwglsO0kFx/1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SS11iwTHY4Z5Jt98oEKtlF5zcXKkSqO5XDD5Q2the911qTspNoi+h4viJ4/NgaYDDWzT3odrtEqJWfUFGFb/ICSmzwspt1maf4VC8s6Ym+yR/kswfF9XEoyk2/EfvHDIyVyfDhu0mmNYQQfZtVxPUKPZe4rA5kkeEIX4tcdM7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN5Dhoya; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN5Dhoya"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74748e3a4d1so104482137.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786480304; x=1787085104; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jQXapsYvV1u8RmWHInXHPTUbHPYP2eL1w8VqePS2AeA=;
        b=ZN5Dhoya7R5+j0M2589isoVNKDiVkZXm7oii77nD5Br7EgcgxbpaOgZVkGFaQBeSvO
         FfLixuiiirv5uStRXU/NaWRjAp0OPvtaUpxlJZCLRf4yEpbK2ZmnBOaM4mwdF9ukYKxi
         vdrCIIQX4M7J9nmC+AXzHNh6zZrAnHMOqFzkvq0rOzWZ++6ObE6i90j+00XNbH/GZfeh
         z9N+gIcd4vTnvEBVNEImX12gJeoHNDC9G8lHUIaI4rI2IYyup7pO8KCU5Lf9JN1AYhDZ
         otQnU04y02vBCStn41Cjm9wMv3Aj/Q5a6STFQdCp2aIExoCRfyvyudSB56Y4U6h7JV3j
         Qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480304; x=1787085104;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQXapsYvV1u8RmWHInXHPTUbHPYP2eL1w8VqePS2AeA=;
        b=f1d4V5IIdAI/shjxwKvbPYKAxrKBe2lRbVWBYKTdmAgrr/74p/fIXbKRxCRX2rnEVX
         jy11F93DGi4SX3mPjIXNr+BVa1ca3pOlStOPgujyzbGiY931ZfqusuaCt0NLA4MOcjXL
         e2MtUMe0cLXpu6ZyQc79s9FGCHriQTAxYHufI9sRdgVLxmg5SSTrWyIVBXDyme3aJS9W
         LfIULY+SVLIi89VfCCIp6aPMaVJ/eSfZBWFQhsy4n9JKpr4pGdny08oPEvCLkgJ4zJnu
         1UoY6+X1eiJFMqrnS467u9Hdb2XDlhBpkwjSlL9NcTodhBkDSHpHu1AcacFOEx7waySV
         qEKw==
X-Forwarded-Encrypted: i=1; AHgh+RqSPsABzuvkACAUiDNJlUrI2ElmlnqtTXCa2PpnNNq1OV2P3Aeqzl5VR8UxylGBF+FnM3ag3eVc4Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz405j9OiderhvEA7mz6qwldwEioOoHSm+0mC28FSW4xKxlva55
	CGIKGFf/ivyK7kQYtUZgkXyvoZFmiXL0WxKALZuordhZwzHJl03O8EsS
X-Gm-Gg: AR+sD12BnwjLm99kagdcemzQmTa4c09kgRHy1z0tR+NFkLlSuEEHjiCMDqVzaKCgchn
	7b79zk29wL6qQ3ErVSAF/mxr6+8x2BGeDocvXD39L1N8NtqjhwrnwqKx11+GcNi4zfzwNmT1lO6
	IYzqYxprHDMdOM9K6Ojx8+M9A4whgWfYB+E6uuNpsn0p5sC9ulb/s1BQrvlsMrJP2InkFAYwIDV
	dOFRTVF81vfSqD3yLOao9fxCX/fzHAYGAgXdY/hhmKkXVg6hq54YQgtY7NJzsIQzxZa7MjBf5l4
	ZxfAX6p3gKRLJX0j2J7lXE4b55FJQkA6/MLG6SiKBlVi4g3ZM+eOg5xBtCAunvDeLfoYUiZ15vo
	pQu27d4R8OzEbHMyajnO9S58N/mphNaC0CSC2hv8P1t4LC6ebBUIeYULxUsmnairrqqbqSFVkq1
	W9uiHxKB5Swai3q7Vp4/UYpMezooWIJyNETZlOQq26Vy2bQ/OHApPa
X-Received: by 2002:a05:6102:1496:b0:763:ce80:337e with SMTP id ada2fe7eead31-76b54d84d6dmr1994826137.1.1786480303709;
        Tue, 11 Aug 2026 13:31:43 -0700 (PDT)
Received: from localhost ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76b632912dasm1128489137.5.2026.08.11.13.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 13:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 15:31:40 -0500
Message-Id: <DKMEEWB5S99C.1AV3WDDKLSB87@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
 <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
 <anoc6axjV0uSXDzB@ashevche-desk.local>
In-Reply-To: <anoc6axjV0uSXDzB@ashevche-desk.local>

On Mon Aug 10, 2026 at 1:48 PM -05, Andy Shevchenko wrote:
> On Sun, Aug 09, 2026 at 03:26:57AM -0500, Kurt Borja wrote:
>> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
>> > On 8/7/26 10:58 PM, Kurt Borja wrote:
>
> [...]
>
>> >> +		ret =3D fwnode_property_read_u32(node, "reg", &reg);
>> >> +		if (ret)
>> >> +			return dev_err_probe(dev, ret, "%s: failed to read channel reg\n"=
,
>> >> +					     fwnode_get_name(node));
>
> Use %pfwP instead of %s (same for all other cases).

Thanks! I'll use it.

I have a vague memory you may have already told me this. Apologies if I
forgot.

--=20
Thanks,
 ~ Kurt
