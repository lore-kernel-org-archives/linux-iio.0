Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD663DD51E
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400117; cv=none; b=aW1lXbXwC/NTXBisynIsC6OMpJWwrtgK8ZuZAvgYSFBq8BMMRmXKDAJ58LJzqLGOID9zEgsQMM9AWr8UcDkIYgduTarmWCVUdBgpYkgTsCqdV1UVJ0luTe7bR1o2qHGgQ6jmCU0OlylrCmbVpqq6PEd3FcJey/NZ8ej3saZ6HMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400117; c=relaxed/simple;
	bh=HsjoEx9kPh9mogL6cGwXhgkp/fQPrbXvPbytpeM1eUQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=I7YFNGZuU5FnSAAg9hRRq66i6NcqkG1VlIzCPYIoxp68cgrLRjqYejKLZFIyK52C27Z4i1MyKMszMHOsFsSVwKSYkvxPYmEgUICPQksdVzxpsPOvS13Qio8d8KozftakIdjf762ASXyzxfrxwJDv+IW1JTZkN9abHkri9UVjl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhocrhVB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhocrhVB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3637b90so3431475e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400113; x=1781004913; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsjoEx9kPh9mogL6cGwXhgkp/fQPrbXvPbytpeM1eUQ=;
        b=VhocrhVBcBjKO9TK+ni/V7HCeVrornCc/Gt1YHoz7slI7AuRa3Ph/sW3VS8/DDiVNS
         0Yf+V2JlnRq+vjiL5pCRuKSXNepJRnz0dOqxo8kUDDynEeFW9MwW8e1r2CE8FXT8RPEy
         JN7YCMnkpkgu/7BVOa90/GwMFtQTp7sIEuvli7W+2EP3zhzkYKRIVn4ohWINIY36dXJE
         BfRR0KTALx/vj/QfT9v/FAgPwCOgBGsU6ACs5M2dwKLfKeESxCZzsVmyXbUGsXJieSgD
         JiDbxJHzvxt4zjUsESv1atOSYvsGVBNQDVUDDXSga7cA6xh+OyICMkE81HNem+NrnniY
         yuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400113; x=1781004913;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsjoEx9kPh9mogL6cGwXhgkp/fQPrbXvPbytpeM1eUQ=;
        b=gfH8zjpgVHIvyp+jZGchdvJjWWnT5h54lyamn6lHjldddFMsBsjj9x8L8WwRcphoLy
         gL7ot/ZQWxY6bE72eZH6jpj21LOpcbwAyx3wuQBqJzsYWnC0iyfy8adnHdO+JYXZztH5
         K8x24oQcKdf7PaND5WU4OW6SnWUrEM9A38e/ECExWcg4nj79jNtyeoTo9NUN7XeI5GSD
         WVfAX7f4gPwNqMnrz5wZOvbFGU0Ef9SYJMDFk2VCJclE/6pxQ7I3wVu+JZTWm0JW4aHb
         ZvglXIjJGuy3/6TpqneNpWCXWL5E2TCulGXSdkLDvivrrJtxeuO/zRmTQrL53OOmSwbo
         MQYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SYKwxI8ciElggEUbQezmgnXkWNsZCFo1HXqP4N9OlPiEbRSfH259Ms4O7Lfj1kLc+x8Q886HV1vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaN6g0PiUgIsJNYbuuAKBeEg3SEaWdJwiiu9phP68x7qsy5JZx
	btA5daxUStCdz0LcmlYKKVhbOvX0TvR/zcoeYn8sneSM24T3Cw9yR9Fe
X-Gm-Gg: Acq92OGKYSf9TyrVx9v+XQkZE7dfViTi8HF1JJYauFkaWofVveQQyCg+Y+z9EgCmDnT
	yqyAyXzHtx1AGegmnXApSZfRW9ETW3m+ktOqGYy+x/kECBJUuFeIekx3Zo1aYk2KO263veT/by+
	AWKBOmLE5QaZq+6lhX4Sy4+8hoGF901WfYpjI/in+DAIm5g0TjIcvNFDuDBlaCncabm8eFv1wiO
	jaxTIWJX//KIfySWIyrQEBY5bzdo1oDhHcs0t2m/6bLLdaI3EBQoMLtqtHjE9mwljW79I1yQS7w
	MKFxF2PKmbCWsv1wdPdCU5uQURBAm6GRFXUzNR7lskcZUgCxVGpQ+0LA6qDsaSQ73IexNqscuLi
	AaRbS+aP33TMau5BB7LZ7MgccQZsdpz5SiRmnhXHWYw05ic29lSbNBsWBNjOLPaM+2zOgO4I2XA
	TVAb8cIncBpzRXjx5GQ2JlHI/5DWwuwY8px4N+phP/9jFxOIk=
X-Received: by 2002:a05:600c:5309:b0:490:b280:9fe with SMTP id 5b1f17b1804b1-490b2800c3emr32480665e9.26.1780400112834;
        Tue, 02 Jun 2026 04:35:12 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af5f99dbsm25298285e9.9.2026.06.02.04.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 04:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 13:35:10 +0200
Message-Id: <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
In-Reply-To: <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>

On Tue Jun 2, 2026 at 1:21 PM CEST, Joshua Crofts wrote:
> On Tue, 2 Jun 2026 at 13:17, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>> > Do you know any tool to automate this beyond asking an AI? Manual
>> > auditing is not very reliablo and it is not that difficult to miss a
>> > header that has been indirectly included. Building with W=3D1 and simi=
lar
>> > stuff did not help.
>>
>> `iwyu`, but it needs a custom configuration. Even with that it's quite f=
ar from ideal.
>> The custom config had been shared in the linux-iio@ mailing list this ye=
ar.
>
> Let me help with that.
>
> https://lore.kernel.org/all/20260512073505.1310-1-joshua.crofts1@gmail.co=
m/

Thank you, Joshua. One question, though: maybe you remember that your
last driver was missing one header (which I am not criticizing at all,
as you can see I missed some too!), and I am wondering if it was because
iwyu missed it and if so, how that could be avoided.

Best regards,
Javier
