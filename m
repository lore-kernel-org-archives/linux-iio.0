Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5B33D511
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244908; cv=pass; b=VIVL/d7e2N0pQMTUSEgtGckBqORhNkFTlC9PUSbS7SmDwnrG1TxQIQbS9zJa7HYOxV7G8Dwjnk4swmwSCoh/sziRPoujKDrClPJtkZx+DwNoFHOO4QY6tMdd0Lo48GQk8fokTWwWp+hK5GgUl9dYBOCJlhPcPtT4JF9E5DkLSPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244908; c=relaxed/simple;
	bh=QhZ/gW/S1ObDaJ5tzdx/zGCVhSS0mQmVVZ1zbehNnms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amvwn9Kjn5ZKntoqjMmVpSDdSKlZ8EV150ec88UdSv06d6Uq5vRbXtg875rQ5zp3QZzEf5LL0eubEZDI1tl0bEVkzk5qYh94e+K/Rl251sKyVEqZagX/wYKglEIuTGZXEVLnVC2WLY4qEsKWuxCJ8RsCS+tCeZCi1RC/Tw9uOT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm2UZnn/; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm2UZnn/"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c5361142fso2116397d50.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 05:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778244906; cv=none;
        d=google.com; s=arc-20240605;
        b=BZLEmWNqP9D2Vj4CFczL5tdXd3r4Lrpp+SwWWGyqG6nQfBwaAEWRc7sGMZkofqI0YF
         pWbXwbw6EK+hnI/S4vaDPtHP7BWB83gkqalnBg35HKMt8IUXRdZ1+p0/zv2oOYOE84xm
         bm1042SZPfI9llcm7+0LouDs1m1vNaIA2uOmGkduE8v9llkyhZdvPWc5uvkRwxU82I1p
         UZIJbm4+xGBy7FysGVmGL+hkROCvcMg1aGiEDTE+bL9aPg1n877W6b3l+oeidrqjT82y
         a6vvvEN2PN41g1joKZ3nRBjJb0fwYcdJnfHI8fhhOpZ62o9DAX4L8U4MW+WpuV8Kkdm1
         1LrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNh5KxwhxZCJsoxnacWw4RjbmOVm0B/OxArYPR1gwUA=;
        fh=KwmgzhyjJY7lKcVSsNjxGCUjcZF1elvkt7yoTW5kZns=;
        b=EjvPdPmb++uYvum7caw94OJaeUGWjttkGqn9Y8bfW8tNrH3imzKtFV/v+vHP3Jtvvr
         QIWG2CTL1oBOQ5t/ruId2dAU02rSnZZo90TxhOJBDVxSqxX8H3ns8MllwdRw/JyrS7yD
         E0xpXl2oE4yq83iVQ2iFLNuVLulnG1nmpABKmo7Abpw58pyCvRT3aMNwktymlanIcJY+
         6iGqP2+qeK0ygKBHr6XMNla9XJRVEY0WbmWMmcjbvGg998zeqwMCwNC9mtPjIk2H8bVb
         XVBBS/f8oHUpkAKi+CT+esM56SBYpA72oW2foV/K7ftoERjLcez9OqQmrt7IjapIhjgH
         f81Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244906; x=1778849706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNh5KxwhxZCJsoxnacWw4RjbmOVm0B/OxArYPR1gwUA=;
        b=bm2UZnn/vMnH1D04CAovSR7855SsPqYE/lq2MrbK5323rK35pThME8NwCzCa8oH2oC
         VSjXKCkq8/yDE3NlBBlP0pZ5CK5P258XwWfx3L6bO6/WBD/Etu84jBfFkyfwneFtGiNj
         jjgrEf72KTlRXvhlHXLn0UXI1QkB9aqbFJfdZy9hxH3EzkJJOJBMI9geIt2JSiQbnaVH
         YiU1+6um5IsLW2Lxtkql4681NGKKdAjBJ6O3OByy9803DHjpwbjz6rfuQTADEqeF2GUn
         5QCF5Y/jZb9DOP36aFpbuYgQZtJV+1qQ+tuPEdkX2W+KfbyXZEhnbt1RLfJl1Oxs3a/Y
         4c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244906; x=1778849706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNh5KxwhxZCJsoxnacWw4RjbmOVm0B/OxArYPR1gwUA=;
        b=E/oDrqD8RUwEv4smuVDNRxA3WAoq+6x4cwWw8xCEYf0IA5A4ebkila6cIsHOH6LlBg
         QPJRoEP4kG1NWoDTCST9T8fCAlQ06HrrCZ2jFEcbzGZcZt+UFYJtARy9LPTZ02MFxbt8
         r4pc4k1yCmvcxVOtzmAJFlvEP+dCu4eyYv9WfvlF8GLXBs5cULXUz7bgZQP1/261+CZV
         loW2bZIlEZwNkdWe45mtrbqpsfKw/8aal7FuwDIRWPTYFRSiW1ve1B2DSb/60Jt9A3TL
         Fy6bsSOu8gVHdKy0OWsV5NySd9XFTN/8k5fA0z+5DfCtF9VeYklwWq5qI9mz323iSMEn
         d73g==
