Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC8415B94
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168518; cv=none; b=H2w2rA5/s/OFJCAV7LMSK19tDscT/TEmnJPRkAg3P6cuU+4GGuY1Ig7YrYER7rsmi4MurGwKO1EOoW9jJOTPSyboYZ2+os2ZM6Zr1WLFZIu7fyW0wc4QWrmKT1WRAvhZCL0nfEoq/s8jX3zBeXa8zC9KV52uD3GbSUytw3XkwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168518; c=relaxed/simple;
	bh=LgB1q6UxSStE6Znlt1iXGT3opxdZpJBfexhJpaFVDJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=bllOIG/blObJtd0GW9dicTw0xhnP6I4XtkpIwslFD9sxtemK4vNR+eJQxN5Dn7b35SoXmvTm/mTIG56/DEayMtAqdhKjrIIKg07svkgo84JjoMhr3a4km0MudY8oCCncpHquh6DcB0m8+FIenX9HebE4aea9bIQptG/jRsf4Klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYSEssDw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYSEssDw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499acf0fb55so7274285e9.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787168515; x=1787773315; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NXsEvTFlD66FPV8xQ5q49z6ovIp9exG33G5/qekFx78=;
        b=ZYSEssDwx3Yks7DkleWz0K/hp4ColH9nxRO5XrgddYPwJC800hTJcsiXUKgZQUqKWH
         G98zyMdBs/ufGgwQNJb3KigBGQ6JFl4bBnhqeskhEd35V3yv2mCHP0G803YvcrkSAq/r
         4vCGekgjkhmaitbztvAhmZgv7COoj6VXeiaA1R3Tzc3Aon6djwiTZoM03qfcVryxTGhP
         pFGGQQcEf8y4Z1IcOoLk6Ncg+V4eIT8qiIH+u6E9g6r+gmrdWS15Y2nvK1v7nCntMAV+
         NetCP2tB0PYGEJD/mYDCIS7eYLYyTnHlmzPj5P6QmX1cJEcCrrRavn8LCeUtaOkjUY70
         LXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168515; x=1787773315;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXsEvTFlD66FPV8xQ5q49z6ovIp9exG33G5/qekFx78=;
        b=AFWfjhBCbH45TrWmt2pxFo0cx9j0wznu/yO6OvlBLII43mDKtA9vAKHYx7BHjxITh+
         e/BLeKiO/m0TrwZS8ypiIz4WZkHFrru7E+VLQKb/bS6JFXjlssezl/0JVe/o5SudQYoh
         mQWjl5Jb6R3vrfrePRFHD6WcisegWEbUIZCSeKLGbTtQg3rT8Q+4Un85yX8n+gofzOw9
         sWjfx5dVKMq3T7WFYVNgHcg+IyXkIlJxffFWawmdg4KaihsyrOJD5glNKHaK0qNhFC4u
         VLIumpoue1RkpJPVwxJ6eo0VS7SUO8Yu84WKbX6uIWBZk5y6FRx1xLHFidFn/WHadU0q
         +tqg==
X-Forwarded-Encrypted: i=1; AHgh+RozUmL8nF/p8XcHUq5ox5s1PxEHLwn55QULjBaFfqa7g8NNHOVujWKIMDV+ZyywQ9MPsDcuxWr6Pp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygwMdnTmJi0xKKUVKlVmlT3DxtUHRL2P1ibz28kDoctLZt6JC8
	e6+/wzvAlJr6omxKwCFvJwtkSOIYEzQJemQeUSPEfuT5FMuOrSKEiYXZ
X-Gm-Gg: AR+sD11L1tuFi8vSZnshZ4r0Csxd4osUL0DQUDU1jR3dRaU/CMvKGz/+Kq0Cqq52j4L
	e05dCJ77CTkkdVVQBQFhTxNrKmrp45TiLMATyCZbVqZrZSijVGHFIlI4+brxAgRRNwbPpZBvbOR
	B5BtS0oCz9mej0lBTUecarLFdht+sS0P+wMVyj//xgoGQB6H4VWo8PIAD0Y3t2lnU9yxalOxMO/
	XE5JmaED6A4ShETP4HFlKKuZ/QHDo/bNMmNx/0G0vEbOChhYyfnLlT7QMTmOuoG8JU+TRI+Lsnb
	CKcoJoT9UCEv8yglR09pBca5ZwNLSM1tGIeXCppXZwooOjJM1KuKP+elZSc4aC0HeO2H/+zP+QM
	ypPVn/AVZJNycesW74LZL3KAuuY3aIc/1dgy7OzA4DWDgm88kvxXYupWbWZkggagcBqa5qFfsVO
	vbWcK1wqedcKaOJUc47Egp50I7E0bcgMTmoBvgNjvlrD+bCYCPY0sVu3nmclfOb4T5RqmQcM830
	+8=
