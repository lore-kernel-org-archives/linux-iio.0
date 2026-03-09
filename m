Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB928B7DA
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077630; cv=pass; b=ZqFhDV8+cN3Uj/bNnww4+vcY/Hbt6hnmSqkpvB+DS/YZITZj5YWnMj9dYmvwkUkCehuMeKKCFRPOgduMd5U1eKso3+3lIkHMiGQcAhQOYuMJfgnGWw56owUQ50+vNNf3UI1hUK6L8SlL9IexxLtuOXl0xtc22m7ZjWKfYml8aNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077630; c=relaxed/simple;
	bh=o2bK0FCgS1hV/sjpW1UHjkwFHrxpdWCi4uOBdU06+tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWx9SRMrWYivd2vJ6U+p43p7mgkcAh8CAib/IW9abFHmayZqQYi29ri7ly59S8z0od9IeSN74q7p1Qdw4Vzg1Pu2Ufa7eX3Re3HZ2yxru2amLbfZC7dud6DvBBE4IE5/DARBSITXeEpQ7Kxcdz7NtbGQbvQu/7ngibYGdqzzN0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbIszNaH; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIszNaH"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-662abedbeb7so825212a12.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 10:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773077627; cv=none;
        d=google.com; s=arc-20240605;
        b=R+ZXlLsAV/mNcBYcHyUdeS18vpzfMRZd6Q3JwrnLcz48SrG/Ty+GNLk3FfjJwIvBqk
         LVgyBfELElHML2U2ln2XF8uxYALIqMopu9ak1ZMqyP/7m7IR/vp6TqE5Xo6u7FojG/FX
         U8TVHQVCQN1wiNxzJ0zEkQdnqM8WU4WglphwAe56sBSfimaMHogOShX/446qXopCwHxa
         1xwNgHPYpxTTpemUj9m4/RhmvTeQgpR0ygtOOXH53J04mB7Adtnq2Os8Uoy1U6KwH8Yf
         iJ3y2rBiZb6kS1A0DlDWMx4/T9fqot817bz/WxiCXXEwJU9fSt2WlZXTXseg6TH1Wx34
         YVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o2bK0FCgS1hV/sjpW1UHjkwFHrxpdWCi4uOBdU06+tE=;
        fh=YVm4VAzVCVaRVhUZkk0PH+Etlw7qQgztkSL734wO+m4=;
        b=IiQY0iKOF25idYnr195vOg6qz/F16CqzScx6udIKMnM64x2t5Z1MkQPiXa1wlcozXl
         Dv26JBPQyYRvjqoFjqiNpjtQo0j0FGBPADAqvCjbLYHNP504bteICEdTyGCGAaKceYa+
         C9+6h990++pAVqpO4ZXraYHy9ItRWLiFhRqqdJZTSCVjRzZR5ZaD6ASbtchdukxR2FPb
         CL61+wyzGDyp2vvwNzBn4OJGl5Jur6JeYi89y3Boxr4xjqC0HTZTmifKkFQckkwDsKhk
         Yw2xK/2RfEplV00flvfym6daZwFqkI0mpOhMIA+kOlD4X/K/7JXfHqbAskJ78wjNCxVO
         w0pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773077627; x=1773682427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2bK0FCgS1hV/sjpW1UHjkwFHrxpdWCi4uOBdU06+tE=;
        b=NbIszNaHf8I2ma/+HQFLX0mvE6DbVRdOXbFH8FQLOk3KJSNOblzOpQNRcGTSKPM+nw
         9o3F1+1L+9bxVxrrScWlSPxNaD2cOjfw7Mjh7mz/NaZAhwPlfz8tJ+0xm6oqB4eucrL8
         tRetRRkKuNT3n6R6R1IAsMc8BT5SKeAwsZo1SB+NB+615z99DtbMnwpB6uzx9lYPSrMO
         rIa7y2gzv2VUqcIkPFEWNj9FzV2fJfhOisbWPWF9dDCIJ1ZPFKu5T761HymcS9srIjyo
         VCSHntuuNZL4r81li5mjYVkN4NsC7ZZLwTmy5ypo1dazq3WuNm2/NYXncOttIX+5RSR9
         O/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077627; x=1773682427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2bK0FCgS1hV/sjpW1UHjkwFHrxpdWCi4uOBdU06+tE=;
        b=H2AObS6W+pDWPnAfNn06/AdwK0UsbJL48rbxKuobKv6bXsfkDTjGGQdYzYSyCtQymN
         lfu9fcPAzCabiZMQtShfFYAw0aDaLCwPj+8p0BoezNKz2hHgcec1Coon+RQFV9q8nRrf
         WMeJlN3+kXidzqOreZLldy22FAWfKaD1vM7oSubggBVvWSxvJ8R8Ka5GNEtTjU/med65
         hKug4xa0HTA9gC6v4SJwyjcEChapjO7HwNqYFUtPqLe1oNGmU7qOzNwpbb2DfU1A4yWX
         WEw2729O5pN2tkE04extXky/CgoWG5KD9qMSL2fhDQgvbI7VF87gKHSz63ntoW71BN1y
         D/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvQLu4KvHesQV7DeBKGahCWahmLl03A1fNc/xZpnRQwUvWuPgIB75QxHvGQpQVpzOq/eEZ0AT0m64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CmZ6MjiaXnt1CCbOAjfgVVZWsXiIAxUroj4TgbfSqwWSh1Q/
	+FzqquRXUNLeXngwpiCF+p9FiCBY7rm34+4y8C4D6QkimTWY2d/xaRugBMFbZ3a3PBJE3zCONCu
	QsI340o+JDsYjgEIFKxxcL1U/dyjT9BE=