X-Forwarded-Encrypted: i=1; AFNElJ8vMquY9gZeBoO3/ADe33tOagVlOmEFKLmpe3mJ2/0AH0ACdTVZYh5FsBepfwd8sO5PMcQOlVq4hng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjoICbrypGkT2fyVj76WAXMwf+34vJ36+JipIeZ1fpkQG/LJ/
	GIbvXM84Z8cX2/28s0xk9BPjP+pT+qqtFGAB+cGdWW+znFcr8km44p5c8lVhw19Zblf3M6wLB0B
	SPPy7P2YfqhsX2saSHDAoEiZRda75ww0=
X-Gm-Gg: Acq92OEKBdDWBfHHlJLhUtz/RFYq2khw8YRHckGVc794sBbS/yZmoHdCwn5nzwbelvd
	ykMtY40xnxQa6aABOnt1yee3YdywHxUJd6/VdYEd5cNYuIUvXOYTtmXio0qkf8ZE6FDtwgx5b+h
	RGTQWil3eYgI6pDXTgFmhNFQuCEx7ZDpGkS5X5OZ1axmwMbUOC2Tz70/DbJwFWR/asRiRrqztTc
	J7R+gLlQEcl4ONddvGFhDkiJA8taBLM07xYMt6jc3hbi78XLRrHO67rtXBIXrU9fKyqcqTwCXko
	IpDayb/ybACFARHq3d0SbJjrz+VpHnaAsHnNG7w8jQ==
X-Received: by 2002:a05:690e:d8c:b0:65c:ca50:d7 with SMTP id
 956f58d0204a3-65cca5015eemr10707905d50.49.1778244906218; Fri, 08 May 2026
 05:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507172404.80435-1-m32285159@gmail.com> <20260507170054.9349-1-sozdayvek@gmail.com>
 <20260508132501.04e6b92a@jic23-huawei>
In-Reply-To: <20260508132501.04e6b92a@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 8 May 2026 07:54:50 -0500
X-Gm-Features: AVHnY4ItcANNti1jVf2vTec3WC1ESOPo2v6XqfnoQaAa177Qpo0dsvBQT7nAPKw
Message-ID: <CAKqfh0Gn3HAaYO+_1AxcWk2SOJ65gTv7Us3gehUqc_PAQVv5Zg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCD30 maintainer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 7:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  7 May 2026 22:00:54 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> > On Thu, 07 May 2026, Maxwell Doose wrote:
> > > The current maintainer's email is no longer valid and the driver is
> > > being orphaned. Replace his entry with mine, as I am volunteering to
> > > take over, and Jonathan Cameron has approved such.
> I dropped last bit as I'm approving it clearly via the SoB so it adds
> nothing to the patch that lands upstream.
>

Thanks for letting me do this Jonathan! Glad to be on board, can't
wait to bring some needed change to the driver (it seems a bit messy)!

Best regards,
Maxwell Doose
