Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36A37F8A1;
	Thu, 11 Jun 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200753; cv=none; b=B7ZJGQy4j8M8ckAyb5bIZlemDdKrBqRo1UpPr8OBv31vje89sEHDAmtM7+tijKHL47fa+SPqRuNopDXo7xriI7Z5jg6jJqER2RnKcRnwZYrZ0imUPaePZJpTle4Goxpuxm7U0LRb7KLzckm+Ks+VP1P3TijBoARRkVd/42sd3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200753; c=relaxed/simple;
	bh=6VonIUSnB2VX1hIS+0y7GFggDcso+/e+QgzgxZQdekI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrV/TTjniKdk50UC/0NK4OPtM3GVSaEkgZgiilFNeDYzQ+kxOG6xjm7AN0izXaxLd6Skr94cQ8qKjLZSSlQxXODCj8yw/+VKjrneR6JvyHf8UlguIUVjCwqd0gNQxIoQJh3lcLzRAVrHMJNXghT3E+zPMVQevFzHD21jPCKk2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=NyCJUJMM; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=NyCJUJMM; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="NyCJUJMM";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="NyCJUJMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1781200242; bh=6VonIUSnB2VX1hIS+0y7GFggDcso+/e+QgzgxZQdekI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NyCJUJMMMMgu+bCOZWx+k5Q6w2XLDVed45aLKpwCON2G86TG8r3qqdrIxEcFS4COY
	 9zdA6o1Q5FhbA73U2wgHmnogP7XuVNI84DUkMqtNyauW0AuOOjt5+kUVjbTT4Zn1xb
	 2IJN6Ie8msCwDlwcI8cRZhrD/sGrugqjTsbvGo4sG6ZqDYLBMipnZrYO/ZTedOMOH+
	 vjq9NXwUBUrPHH+pPLGzK8aS42/+ApvTJPgEOqyEfzTWMttOIJakI91rCtYlonbJQm
	 J/BAxoobEzNyWc4IBbvp40+9JyyrhKFFcbREvzkVsc2ToMllAzFMGEf4wWKMuOO5Xl
	 nDe1hLY3zTEsg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 52C2D390154;
	Thu, 11 Jun 2026 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1781200242; bh=6VonIUSnB2VX1hIS+0y7GFggDcso+/e+QgzgxZQdekI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NyCJUJMMMMgu+bCOZWx+k5Q6w2XLDVed45aLKpwCON2G86TG8r3qqdrIxEcFS4COY
	 9zdA6o1Q5FhbA73U2wgHmnogP7XuVNI84DUkMqtNyauW0AuOOjt5+kUVjbTT4Zn1xb
	 2IJN6Ie8msCwDlwcI8cRZhrD/sGrugqjTsbvGo4sG6ZqDYLBMipnZrYO/ZTedOMOH+
	 vjq9NXwUBUrPHH+pPLGzK8aS42/+ApvTJPgEOqyEfzTWMttOIJakI91rCtYlonbJQm
	 J/BAxoobEzNyWc4IBbvp40+9JyyrhKFFcbREvzkVsc2ToMllAzFMGEf4wWKMuOO5Xl
	 nDe1hLY3zTEsg==
Message-ID: <809d2a3c-4189-4cc6-b340-097608b48c83@mleia.com>
Date: Thu, 11 Jun 2026 20:50:40 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: adc: KASAN wild-memory-access in complete() on early IRQ
To: Maxwell Doose <m32285159@gmail.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>
References: <20260610115700.774689-1-jjy600901@snu.ac.kr>
 <CAKqfh0GVDpfP=TJZPQ2UYkUj=pe1KGn4j1zqbaz_19xawekdnw@mail.gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <CAKqfh0GVDpfP=TJZPQ2UYkUj=pe1KGn4j1zqbaz_19xawekdnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260611_175042_357202_3E31A7DA 
X-CRM114-Status: GOOD (  11.53  )

On 6/11/26 19:07, Maxwell Doose wrote:
> On Wed, Jun 10, 2026 at 7:04 AM Jaeyoung Chung <jjy600901@snu.ac.kr> wrote:
>>
>> Hi,
>>
>> lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
>> spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
>> interrupt handler with devm_request_irq() before they initialize
>> st->completion with init_completion(). If an interrupt arrives after
>> devm_request_irq() and before init_completion(), the handler calls
>> complete() on an uninitialized completion, causing a kernel panic.
>>
>> The probe path, in lpc32xx_adc_probe():
>>
>>      iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
>>      ...
>>      retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>>                                LPC32XXAD_NAME, st);           /* register handler */
>>      ...
>>      init_completion(&st->completion);                       /* initialize completion */
>>
>> spear_adc_probe() has the same ordering: devm_request_irq() for
>> spear_adc_isr() before init_completion(&st->completion).
>>
>> Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
>> complete():
>>
>>      complete(&st->completion);
>>
>> If the device raises an interrupt before init_completion() runs,
>> complete() acquires the uninitialized wait.lock and walks the zeroed
>> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
>> return false, so swake_up_locked() dereferences a NULL list entry,
>> triggering a KASAN wild-memory-access.
>>
>> Suggested fix: move init_completion(&st->completion) above
>> devm_request_irq(), so the completion is valid before the handler can run.
>>
>> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
>> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
>>
> 
> Thanks for reporting this; I can start working on a fix shortly
> (assuming nobody else is already working on it).
> 

The analysis and the proposed fix are correct, please go ahead, thank you
in advance.

-- 
Best wishes,
Vladimir

