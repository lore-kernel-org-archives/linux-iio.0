Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E22282F20
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615954; cv=none; b=fP5Vw01wGkMoyAHMzjN1ZuBZmCSSWJRxcbhqmNJ8MPu62wpoObI1euBgILu+fxMdrYbQpO05pT0oEM1YWqwSOAdI53VPJ5OeBncdgpTB/CxeEowEbZe9Hjnry3E8WVPfJpyfJplkneifqJcvo7wvhI1zer+CGMWT5Gx1doZFAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615954; c=relaxed/simple;
	bh=JMKAvhIXCNUjIDcumQ07uQ6ytuxwQvAU0JuO97CiZgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7+zYlL5aBw+gNrqR1lL6EG3aS+oZzD0JmZQdPz6x5MnaoipkPuraKEKSXlMqmknWxrbfcL9MmQ6B8DeT2uRfQ2ux1whXnpVZ9EZW276iUyHvJg2WUHy2deHfXsk3AxofgVI1sBCLckBtbOQ/wrjalwGzFaHPKNWd/4IpnZh2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxcfU1+k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxcfU1+k"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d870d54so227495f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615951; x=1792220751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M9cNNicW0o/hRO92NlnGJ2pji8f57gDd+YVFwHh22Sk=;
        b=HxcfU1+kFifjL4FwBpqnR3SP4fU7IVhK7AMgJ+vFB5YO1heTATpr6yWcwkFxR3wp4i
         AjqeHkCDyUVPG3/Uqs5HFkvttghiCm1xpjh6gWA8AnPL8ZZEomUwvgaxYFwnAS9yAsG1
         Ef+6Z2H51B+6++lbrXKKIAg/Ns5PAiGz9lKx2tqvSH8Xk6pG/KJQ4igdp6NcDlFhLKDh
         qlE/qVC6zsJaZK8OTVdwjUbySZQCnomU0n0lZEYSGUZgHTF/zUeKKnNNQggYsZjV3yjY
         yei3W/Nwdgq7u68uRiqtEGr0e7Xd4tMagdIA0tpscz0VPyJmos26SwQvVks73fJHExiT
         cyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615951; x=1792220751;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9cNNicW0o/hRO92NlnGJ2pji8f57gDd+YVFwHh22Sk=;
        b=IXVWc3rQPHLmYOaBrdEcLV/Q9eCrymyW9cT0X2ZLp9uoTLkgidPh/MaQs+/N6nwyIj
         JV8r4havGov+GKDgt7s8TU2ovHPgkTzDYpLxruqFHsmqcxQ5eQDgCDaKUHi5Q5jCJ3+Y
         DEzgFlRdOcetnB5nx1nGaqMMtOgFehadKCXTbbi7+rGhHdASqgOp5yAmpWDwLvufUsJP
         15jg4f0OctmsTZlGXHRpzpKrlkovjpSqXNwzG5msA4JlKsajrKQsn/xFT//G4TMvMrvd
         jngmq5XkN3z5Ma57qIgTGlreAR61Ul6bsavTdr2gKisZBknj9ITjd98RBI3xfW+4Frpn
         w0zA==
X-Forwarded-Encrypted: i=1; AKwUvBz7NoT16fVHGEl6OfVv1GcbhTrachxCzhQFuDfQrn8BOJqlJ/QU6FCipCE+bWq8JUOpQm6nBILB3RQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqDvgf0habrmMeKR9OdInCWpWb0RvaVNcCWmPwGOcCPGe6pW2B
	KpcDmrvR5gNCDQW+uQBVb6+aArCtxzeWfhK+6f7UFfh1jUiJc4dujqVz
X-Gm-Gg: AYBFou1HBPEc6JGvznAKIzqcOc/QayU3REzONrzaiUI+4gIjDlppGB1JIbpgPWrHwDs
	tUG8m6BqvxN09ky+B1qM8Uaoldg9MVApcom/7xI2W1AOev3rzz+qvMoz6z6/VrrgOwM1MObfbPe
	Yhh6/YMEptOr/KAKiI+PxY8pjFksQDfz259qlhf8ldeGlypJW7XZshDja+kRDN37g+vTK6mEIHH
	+mkEPdD2bi2fdvLHI0eFoEpFxqCHdAJfoj1tpIDiNGDxNypRHQa1K7k+ZB3oG0CestPqf8EwJM8
	nVc7Yb5Mi+3waStBnsKqCDrl3N5pUH1ZG3moLayQVXxzwAI5gLj4ZKuH27rzprpP/BAmDapvaK5
	R7N9dF/inxp0Gg9POFrgV4Zntb8b/jRL4epbg74+c+SXh75Ps2hfNsHEyhXtBRWxCM9mwwY0eSG
	AzMZLqAq5trtVQh8RCtTv7qRLK5661D5Mm6emhSuGm3KdLNuAGK41bbvoDtxSX3yyYLhZM1Nlxj
	oWD2qGjxiCZ2lEegxEdC7AgzkBpR0ICkyHnTD1sd/vClx7VRWwCInZm4TT11/TEBQJ8a+Shh1tj
	f3JK1CAwX+wY75OQ5P25/mABdbU5W2Ae7DUgMqIjWH3Ob/EasTRLTgo5Ck7ZsAe46kIwg9qKCI+
	4J8qnifGVSY22OUG/hmmW4kj0LVZHrgw9fwFSsGBq7GuPN+o=
X-Received: by 2002:a05:6000:4308:b0:488:823d:5060 with SMTP id ffacd0b85a97d-48dbacf1667mr7353088f8f.48.1791615951135;
        Sat, 10 Oct 2026 00:05:51 -0700 (PDT)
Received: from systembl0wer ([2001:718:1202:45:4bf3:6161:9f6f:60cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm7449823f8f.56.2026.10.10.00.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:05:51 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:05:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ltc2497: add LTC2493 support
Message-ID: <20261010090548.789cb699@systembl0wer>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-2-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<20261009-submission-ltc2493-support-v1-v1-2-3dad1d4b152a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 11:43:35 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> From: Andrei Stancovici <andrei.stancovici@analog.com>
> 
> The LTC2493 is the 4-channel member of the LTC2499 family: 4 single-ended
> inputs or 2 differential pairs, with the same command format and 24-bit
> result. Add it with its own channel table.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
