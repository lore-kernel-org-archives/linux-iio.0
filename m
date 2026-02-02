Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC05366833
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045467; cv=none; b=H8oh20oJG+LHimvCY3NdB1NZOgrrBeWdTDGiNqpQYkLeWzimEa5txQNCemmRKudjnXmygxIB0bQGf7lkvhn2hXBbNHfvBcJ9bdotO32CNa1A8VsAN8CB48VmGzpb6BmE4irBide0k+w2Wd6ZqlfDg2VF+EFmCBppCk7rbE20ukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045467; c=relaxed/simple;
	bh=Lw+CdkWrNDCg1/AjmrE70CH2vLDd4ESEszCTUzmZUrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3An7sZTeXRvvtxRiYhm45fvKhtT4IaKQUEwN49sVey2qPZdRFNUXjAK0QxhJldGT+V7E+23nIl74s+98/fGecOFD2lj/vtr1gSLl1dtZyJeglB6uB/xIUSimnkYpYgCvCI4En4h1Ij6zSNoFReL46JEzm6pnvCLs0Mk7h4fCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NZQtgz8J; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NZQtgz8J"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c962424daso1844282b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770045465; x=1770650265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsSha5Bi78vbCUKsfGavyZpVla65ggcaaghfokicSck=;
        b=NZQtgz8JXaFxnJGFmY1492CVvShTyCPLvaaJ+/ELE1gG4X9I/HWxXSTeOgSywOt2Ei
         DEkruhI2I3pavSNuava2q1tlOU/0PSeDLo2hvH1JYn6Ld7Q4IEcekwjh8niDU5s25EhE
         VDKr/SzrgIkXCp2i1Zfv77wAQGvwWI9JK4eWh3lXABEGurZV1ZeW/7pbBSZNbSCC6XwJ
         G8IoR9JPPh2/Irx0sQPStC9OJuLxufnlYjQfC9I8ebFJjrQPm5uAhN29G+aMd+SYL7QI
         fFj/AePZG/wxSebH54Kq4ReO3WVPBvCBCcd1iyNg+xfK8MhXb6frVc4ZJ4UgMmM0SGci
         8M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045465; x=1770650265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsSha5Bi78vbCUKsfGavyZpVla65ggcaaghfokicSck=;
        b=pRk/qTwLeHrrVY2w3/Sy0T50J777/e6TBJp9FDQzkli+TshcNRT3jlSJvCJBd2oL72
         AfcMwJbpn/NeAXblOUqZBWEsE5O/gnfvEmbSBGR7EuUSSlALSRYyOOKQPMLo9qtGUbZw
         GP9sf5I0kAzLonXZLGlDuj/dl5c1YkadJ87DvDBSABtW/w0O498Ze/hMaWC3efCBVQDB
         BrSgHvfsvI+Vc6nub8aIkAahzvzbIxYsx67vP3dLbJte6qneLM9LxEz73ORpCep0kDqp
         FA6JldbQb7vg3UyLzWCt4J0OCC9divpq4lbyjKR0auU6nKKjinJDUTceyvkCxdp7G204
         r44Q==
X-Gm-Message-State: AOJu0Yzq8icYSN3WypMbMuOzDk5Vs9COTVFUQklW8rH1XTlJRgxAeOqm
	HftfbcJxvUMQv2E8wjAUOGMJtFrSwflW0D3KSZmcr2Jh5SzSe4+0YZLjJ9Bmf8twbwUtHzdJki/
	uuEA1
X-Gm-Gg: AZuq6aLO4tnVsowdQbs8T6dPWDgn7pgkRFCyHYymZyiFfziVzoP4FCUMyV36J1oKg9w
	gaLkGiej61hgX7A7rVC8ZSNfdmoCoveBAuKFvpC1J8rUU0BWXRQHyjak3e1jU++wzdy0gKbN/HW
	R2z0Hicwd5d9negWXsECH3wotdsExwKj6pQrIK977ZffuDqGLz/FlZUjPdiwQDMFnyBWlPTMMIn
	sw1uX5yL8jKBhqGD9LshkOl9cvg2T6EZBrqhyy8gKq0gBHSKH4FQYSekCBzI+7rjF37YASX+akc
	Z494akGqjzlG2S9vzTQHG2EDVfF3KGr+e1RJDWgc8YoG4tpoE+vVhLokR+Yhmt3Btd8Hhmkq94W
	uVEkOA2vQ48nxhLO0og3eVtuS0aSzJwjO+geDnmbStT1UrgcuXiECnk3fAD9y5wuXjHzZG2c+hA
	ocVrOJkWAX0EigEbuROn33DGFuNvmq0YJOjM9LNcyT9K2QOeuETWWZVRUtDnAb
X-Received: by 2002:a05:6808:c293:b0:450:c9ad:491b with SMTP id 5614622812f47-45f34b516d9mr5297901b6e.8.1770045464994;
        Mon, 02 Feb 2026 07:17:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095749f274sm11881145fac.14.2026.02.02.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:17:44 -0800 (PST)
Message-ID: <d74fc49a-dc9e-4b06-94db-66d5695b6faf@baylibre.com>
Date: Mon, 2 Feb 2026 09:17:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <2b49eacb-c375-4b01-8cc1-325fb743daf6@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2b49eacb-c375-4b01-8cc1-325fb743daf6@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 4:58 AM, Tomas Melin wrote:
> Hi,
> 
> On 31/01/2026 22:30, David Lechner wrote:
>> On 1/30/26 3:16 AM, Tomas Melin wrote:

...

>>> + *
>>> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
>>> + * calibration. Calibration procedure is device specific.
>>> + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
>>
>> I assume this means it supports devm_iio_backend_request_buffer()?
>>
>> In IIO, we usually say "buffer" and rarely "buffering" so this name and
>> description is a bit confusing to me.
> 
> Sure, would this mean that name and comment should be?
> IIO_BACKEND_CAP_BUFFER: Backend has support for buffers
> 
Works for me. Or even more precise: "support for IIO buffers"
or "support for IIO buffer interface".
