Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E13BD629
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686155; cv=none; b=WdPkkPnq67nm86w4dgviIMi8jkvvoFbt625Hle4y9LHzEAuFMRSP35cM6x6LSKCFly0cE/Zyg2q6aZYkBDbTrYusDPtD4Zx9MEmTQsnvnlNPkzmMMvGX4X54w9UvAXLfLHo4hkWAkkQWt4i0dF97YtJZi/06AOPFig1cBp6zMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686155; c=relaxed/simple;
	bh=xcmHUCE5IgFboJHmroyLqqW8EiS5ElHFHrQPDGoU2iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpk2TbJHLXab16NYsprk7pErBq+3NANYR6tUYgQ74HMSliTeY8z+l3ahKKv5I02qwPUsC3DF5sdDvyzT03qOGXeZ5H1l9HULRhHl8CA7npMlQpYkvGhug6Nmki8AVx/CTP13XqmX1HT6PIa0DPf4ZbsGzgNaJifU/07yDQyKBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm8gqLru; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm8gqLru"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so395882866b.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785686153; x=1786290953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikcYVMKfm2PfttYrRPgFLnBVdWxWGxC5+Pnq2dtQCtU=;
        b=jm8gqLruSj+mLThjTFSBZKTybI8bB0uyKuuAdOJvVRR7YqYnlYwwrN934alOPJenHP
         toSX6mMMMTulhBpO7HenmXoBeyc01l9idKhUycpSl5aC/OY/v3sVFNyks3onOEboyilb
         QJ57jvP7s3cjyWh/i5E4PIRpKWIINaRgz46K0Baim8CvdaLH6TOxIG367Wn/z5LvpzmX
         63AA9p0n5qB7C3dPG3+Ux4tjEbhz7+nv8FZDs/PT+NnMGH8HAQCc1/Rf5fIZiXNTvgHc
         7VZFUY2V0PXHNdY5b31ZV30kQ3Sz4KV/1/yUJqs16W3EstNZ9oqSHIfg1KCYehT5+vWz
         BPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686153; x=1786290953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikcYVMKfm2PfttYrRPgFLnBVdWxWGxC5+Pnq2dtQCtU=;
        b=S1hnK52xo8Gxabf/2bJ1dZGqEnIlkHogqsTYC8GeTz+S3eEKohxan/bNT2pYMQAL7e
         TLK4Q51UTVvUMjEdgJ9B8UKi26U9PDxrXCwiNFp8pVpD3uEo9mvxkkD3Jvn7Io22TUJw
         qicBZC5hWIHGNjigV0xNDwEMndmyLEK1y5t2F1jDI0VFeD+TotUN9sWnWtq4ojKUI5bK
         LqiHr2BC4cycWLr/IsLKCOoFUzlpFdNhgP6yxo64Y1r5WhZ8kOwyiFOfh3Y7kaskXl6W
         1DmT3Whh9lpJ3gDcZYRBR1J3OwTUqf8HYacrru/DaBpi243/D2JESuSzgSslfI0V0G2R
         C6WQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNlH/zS78z2Z+E/V65q2P/Od6ZavNowKQ4whgLHR0IKUoGVRRpOtY23slljR0/7y/6U3Ybn7Z5hxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXR3J8D1iXLYYcfGiTykfCptqc8iu9fZtDjVbkO/fEyHg7jJr
	/xZuliAT2M6FbXwZ3RI43dIJZRSyK4g6coRS73KhJvXJymjvzDHv+/QIMgxEjA==
X-Gm-Gg: AR+sD127DqDcuzV9AVAnPzSDdhaagosoP2khOT4vAU3OH9vFmgnxizs2qoqsC/r0ssu
	PayzdFSesOcN+D/OlMH/zHds/jyBu5ev8IuvrCxXwfr83ep0riEro96SZauOWS81/3SXeLI1A1j
	Mau+vQmleh5llm7eivgjO+kONQtwszKELhZD/frIyryO6JPHaT0tACzyTq5nnf+d54TamiY+jDh
	305VjXEhcjaGCVXnEMQPeT4TwqghYs6Ttz58CqzFBO5/G4jYRZqkxlORGQRnnjs6U7LX89HP1z2
	uS3poYFXe4GqcVt+OXcrpB5u6CZkNH+P14wltxTWEoPKX/FFzPkhqV2cWO2jSuegHFplmkHj7+n
	tWPASD4Z5qS0Msrp5vx4XYPKoNO7BMl+nLYfcXuMrMSGkbYCaGSdM+0skBT0J3CFErzwZyVP2An
	nKRpHFSYTlLsYmooP+hrHRUWFZDe0pf3wLfGj0PwOi+jWovkC4nbQMsDdqMJQxZ3fjtQAMQL9cL
	Vbt/d6RdNvaKNWD4VCQm0bvwexBQXrPp4NYVPT8etWw5BH01aB4WHMGEEgUV6YdgMq+EiUi3+0u
	bAnOtTgcCxcATr//S5e9QkdIX1ToOoPqlUcgMrilI9mvdS7omIveaZJNub0qseOu++gwU+yS9Tf
	SqENwh2e0FLN6AjOUe8Nk6jyb6Ux8Ps5/aLRD8EsrxgDf6W4=
X-Received: by 2002:a17:906:5054:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c1fe7f13483mr399043766b.24.1785686152655;
        Sun, 02 Aug 2026 08:55:52 -0700 (PDT)
Received: from systembl0wer ([185.94.52.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd44542ddsm462288566b.29.2026.08.02.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:55:52 -0700 (PDT)
Date: Sun, 2 Aug 2026 17:55:47 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: fix sign of raw angular velocity
 readings
Message-ID: <20260802175517.288bd5a9@systembl0wer>
In-Reply-To: <20260802065540.8120-1-congnt264@gmail.com>
References: <20260802065540.8120-1-congnt264@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 13:55:40 +0700
Cong Nguyen <congnt264@gmail.com> wrote:

> The MPU-3050 gyroscope output registers hold 16-bit two's complement
> values; the angular velocity channels are declared with .sign = 's'.
> When mpu3050_read_raw() handles IIO_CHAN_INFO_RAW it reads the register
> via a big-endian regmap_bulk_read() and assigns it with:
> 
> 	*val = be16_to_cpu(raw_val);
> 
> be16_to_cpu() yields an unsigned 16-bit quantity, so negative rates
> (bit 15 set) are reported to userspace as large positive integers
> (e.g. -1 becomes 65535) instead of the correct negative value.
> 
> Cast to s16 before the assignment, matching the temperature channel a
> few lines above which already handles the sign correctly.
> 

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
