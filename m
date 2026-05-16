Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B32750FB
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949380; cv=none; b=ip2FWfLqwbRx38gIc94C/DdpuxD4q0IX7LatY22cfHR4rFQqHpxiQxOZMo1xWs6qdxf3+Ux2h4iy3f9s4fQI+oqg9/wtxDrPDquK32ywaryEWjGF1C3INazjrcTv5LHU7Il/adFS2bNqXtT8SAxDAjc5ml2EFonf5iLYS09M2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949380; c=relaxed/simple;
	bh=e9buK7AOGAcnlt7IK5DMwjtTCBLoEA4NrMaoPx9LywE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ8bUIoiMFrsbY8xsoT9w+M65MaxNejEJ2TJ+LySML5VarKgfNzcCi82lKeKpn81xEBSLtNF7sDzb2u6Z2AQ4tt5EQTPi+Am5f+ZWmIaMh5PrRWxgSdGKylrkR5J36U6k3HH9PdG9DvXXg8xnuXzbuLir68dK6tyuX8GbqK9Q2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Zn/w6rch; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Zn/w6rch"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7de4e6c5a30so1295631a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778949376; x=1779554176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaOStI/eVwEiq6cGdJL9lRYi8PSbbGwHrHPEFgKfdXs=;
        b=Zn/w6rchlGvEAPq++InHpVeMcFc1OBafNfN2fzQHV4jSZuTkmmqcn3bXIWkLiDFhO7
         6XWEvMA/m/LSLqai54VnTxeuengJ6nl9F7VFwbrWgPqckmlxp3kO4MBg3egjUvtUKJ6b
         N9ypEcrrMFeYWArXLbJyFgZGi8TYDlSq9KKYwjkdlwDGWT33u0Wi4StvwOhv3DlvEMBD
         HY8WZxmE55SNmNAGnXHXF1DFZrl4ZLLHvg2hYauDXyhXYYUVvGflb0E5nHIq4FVk56wt
         kbSzxX/FYnqKc15xAJGsvmXExvW60EZnOF0ZfYeCFexbEDwZpu31GUHBKDj7Sr7+SJLs
         BebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778949376; x=1779554176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaOStI/eVwEiq6cGdJL9lRYi8PSbbGwHrHPEFgKfdXs=;
        b=W2VgqdoYv5AUxehDhS6Mg59LrTvB3JPksoHTiRWljp45JgDfYSIFDdysr6u0UqCE6Z
         mLi8Dc386V1wvFyimUrFtzObLIk28oQyadpuvg3Wh5kVFs1P7S3Zsvk3n9WoyK/zj7R4
         czxIoLnWhoJhS9VwNQrdFZNcIKn4ARP0x2fKWpueAQmjKEUlezIBcWBv2Gk42bnn3fsb
         3LJnNoKDS2zzmQd8v2dt6dNIrx9zkGOVcik5JXus3ocQVNr+IJ5CPpANKeG1lq0YJdFB
         W0x7Nxch8ftG0l8rxeTQI489kxFSgAOX4Sa2Ue20rAUcmjSehAIBZ2DlUZ2vh/y215Lk
         O28A==
X-Forwarded-Encrypted: i=1; AFNElJ8YEeiJgy1FzsincCC4Mkbrpfz8DePWaMhS1C4wwXeeZeJ260ekA1V+S7s4vIPRJ4COPaDNyPGn1n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSLxybc8PlwShq6QB+APZ9dPSxOG5nn3zLyHdV8w+W4crZ+jk
	DXRucfA5xSOREQFdoS4UgXgV2JJXJH9m5YW36RDaaXNQ0E3PwoyJPUEx8VQ4Fa95HpE=
X-Gm-Gg: Acq92OE5Z8TjqppVvQZCbxFgvBXz5E+c4Y4gMAV2ulZam+MrGJe3zwzsfp3XYSI5AZm
	Sd6g62s6mVmN7ZuoKJ7zU7WFtu8wU1lsPgAPYpnsxoqvpY0OZOYXkl75uATFOubZzaEmJD+R0cj
	IEAa/YPSrpy2KmSqsVBeIvYDLs34SgYge3uwH8T7AHw678Zahywhwv/wgXAH/EDx70lhk4S5dIB
	aJvuVucRUDU+qOWpruF7vfdfP1C5ZRy4b+fz8XasNWBTLWT9QfqlJmisW4N+NQLrrmXpyOmPdpX
	EXKhUixZU2xxx5rflHxDyAbzH6NO3iEuGBjYKcvg1qxZtLocWFCPVTlbkMLIHA7hnC+hOfnhsE+
	z2BNlmlbiwWI9Jh2sFBh6X9kXmLjZiw+8++TLBgYnTtj+KFrai4FR/o3IJYrLm/tRNK/GG5c/r1
	8bLvd90MeJyAaX5BsYwjaxHRJhewvTayCHTm8mW5xQI/dc6JdGbV3tHlcsqERI9SBrjZckEjE3+
	7PvwzeH5Csj
X-Received: by 2002:a05:6830:6f48:b0:7d9:b58e:55ed with SMTP id 46e09a7af769-7e4fa07b869mr6834863a34.25.1778949376527;
        Sat, 16 May 2026 09:36:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b43sm3827396a34.5.2026.05.16.09.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 09:36:16 -0700 (PDT)
Message-ID: <7fae9c9f-099c-4591-807c-ce43e2f3e0fa@baylibre.com>
Date: Sat, 16 May 2026 11:36:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] add support for Microchip PAC194X Power Monitor
To: marius.cristea@microchip.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 broonie@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515092946.10791-1-marius.cristea@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260515092946.10791-1-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 4:29 AM, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> Add support for Microchip PAC194X and PAC195X series of Power Monitor
> with Accumulator chip family. This driver covers the following part
> numbers:
>  - PAC1941, PAC1941-2, PAC1942, PAC1942-2, PAC1943, PAC1944
>  - PAC1951, PAC1951-2, PAC1952, PAC1952-2, PAC1953, PAC1954
> 
> The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
> 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X-1/5X-1 devices are
> for high-side current sensing and the PAC194X/5X-2 devices are for low-side
> current sensing or floating VBUS applications. The PAC194X/5X-1 is named
> shortly PAC194X/5X.
> 
I assume we already had the hwmon vs. iio conversation? I would expect
something in the cover letter justifying why this should be an iio device
rather than hwmon since it looks like it was designed for monitoring
e.g. CPU voltage.
