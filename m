Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5C306D2A
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696258; cv=none; b=W1RpllS0wtrprpZ8YWU+xHAOgdH96RKU161nJm2WDfvNGaqUvESaQ1jMcvt9cZWu4KZRMbtaxTwMcJFCOg69Zici7570g4V7KWTmWD4ed0hCuIX+IPv5fhf3SpPjRstxM6mk9CD5JVuX/zu2P29vFrtkb+WsAA1gyydCVs+Khfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696258; c=relaxed/simple;
	bh=s3PbTDlk5Oqc8Ek6vf/l3d/qYjy/w+Dh35a8RCdVKqI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Usyo2mXIhowMeVgj+f+Orwc2SFldXYrsuxXUPxVearzLl8iVv8lEMSi8h1L0u1toNWtCpvALV/6GlQ4CbWqmmeOakVfilsAGFixd+WMlz26OISTw9j9l+Etcuc9gujFPox9P16jSF6wQqldMeeLhLsne7erfb+Wjl3I2/8j0XGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR4FYzf1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR4FYzf1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3578228b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696256; x=1779301056; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3PbTDlk5Oqc8Ek6vf/l3d/qYjy/w+Dh35a8RCdVKqI=;
        b=sR4FYzf1dIi36MsGVWSv5fDwSVqs8dBzRZQcOtHF8Tvfi4J4tHBjqywoh99MbUwAvA
         FYbG2qKlCwoF6L4GaMxkAu7c8EUmF63Tiuz8/1R/IYxF2OFHe2l6NKqorylsoyTzYc/Y
         joj2v2FX+DD9p/Q3hBi8Ma3LL+VQA3gumUHo2O/muLsS2eR9lzyKzmedzdC/OsIu2jqO
         /oexRcnYP6Rt+rH7pcv7a9Z9YMuY/jghseIdioZq9ZmVtclejKo0581FEmFncrtUAy8i
         ldo7Kd5GKP3+sQhtIDShAJCumgM3LXcBsrSg9DoquxHGlbS8vZPCwt9Mz7oqbUrAEYTH
         vnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696256; x=1779301056;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3PbTDlk5Oqc8Ek6vf/l3d/qYjy/w+Dh35a8RCdVKqI=;
        b=F4BL37V989aRFzRgyh+05JrXrs3zOmJ9liLj6OgiULn868oHuR9vS7aixyKhmI0zuA
         ox3uAmQOqEoXsApxl+DXuw5B5amovyuOb21RPG8gS/NQRf6cPXtykNS5MamJ3JE4hx5o
         f3Q129orZ1bDuPgkiHgWXMeD+7r3pBjM0dero4Zxtj/IjX0bGmq9MszdvxQ1nT+WZ9Pd
         uoeVeFyqjzZiVndNsBExX50l9EdgQ+Hy3q1b7VOwurJFi86hooipX9198vNmMcZA4zFI
         EQgrKwr2622qxQlVSuuz1CCfuihlNPv7rH6ZQd5789sCP6l1GOovNbIxKDEeVgiOPFg+
         3GiA==
X-Forwarded-Encrypted: i=1; AFNElJ/qkbGGOKSoCPS3rWp5wjfgHjGC8xnjTh4kMolaYPUr58XCE1RWchQ1v8JPMLp+l18/D3RDu+M/d6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpn+KEw8Qj/jKE+WdD4TXtyBsL2lP/l8yEcDYYX2G55Iu+gmH
	CjpwW2sc0VTpNQiCpC5LZOsoN5qgf+ubHKzxRSXIUD7UMbodelE3gVuG
X-Gm-Gg: Acq92OEuQXtxIbP98kiiC8SeMpcgRi0DnHNpmnMXFkt9StQXsQMW5rz72mzrADXys09
	fBsl/n+ul3Qw9ZxuLTflv1JSPhUIrahVRXT7LqlVzdBssQV0cY2mX+YenfUWu9nbV27zQUZQRnp
	jYfTl6mHYkgOOwcdoiGPFOeNzX2z8AtqNWB4O3WHGBlK2rAry8U2QwzX/J6Pa5ibPh8sLZheU2x
	LPDXnmMMZ9W8kkohASgBuuyrqM4n8Z7C42nAEGzn9fRd4DhYEECW/62BilzmDaHsQZKcRG50Qck
	9MgVmAAwkhaWRUvGIEs5wvYA2oJz6EGH/bLTBRZw2qGqP7KLpojrLWcVWW2HDO1wsDUxHYXW7zl
	2BR64B1ATmMbpaJhkm/jFrhSx4ph5QvWbdhKkTzF/SAWkryE1l9eimhRh/pk8GAeNalpUIKAvmb
	c/t/NV2cijlJ6LP4ueQYkbejCddB0hPSDGHm8DCyO5MaAl84dBEBJ+Sgs=
X-Received: by 2002:a05:6a00:4ac8:b0:834:e092:2631 with SMTP id d2e1a72fcca58-83f03e948b9mr4491931b3a.8.1778696256394;
        Wed, 13 May 2026 11:17:36 -0700 (PDT)
Received: from localhost ([203.99.159.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cd19sm166265b3a.54.2026.05.13.11.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 07:17:24 +1300
Message-Id: <DIHR7242IVEQ.HZ3NLNX0G9E1@gmail.com>
Subject: Re: [PATCH v2 1/4] iio: light: veml6030: remove unnecessary read of
 IT index
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>, "Javier
 Carrasco" <javier.carrasco.cruz@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
 <agSt_TGpyujxqrZc@ashevche-desk.local>
In-Reply-To: <agSt_TGpyujxqrZc@ashevche-desk.local>

On Thu May 14, 2026 at 5:59 AM +13, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 05:49:41PM +1300, Javier Carrasco wrote:
>> This is dead code as the IT index is not used by gts to set the new scal=
e.
>> In its current form, the value is read but not used afterward. Remove
>> the dead code.
>
> Does it have any side-effects on the HW side? Exempli gratia, flushing FI=
FO,
> R1C (read to clear 1) bits?
>
>> Fixes: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI"=
)
>
> Not sure it fixes anything. But it might regress, see above why.
>
> ...
>
> If no side-effects, the code wise looks good.

Hi Andy,

This patch does not have side effects on the HW side. Apart from having
it tested with real HW, the operation being handled here is setting a
new scale, which is stored in a persistent register.

Best regards,
Javier
