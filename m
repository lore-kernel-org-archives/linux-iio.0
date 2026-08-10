Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8135C1A6
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344345; cv=pass; b=VcsdetlugQ76+tMDSNmEnYIUebzT+LVTxb++o/m03QT7APXqXI/ycpco+7GPooWXvgyeW6a0yA2oL4sTm3hjD2AFgx2M2ZAyvivxWNMAh8OyJv6n0SOUykOx5kyHpSekDG/DK/Q+Ln2x3l9Jxu86Rq5ScDM6gKY7EV8/KWTNFX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344345; c=relaxed/simple;
	bh=6QLcu9A9KrdkmU5J8jY6ZKHAPoHX7aOeecWkTsMmAII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aK+4VRPhapCPNGmCeeuPLBW7//gwaMCSci0GmGf+hOW8gsGo7CJBgyKp/slz3f8yZ1Rn5bjZNq8bjWtRp3EOvoneEqODIAEwDg5WYeWV1gVVisI4YuOoIrY0jMb8OxJRwMp76XFdpUVVgCr7jYjpiy5J2QFwou5g9cgJIhassyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3+EI4tx; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3+EI4tx"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so1333289a12.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 23:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786344343; cv=none;
        d=google.com; s=arc-20260327;
        b=osd1QO004H4S0tH58gSocS2yr3JD7UM56N14ZAkOFkKi25634eKiFgSKvC4Y+29YdY
         HlwK2LnrN024pIwm9a0jhmn4HKKF36L7MoiAHxNckdCNzytLlTogfmj0Ip3vw5bE+4ab
         8AnjUYM5Ls75P478Wp/8EAkm7WOudAbK6/+0UMuFBzJgiTBEVJNeCZRm+d32Bkmatkxp
         IjYd/X3PXTXet386lyiYIbjk44/epzTE0E7RIKlazEAp1+ECxeF7WW+IAfGc0vKy0Y8j
         syJT2v/3ms6cYjwdEqnB3XzrdYMaJJhCyM6HvEPXv7DWwREDVW5LNBfZQYAA+t7qZ7HE
         HkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6QLcu9A9KrdkmU5J8jY6ZKHAPoHX7aOeecWkTsMmAII=;
        fh=SonJofjX4as7KZ2EePQTL3kjLR1ea7gA0NXdw2IS/co=;
        b=YQz11Y042n7iZM0NPB8cNF3WCaFbPeUO/ckO4Zks13FrZcw+ZikwL5cALEY7n9+rgK
         xSQd40EWjt4YTyemcZhrxNBPZh/hXpnH9RYF/acjBzA9DQWcvjzJxVad8dL1K3Ue9DlK
         t8DiNFsMvW4TSXbKfWEEQQKWgm3N5w9B8/YbmzKsssbzwu1jt/wwjlhgBXxciveHgd7m
         fDNnmWkwt3AjAFmWcXRfWGokfmsJN9waqRcrhaDYuZVYAWBmiy6C1MfDsyJ8T3Utb0DT
         62FTAZy7qDeA00fcn6Omvmoba9XTIerIqG6rMmSH8T0W2YpHO68zTori2t8LHBJI8l4l
         p2zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786344343; x=1786949143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6QLcu9A9KrdkmU5J8jY6ZKHAPoHX7aOeecWkTsMmAII=;
        b=d3+EI4txz/xyPzoSyajwX2nxSLf9mNW6skiGm3WiXb3ZGTE2lcAhTdCCEDYHtWuxUX
         fMV3iS3IFLSvIEMJlNaUttJvDpYzTuPCKd3knqXJDmSaIqXHXONc8qmYF6/fVBdAB6jD
         u2IRAXpgRn4CKecU98/8B3qbk+o7zFu4/zLWieOex425OvL2TApr6eE8t44JbTEVkjDF
         4UgcXV2gOpDnM7rbILvM9ESwPQNdWKlyKhRUKYEzwHDB4QwrTngscSbfpyD5VNoYUEWd
         4ygR7Oy57HjXl6H7f9S2Drr1DSehHnTaVLakEr++eX2/WrPA05XedWAkbbbMuE2Y7OiF
         zPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786344343; x=1786949143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QLcu9A9KrdkmU5J8jY6ZKHAPoHX7aOeecWkTsMmAII=;
        b=fv32A+xVUDi6eduEyFkHaU3IvZzOUaLQ40+ixJzxPOKUEgp4hK6L5174wjXOdQWebZ
         88PgmwNSjG8GbAORFNDRZ0jOEaTtEB5ddIPPUsM7dDe5ur1bhQ+3TuYhvocVFwdKR54Y
         2W9YojE5V2BDLb/9x4z0VhT0uDnd8YFtTUVz20vgcEuFghkxGVG9ZA6EE//8L3MSGVwU
         srk7jSLpXE/cNlYWfpYkI1OrOCnUvnYUO31Z0ic3bNRoe70X1DmAEgQpLLuMI9JIpj+w
         rUhPj3T3355HQlzaSxzn0IIQUE4Q221Ke30mQE7RBz2nclehftgs2KQo5ilevB+YPv33
         eQDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJlMzFaI0UykiEDy/gw8AmAgjD0Ay2HR/8SjOW/QbiIP4sUWiyN6m6fVJjqUgRqI/1EHarWH+DTZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQNwDs502tagk/l1dWcQfZ94KEqK7c7ZVCcChGsQinMSZxBfQ
	sSvgu9x9k/wXb7sW6CJHCC7JIrKDNsgyxzknauuzAOhD8FnPsnfSU8iL/FsKr/67K7AXJj7s6eg
	8gO3RNKn7YAggdRF6nwbcPQ35ozEPH+AlN9wr
