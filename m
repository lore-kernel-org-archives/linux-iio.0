Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E24204C36
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771696015; cv=none; b=WSxmVgCHGeDJR9AROmTgYt18XnYXlf9M5lDStuRFzM6s271MRlu4SVJxKAS4fLbXAYz8gDuXdv6pRAXkFC8gOYykgHgtTPz9Icr1l3OW4pBD24GIZrwIy90nNi03FpxIF1Pxoqs+zOEAOlZMVPu3O+Lq2Qynb0eBfCfgjDpnDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771696015; c=relaxed/simple;
	bh=ZrxFx6kVDvd1icQj9WlMBkt47n8G+r+zQnMgQJcx9vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COZikdOaWF26WUy1VeGo7Xl2HdtBkLtbLpPWIPriBkQiHm2L7diNIU2JLWzaOz/B5NAIqQ8yH0YvK483IeZvDPosp8OUr0I4rppMwv5dPuaaZ6iDftTx5eWnbdU7asSGgo8iyrwLSJmzswl3GYBv63Bjj/JvW+ai+k+d4R5Qf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zjtzUiM7; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zjtzUiM7"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-679b072ed3aso1574346eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771696013; x=1772300813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrxFx6kVDvd1icQj9WlMBkt47n8G+r+zQnMgQJcx9vI=;
        b=zjtzUiM70RkpyPmay2O/ST8QcnhYVVdNh3jOd1GjQ0D46F5cuX+cPo29Qaj5VL58bT
         dHT9UryYptxTBAtNU68SiAyw47tp6o0Gy8DrtJ9wTgLxd8gj8zH49J1KmAfoYFweCjUY
         /bszy6v1/2+PYEIarW3iBBCe/Wd88nHuBBjW2iEmczoqBq1fjMPJvxqPxj/9CGAx21Cw
         2LIHDpgVsTtebmtZPDK/j1ta6I8LCupZZtM29/UWAlg6hygw1p9pyf+wGWkurJ/ZPsgc
         bFFlSzSUsHfUNzd+QSqErH9D32N6g0PaEKc6CAzWBjmWN+Tn9KSQEj6ABtBbQQpvLHx2
         6zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771696013; x=1772300813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrxFx6kVDvd1icQj9WlMBkt47n8G+r+zQnMgQJcx9vI=;
        b=XJNvihYgtzS+Oh87MOCjHOuLg3tKhdapUmW1oIWaM7E7ZvTg3SlhWmtTrMORswlzOH
         dPZwldLKOHL6QPyM6OOAigbfogAwN/U/HUPGHk0QdxbP87/QiWqJ3OIOkUEhKNPL7rmK
         NbsOvrMDf8VVfBFYdb5Y8nqKVLoF3DtmTfcSpoj639rIUulZH23V+pgmRZqZq12uDRZ5
         hi4DJ15E/e4AVI34QfepPUmijOycOU0UT7JweFX/AkYmXAcqbH5ZlYfVM0jHkYAJlm7C
         tIHsGy6pbMk5r+TEGAnO/VuaONrGvGF23An0Z7j+WTyLlhpEK0Kw6z5cjsHQwgH+p5MJ
         raNA==
X-Gm-Message-State: AOJu0YwF02zEJJclVOdU1N8EvPH01YfTNafda19J5E8cU2blVSe38ScB
	IXn7Yv3GkRKqKGVc4EwZFqR5y8AxR9UvCNjsSBJ/OuhhrcocBvPrbsEn1J4dmFlk7KE=
X-Gm-Gg: AZuq6aK7g+bgjz2s8CHwMGYH1C0VgMLnFrBDzO1DjNO8K08ajcwBX2axV5fvBi/d2EC
	id+sb1gpVi8uhgzcqQu2RNEh2zV9sfbyIC1pHtpapjtyS1/xYp8kiUjge7gwQZumSU37FC/y1PV
	d89O8OZI2Kk6Acn7gyMfndODUODvDIGNEpnX7T3esKMxxGOY2E82jzaW92Tf8ygCx8v+imq3Gy3
	hxu+rI3kd3xrn97qyospzV3bROnd4YXrc7gJQ3gcnmYRcyKvLeai6ORwzksWvk3LICmm7rmtJze
	eBDDfsRH3JMhUpeW9RTDlqdow/WQHfx8whyeTpOBoKil1lm/19PD0SYT1OzKrf2WmydCvNv4Nfq
	T7rAjTLs9ZwlDkRdqde0oYrxo5JmU6jDxt90yBVO5GiuNf/KUm6AmKjH8x3H3OiUAE6VZTZG9OI
	/dI3BiMWpJUMRp3+cf/deZ0ifYA1eeuSjFIFcLrttnMjVm1KEe5wdFMFJ1XwwXQEBXSE6s8A==
X-Received: by 2002:a05:6820:6ac1:b0:663:12b4:959f with SMTP id 006d021491bc7-679c44e5a36mr2138594eaf.42.1771696012812;
        Sat, 21 Feb 2026 09:46:52 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9a231sm3004319fac.5.2026.02.21.09.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:46:52 -0800 (PST)
Message-ID: <bc226921-03c5-4780-a6e2-5db1c21b19ff@baylibre.com>
Date: Sat, 21 Feb 2026 11:46:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: pressure: mpl115: remove stale TODO comment
To: Neel Bullywon <neelb2403@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260221172601.77818-1-neelb2403@gmail.com>
 <20260221172601.77818-2-neelb2403@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260221172601.77818-2-neelb2403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 11:26 AM, Neel Bullywon wrote:
> System suspend/resume support has been added in the previous commit,
> so remove the TODO comment that was requesting it.

Why not include this in the same patch?

