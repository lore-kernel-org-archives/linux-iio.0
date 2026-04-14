Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D553C5546
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160267; cv=pass; b=aohZDunl1PVQLDEoZg7ugJBrHBiDbyGkLc1G0oAtSrWdPQ6tVfBC65A6L5qJD3e3II2pVlANyfgUmNS/k5oCR0rLvMQ07rPkIk6uiZi5USVUnrv4P6Vyr+W19Z7y5O9tS7/7bEFC5RD5IMw32Ha6Zo7Hjcyl4CewURp9gB5dsXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160267; c=relaxed/simple;
	bh=4LjW/qXhlw27jyCxexFHShkpdwDpih2uFl9wB6QWweU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8K4HBRRbG04rxd9cWzWDV5N2rwFRh0oAy7GEFrrLFSgIhdABrGF8WjKLFvPTWfdRXDQoMwjFd4RlZ1ZQOoSR939tlO5+P6xUgbgLYs7nwHC4ptGZVDTh70RvEnSeMt2vKWWbyEgfEzVCxl3+F+6O0Qdu/wiGclr9YrpvO3hR2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUkkIX1x; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUkkIX1x"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d73352cf2so1852537f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776160264; cv=none;
        d=google.com; s=arc-20240605;
        b=lCmKvXT89nFOuqK9vZk3w14qSwBz61RWoCe1y+aNlrQyFE0wF6gKq9vrKNrciD7EKb
         j6Xd729V1B/aQB51h9OmvGYtuF49dQSk3VghRHHusGDAu5u0PCpMdSbdKcMj0dTP6az4
         Vk6sPAaF3c23vCy4y4m+t9D5rUI/H9Oz7ykfb0ia2O0uWklU2vw/P4jPK0iz+fD+o1UA
         qoaCumwhBpfS9jPxLOaE2U15xOV7XV9PpGiB0rrfmw9JzXu3rIvgfXYscHcsb5WmfdbF
         pxOsxkrADLspktWsOlWjFHlsHkzyJcvdNUtU7s57c2WcHUuyit8LxDY6+uYVdLDvZEk8
         i+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kl1qXM31lG42LlVmPxw85Pw2BbaLgJlNP4rATMlCHS0=;
        fh=j6nIcyuVlgLAoZCnP/8LjgNZ7Mpyp6peb5Fo/X0jYmU=;
        b=OnN1hgisVV1s9bAXbFS+UmlnJahO6LOgqkObInzLmYr55t7D4CIEdjbZ3xeTuz6eLL
         joExHJ18VGIf6QI9hpqbs8DRwatmujbVMDMhwR4SmuHpP7RUaDOrrJSF995LkNRxfdev
         YtvyQQsn3pCqPSdrnk+LfZ2+k2O1CS5CNrbp3zoScMKW5EeCk5apESVQhHyO5F8ZeiaN
         bEj9a0Ok+PW+6lwrdtQL/LgVaKEBEiwWJUUVRotDot0ilf28c19iKJ6/GynvLTYRu8Ww
         T5BTVs/nOyFC87siJgpYWVpIYaRxDW7B1+xsBnmPI4QSR+T4pW3SaTVHlV+TUIfWiYh2
         heCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776160264; x=1776765064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl1qXM31lG42LlVmPxw85Pw2BbaLgJlNP4rATMlCHS0=;
        b=eUkkIX1xlE1ICN5cydgD2lXeQFfph27ShXwgg8TH9s7259Go/u7ygyXaWvd6MWD8N1
         FUQ5/tqHs/I1M5n4zmqDsVLzkKgxCUuDjvcO2lkFHFN/ganzzaRWTS7nuY4pldtGryfg
         e01QYo1nIamU2DDNYusb/vAuDb7ZO+6TPgKRAKkwgOqK+y562wY8AaYNXaRltoMPn5G5
         BZtJvVnaUovostgng0c1g1pAm08KdpUBZ+dmd4xWeADUQdiLvGsZwH9cAn9jycJMyCza
         TYPHRJYPVArzsDa4+0muwRRrT9zLUCheAO1DXev4QFQnY2Pwa3JVInlrmrwaUCXJfFXZ
         tTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160264; x=1776765064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl1qXM31lG42LlVmPxw85Pw2BbaLgJlNP4rATMlCHS0=;
        b=MSYAro2iA/h0uCJgxbYMrOikN5w2p7+ybr4jU+ykaDWMIMBMJlI/jq1N2O7jTsKQtm
         2VbT0nKZGjyMnR+6BsPVsmFybllrleA+PRVLsv1oc23OCoJcyKON5bnqGJH79jWqm3Rq
         YGpsFBjMl6XMC44fM6Q7KCjuro8r5XaqwfgwztdqWJJqiPRkKVW0W6EWv1i3QZrO4zqy
         Obh9WIh8Jv3kx5xsuz9pbfi8800So2ZgQD2Sv4tWRiGJ+P3z2WgS4/3B/ofHHW7QQqDf
         8g5MepxF7YI6sgY9hqjRjq/qnd1Zkd6YZpTXBhiDSQHKhOhX81VwYTbIGRKSANR4VrUj
         MJXg==
