Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079592;
	b=nwdZFrPwkWQxo+vEPeAkHBaTq+E4DNTYKsD/jKMAkhRsozS/6qKZby83F+YQsvAKlu/q
	 aWBoJo/V9ekdLAn0LPI091yp4FGvLnzOXMGVjbYJRkZhh/FSGjOJKTfi8ATYINk8TqYS2
	 OSuIEWOEvOPQ4PFSD64Mtx0pzS71e7kDuxlaxrgKwi7NZ5HJZA0tDeDEZUUYjPVNTZw5J
	 bduw7ycommD7wCKC0cnDAlBI27A0vx3lcGPZVGW4HgTkuCm9Ikyw2+kwqueOu1FK2l8Gv
	 5PBbSUhjHyKSdtYUUH73Xu/8bByTpM/xLEs696+kaQ/iT5JWOaDh2T7MkAhCXGCsGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
	b=cS1L5onOtudSpYlJP6FiZMRb1tSq2iXgWSGR1jSRumXWsUAG0tmwYiF49uEyCIen1fLY
	 XTzQPDnKquZLy2CtEKmoSaoqGW0em/OMOJjOVsCF0qj+/wLIE5WGticrmoYTVsBhh0OGC
	 1uGnqQQgZw09PJt3nwp51Uj7lTWqThIlysLFBjC1NUr9o1OhccJKh/adzn3AjMfpZZ2Hv
	 qyKfWhVwZ4uZeKsEQLIIqsiODu1RQXcIA0xnrGv/hO3qarFKD02AuBetr5/lNwxD4rIAN
	 jxI0D1IBjInTASD0n7ZFMqOa4jYUDYgQCfkwPRIer34k7RcP90b9nAYSV6t0S7f7z4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=cyYxEfas;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA8606A326
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=cyYxEfas
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so260958666b.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795079589; x=1795684389; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
        b=cyYxEfasnJ1RB3+F9HQ3kC+3x1Suvkc2D89LpTI8+pw+eAAwycdhqJavNg6jfArG06
         7JOCKyjIFZw+nr/clzS/FlZF0tkW/tGCuolgw1y+hnhHah0vaD1owxv/OtpdlF+et24+
         5L6UDEJTNVsrLK4J+ku1kAWCSku6cLc/TckT9iAM6R+oPGnlb1CUiB3kUc5/c+MqFRyB
         stqsA0fzEfvyMaiEWLDvydtQsTclnOH9ybTAeNhVohSNOZyB0c9EwQfXP1kwiRFNT07A
         zWt7aKVRGzi7F2YU/x0W/Yt/TXqrDRWJJU0hid5GcWy+qSpR7k1tulgob5DMl37cK+Wq
         ZePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079589; x=1795684389;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpg+BVDggcvUpSEiuxjRpyylph3rGxNLp6K/2aQmllw=;
        b=BJj7XweBPx0QGkMr4H1QwbFhSCpcHgiBHq9wDFV4k/oDqF1q6QqqzkMdMUIBlkrLEY
         XtCktc9l57WbSTzFhMMEnmMtQpq2OCofosQvVtGR15a29jSg/D2KgQCuvo+ZhjX23qpT
         QRRuHPmgBYU/j0BN+wsCarxrywIQ+Q/5mUcZqqqOf0RwDE6R/EvJVEih4DhUGTP0O27n
         LfYuSo2XtW2PR4zc++mc/CtTsEmwlz63u1vVtNQBkMabu8BcNqN+09L08IhcC85xn5E6
         cOTlKCNd+YC2X1svR7AV2ongG2y5WZMBD2mevoLuK+6uyndgVhhe2OR8QbkNfFvTcbkM
         vz/A==
X-Forwarded-Encrypted: i=1; AL+hErFpR3n7p2WtMhuj0qfN+mMwjslNt6kzhZYeLg4rcOw1dj4Ye+1txPZ15X6zT4L3pbqcavzDP0g3uAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hEgWaqz2es1woarJznsnHmBpSax9zkjsiRXP5F5ojZPwK6h6A
	ErYEbzJAqQsQfSsC58NUCJkAQoOt3B1adZu3K1uj6jmX2W6ObIAezK6PwSJMKLzFzvq1YlLJUwi
	ffyh+DyY=