X-Received: by 2002:a05:600c:470a:b0:499:a4d1:d7d9 with SMTP id 5b1f17b1804b1-499aa1b03c0mr125031515e9.9.1787168515089;
        Wed, 19 Aug 2026 12:41:55 -0700 (PDT)
Received: from localhost ([2001:4bb8:17a:e1ae:bb46:a0a7:bc2f:9020])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm118454165e9.3.2026.08.19.12.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 21:41:51 +0200
Message-Id: <DKT6D3WGKJNT.3C9TI16LYV4IZ@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v7 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
 <aoRltgy0AYZ_Vcum@ashevche-desk.local>
 <DKS790BEXVON.1FP9LQUPNTYDE@gmail.com>
 <aoU0JSmv7FWGW_Ms@ashevche-desk.local>
 <DKT4WS5CVP2V.2FWDOOOHIL3XS@gmail.com>
 <aoX78syq62cEs3hi@ashevche-desk.local>
In-Reply-To: <aoX78syq62cEs3hi@ashevche-desk.local>

On Wed Aug 19, 2026 at 8:54 PM CEST, Andy Shevchenko wrote:
> On Wed, Aug 19, 2026 at 08:33:30PM +0200, Javier Carrasco wrote:
>> On Wed Aug 19, 2026 at 6:42 AM CEST, Andy Shevchenko wrote:
>> > On Tue, Aug 18, 2026 at 06:10:51PM +0200, Javier Carrasco wrote:
>> >> On Tue Aug 18, 2026 at 4:01 PM CEST, Andy Shevchenko wrote:
>
> ...
>
>> >> >> +	ret =3D pm_runtime_get_if_active(dev);
>> >> >> +	if (ret <=3D 0)
>> >> >
>> >> > < 0 seems too much to me. If there is disabled runtime PM (and supp=
osedly
>> >> > device is always on) this prevents from getting events.
>> >>
>> >> I am not sure if I get this. A reference is unconditionally acquired
>> >> when events are enabled as well as in buffer_preenable, and also in t=
he
>> >> probe before interrupts are enabled. Runtime PM should be active at t=
his
>> >> point. If not, the interrupt should not come from the device, even if=
 it
>> >> was on (e.g. before autosuspend kicks in). But maybe I am missing
>> >>  something?
>> >
>> > The device maybe in these states here:
>> > - powered off (by runtime PM) ret =3D=3D 0
>> > - powered on (by some previous activity) ret > 0
>> > - always on (PM is disabled by user space, for example) ret < 0
>> >
>> > Are you telling that the third case is impossible? (Note that autosusp=
end in
>> > this case is irrelevant.)
>>
>> I followed the execution paths and the third case seems to be impossible=
.
>
> Thanks for checking this!
>
>> Setting power/control to "on" calls pm_runtime_forbid()[1], which sets
>> runtime_auto to false and increments the usage counter. Note that it doe=
s
>> not update disable_depth, which is the variable that pm_runtime_disable(=
)
>> updates and what pm_runtime_get_if_active() checks to return -EINVAL if
>> runtime PM is disabled. Therefore, pm_runtime_get_if_active() should
>> return a positive value under this configuration.
>
> Would it be possible to have negative value at all from
> pm_runtime_get_if_active() here?

That is not possible with pm_runtime_get_if_active() in this case: it is
just a wrapper around pm_runtime_get_conditional() with ign_usage_count
set to true, and therefore, the only path that could return a value other
than -EINVAL, 0, or 1 through the return value of atomic_inc_not_zero()
cannot be reached.

Best regards,
Javier
