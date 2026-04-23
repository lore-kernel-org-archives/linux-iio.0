Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E52C032E
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977125; cv=pass; b=b1HA7vW1cRL3+KwCU+QoWn0yRBY34QL5UQXHJj2v5rxQ7bCKyr8TRNUuGYNN2b+/HIZV8DCM8vFTZIvB0TFQqty1BM6blQXbk401p4mFqXGteaCeHHvsTTb/kyU3srCrNXPTNW+1z5nvhAkumkzFi3vy+oQMyrHW/BMvqaD6Czo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977125; c=relaxed/simple;
	bh=VoJN8ufs/Gsb5LP8C3MnoNgy/aPAmOiF+Cb+60vginY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HChBmdjvbRQo4SvdfWJnum2dcVdHPaffTR6YFxpoJizt3xwvijXOqcv6u4qVPky6ib7P2F0H8pVfqChcRfgblE5LKIIZg0HLL/jxy76LbuSaj5kp6jxcMimnlR+JDMuQYol/1uBEOStuzOJfic1uujgogzrKFuRsUBqE+q6Unkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=AenqN42G; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="AenqN42G"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so12803418a12.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 13:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776977120; cv=none;
        d=google.com; s=arc-20240605;
        b=GKvD46JQQVxDVOIO4rCDcivIksiX6CQ78a4LXrt3N2uWOyMOaxmteHdRQTPrCj78Hz
         Z9lgkFM/R3FShnufHk2tXmQpXSNmy+pC2s338gdsKhiFH8MFu4xyAzsa9Cykn/D+fZ0/
         zX+Gyjx0r2mehzRa3ywoBQbdCaHnblgcUnIQyDYwHUskDkD9YSoaqD1sxwnGy7GrOdNM
         DonDbwHx+O6zEjaXZuhvIxZVviYkEbodqNbB1Xi9glXBt5Gjo1m+AUxDtMER5wQtrsQD
         /rjA9/zmjktuSdZXD4gH+qgJpTLB2SadERMZoPC/XHL72g1ug8zE0CkZary3WG4c3eAu
         IFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VoJN8ufs/Gsb5LP8C3MnoNgy/aPAmOiF+Cb+60vginY=;
        fh=z++0pKAcXdgECQuZnv/9P10NKhzaKhMc6UkUZxom2GY=;
        b=BzLZMkEdxTmtuI9Uo/sxA1uFPi2yDu/iCE1NYqFwTpfwWImBXEp2cPpfFsbq9ZQO0p
         KUXQTAon9BlnjD8RoNFlvXYuQwoiDiRt45Ca3cXvchbiRVJhdnumTClv9OYlDKKph8PW
         2QpnLV0SITGceXQnHenKJQe8BzEgjsDuCn7i6MoGdJ9dpQmkSsdU7pb6go2hu96Ukh6h
         6ffVGOj6ZXp0E+ZDkSjuSpJjSdPoBUC8i7KDmURy6k6fUXpYOZsKnNohSvkNJN1xyKQz
         gv0U57LzpSCVHSRBe68yhGt2tBV45S0TJ27DZdvp7DlZqeVu/CBLLQqCA5DdivvE6Ogq
         1y0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776977120; x=1777581920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoJN8ufs/Gsb5LP8C3MnoNgy/aPAmOiF+Cb+60vginY=;
        b=AenqN42GLOXzaZG1SLUktxYeQZpEoLX49Wkhv+RqlBKkuZQPElNSh2uVKMdWFsg4JU
         CbZVmVOLd3kVduo4LwdcrjRJoYKaanHtiGW6hMkN6YKsFxTnCebyJT8/MhHCEmohy0dh
         kByeCIzDaOpSjtv69SbfgupxpsLHJ3TK0rUGMFflwjqttnZUFEvMBFZGgxak0riAWd3A
         JXjZd3pslxVmZhgcu/3n/YZu4u5uAsLPVEO6pX7AKm1QP54n/76AdmONuuPGjlrJrFJo
         HrGu1BxLacsuB/+1zSJXCJZFL5EygC9VdWGl2dytXY8SA6J8fDF9Yo98fMTnRBK1pmhO
         MA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977120; x=1777581920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoJN8ufs/Gsb5LP8C3MnoNgy/aPAmOiF+Cb+60vginY=;
        b=pJs/EP76grzOz6VW1zOcylh8LKcFu9N3w+L9lbDnv1yb9cBj0WvlFX77wjDPmfw3Ex
         KHHWq8UyKOZnyMP+IAQD3opCrZtxrJkm0tsJFF+vRjGHlSy139+QvhSFSot0trlNuJYd
         HQQqWGmzFCPkEcBC6WvRlO/dD9FFDsGUD8StwaT9X775ubN7tghoNB6aPbQxe1YGZ7fh
         1TDTh2zUhie5LAML0i05jnbLYJjj00iYjCgSv8WO/8qYywjTEzQQwik+UqGECE47RB7x
         p71v6ezQHlwEWLR9bysgm/GRkMl8quA/UpsT2ie+0VshEgZ4yKVmX0h55JG2bkBl0gNR
         aYOg==
