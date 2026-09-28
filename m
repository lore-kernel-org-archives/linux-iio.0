Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCED2EEE92
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618417; cv=pass; b=gzq3TLIen9NdHfhbeq0s7GiHXHDqNrJbx08F1US9VmKhMFKD8+afL9zrRPWupil+33lQK922Blre+0KQQuJ+lt8LO4DdDpP8JKHNjaZklfRWkhDTA3F7oo8jEohJswD+pB1PwYKa3hrweolskLBewPw+Ai17gAjCnta0F8TjBLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618417; c=relaxed/simple;
	bh=0I91rrcpRDBpQavI0QACCEFr7s3xG2ezpO5mspv/Nxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVm8wmMMwXqGEZbUbbdv+ZV0H/TYYbSP2CACSSahoYcQLgl/gvDI2C5tpK1f47HbSv2JzaPw3s87qtGjRCzIwcT/slVoxbngpH0OsKIYQTy9vQCxFufv6YnBsnwvXsG3lG2aSiNvhtD+VQZruolRLRTPfFm9YkA8VzJ9QiGS+7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U21pzqh0; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U21pzqh0"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so5326571a12.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 11:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618413; cv=none;
        d=google.com; s=arc-20260327;
        b=cX0tf4UDj3v7uqLkA5LM9SDIqF73Q39KVHcGBIXUZ0B9Al7DCQXjIEHvnwTOSVQwqp
         b93ZUbpfTTB/xTRqdPNfObZS1hoH3D9YwtgCEx1cUxpHPfiaEVNDXl1kGa2k8q10LZfW
         SW49GSxrauUzU+ehhUBsmzCly3VQLGDmKRVaxXg1JIsakLpKrzo03Qdc2LqygTPSzpu1
         dmptlex4Z9oe+CesgY9kZobOC1FD3CjkHdtnT7VYEDdiUxLFAqydUKzgi1uT6BxJLkVp
         BdVOL/7Vd73F9qVjFKTC8F9fMUdOWC4e7Mt/grs6DUIqX9zZDny4l9Wg/pz+4HTaz7aN
         5/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0I91rrcpRDBpQavI0QACCEFr7s3xG2ezpO5mspv/Nxg=;
        fh=J+kVr3OPVHknWxW9iUwKJzFers4mgfFMwmnWijbjpbQ=;
        b=AUiqkaEcnSZameXI1kSGBdTfN7m0T7hWSOvatkGjt/8XszZfaVDRtfKB8QEksi3oxm
         30Mn5BJP1kb/RSQNs5/E/95DXF5hkVj09QSJEJVrztdk2PoMKsjcYy5A5pWcFGbwNcgo
         4ifzY/lpwS5xK7xtw4TAnV17xDSBZH8lGNnFWL65BVEY6KaxqWJzomL8SvUa6fnXRHHR
         HaXT1ZGDaTqAJgTq6SalUZGAFNR1QWw8S2lQAfAtg6bpH6YupLl3iqzlwoDwC6tBkaDD
         PTCIsO4GdQsDE+aDR5luJoLzI4pI8Rt5Q6CqpbM2KuWdKbE1YY6VrUPl3d0zPWmxmKBa
         3gbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618413; x=1791223213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0I91rrcpRDBpQavI0QACCEFr7s3xG2ezpO5mspv/Nxg=;
        b=U21pzqh0G+cG6Rjf9vpVHgRMS9c4h61p6EdkOkzXqcFp4HEZ34aKN51eDof9C+m/sy
         N+b/8FkJrjf4V/d08YLgrtboZgDtYCwVyZLQIg7VGu8OH+TV3Do//RVIh5JepwHQu8zT
         ITyUwhYeyibKbeE0jPcP7tXSTtKblVY1HDq9xW76YbE992OgvSlLiiwjX+Bnc5wQRq7n
         vqeZhghlPR9bEYlfOL93WkzESH0KdFS/+XkqHTI2/QlL5bt+RDIMvJXTbm4JFOnPHETR
         RNAQTF1hJJTTfhTcOAeJogPLoLLVHkmtsyrOyGntBN/QHp4q0WTwTzAdysTK5FYCU6k1
         vTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618413; x=1791223213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0I91rrcpRDBpQavI0QACCEFr7s3xG2ezpO5mspv/Nxg=;
        b=uTGW/cEp9QPpEcMPvGg5hohCOMfipEJ8bQ3u+Cqf0Y6ytAVHTRdMJzFtcY/+H9ItGs
         wzvEw+0zSlrxUiUXJ5X/9+mAG0zKGPDeeGex3Ex/a0MeBuWGARDjmSz0SYZen82o78Jk
         9TDqbdIen/k8ym8nCGuaBOjzK9CaUHHv546D+k+uuLquaAa/xxj9F5ohI3FPukDDXWyx
         a+UbA+fHv1kEAeM3Qny1FBkJXrxzveuxVnaXVq1Mg6Zg4dz1ITPm6i08Nd7SYAF8hpHp
         eeir2xYkkpjdXuix01rdYWBkSU0GVU/p/FmaGiLwD3ODxpLIj6+EfRkxcwjCvqOP5WHG
         E9/g==