X-Gm-Gg: ATEYQzx5GSdTCtgIFVRaryBG6LaPNwVBffsDgg0cEKp4teWZt4GNj189up4Gb4col/Q
	xxXR//tm6855zlXG80HcvYgtD4SwBqn22iIjoXLR3GKiuc3p0vEh6okJVT/r1j8BoAG+kIVmpiN
	aBYzfl7m2vdChCwyRD6BagBRoH5KMkyYTdTEufLDTsI3ukQF4pl1hpDT2S6ReD6z+j9aHsBnXaw
	HrGzOpM86Pk4I3vG3OxLg9Eu0DR5tnCs0bARUjB76A5WGoRGHFblfhwISnSstz79eydJZMR7Q/j
	lInoLYkMgg9hx7MWGt5QxiquQOUlZAunt2xY0xc/U+lnsYO2rXMY+Hrn+ao7KY+rpuH7fBG14kb
	2BdohOlgnd8onhGAgQX5QIJs5BuQ=
X-Received: by 2002:a05:6402:364a:b0:65c:420:d3b with SMTP id
 4fb4d7f45d1cf-6619d53abacmr4620288a12.22.1773077627255; Mon, 09 Mar 2026
 10:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com> <aa71mdKAc74CNhdd@ashevche-desk.local>
In-Reply-To: <aa71mdKAc74CNhdd@ashevche-desk.local>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Mon, 9 Mar 2026 23:03:35 +0530
X-Gm-Features: AaiRm50_MJhKRGjgkhRbSs8OVThnNc7Zu1_yeLMFNLJkjeGvi9IutY_fzJ8WhyY
Message-ID: <CANS1Ubiz2Lcq6fkq2yK0vzcxXSBGOZYdLr3XWGkmcnZLK9RHDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: accel: convert to guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Why? It's valid change when in the series.

Hello Andy Thanks for the review, As Waqar Hameed previously
instructed that alphabetically aligning
headers is just a cosmetic change and to be kept in seperate patch. I
thought it would be a good idea to keep
only one logical change in the series.

> And again to make sure you got it, send a new version at least 24h later =
than
> the previous one, not 2h.

Yes, I will keep that in mind for future patches.

With Best Regards,
Rajveer Chaudhari
