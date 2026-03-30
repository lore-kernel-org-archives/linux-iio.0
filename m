Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A03AEF34
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862698; cv=none; b=aHHLJrSAcnqIWCdXZs3kZjnDWv8aAq782cwJqRTO606o4MCk/55cgL16xUnpRyHlijXhQk0NFxW7DwqgKUdNkCNsM0UOAYvy4bLb/52P0AUyNi/DD80pyKjzRyaO6fLkIIQiHzup8RNU1MbOioB2gMzZuqjfjKMJ21NYpsE+Xq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862698; c=relaxed/simple;
	bh=8cg+3kQLXXiTkfV3cU9A/x5nfqzAT5cAj6P84d3VV1U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VfziOmL4poyQd+3/Q5upU4kPuPvS+291rvP6ZCCnSXQ+kCpQh3iMIUcH4rFrOQWZaHYxloP3l6Hd8RMNah6+ZbBuKp7z7OwrkzJ7wu1u0leQHywy+T3LKUlortr6a2eDP7fJoa0vA1d++dfLUBxbaGf/OVuZsBbNK9qYGDW7iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6iLvl9L; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6iLvl9L"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3988393eec.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862696; x=1775467496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GpOZsFA9YDn0yRQpDJcAiVM07QWQzHxZa1ILteDRZbc=;
        b=k6iLvl9LPz2/w133TEPEysXJG3Aivszk2lZUaY2EAq03nLl3CGtcPNZPbWGrDkaiEJ
         6vvX4MMCjI0iVIipmBnvrrVqJwkB7XOgC8TaSpzOqqErMAtdb59Dy7KqnmW/RHRWJRU8
         ShuH5dk5k9pYjQVGQt5aU3VE4TNgzB+DTWs26i3c5SIxZvmGl6PXYQDpNSjXHcq4pgu4
         vTMkUVbWY5slW5aJKI2C+Lw0T74JrOmdQo24aVFSRiwUpjmYZUgCwKq1PSNta621V2ak
         2OrIkDDzufPs/tGdFpx2sORlj9xhG/jjXi2wUVRTGeAmyUH8LA7qHlE+Bs1EMDIRfy/N
         JYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862696; x=1775467496;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpOZsFA9YDn0yRQpDJcAiVM07QWQzHxZa1ILteDRZbc=;
        b=RUbWcQwaKI0JF80kAcUGnsFHxD4AZMv9Rm8G1iMYYunwAv1wVj5AoUuKQiBFKyAfHR
         pvpN9UQZrGOzSCc+GSXzZOpM9D2dwGIbK3Bm1xxsMhipJhn39UAHUo2ihfcL9aKGbpZV
         tx7DtBGdcUyniqjCHOJBoMfgNJigga8D1/rmSawbIt2PgzJffXSfeVK1/oMxJ/QlqjGa
         9S+fLlxruKQ4ta/6QMSWqeupfNwd5veJGR1AlHi9ibD3eAoNPOGWwUqgz3mATTOjZyC9
         C9i/v82Jwh0fiy2BFOb4lYhUZl2YKu/DOmrWN/q2XwtYFm423983aAX019TN1ATBDGBq
         CW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg/zJYAxhoAy8m6S6l5SnWKdrN3PcyUjNhD7XozVM2dBeLftHEf0fQ1UGsJg4pAm88Yq37KvMXbpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAsTTUjDW9km6Wmx93qSxpsE50a8Y7lMxi2L8BtnZ9nC//Qfn
	VeQOpxm5suxnKVEJXLTiHXWmliQNKHZn1E5z4ky0yMHf4NFIYuI0jKYCo/8ZBw==
X-Gm-Gg: ATEYQzxlbgb34TW3QA+YfWjhhPCg1AKqi+xn/w7zQdhhNg5et91RoND/Gs4gPSQbJsi
	umMzDtO6LEI1ljEJEjuNVTlV/WzVDSuVjJg9sT4/CwzR7TGk1ubqt+UxSgSdhqNPfSp5tFpLLkX
	VKOEHfrY21ixoyKWyIo9AP8M9lHAON2OCvltvWiTTw40MXlajSRcG39lS8zmHRHEWJ739nVs2wU
	7zcnX59/st/R3fmikX4GkhYPBZYEsKoUDnc53m8cQ6ZesdrQWbtF1Ib7ORrQJp9AiG++IMAIHwH
	FiNnvnQV6UxlEoFO/lx3MBzwhaVZQRmmhAABkA7t5ojDDukJm3njr7vjOz76tU++70Y0CS7OJtG
	s5J00PCzU6hnfmCLAY2gPizszR6zswFNfvSQRd8QjWn+nANbB1wEIs4trdxw5m/uQ3zDCCWMeQo
	RE5JrkntmdJfriEBr4We09aOqOAmLaos/pFp1yFj2clBc=
X-Received: by 2002:a05:7301:da0b:b0:2c3:b172:83c2 with SMTP id 5a478bee46e88-2c3b1728c62mr3307373eec.20.1774862696044;
        Mon, 30 Mar 2026 02:24:56 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2601:647:5e00:4acd:e6a1:71c0:d327:1ab4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm6740116eec.18.2026.03.30.02.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 02:24:55 -0700 (PDT)
Date: Mon, 30 Mar 2026 02:24:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
CC: =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_4/4=5D_iio=3A_adc=3A_ti-ads7950=3A_co?=
 =?US-ASCII?Q?mplete_conversion_to_using_managed_resources?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMRc=MdP-fvm4WWgFdHabCnVbc=rV943YhwrCHaCH9VCo_ZJJg@mail.gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com> <20260329-ti-ads7950-facelift-v4-4-c568c508c49a@gmail.com> <CAMRc=MdP-fvm4WWgFdHabCnVbc=rV943YhwrCHaCH9VCo_ZJJg@mail.gmail.com>
Message-ID: <671889B9-1D36-4F00-B044-0173A13F7403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 30, 2026 2:20:33 AM PDT, Bartosz Golaszewski <brgl@kernel=2Eorg> w=
rote:
>On Mon, 30 Mar 2026 00:47:09 +0200, Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> said:
>> All resources that the driver needs have managed API now=2E Switch to
>> using them to make code clearer and drop ti_ads7950_remove()=2E
>>
>> Reviewed-by: David Lechner <dlechner@baylibre=2Ecom>
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> ---
>> -
>
>[snip]
>
>> -static void ti_ads7950_remove(struct spi_device *spi)
>> -{
>> -	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
>> -	struct ti_ads7950_state *st =3D iio_priv(indio_dev);
>> -
>> -	gpiochip_remove(&st->chip);
>> -	iio_device_unregister(indio_dev);
>> -	iio_triggered_buffer_cleanup(indio_dev);
>> -	mutex_destroy(&st->slock);
>
>That's a functional change, there's no corresponding conversion to using
>devm_mutex_init()=2E

devm_mutex_init() makes absolutely no sense, as well as having mutex_destr=
oy() in remove()=2E The memory containing the mutex will be released right =
after=2E=20

--=20
Dmitry