X-Forwarded-Encrypted: i=1; AKwUvBzELThXx4Qh3sCa/puQJnkA5gbQQOIzSGl+xduJQcjsa4kUZuOFUHYQh3xIw1S5RPeV7VdYOvhr0Zw=@vger.kernel.org
X-Gm-Message-State: AFuF++kDlsB5Wt2s9lFpNatRSK+9/T5bNIp5M+Dl+Ccg4zVZyaazHSbT
	9sRIpccEtWdn+Iq37xUJlOnEeD3Mr01L5KH1MqgktXq/W5WQXde+8puA8+jVJJbiLc1pWpYYDAl
	QpspbW2h2ejoFraBW0cX+CSZ4kBM7GJE=
X-Gm-Gg: AYBFou3s1xCe0e8sJrkQEtmdhlm/Ylk27MCCZ8MiY01kT6LE5nVtTw1HOw9rEvlQEac
	E+RPYeQrwfeDQxa6AGIBSZcRYiKo+BMq+PqgApbW4rgmDHAnaBmnUetTKpJw75DRTM2TkWEg2Nz
	d9YRMDZXl1R+z47VL6R1rfAfTCUI/ubROrLwHkD0hp17pOhSXG7MToF4fENFovJB1Kdo3gBw+mr
	Gf6Y17gstpXtT/lM+uX2gIq16u96FXcHG0YSuaZR/jr59ysZFxPmJMN1Wm99vei/uZNerq3cVrB
	LylctsxiV+5LDEpp5bRE3M2+hMkp2Bacmw4mG0E9JlE8NM1Z7MRI8NRYZEwVTbf7pIZtLM/93ea
	f9DEw1h5aaPzsVXBl1jzAEC2cYbOfE/++6l28WVshtJf7ZYH9gLa4KQ1lnt3/Rsm2YYNjcxLmlP
	gqGd+Zskn17CJAYKQSt8XRbB8JLK5vNrfqjAMjXr6z
X-Received: by 2002:a17:907:e155:b0:c2a:c799:d068 with SMTP id
 a640c23a62f3a-c2ac799d409mr775442666b.28.1790618413239; Mon, 28 Sep 2026
 11:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928175049.86941-1-jwuerz@gmail.com> <20260928175049.86941-2-jwuerz@gmail.com>
In-Reply-To: <20260928175049.86941-2-jwuerz@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 20:59:36 +0300
X-Gm-Features: AclHuK_XhOB9oxmJMY3hrhIvGwqZTaiueHFkjkBAMtGU0VsTwDCtlnHkWSnBtVw
Message-ID: <CAHp75VditdLK=ehv2f_9Yo5m=6zVg86u==sk5sY4ACjJ+hWr7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: imu: st_lsm6dsx: Use C99 initializers in ACPI
 match table
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Samuel Dionne-Riel <samuel@dionne-riel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:52=E2=80=AFPM Jared Wuerzburger <jwuerz@gmail.com=
> wrote:
>
> Convert the ACPI match table to designated initializers, in line with
> the ongoing effort to do so for all ID tables. This also drops the
> trailing comma after the last member of each entry, which is only
> useful when more members may follow.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Link: https://lore.kernel.org/linux-iio/aroutl04Q99mqJor@ashevche-desk.lo=
cal/

No Link for the suggestion.

> Assisted-by: LLM
> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
> ---

With that tag being dropped,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

--=20
With Best Regards,
Andy Shevchenko
