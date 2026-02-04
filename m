Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBE21576E
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167391; cv=none; b=Wi82JWI0IBql8SxjUWZs2+IgPY+rND4Mp3eCv4/tuRkncmQROPKec5MPv6zunS/hj7pIABztYU2uwlLNz2G77gVrJjptTEAVzVCpjPaip0b5JCiIq2oJ8bSOSbPLJW1D8VpmQPtIdL/59o46GQvsoDRbpcH+VboMhPztwbZCJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167391; c=relaxed/simple;
	bh=xjoTf+RdZbJXGzcATVakgVnBtZmgxlgPVRUtdNu5Y1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHTT25iXibctiVNiHXtZYLH073XKVU4fgcQLZ9geIltox2VX8Umi5xm1As90TZv6RrqwBMxZsejJfJw5tTmQ31IF+6HE5XKIOr0pz7liUNwv2HEbQU277u1dWjQp905AwtzhpGGzl5XmOKvBfWcNF9o4/vWZJDl8cFdjG6MFYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JxPKlCQJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JxPKlCQJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45f18e8f2f5so4203382b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770167389; x=1770772189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmZlgQDgh534OxFG8JZATRMPWrlFNsFCg2UONerEvKU=;
        b=JxPKlCQJAZBwo6zPG9pzQlhFoKtTjStUYPUuE51kHjYd5s45tV4rkVAkuGyxvhSNtx
         uJdMhxkmdZggRX/Cwt/DbarALHuRj65ZylUl4+uNtz2HReOmcgUrYJ7w2ObVYnhsss3i
         dtSBsJQ78eHSOuMGFGdqFEhqqgtldm2nYpoahw0ZkNnaveQgnJ8HvD+9naDEOG9SjZpy
         ML9j8UzLR8NabraaDv9W9PI6a3QuR3sYba8rHSpYezFvOYYOwFLWiWjSIWL/HRnaB/Fk
         RKs7NJ0t+TfFa5vcVwqi2PRj4aVnNQ+XgnJX2n8dqhv/hGEAMtxMmUM2XiCposWaQgpT
         82wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167389; x=1770772189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmZlgQDgh534OxFG8JZATRMPWrlFNsFCg2UONerEvKU=;
        b=caSBxYV2LZSuMDfgaOFDENvdSvk4YlqtFzXbQkSFxdQq5DM0mIMUXpqU9EqS39n/UU
         eWchwpMoGj+7ZJtpP8n5AQRe6zEhaEc0UFxz8kj0WE3nFjDe8gDEdw8Ie3YxCMb81r7i
         Fejuot68tKDl+ppQIz9KMGK1cRbLF332ORHhwTF157y0CIbQXKmUjLiiHc8T0xAuarJu
         YUYXiFmLfBdPWY6ywkVg6T60kWhLzTrAI7U2miDOB5zj1Dro4wF5UuO662a0tqWOgO4V
         8+B3fSMj0AkX12J1aiDwAhmi1/aKKOs7f7SnrROKyBP+5vYYDyc4sbytnslmMoCPn/+h
         0wPA==
X-Forwarded-Encrypted: i=1; AJvYcCUfBBEsBmusEKGSCwO2ariHxvN/7/+6kpHEUJejqtsfhhbBjdiv9mCDYs2oJVk9Q1013/PZfVMLmRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD40Nt2FwErQLezQlMSUy2SYxMhMLN91xHBbrTHTsoZKCJzS74
	laR3ayT0zpHUuoNm0gaOX+GyKcTKu4+YpdMp5MQDjbt39JPKMnImMXS3VDHAJ4P2UHM=
X-Gm-Gg: AZuq6aL3aE9Kjv1sXZwUtNaFkRfgzbdufVxa5t+kg08l53cpXnf17A3aB9fcnGJigr8
	U4a9hj8QGQiSQ4DHFdPhcPdeVxTZaXT7Pvh087+isF7Fc33JbDb7VGB9FsDPff84p33U0sIDZhO
	GVe37GF12NVmOtFCXr36FYyRYQsV2hXSo8tX6ZfMDUp8tKdQvzTtRrBznHofp5webkTWMqgZ+Ty
	L4XIJRIe7jdT9n4MuK606GS0EzFHq1E4bv80/LgV/zku7igSesaw1rfaeUA+3sRmapm7P7/Bz8L
	49q6o1J0+GmesgirOyL4L2FE5IasFv7HhCGuTYljdW36Fc+3yFhcVPWhT2gsgu5JrZjzrut5uHm
	y/zM3Y+bVvarq574aUSuw7P07MFi5GmFxS4ve+7k9FZ/UZk7BBUWA7etS4XtLdNBvijDhyOVywj
	6Ux2isfXO7Gbh4MOWahr08FhNQdg71x3fJvS9Fc/LvQFJlgmjicOnVi6k=
X-Received: by 2002:a05:6808:4f4e:b0:45a:770c:d77b with SMTP id 5614622812f47-462d59edd49mr697702b6e.35.1770167388843;
        Tue, 03 Feb 2026 17:09:48 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a5447f36dsm706472fac.15.2026.02.03.17.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 17:09:48 -0800 (PST)
Message-ID: <f0dc4a8e-6833-402c-a2f9-8f344480af82@baylibre.com>
Date: Tue, 3 Feb 2026 19:09:47 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: magnetometer: bmc150_magn: Used guard() for mutex
 protection
To: Neel Bullywon <neelb2403@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260204010529.48000-1-neelb2403@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260204010529.48000-1-neelb2403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 7:05 PM, Neel Bullywon wrote:
> Replaced the manual mutex lock/unlock calls using guard() to simplify
> the error handling and reduce goto statement usage.
> 
> By using RAII-style cleanup, it ensures the mutex is always released
> when exiting the function, regardless of the return path taken
> 
> This was compiled test only
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>
