Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32F3ED118
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081749; cv=none; b=I3mcXvlkCMfUhdkje4njjjLIzeLah2254veL9Uuy1HW6O0ADQXxUfQuLH8jxJlS0WbVRAjQLWt0i4fwgq18cATE63lre5Zw6d66Q7EUZpKEJWFFEe8D/UzmP6dn2RHB9GXw41kdB94XgJYxt0rCprEMp2SD2n5Fq8rVbP60YrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081749; c=relaxed/simple;
	bh=uerMeSSQ3acxmOZMeTOC3qPnNJjEqmCZDN82K86gjYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDrxqkFSC188V0nZzLbQFSA9j15Ifs3M3gPCOcILkyN51EWd/JQFtO69yyCxY9Jmwij6kEluRzwjbvXtWL6GQ3qB6ULzEGuigMR2lsKV8etsrm3WMBFRBJJkjlln53sVn8bfmTlH0L2J7+m/M44fOKE59ENLb8IgXnXG4VBgDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pz7xICXj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz7xICXj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bc177ebda91so684090166b.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778081744; x=1778686544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Nckv/LuldqfEBJSIft5ijwXQ8LBQOLvQF7H6CHlTT8=;
        b=pz7xICXj860TLar41rDp+a7GJXrnJOLw5JZ9tqDPmht1/6n38o4nWxz3cSXrN+IYNa
         pMLNKlPRyANBvJ5MacGZ4WlDxUkIykMA/WvqMGX6tJYx+9WrjRtrDz1KtxkhUeBAjvqn
         OyGII5t6W2mb6jgqUNRei47axhXAYXzp/8BnCcKbq1dNSFEZn491BMSrwzPrewc0ShzJ
         y8ZB/U1I/x3YLNvBNZ9B93FHifWl+vV872bdQ2t+yTsEQ29JEY/UQ49ucHkNmMx4MFiE
         6qi78KIgkwuB5zmaUVLVINHv/Sx2gaaLbGPTURgG6oKI3IO5RS+qRXnWnQ2Mw1kNScfV
         huTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081744; x=1778686544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nckv/LuldqfEBJSIft5ijwXQ8LBQOLvQF7H6CHlTT8=;
        b=dKx0OdFOF3jQx7JHnADwfdMe5H9eZTDa1MTVAy6NAgRfKhSZePI7XPBMcJmhjBiDTt
         VR7YwO4FH/8HAq5gcBOIUf8S8dicGYtBY+OAUouhHpsWiYkV9Jys3rEwjQO3U99iN4f3
         Gc8mppnYP7Fy7H0+nVv3qBVL449FM+cD21WjCU+LN1n0zsafZwOnLtqUmMRqZiUvPygh
         cd8Y909GGPXuKwNM8NBDL0W3hWpjM8AreddThWjARPzrfdbZt+schp0beZNJjH967RSu
         aR7h+qClxrL137y2el+0qhBqlNKb21KMp2i3HyyFyZYCU0rZ/yHxi+aLQrr8rXWm0PLH
         GSSw==
X-Forwarded-Encrypted: i=1; AFNElJ+gQFQpIrZFyE5IVSUPJe3nPukr66FwpAwmHz8h2ZPhS+FsWzw+ZDrgP3fXcu55S6nrxXc9+sZ8L04=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZmAs3zWE1HkDHdFfCIKTBe25PP6PaVsTPBE+ZBbyuMmgQVbi
	c7CX6Cn4vXVwNf2u/J3+T9oabO3+FfssqqIT/oscCWDhH+cB/eKVVOD0KsfSlA==
X-Gm-Gg: AeBDievvVQ7JQNCUAMx1S7HYw81bnCTDjvXUYZ2qLVnpZe1z7CFQBRNguiuy+8hAgVn
	c/lO/dBmoqwB8PX8WMEZoq2Qirpmv5h4A/PC56cM00rsDrmTMg5STRp3IPzIp2ogorLp/PJay2J
	MV4jLawvE46PX61fj8sjsepeT7egW/sqdgmp4nOoCWgxQXzzf3nNXPqVZw3PF+ESzIpQiDjW4rF
	BcygYFllNrq24xhG8vfPfrj8ONDJ6wmjd+A8Y08Y67v556fNQg71iPa2jiw1IreZxM1pI6NdBmV
	9ET2LYYBqqw4tgFXEJ//SqnISwjVCcsp2bhcf8ujRm58K5giKa2h1U0rOjocjo+xC/t4WfedpbJ
	yvhydbB6NlCyqoh7wLtmEtcGmtpXUj7B789lskJZkw+WmOfzsgDzmMtmuUXq/fNg/NiP4gB/o4N
	xhCLc2R+MNZQC16kRhp5VNuZRxdRE3mMVEi7OQvDGG
X-Received: by 2002:a17:907:3e0c:b0:bc6:1550:ec56 with SMTP id a640c23a62f3a-bc61550ed0amr134372466b.39.1778081743850;
        Wed, 06 May 2026 08:35:43 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55f00d170sm96974666b.49.2026.05.06.08.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:35:43 -0700 (PDT)
Message-ID: <16c08754-840f-440e-a252-b14172393394@gmail.com>
Date: Wed, 6 May 2026 17:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: light: tcs3472: devm conversion, wait time,
 locking cleanup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <afsWI3MKoWZS4mL3@ashevche-desk.local>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <afsWI3MKoWZS4mL3@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/26 12:21, Andy Shevchenko wrote:
> On Wed, May 06, 2026 at 11:43:08AM +0200, Aldo Conte wrote:
>> This series of changes modernizes the tcs3472 driver by completing the
>> devm conversion and updating the locking style to use an automatic
>> guard (mutex). Furthermore, it implement control of the WAIT state,
>> resolving a TODO.
>>
>> Patch1: Converts the driver to use device-managed resource allocation.
>> This removes the need for an explicit remove() callback, since cleanup
>> is now handled automatically. It also adds a new function called
>> tcs3472_powerdown_action() that powers down the chip when the driver is
>> unloaded, removed or when probe fails after the chip has been enabled.
>>
>> Patch2: adds support for the wait time resolving the old TODO comment.
>> The user can control the WTIME indirectly by writing to the
>> sampling_frequency attribute. Changing the sampling
>> frequency attribute results in a change to the wtime while preserving
>> the current integration time.
>> Similarly, if the user has previously set a sampling frequency and
>> then changes the integration time, the driver re-computes WTIME so the
>> previous frequency is preserved. The patch also handles the deactivation
>> of wtime when the requested frequency is very high, as well as the
>> extension of wtime to its maximum values (by enabling the use of WLONG)
>> when the requested frequency is very low.
>>
>> Patch3: converts the remaining mutex_lock()/mutex_unlock() pairs to
>> guard(mutex).
>>
>> All patches have been tested on a Raspberry Pi 3B with a TCS3472
>> connected to I2C-1 at address 0x29. Sampling frequency and integration
>> time changes have been exercised checking the value of WTIME and
>> consequently WEN and WLONG. Raw RGBC reads, calibscale, integration_time
>> and threshold events continue to work as before.
> 
> Thanks for contribution, unfortunately this series needs much more work
> and more preparatory patches as well. I have reviewed the current series.
> Please, follow and address (or comment why it can't be done as suggested).
> 
Hi Andy,

Thanks a lot for the detailed review. I'll address all the points in v2.

Regarding the series structure, I need to clarify the correct order:
1) Guard (mutex) conversion
2) Header sorting
3) Devm conversion (with the new TCS3472_Powerdown using Guard (mutex) 
directly)
4) Wait time implementation
Would this be OK?

Aldo