X-Forwarded-Encrypted: i=1; AFNElJ/CFNmfbSv4nUQrgSWbf4gFjYVjsDOg/C7/KXkk0SVQXWhzdEvsgx+5Y/RT98AoN3hK9CqjDdOjX90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KGsILfegnSrmkh2O4Flg/y6BfwLgEcPhG6+sgOJreWvunt4E
	STN2QYI20tKrkMAY2AYqZ3KUSyyoUBN4ITc1+P4T32xUxCtHjT+zHkfdu0lpBDtune1Iju4T+WO
	ihgETyr161njyeYghNrAqtEcwv+rZTpY=
X-Gm-Gg: AeBDies/TTOX/IlOLUmlmtirfrOHGwi/OQf8TfTHrFbyIw31o//KStm49PoAinx/G6d
	rt4rbOHfSpsKu0DXOgsQ81gz5s1RSHoZzJnkXDNstX6Z7h3CHgKurDYysiIzJwjIIMD00nLKkes
	irmCZpJ/Ii24gD2lbowvmnMhEnQNlzP3Y7B0w2GSIbe3odiQK5a0ViIQMBsaXmax/MjfJ2Q/3Mu
	+fP+iV+1Bz3HbVCReudb/p4GozINNTL+MMfngeBGfUeM5HfrKI2uZvzIB0HCx2vznjy5MWclHU5
	QU+kDzi+ygkvhDeBUKrOabI3ktWJ4m9/Zggx8BEFgbs7MiaHf4qwIH35qUNkhEhjxG0/LU41vzG
	z+5/1bBVw5nK4EzODvtShRdRTbciSPyDJ4fI6qTUe3/+QHtYxI3jlvK1M9CwMDSID+/QZ1h3dPv
	g9MVa+YhggRHTv8QBfeSRxHJITDMI=
X-Received: by 2002:a05:6000:200f:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-43d642a1f1emr25593544f8f.21.1776160264405; Tue, 14 Apr 2026
 02:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-3-joshua.crofts1@gmail.com> <ad4MbnpAfBEXKDzm@ashevche-desk.local>
In-Reply-To: <ad4MbnpAfBEXKDzm@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 11:51:03 +0200
X-Gm-Features: AQROBzC6rguiJabYsZOY4_RYkbulpgJEphpTychgiYWAeFDC4PxCQbEE7STdgG4
Message-ID: <CALoEA-ye9aKD4DyciFNZBW2TSd=pw162DD28rdvRw8O2OJvcqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 11:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> It can even be just like this:
>
>         u64 freqreg = fout * BIT_ULL(AD9832_FREQ_BITS);
>
> if I understand the integer promotion for unsigned types here
> and the * operator correctly.

Sure, at least I'll ensure that the reviewed-by tag is incorporated
correctly.

-- 
Kind regards

CJD