X-Gm-Gg: AR+sD13Pe0b+GHlelokIT6DZVHgMocFD71AZGdpr66wQ89s2ezgbxMSbNG1PXeK/gXp
	GOSugkknPHXOEVJGVWkIN03LKFL5rR5t3clIoRBg210/sXiql48P/1xarx5arYS+4TY+aIVe/ry
	0nK7VcTIp0kQOg3tfzbGEpVxcfl4WSxIveLpzg5Mmgsx0Tgbzi1gEvzlmDYHNgR/LXBGvgT6xcc
	UevBdr/fBfjWKTnHqnr8o2IYBAGUO24ESWRp+BpeRljLh2m0rUW3TdzzNeUsjidh9nDsoq0O5Mf
	JV3B1VAxHKCl4k5bFNBSvPYPTbcCXQ6OAfwCG65ozmJx4rGn1cQfRCyko2pmJI68FbDmjo6sDSJ
	3jmAe4n7/dfejZI1aF6lowsh5biOcgBDeBcvJtT+jKn4YkVA5dxyLK4sFz0M4gGSnQ4Kd+SQOC2
	ewrMMM/OR7ElBys57503yYTCIs41I9x/83EB1P+Z3j4nCIBxsBKIoBtA==
X-Received: by 2002:a17:907:e1cc:10b0:c20:83b0:92d8 with SMTP id
 a640c23a62f3a-c2083b0934emr648679166b.0.1786344342470; Sun, 09 Aug 2026
 23:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810064234.1850833-1-congnt264@gmail.com>
In-Reply-To: <20260810064234.1850833-1-congnt264@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Aug 2026 09:45:05 +0300
X-Gm-Features: AUfX_mxrE8pNd267WhEyBxyLos6OjYm3bVOTtBQ_3c-gISNIhDoHX2Yydt0R42M
Message-ID: <CAHp75Vfzb6cyrpfadfr3-UkNKVqNP1jsLMkmnozG9uqizt=thQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max1363: sign-extend bipolar differential
 channel reads
To: Cong Nguyen <congnt264@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:42=E2=80=AFAM Cong Nguyen <congnt264@gmail.com> w=
rote:
>
> The MAX1363 differential channels are bipolar (scan_type.sign =3D 's') an=
d
> the device returns those samples in two's complement. However
> max1363_read_single_chan() masks the raw value to the ADC resolution and
> stores it as-is, without sign extension. A negative differential reading
> is therefore reported to userspace as a large positive value (for a 12-bi=
t
> part, -1 reads back as 4095).

Try to make it more compact (remove unneeded or duplicative details,
do not blindly rely on AI).

> These channels expose only IIO_CHAN_INFO_RAW (no offset), so the raw sysf=
s
> value is expected to be the signed result. Sign-extend the masked value
> from the resolution bit for differential channels before returning it.
> Single-ended channels are unipolar (sign =3D 'u') and are left unchanged.

Same here.

> Fixes: 168c9d95a940 ("iio:adc:max1363 move from staging.")

This is a wrong reference in case the driver existed before (and that
is suggested by the commit description).

--=20
With Best Regards,
Andy Shevchenko
