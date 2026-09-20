Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5C3D4121
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881488; cv=none; b=bmOzimB26EVLyiVXdMkCh8y72hFxm3Wfyu8hbJF6Jqjs/nQrajEjTZgH3sUq1VDWa84xHXQNuk7xEe/t2qznGrVVQ9HFF43AixE/GJ+TMzkKiY6H3jLzZrho67HJbE29Kvlx8ZV9TVFrdb4kiyLchW/wJHqEI/rlkD0ZQwc04wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881488; c=relaxed/simple;
	bh=qio30BBoJgNtCXMiZsiYGpqURN/Ug560k5Han0gxn+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPIMg3vCDpi/skyae2jMPcohXOINfVOpyGgPQ8SUFNEAS+DUsKiCZFepyRZKWdkQyFuewAJ6JWNnmOV103hbpBJCrSlTXnRy38NZH/7TQTUgTkktjxyHXYfKAkJcedXAuxBeoNO09Z3xrPZKu17RITyjSwQ4Qpq9HxkoVvvD+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTUBTSnh; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTUBTSnh"
Received: by mail-oi2-f9.google.com with SMTP id 46e09a7af769-7f66624aa21so508015a34.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789881484; x=1790486284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qio30BBoJgNtCXMiZsiYGpqURN/Ug560k5Han0gxn+E=;
        b=QTUBTSnhmc2cI4Qhs11uPePlJt3zwaGvPe/l0T8YX1qJktU+Jo/2CdoY/XLPAEEYCo
         jkXItKiYhfdoLRy2tXryA7OkvWokLkYt7Sokos3egUFK+Nb4gu2Z+9UVW3q6SPZwrfpk
         Q287tq8uj9b4dgeu+/7abMZKqjPNL3mvTIKYRYAspcdGYX0PUgnXPk10OowZcj9LRcHU
         A0Ofa4o2UnkVDeej5p2jUUUCHmLTwZ1KzIp0IOFTKnFYZz3rVVD1G2uWMhki9zhK2Vq1
         Yw152lMEv2Q3UpPGL/mpKDBamVplAlOo7Qm8F+11K0iEM+6hDkhMzuJd6OEo2hjWb1Y6
         9Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881484; x=1790486284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qio30BBoJgNtCXMiZsiYGpqURN/Ug560k5Han0gxn+E=;
        b=eG21hKmIlrv/oNCa6Wq9eEgzZXZK5IuCXBbMI1l47FPQ4vOvdmRT0JDzUSuVdJRGcb
         UlbajmCg1RttPB2qHaTHWpkeoVDxbXesODD1FPwHPE6mIPqIPnlZUA0NUbIjD2l+YUff
         buLzQN3XdGj9ixRKZz2U6Cyw1bYDlIh3IcoAGTSNGlaCA6pvNnBlNeZs/qvIvy3UE2mZ
         MvvrizuDYq20Y99MQgZ/6TPoafFnHA5yLEIVqV3ES1pgrzYFcMta/k78wj5DAXQwnzEZ
         U4gfHb3mN3D/NMTvlgQ7EVWwueGg7QnOqCJxitvjeSX9SKB2KvCIqb156ClLJT5zLGVx
         jdqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPW/cicUGvbAGInTSYDDyHNS65JqfqjcodjOBMBGupoNomrV2lZuHMMS35D2aazbICEtRD3N9QHJE=@vger.kernel.org
X-Gm-Message-State: AFuF++nX7o/OyFHCPTT0tX8mvo0Nf5BMFr684R4ScivjqBXBUDdssqUg
	KHThtQuL3vgjadclBjoPW9Nz69qUdgf70lOMOuU/aEd2q9W5Sjty554x
X-Gm-Gg: AYBFou1Sg4QoghAhRIPbF2zxV7RzZ3iqgUJVELOs1mBGIpdQX/k8Ok83YK4s5CQ6l4r
	d9/LijTwmoqkn3tNxE6/Z7Aa0JTwghNirOvtdeVdyPl8eBjcxiwVl/WhrVmVmIHPRaK88DE+YM1
	/FeJ+i/IG7wGt73qpYChKxl00ImhT3g01ylqRSqXDpuM8VrxilCKmVLCV4Ynh81ZjMBqf+TGJGs
	5QsBWXUcsEpcRedXNK1MlngDMC3qwr8qlhkmUnUCeYxz0v1NYp1TONfblGTEUdjSNE/8jZdjjEO
	02BkGe+ILyfBR9AG0sWLWdhoU9iC0BRotnpG/NXAdowaWT+HfcuxHtVS+5gRsX7fmXhMbj45xDY
	l6uwbXMJlb5+ZxYTaCK6FG7SPB4aXE44Ue9ydLLtcIvWhB16KtGEVksuV3KPkt7yZins39bcBO0
	JylMBXI93yVu/v4AXzGFnX6uAU9CcKOvSoe0Kp4EKoO13/5Psqpu4CL8ekSn8zbehIGfEmDPELy
	nDw6eSVz5Ttgtk=
X-Received: by 2002:a05:6820:2219:b0:6b1:2843:1312 with SMTP id 006d021491bc7-6ca972e90f2mr6018628eaf.0.1789881484271;
        Sat, 19 Sep 2026 22:18:04 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::2620? ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd320d5c30sm5494232eaf.2.2026.09.19.22.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 22:18:02 -0700 (PDT)
Message-ID: <1c1b2958-dbcc-4a8f-8d7f-d2eaaebc941b@gmail.com>
Date: Sun, 20 Sep 2026 00:18:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: adc: add mt6397 PMIC AUXADC support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
 <aqzl29C_R4zwAnDK@ashevche-desk.local>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <aqzl29C_R4zwAnDK@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 2:18 AM, Andy Shevchenko wrote:
>> Cc'd Luca.
> Instead of this, just put the real Cc: email tag here
> Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Done in v3.

Thank you!

Best regards,
Ryan Brue