X-Gm-Gg: AYBFou2FbQXo6YAkJ3/sbT8hKWZmGpQTZfYXZ5bhXgEuSeI1e1Itsps4UMF/shpkxkq
	toxbW7gSLKXscmjOiJihelRUmXFNp53MoBj+DW2g5osBvciPMyCg6RftFgLjiZo31ty4rKlO7UB
	e+hriJhU9ks05AZiEWAbLI0NFvFtK8julXT7U9xPUIqq0hwvWhJZkmmBdwbZZJxew+AQecTkJxQ
	tNhgQrjMvsPyzmH4WkIrVXWN7R+qwkoitG+XdpupAfi5nDvwWNZKIDJpqGq+FRPtv4rxs2KFY0r
	/+P9hbEdhO9Yymwyag72BGkEB4pIS7BNG2KrQAqlLLnhvCwejc6q5Cu5ys0JrIz/SiPn8HmFWnL
	sjdNAe4uW1HNqWsmUGqpSlHsT/WeMmcccjQw98RpNUwQtXb4qs9HAFetpEMig1fgvf+VNRBoWkW
	MOQZLvJCDNFfBWnQLCZXQgbhuGhZZlRlw1fw+knHtzW7/3sCWwFRxdGOFxkGXZX0SsYgMyGJhIp
	SxkOfO8cVQhxoonqKhqHO1ESUPlMQoFeSdhoC6BGkk0ohFnuDO1jCsULHrmGxHJdxdaf/tXOKJ/
	ssCSahX5dXkfi7V9ZbYmSGl7vlBQYXnRVjBlu1+aTUe7T6N/aOM9S2iWu2dQ5sRt8FjSy2yL+g=
	=
X-Received: by 2002:a17:907:7295:b0:c31:8cfe:9a25 with SMTP id a640c23a62f3a-c510e19d00dmr455876466b.9.1795079589464;
        Thu, 19 Nov 2026 01:13:09 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512341e0adsm87945966b.36.2026.11.19.01.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 01:13:09 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 10:13:08 +0100
Message-Id: <DMZ2LUM6AWXG.4IUB01OTC2NF@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Rob Herring" <robh@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Laxman Dewangan" <ldewangan@nvidia.com>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Jens Reidel"
 <adrian@mainlining.org>, "Casey Connolly" <casey.connolly@linaro.org>, "Val
 Packett" <val@packett.cool>, "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
 <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>
 <20261118164229.GA2892053-robh@kernel.org>
In-Reply-To: <20261118164229.GA2892053-robh@kernel.org>

On Wed Nov 18, 2026 at 5:42 PM CET, Rob Herring wrote:
> On Tue, Nov 17, 2026 at 09:23:12AM +0100, Luca Weiss wrote:
>> Document the property to allow using this sensor with io-channels.
>>=20
>> This means that the output of generic-adc-thermal can be used as an
>> input into a different node.
>>=20
>> As a specific example, generic-adc-thermal takes in an ADC io-channel in
>> Volt, outputs temperature in degC, which can then be consumed by a fuel
>> gauge driver to provide the battery temperature readings to user space.
>
> But this is already a thermal-sensor provider, why wouldn't the fuel=20
> gauge use that provider?=20

thermal-sensors =3D <&my_generic_adc_thermal>; could work, yes, but IIO is
way more flexible and can support the required use case very well.

From what I can see no device binding (or Linux) uses thermal-sensors
apart from thermal zones, so actually doing this for another device
feels like re-inventing the wheel when IIO already exists.

Please also see the cover letter from the RFC[0] under "1. Do not
implement IIO device in generic-adc-thermal"

[0] https://lore.kernel.org/linux-arm-msm/20251010-bat-temp-adc-v1-0-d51ec8=
95dac6@fairphone.com/

Regards
Luca

> Seems like this is letting current Linux driver design dictate the=20
> binding.
>
> Rob


