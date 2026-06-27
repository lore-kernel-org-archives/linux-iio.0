Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06C30C618
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782585014; cv=none; b=ROw6pTeomq1cJPrgsqTCEFx5ekmyg2wo87ZzlVEi+aqCHS5oRX58qR9k5CX9wfr60ptTyEqie/ZLn4WUp8BypzYWo6/wNaMEfuV9DL3uLPz9zO5kZxvOudm9/zzjFxlOGCwdxIm0dfNmr61AtrtT5RjlFA/VjLHl2eH0JjJAshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782585014; c=relaxed/simple;
	bh=pC8fa4X+KpaN8K12A60eHy8/3aNwxEawC4NV5EKQasE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc5xFZBVrRVUXN0s+ALQOyB26N6IlmPscNpVV/gU87FYRwDQODu/kGqBOeg21q81Sw4qVCzXpx31qmhJ0rAshTH+6DgUDEFOCyV80XalM7o4FaB22lyaPgqt1fczIrVg4jRTP34C+su93uGEDBDjOZBJc8s895yjRhDZbF6Wibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BXDLkK27; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BXDLkK27"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9565cc13aso647375a34.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782585012; x=1783189812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwOhfje936cydMDnrwerRTqSDQiNMF3yBn9vwrjGE2I=;
        b=BXDLkK27ip3mhkfvOrg0LB/S+puU+Q/Rw9XCsakriOOqwOVP/wftQ6McILZj0Egpcv
         inxj50Sgkl4T51ENM40gsE/Tdp4KNq2fsEJO6pPX/KoMI+/CwtiE2ocJGA9THfJNrpAI
         d8BHi9dK60Uj29A7lVO+BauEcolebKTCAl5WH65dVcnz/AhGAGgWGGo6bOouW3qofYxa
         IFtS3Ot8EKREZQzi84a7kGqdxFp9Wirg37oWA4u+p8lvJDv3WHWba2CunFa3q9qX2P6f
         24daYbjq9PPsemWAQRTMbJHD3zWKTGRaQn0zoYa+eUJBql5cm4mcCVqdMSCKGedKjE2N
         gB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782585012; x=1783189812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwOhfje936cydMDnrwerRTqSDQiNMF3yBn9vwrjGE2I=;
        b=OPLmYvsL9RbYkNUKKyS5lji/svblWktlgvNDsBwGHKFpGtUihAqxMUTNOnTV8h7jJB
         pZBYhIBbbyRDl5d1uQMotkuExw/PDPkGsZXChiRQy0pbJVa/9flKZlA91rZaKiJKiKW+
         6h8jKz09VcjcPaoIjwbhe8piaCRYztnUikSFFSVAHdc+EeQDnwYKsnkwyhV6NhyESGv2
         4s5Qsj9tM8PTk7FbJxEpZsr/PFsQVx5F66vs3tB5mmGneI9ZZ4RAkJn2oR9SXrkzImDc
         iuAaWUuCXYo9hsw/cJeKY8J9mG4AmDRrHjhSGh7ek0Xv9ihj3HoG/jCTgtdR9C/zDsLF
         sJUw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ghwg7qJ//p2FLNu659FGlvz4N4Z4BrvrcJRipG3ErD9bPojb0gDfK3oYqPtVLHDJdhKt6HYNgX20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzDxn4ZctgKoZghYJ9GqkWAfQFc3EI2DW/FhoeY7h+MhsgwMf
	p7hQoLi8aEn3m5vVdIjtb5qymjY7jnFw+EwpmflKOdXYfJsMJP5m7FBgzOhve3rad+c=
X-Gm-Gg: AfdE7cnJbxdGn6q+Hea/c4lXVTONuOI2Ph5iFFHp4tskOyd2TflHyCc6q6kPwNz5EAx
	K9v40/hbJ+EdEuo2t5FbhtKoqLKXHLJVi/Nk9JcsDXlkQn7MHyOeJkrJ7VxYjTuRugyLCbQAoni
	uku3itCidur4awoSG5qOiZlxGjwg3Ba/KcjcBZ0IoibzKE8qEGbgUgomWumitnzxikTDGZNNDps
	hyUB+I5IjgEgTVR97SnEq1lic9mRicaZX2lV9GBZCc3jINl74xKEDezI969smdox+6gyzej0v6H
	7zeRi0NjBq49k76zyPjaIsG3UhC0u7UafrSvj9nYL0M+jrivQGNGmyKfMuzol8qPuLTDrZvjRzo
	oS77YNkmMtWQ+8NMc8Vj9NN1pDOoWO5fI8fA+OLfDY+znWmbjUiO3IwlkoBhmT5fPwguibDOz3c
	ABd2GBNYSxBYxyAsfy30jNwxKH3jYYjOpV3ZiEJMyH4BLK+Z3z/Z88aICpPz1x6Ko=
X-Received: by 2002:a05:6830:4119:b0:7e6:e0ab:416c with SMTP id 46e09a7af769-7e99c19229dmr10659662a34.16.1782585012056;
        Sat, 27 Jun 2026 11:30:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:47b8:1bb2:ed26:1150? ([2600:8803:e7e4:500:47b8:1bb2:ed26:1150])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5d4a4bsm4618913a34.10.2026.06.27.11.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 11:30:11 -0700 (PDT)
Message-ID: <7dd221e7-07de-4922-a2fd-87a865558a87@baylibre.com>
Date: Sat, 27 Jun 2026 13:30:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iio: magnetometer: add support for Melexis
 MLX90393
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260627005843.7786-1-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260627005843.7786-1-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 7:58 PM, Nikhil Gautam wrote:
> Subject: [PATCH v3 0/2] iio: magnetometer: add support for Melexis MLX90393
> 
It is best not to manually edit the emails before sending. Somehow the
subject ended up in the email body.
