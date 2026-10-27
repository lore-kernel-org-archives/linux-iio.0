Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117598;
	b=LZpRr85kwAU4qdZjJvMEzq2PdEr/PBycON7wGtoLEyt7pj92RH+0K+5okP/u9LMZYLUM
	 vUEtogzQsI2GPLdIrIlEZdFnbl7Pr//vfTHikdanTk9ITmkTZYH4MwRd33kmtvNDaGsag
	 ZxwT9Ib4M6jk/9N+DbkEDxo726yzlsL5wLp8tvTEO2W1kiKDBEPpxL35FAblJn+njSJWW
	 bHihQhyApmJD9eIhkiluPc77vLgOiI42TR9JlYI2B5PsohcN80a8QrTWtpJT5x4rwjTj6
	 PYd2swEKrztx+ut+IypIh+adg7yeeRIeZGYZOoL3RVshAy/7Bnnf3IGWtEE/yFN/hjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ooO+4o+iyCDW1yp9ltn95i1A1P6RGqe7Hdqipu7WV20=;
	b=DhzjoBES0iKPoJ41pmFvdSexeawM6mMif2rpwRFiU7jBkuaro2zpQi02N8NFmWmbycVD
	 nLa6IRnu6iIL2B2G26xywHU+Lw1etcGSdkN3x2thCMaKmYgFC7H5S9BXBklcLiF+j3Kde
	 0dceVZ0b4Q61hE2bPl04OX9fIWWYhnONtjTHxbAQVms30iNBLM6keCDcImaHKpI/T1uMZ
	 Zof4EcRzwAPrUx2MB/1yr0nRdzYw92yuvFqIXmqqOqodTKmKyiRHeZB062khCar1iaCaw
	 8LRtmSJ2xYbofVXC+id9dQrEAmJi2CUkZYhqsU3Jc8maH5ttU9+kQz9nE17l7uMmDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6ghNfU8;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFD606A31A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 16:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6ghNfU8
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9905d61449cso46316241.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117597; x=1793722397; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ooO+4o+iyCDW1yp9ltn95i1A1P6RGqe7Hdqipu7WV20=;
        b=l6ghNfU80c9PY3RK9l86uyBCFRlIYDFt3dDfCadwUZdKX/E0Hx3ng8LCLwFPuLTQco
         iveQg6UCtdT7gPXI22B0TImXwYI6Y7DQG+gm0DYEhrIKqFGqaawLiwhKROuvlFg20Xm7
         MF3qJ5hn5rUsSPUEh2YglXuHTLSzkiC/4ZX+dhoWMsPUCdoxmUPn/P+iTQNPWN7I2AK+
         Kpo1/S3w+HolSwXJIzQ1obajFpsxtCmCpgu7ASWuvjYAtA++MrWktN8aO+8762BofjcC
         dA3nmCoyAGlARd+Ha7PHIIwpMk6Fc5NbBW5XVPidsXwU/pXLTXiLto5aOx1fUbFEY637
         NMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117597; x=1793722397;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooO+4o+iyCDW1yp9ltn95i1A1P6RGqe7Hdqipu7WV20=;
        b=Y5N43QP5O6gyVajNTUyvLUjqE2dCkbQtJR4cKnh7jkvVW9rXT4uQbFbEyKZem031Ry
         8Jdq4uqeqrC7x/a2Tb4yIZhcqOkkRac81lVYC2hKYPcoeS/ciY36Ts3BQQk7nBzu6ZLy
         J3I0DyLQSNsE1M49ezKNWjErrUDs9vAfXOIv6xGgi5cvmaruqOGu0icv3/rqfszpqgVa
         utOOTTch93i/OpT2EH4cVbpiaDIaeE1Shb/Be8EtzChvUb9cupogyDvnYPc2MuhDR0cV
         ehUV0K3nxAAAs5z5kh54zZa1lHfHpcYc9BOBfKPPEp/z0sYblt8GchXTKxO0fUyp29pF
         hh7A==
X-Forwarded-Encrypted: i=1; AKwUvBxcVi9LsMKoCSfKR7b8CdsNicn/2F9hWgDL1F3bLxmf0ZG84zIvABdFJTg4ND9N817+Zxhlc3I5DUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVNxbYT9nSY7xLgC+5VBfDEKGIahoUMl7fYzyQNLsLGM9uEPXI
	HwMF9mfj63+ptF0IY+s7kXTwJPnVb3mZeICkGGgIQmHlZGbvsmphSpM=
X-Gm-Gg: AYBFou3cVdTlMDdXvTDlx2lPhCZMXSX+Wco8Waf9qOM807ENHJEdAIFMg6xmCMjyBig
	BpY0rqcUomAbo6ZTvqaaDCR4ic30QmWxdf37rM15MJZ/BvJiTXvMk3RWgk68ajPmbHJQ2zo+OBF
	gWBKxc3RIpjt5PlPTGAy60oSprcE4m8vPhLn7vHF7rtjzx/23Jju3HFxItqi3auZ4Tq5DSyf3Un
	+I12xkCQmvBmcJKO1weS1pIybNXLQRx43pqJxq4QHDiB/C/oUsriUWfflRPZ5eQCcSFf7ytqDTL
	xpiZOdQEguCxC0l03JA2WpQp8X7Ucaj0nOrrTd7GDDIjU9FTTVq7KH9Bj0urfhgvqbvy/gzzkwb
	RHT1ynHtmZYqFZOjnqGUfZ8CEBOIjrkm1g0lDUfwOvHdGMqH7zUYYjfph/JYQFGd3JQ7fQo9A47
	Tg8L74ojH/2BVBHGbmDlGnL8Jff5VaFVTlEkaXVje7mdSCJmPFLwu8G4Y0+FM56Sr84Lz6rJcGX
	FVSDkj9oMNIX8l2GyGqAtuMdlrJyp9qVRYCBC6V1wzd4cp7sBBlTJg+mUQdRtPQz1Eb6dsmIbog
	v1YvabG4IHY1sYE=
X-Received: by 2002:a05:6102:3ec3:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7ce5cc8aa37mr3260290137.9.1793117597486;
        Tue, 27 Oct 2026 09:13:17 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125932041sm2959251241.1.2026.10.27.09.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:13:16 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 13:13:13 -0300
Message-Id: <DMFR4YE7AKYX.MEG4N2UE2XID@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
Subject: Re: [PATCH 26/39] iio: humidity: am2315: use
 iio_push_to_buffers_with_ts() with a scan struct on stack
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>
In-Reply-To: <20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>

On Mon Oct 26, 2026 at 8:05 PM -03, Jonathan Cameron wrote:
> Move the scan buffer out of struct am2315_data and make it local to
> am2315_trigger_handler(), as it has no need to persist between calls.
> This also removes the need to hold data->lock while filling it in.
>
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Hi! I tested this on an AM2320 sensor in a Raspberry Pi 3b+.

Kernel version:
Linux version 7.3.0-rc1-v8+ =20
Debian clang version 19.1.7 (3+b1), Debian LLD 19.1.7

Everything looks good (no warning or errors). This is the first time I
test a patch, I'll add the Tested-by tag, but please tell me if I am
doing something wrong.

Tested-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