X-Forwarded-Encrypted: i=1; AFNElJ/uqfnTQjDYoej9JvYMdhjiZnyvQU70SxYMaDe7S5Rxe8TPXyj0QkAuIgBZdSih+RcR7iuCadlj5gA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n4GRb+yyid2NhD5sJFrSGXp6Fdyl/gEDI+lABQKBm1FHR1tA
	xYoI8QmvWQigNsBs5CyVPQLz4p8/BgDecBAHTq0GpnIaEo5SwWQHooNSOlFmI367PvefTSmCLjp
	pc++Fy6dPcdmqdNglMEpQxr1p+QEEH3DupS855WLfLtoAoZLqnFMmSBgtnA==
X-Gm-Gg: AeBDietfKz20fAAi3eaYjGik0nMF10x4DQEm9CJr0oQc2PPex31nlqExIkXWRo/x4t9
	b9DzOTfqJB5JVPs7LwCqS/GKCXlmDOC1IvXXN6/fSl4+P+fjx/ugD8+r1sgdx1PRd/oGcYFwosd
	LL01aaPUS8c3REIoXy4/lUCwQl/KVsadB1smaAAyheB/BnBIEAUpnNcvKpyJBiseYXpRSH2Y2Lh
	aGSMp9GAqU40+Fj+Yd4hkE2Qc22/rUPAsBSYLoMhraZ7U95VydInacN5Wdn7SNcUdd32gxa5CXU
	3iXJ8bGD0+f+H/qbvWtmKDkd/7FDNxsIqhppixLMFiJzlPiK
X-Received: by 2002:a17:906:c146:b0:ba6:6c2d:5c81 with SMTP id
 a640c23a62f3a-ba66c2d5e63mr691297966b.44.1776977119849; Thu, 23 Apr 2026
 13:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
 <20260422222553.67660-2-gustavo.pagnotta@ime.usp.br> <aepa8jD4uBrtY4WV@ashevche-desk.local>
In-Reply-To: <aepa8jD4uBrtY4WV@ashevche-desk.local>
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Date: Thu, 23 Apr 2026 17:45:08 -0300
X-Gm-Features: AQROBzDC4QkRxk-HzuEojfY9zh10mRlegaMd_GwOGDOC1w42oz13HVOZa8YcQgY
Message-ID: <CAD7rJs=gNZoS7=HfhUoi6K0myMQmo-9Wd_-oYcfkX8cAtpBJbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: adc: mcp320x: sort headers alphabetically
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	nuno.sa@analog.com, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>, 
	Christian Barry <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 20:46:26 +0300, Andy Shevchenko wrote:
> Is this SoB chain for real? If you want to give credits to mentors or so,
> it should be done differently.

Hi Andy,

Yes, the chain is real. Eduardo, Christian, and I are classmates at the
University of S=C3=A3o Paulo (IME-USP), and we are working on this driver
together as a group assignment.

We are doing mob programming on the same machine, which is why we
included the Co-developed-by tags for everyone involved in the changes.
They are not my mentors or professors.

However, I understand that having three authors for such a trivial patch
(like sorting headers) looks highly unusual. I also realize that, as the
sender of the patch, my Signed-off-by should have been placed at the
very bottom of the chain.

For the upcoming v5, would you prefer me to keep the Co-developed-by
tags on the main refactoring patch (Patch 2) and leave only my
Signed-off-by on this trivial header sorting one?

--
Thank you for the review and the guidance,
Gustavo Pagnotta
