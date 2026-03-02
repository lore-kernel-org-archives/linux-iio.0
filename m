Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12732AAA0
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468895; cv=none; b=KSaevZj/uvYQXBidfQC1O2u/T94xgerz/zyVRulNPN/dquxrDw1ywos56QHxGgyWlxZhYYaci9tLoN3Pr6jC/LUaZ2zr9opKzdLPP79XxtPAYVDTgmAIE2o6bse+OGpa9glvunlTz0BpI9YmzeVBV+mD1JyCguhO3uRZi0JYbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468895; c=relaxed/simple;
	bh=gSM64WsfJO6S2rYh59GGND0YhSvSxWL8wBf+z1wIn+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trJOw9nlOFzuoKgszVsVY0RqZks0DqoTWvwn7HoQM7a+zVdsUUPoSeSIpBLgKkwqdKAnFA2MqpROskZczFsJ+PLPxHx98VTvIsLuPa6hp6QI8JPC+EbKoQJzofv+00j+g2u0jzmm51BVQ/Yz2LXUbxuND+pClYpS8inH0ywfl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XLckC5e+; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XLckC5e+"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-679f6ee3fb0so2052133eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772468892; x=1773073692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqJE5duenMEqcJdEHn+YMVP5pRk1d6NJmMPCP3qEwks=;
        b=XLckC5e+/apSg+/a3/PHqUBuMgWAfoy/NesieCeXDBjwODb5reZWfWdhaACh8UX2dX
         zJwh4Ni3mQNKLXB3qJIVNLfcV34+Qy88PbXrQSbORoupkc9ARa8a3DE1Oy4DYhE0Thh6
         rNgh3ovqoIa5KWojlGptDgZDCMjkmTBBYMtgdA4NMnyuTjc1aB1XYqcqnGQA542rY96Z
         tmox4NOcWPqBXNTKZFxgbyGb61TQtHvExImR3Wj1E/hlHbef/v0uzkxmaDa9IucONv9+
         AHTzR5voTNqXrgFivOzHpcAhzce4/RqMi8s5jz+ybJoZsmQSw5j7JPelsrlVgmzHUw5k
         +etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468892; x=1773073692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqJE5duenMEqcJdEHn+YMVP5pRk1d6NJmMPCP3qEwks=;
        b=huJfJIK1x47wW9v6v2IIR9NUqXfLIDhriYWuGoi6crF8zsY/o8zx+j+JMoHI4cHs6a
         RJI40J5P1/TYnoam/SAm1xbZi7DVmJMGFZxPBjBWcIcEcjNXEeYHtTTqkiY/IpprbzmO
         w1eGkCplPkkFewjSg3rGA64V2UXvpe1qujuTvzCCR8KhyxL13qM5eTRZPYZecIxPF3f2
         PJyvrQhjYN+Nhk0kxLn3tRMVNvXKFiNy83erfQuFKynhyC0w16owVfTTUql/nRiJ/jpo
         GEXWwAOzKzxUpcKVSQml6/nb98mtmup+TdPDnN0q1c97NHn8HTGRWUVC5i/sd+2yhMCG
         XNPg==
X-Forwarded-Encrypted: i=1; AJvYcCVj4G6I2tSF7E7ynksUcSnGMQIf3OrzVu6Gyyoaox1gpHp7QSA2T2HylZqX+u7gAu7LsEUQnmxU4PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagQF7Zqursr/UwvK1lK0iI2a3ir1/G4PKTswYIfYNlu6OJjkF
	14jHHkn9rDrdce5jfAqGaqCjmkyb65sr2txIsDfC18SpGA1bXmEG3ondPNRhjihJJ4k=
X-Gm-Gg: ATEYQzyrfngebrlmGUjH0TmWpFwMybU3O2ltCO8u0FHSJLE2r7uIGr4varq8wRct9+0
	qo6YaozTcAYEKEySUWjSNk6abK8mwlWnjNK/Wf3MvZBZXLXNpHrZp+WNd38neb00i4zNP2Kf6gX
	Zs+E3dL7s1JrIeJP32TZjLVGImAdILij9cJNjQQYH/QgHPv//bSShs7brnMIYXTncHvJeidCKTa
	NgiKCNTLS3scV5si6pDsDnK66hApQRxiBfVbjWjb1qz0+c8CTUDoX+E9PehBniabOwtqGeDziHH
	XuMGuUpJW1qD33ZxL40pxqYBcESygv/jvhc4Oofc75RS5uNmfb+YzKm66a0Is+10uTWPhA/xDgU
	uPz/NW4MqGvnUKk1LqcoxY+vXzE/jrnL2SPaJn3ZZ78aT8cUeD1HM5HgRHZwLvHpdchxwzPJBZK
	V80PdeOfd77UM7ofjpQ6hJHmvz2+xrqYpnyVx4UU/FVZLZIZ97UfNxMJ0vf5x82c84mesfIDt3j
	Q==
X-Received: by 2002:a05:6820:1b0f:b0:662:e066:73a1 with SMTP id 006d021491bc7-679faf45f27mr7102281eaf.57.1772468892553;
        Mon, 02 Mar 2026 08:28:12 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9e8d6sm8979804eaf.13.2026.03.02.08.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:28:12 -0800 (PST)
Message-ID: <8ce6bc3a-c55e-49e4-973e-5f135e2b24ba@baylibre.com>
Date: Mon, 2 Mar 2026 10:28:11 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] iio: adc: ad799x: modernize resource management
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302130632.29144-1-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302130632.29144-1-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 7:06 AM, Archit Anant wrote:
> This series modernizes the ad799x driver by converting all resource
> management to use the devm_ infrastructure, ultimately allowing for the
> complete removal of the ad799x_remove() function and simplifying the
> error paths in probe.
> 
> This series addresses the feedback from v2, where the changes were
> squashed into a single patch, by splitting the logical steps into
> individual, bisectable commits. It also incorporates feedback regarding
> the safe ordering of regulator disablement and IIO device unregistration.
> 
> Changes in v3:
> - Split the monolithic v2 patch into 4 logical commits as requested by
>   Andy Shevchenko.
> 
> Changes in v2:
> - Incorporated feedback from David Lechner to eliminate dynamic buffer
>   allocation.
> - Incorporated feedback from Jonathan Cameron regarding the ordering
>   hazards of mixing devm and manual teardown, utilizing devm_add_action
>   and voltage caching.
> 

I just reviewed v2 because I didn't see there was a v3 yet. This is why
we ask to wait ideally 1 week, but at a few days before sending a new
revision.

Some of those comment will still apply to v3.

