Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A57347DD
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511687; cv=none; b=my/Zlbr6oH0cYPKZLLMGzngmnfP2jzj72ImV0ZmQJ2n1+mjLHiVVX4kkXMs9wPevxMo5aASUAMl6J6gB3v8zbY7zq/ab5JuepPMWZeBn2NUN+MlfQYW9aZBbm6Uwm84tFxkDH8L/jTO+GAHRhGGo1Hgtxk1bzBwDsQJBhfyUrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511687; c=relaxed/simple;
	bh=zOskvLS10rYNxZVppK5rSYC3b2FQ6yq1FEq2VBHohdA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ri26zwZctA1FtMGGaZnWfpMUOkiIejSL2PDDksNWhY0EL7FheN7WPwr4XZK5ceb4cWELKykwAXVdKuPfAZ/ZOKwlz7e0NT+PlgIjTthjRRJO0h405jZIXwnDxN3sdDjCydGbK5c9IXlL5YtTGYmd0qV+FMpVMnoeakOYcXcmPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4avUYaZ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4avUYaZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so2775602d50.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773511685; x=1774116485; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOskvLS10rYNxZVppK5rSYC3b2FQ6yq1FEq2VBHohdA=;
        b=B4avUYaZryYQplGxkd8ckQqKgHo1v/12lQTXP0c6Z5k+ZGunlEYvlst/lrx8NEtisz
         h8fVuyrYfQ71M43VJDgi22YgcsuOy9aLFapUlKxOciupZawS3nIwMJwDZWAHPt3jqDFI
         9fY43sy8cWermtsVlPoBdtG335UPPoVqnTuP/kdPeG2XhWYVC5JCMksI3MgKxWJG1oip
         /9Cd+K0n2cmYGKFwU3QI95ifs/ykh9VCvd71/YO9tOxkNeDLBh0AIIWxHByvEIzl4895
         aeOp80QRS+BeFlpQF+pPu9rrkBXmj3xUNgn3zpDWuqz83XKvjCkb2Gv44LkoyBE+g0vm
         ZRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773511685; x=1774116485;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOskvLS10rYNxZVppK5rSYC3b2FQ6yq1FEq2VBHohdA=;
        b=nNWqF58wNM9w2o36F9dR2IJSUV+OCxA70R7VW1ErEP8VJ9HfPHhagrqGqPAltVeKwz
         eYoZK9m8i3ULCw0eUEHkq7IHwkaJBcove+Hokgz3M7fCYItce880cvXUMwfSow7Fmuio
         0sINHCA9TEjO0AFNh3wkXU4HtPrMxaBuB8hjJHlU+E94Smk8Y2o4eSHv4dqcvD+3eaW9
         dJv3qqI+apJwR4aXRQ5JfUUYwTihjanAwfgPR+SatuNW3hQTUYn58RgTdKnyeiZDnHeR
         lLR+LF+ZIVB7TvxefkqkC3a+mHeKt/gQDTSIMHU93W3zTBTmROdehuJDkXe6fN7Mvix3
         Kc/g==
X-Forwarded-Encrypted: i=1; AJvYcCVqEQaRGoL4U8VI3WMvM9gGu1ZV4J4bfi1QYFH70nka0f+MaKM6Hj8e6s1ULDBOVZ9L+I7g1is/DEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVd3No5kWRfYHXWFteuacIFGVZeTCiYX/7RceIRkZBA/KHOBw
	e3iOFTQYo+S6Dc9mHZ2p3hlcsQlNZ52qPN9V9Qpz1cafMSnmUlOB9Ghd
X-Gm-Gg: ATEYQzwASL1grm3NqZJnen5t9TP/a9jO5NKUi5wyn0xuIWBcbUjCjzS8XEbbwWyC/Q/
	fLr3GLag51WUHII59K+Koj4JaXji5AB+cQW9QF14jZjGZs7r1AQZgz6U5V4kHiSu/qdiOqG5S2D
	5CcVX7b9U4E99JRXnKRHucaqAO9JDSKQFKGEOl+MVLd1f3/vd7NQl5kRQc1gJctCQ0sYWIQldQ9
	+2eCnBhm36JC++YrR3O9gqscbsxkHGTb7kYYlVPMvoV/HnfkqJ5r7xOF7PFyMLwUAWQJyk3ggTx
	fS+qys04O1+LgLGHMU8fuMqFwOZWkh90IuIWrZ5MaQHbaDWo+dbizUY7GlA14Gbn3GuQwnPooIb
	WRjBSEDNL6uHLv1SlTULckMH0z7nV5uMrM2J/MpuD2kYNVTh2LB0kG+qJifXsWQqAniJSg4Urle
	jfkLuUH3Opby+0/YtJfDB/9grJdf7hsBe72HRQBXnGznGycmFhVuUG0wnyEW8Qt6qvTu+KYMgd3
	YtDr4gSOtMChWRw2gFPm8Qa04VLQYfR98WuhuifVNGF6Z//WOQ3W3hV2KB4Eafc1po=
X-Received: by 2002:a05:690c:c155:b0:799:182:17bd with SMTP id 00721157ae682-79a1c0e1676mr67691637b3.24.1773511685202;
        Sat, 14 Mar 2026 11:08:05 -0700 (PDT)
Received: from localhost ([2601:7c0:c37c:4c00:f174:ec69:bc86:8883])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a381fc2cesm6431537b3.24.2026.03.14.11.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 11:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 13:08:04 -0500
Message-Id: <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
Cc: "Ethan Tidmore" <ethantidmore06@gmail.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
 <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
 <20260314110758.2fc20704@jic23-huawei>
In-Reply-To: <20260314110758.2fc20704@jic23-huawei>

On Sat Mar 14, 2026 at 6:07 AM CDT, Jonathan Cameron wrote:
> On Wed, 11 Mar 2026 22:18:07 +0200

...

>
> Hi Ethan
>
> I'm not keen on a mass cleanup like this without taking a closer look at
> the drivers. I would say (based on gut feeling rather than actually
> having checked the stats) that perhaps 25% of these patches result in
> feedback on the surrounding code or follow on improvements that are
> enabled.=20

That makes sense. That would be a ton of time spent on reviewing this.

...

> As to the your question on how this 'might' be done, it would need to be
> 1 patch per driver because this will cause chaos for backports of later
> fixes due to significant churn.

Yeah, that kills the idea entirely. I was hoping it could be done per
vendor per dir but, I understand why that wouldn't work.

>
> There are ABI changes that we want to push through the tree such
> as iio_push_to_buffers_with_ts() but that's because the new ABI
> is inherently safer and I want to get rid of the old one.
> Some of those cases are easy, others much less so.

If a tree wide conversion to iio_push_to_buffers_with_ts() would be
wanted I'd be glad to do that. There is much less volume for this
project and if completed then a deprecated function could be removed.

$ grep -rn "iio_push_to_buffers_with_timestamp" drivers/iio/ | wc -l
73

And this would be much more manageable to review. Would this be a viable
proposal for GsoC?

Thanks,

ET
