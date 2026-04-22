Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09B3D16FB
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864510; cv=none; b=qtlpIpyLJhBpkjnXLOLl0DSS8x7Zk07+OXfacGC3IfzPGsLRPurydD+R5qvDYQw5MXsgaoICM/vufhJF7IOh6UQ6i8/BkIW/OH6unkHcLmm5jJMvnqiucflS52/Hd9UNhQDpgfoGW+QFHZWfGIl7o+EI4l3o0DStvY8Lva+WJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864510; c=relaxed/simple;
	bh=Ls8R0v4nHceKVBL1Grl2e5FhI0eNEP/FpUXARtHXqAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXnIqZkWpG8d4k47SN9om3P9sL2NGuy5dmGmK9+dNdua96RB1zbfFgiViGMp0oTxYDjjAXV+CZa9VxN3N+Xj7ZnDynMczWBhMGUsPPGh3aH2cq5wUIIFa8nKbIukZbrBU4LgXd3K4WEaFRSzusWQDKL0NnodR1d9Om0TaYbVwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKZgeR9T; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKZgeR9T"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a01c80c34so51467441fa.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864507; x=1777469307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7DZdG1ygeQjm+QsijNr56ROnVch8sEGbGnDlhLN7s8=;
        b=TKZgeR9TDzb5bP+sVNbWc0b1a57TnGi1Y9lp5SO7srnudW4GiTBZekRi71vVmeKWZR
         Lc9mA0yWrMu7EgtiwIdknwcaEp2ERarxHnxFwe3QKzcQkt8SVAxN+K2vSZ67j9BgrEpA
         Wt42XH7R2tcOyHzwHL3vTpdkQWVLaS5sFvJAq01Q3ZHCQcbxzoHP+euL5Sad1stAwHKv
         PxH8rEe2NKapAWrkOgkder27nsEKQ/bxVFQ0GT0KJZlrC7eHGqmytHayv7PexA9DWWL1
         nHofASGab1FXsWEoMGWfz9JlCwvo8VGjiOgAYa1DlYJ0oDM0IdjwTHqdaj0MdQ2XNP7Q
         Rurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864507; x=1777469307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7DZdG1ygeQjm+QsijNr56ROnVch8sEGbGnDlhLN7s8=;
        b=XgZIL+ANrMdbW+6n2JuQ5rSTHmsuCLz9jBh4wXXqfgPSJOKaaI2N5mmwcnbVMufXn8
         As9/SuRrtsIcXIX1wfJDaQStdvEmyGkOXP+tN+JUs6SnvvrjVgctnMnDUBXV3CoVC4bw
         iTYpFiCrra+FnUj9FnLuePib4xd+TTOcUH5eXfST1GNe+yguWjcf+RUE+ARzMJynSZZA
         JL8wiin8qHfW7yfPztddY9O5ZV7mQc3xA+bCycpw7dxftDdbaoQ+DtNH39Gcpt376Zto
         uuUSIOn751ofG25IRtgk1Wq1pi0fAWmHAYX6rJLFOwQx7tUI6hSWs34ULKprfDok161L
         jngw==
X-Forwarded-Encrypted: i=1; AFNElJ9gzEos+KH98PGeOBM886q1Jj+oqUpZugwg5BTIOZ446YHV8eCFNVNYQsua1fzA3mjAjtFHsucU3o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5hQy8FwVTb3YVKBLgxDqW141mIqQVRBLZUWTlGNarsFmOoGz
	0nBQfLnk+XUouG5QfCERfRvuprOmtkPbjplzcAylo3sj/li4A/WvUDTv
X-Gm-Gg: AeBDietdS+TWlaMOoENwp287UOBbQg7S/feBD6KqI9rjg4RmR9DaSzxoOqz6Cky8k9v
	bsbBl/cjFngNO92OZiUiKnm/+Ldy4xWdPmsSSMGqtiWWoYMJzheJZv9tSUY8V3zsGgw82pDF/8l
	xLEbMkZibALMmSzjyDxyaghhr8cbNWgM74rJjfWNMVIUDE15RbGBm2szRnXgpdLgMZuMcT/5gtB
	BTPh3MwMuVGwjxIJDijk/i5eSgMFx+Ihm7TNGudsdRnq7Nw+8WZL/lyFznyZ/ek9aLOgfdcAenP
	GR1vsfIUUXaHR6EeLD7ZZsZoUINj5JKB3ANMEP6RtxsGgK7UO492GYpxKuKc1rTbZj1E4dXYCyA
	qpQWO58DklFjzjNzel6yczRILMgW8vtnfF3IOxSybwN0yKpg/AgzP1+5svXnOVZ2kgDO+plpTXt
	ecmwSRQuvNd4AZXigKS/FpXpxdv5ebRty948y+AGQwUVAt1mCAukZe14jprXIEnMv2b/xHH0ZHy
	0H323pCNuZyw/aJ1A==
X-Received: by 2002:a2e:be1a:0:b0:38d:e220:8dc2 with SMTP id 38308e7fff4ca-38ec7adb720mr71809041fa.20.1776864507102;
        Wed, 22 Apr 2026 06:28:27 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:727:24c4:8ea5:6d98:549c:1687? ([2a00:1fa0:727:24c4:8ea5:6d98:549c:1687])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f5119sm33473551fa.2.2026.04.22.06.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:28:26 -0700 (PDT)
Message-ID: <e62e3f14-c1fe-45bc-ae9e-760058dfca1d@gmail.com>
Date: Wed, 22 Apr 2026 16:28:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: ingenic-adc: refactor
 ingenic_adc_read_chan_info_raw()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Felipe Ribeiro de Souza <felipers@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 nuno.sa@analog.com, paul@crapouillou.net,
 Lucas Ivars Cadima Ciziks <lucas@ciziks.com>, linux-iio@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20260421221629.70401-1-felipers@ime.usp.br>
 <20260421221629.70401-2-felipers@ime.usp.br>
 <aeiJo3RCKFLEGLEt@ashevche-desk.local>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <aeiJo3RCKFLEGLEt@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 11:41 AM, Andy Shevchenko wrote:
[...]

>> Extract the sample logic from ingenic_adc_read_chan_info_raw() into
>> a new helper function ingenic_adc_read_chan_locked() to improve code
>> readability and modularity.
>>
>> The helper handles the mutex-protected section for sampling channels,
>> while the main function manages clock enabling/disabling.
> 
> ...
> 
>> +static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
>> +					  struct iio_chan_spec const *chan,
>> +					  int *val)
>> +{
>> +	int ret;
>> +	struct ingenic_adc *adc = iio_priv(iio_dev);
> 
> Please, keep it as in reversed xmas tree order.
> 
>> +	ret = clk_enable(adc->clk);
> 
>> +
> 
> Redundant blank line.

   Yep.

> 
>> +	if (ret) {
>> +		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
>> +			ret);
> 
> Make it a single line. It's fine to go a bit over 80 for readability purposes.

   And BTW the new checkpatch limit is 100 columns. :-)

[...]

MBR, Sergey

