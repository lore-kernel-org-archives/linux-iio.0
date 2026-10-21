Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616190;
	b=STFezrCDdVd3ZF9bVEo2mPLtLTFYD8S64zOhAwQHLKY/ogf1HL4vd/myQ030ScdkCHKx
	 crjjfK71cR+jqyWUFVc3EuVpydzrbocyRnhWn5/oi7bUpZYoIzPWvx7AyzFXTjMLFWpF3
	 3mySsZOQpqjST5Phge4ubnIC1cc2g8Rjk1AZr0h0+t4Pd6yAcV7z7XQvAfw6xnFPuR4tE
	 5n6IZpmsopJeVErcotZsLyuEPdlVIBk6np7KdMe1FZKDNMoIKnRvN/GPFSI09aZ2TwITo
	 HIBqSkUFMAzEWRNiYHH2C4OTdrdvq6ip3P5r5xX8d69nMdrlMSPqxRkloTtFzI5ONeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/wMSCFq7cwAqlw5+JpUyGiK59gPbKmzoJzlvO01tlDo=;
	b=aq0qXrXkh+mmd/8iQP+MMostm1TatMRnLqgsrfIX5mAmCNHZea2xejopsU0Nk715rB1D
	 8yw3IXO9aiDEWGZYftCb19BWuIbDPiQetzBmHAURulYrDytGWz/1YZ8/s+42/9ytKkydq
	 a7jsuDBP0r0/f6HgZJw6n4dObGZg6E+5utbpKp5iGQUa0ond8A40BrEJ0iQyLuQQH9URN
	 Ues/aregMa9YHHsP9sieoWyb2K/wDiqEIrg0KPFo0fd7+XWQ34VputLIaCpio1e82aROL
	 VdZDyji0dmYZ+QhR+Ki1KSK6J9euOy7tSPMvMz7arFQQ7uCArXfb9eEtvkpVgtv+5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gwwp587o;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36C606A319
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 20:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B36C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gwwp587o
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1517bda04a0so1189985c88.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616189; x=1793220989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wMSCFq7cwAqlw5+JpUyGiK59gPbKmzoJzlvO01tlDo=;
        b=Gwwp587o6azI29+TvQEdT4XuDNJaKyrkNZuS1Wb/cZmb6w0H2yHF29MWJxsJ/25Z+i
         B261985l0eGXHxnxZOaQnnbmRSLY04ujt3hKiGMmALmostf5QpPU0wxepQPKIPk8MFdi
         /e3xSDHfQxPzuwc4WqOW6jKy9RxwzsYCK+2mMZ5uR1zInZ/e7fcCoY/d1TKyD4y+Mfvl
         AwdkZ4lxe18Q0MrlpQrZzDoUVNXWuW7t7/IhFYPgOaDzGuJ4I4WUUh80pT44kGQsIGqz
         +I7Ay+yfALT6kucTCpgFYLSwT/6erjOSnXzs9zK3c9kRlopos+DFkr7ncj5OnfZJd1PJ
         gWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616189; x=1793220989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wMSCFq7cwAqlw5+JpUyGiK59gPbKmzoJzlvO01tlDo=;
        b=X8BuwSsgWmQzYMe+DzbA8YzpAWSZeyxN7vCoMdKHTQ8tMlmJK69BCufyIWnrd9iJHp
         //byaeYoL37TtvNhNqQo+Ddc/UqMubC6ZwCiAKfairOWxtnUuFAz8M1xj/7K1n+kp6Ii
         T3d6fLTczi5Ewmwblt9i6EOtK4qbUwNIGfUZ1gm0H2EvJSSXmQD/XLLIZBgBvdXi/U0a
         AR6654J3TjiMORN883i+xI3Da5wEWfi9him9Mq5CkMsGHS6MXineFNNPMqk8jGTxf2s2
         EfFZ6ca0m79PD9BH1zMb+jvEe/IzO0w5Wxuhtq3RVgCQgtVkNblRhBSU6LIcQzamlBhs
         AN3w==
X-Forwarded-Encrypted: i=1; AKwUvBzaFzSxtFjL2V19SAQvBuprgvTgrDKObjJIJ1s6vB3x3u1dpyFwAQiwjhf4+RxJOHChEea+qGmvoAQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4/OQ1BGINlRMWyrp7wimx8H8kB1ABkWAST1NyZNP/63o3OV1W
	1ypvo7c60B4p3ITHz02dvXJo/sHPKHsJhKdrYxJam4fGre+tHk6ijRQ4
X-Gm-Gg: AYBFou04Fe2v+bXLuzF3kr/9bXbZ2a1GXDBO6QhipR6Rs6mvzmVMFQyv9ggEHbmwsaA
	jr9x93W5tSLcCa+uEhtHNdWkROamb09gHw8z2QggBj1tmp+hZw4JrE8IW6ZEmIWF9F2PTSTb/yl
	UbcZdsUwhdQNmJmf2ydy8iEjELdz802HZyRpOIyqk4+wDpAR85UW0bndJgxUr/rHzSYjVqn7nAW
	OnJh8tKcS9kyuRPKfh6dm6BcqxRLm3DyCEWokO/2cSCSYo7zUTGaOV/EQ9EZP1IviI+t8GO0LRP
	atsfWdk2lQIKfALj263DudPiPmKrTCmYS6X+QRGvWfb5IdV9TXO/Kcp+3oObW1G32GXTBsaZzQC
	Ve/NG+wTlNeq+0mwatAskgkoaqfWQge+jvSehX0EvpUULqRCHnjMzR9BNdm60/NTZzmIPMZPwso
	uX5mu/J27oFusbMBrpVWqPe4uE329b9gUVLuKlE6khz22BfoVfr1WoJzYVaIHHSk91A4pE3eHar
	XoSvKPiuVThglvowd23Qg/oZpblhLVvE2F1tQGnauUaYNHVQHF7Qdr/P9CHaWmLrGNQ4a+b7hgi
	gde6FhzGWbErHQhIg+hWdomgGelrkZLfPxkQmUAmBiQfJyQA9oaHKkj7RrQae+GC4lYEmj1H6Ap
	g8HpXqW48ZUllmJddrI7Akq7Fb9rdZtdQ
X-Received: by 2002:a05:7022:eb46:10b0:159:aa67:2893 with SMTP id a92af1059eb24-190a632f2bemr4055440c88.30.1792616189407;
        Wed, 21 Oct 2026 13:56:29 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm13371585c88.5.2026.10.21.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:56:28 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp in hw_info[]
Date: Thu, 22 Oct 2026 02:26:20 +0530
Message-ID: <20261021205620.342142-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atkKMNHPRLSrD3iZ@ashevche-desk.local>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com> <20261020095936.00002ff3@gmail.com> <20261021183823.169199-1-kapoorarnav43@gmail.com> <atkKMNHPRLSrD3iZ@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Oct 2026 21:53:36 +0300, Andy Shevchenko wrote:
> just use --base next time when formatting patch (with `git format-patch`).

Will do, thanks. For this one, the base was:

base-commit: 28691515f54f03f23636cbf1ee2cd60fc31e2353
