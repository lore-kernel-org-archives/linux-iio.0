Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E427587D
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942964; cv=none; b=dhwCsiSdM67WeWzJy/DB6GE3LbsEOCt5mfPmGGBSs+5p4JdKPGYR489qVKnTTJDV9nCax3IG3dGDkFfaH3g5pxpT5csJ00pOW3GRGIeEEtk8nzSyioSq0cWJUikXq2HjDB4RRC++cw02Op3TuHq/Fq6bzYi2INs2EBA7F7kBYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942964; c=relaxed/simple;
	bh=sXhVfI3NRz3SRrQK02Pgiyri6oNx/XWwv+OBfC562qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpQ2onabZiVgwQ+fDWyAL8Q45uxtj5UgDAWULm3Ysg4L+u4d9QrWUEYU2Jn2S4pVvkrfEbiMMZGue+8eOCRu0LRRgGLn0Q7JuOqDMC/eoRhHj9aywYWrJqITy+F1k/8BbD4rWMYTbt5HHS7D/ASYd4smHq5y6MJ4XbS0N97sw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=MeCkfSOZ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MeCkfSOZ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-484ba8bc89eso198281b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778942961; x=1779547761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAbp4aL3c3GEYP6hWoueO3Z1V0hSEOeuJ7yfKstkuDU=;
        b=MeCkfSOZTSzpGVNQ+WS/nPcuPLJtN12Jgf1Uc2+LK8vadj66HClUwnU2t38++AHy6/
         S/pTEMncVcM36inO2GmuXWlsifIF/4IfX3y3Lc3YlEMkVE3sy9anEBdmCe0fo9QPDkpt
         aA9MIKM2UQ9yxnyImk/Mi16oiDYQMjJNI74m+RNbYMT1GJ+N71CS0/ES48Pf8F2TO9Ks
         B40mV0C3UZEC9gAStZkR3sPCHviHYn62ftlkvJ7APeTTa59oVRft/v8oTfynkbR39p2W
         /Sl23fPHT7pPK1jOYLq6SgXWSiSwbdys91iEHicnzHIgImZ7Q9NrjmGWXn5FzzTQcq5d
         qNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778942961; x=1779547761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAbp4aL3c3GEYP6hWoueO3Z1V0hSEOeuJ7yfKstkuDU=;
        b=HnmcqSgUAIUL3ZDL6LoDl6p2QIdE+esRw5WakwVAkLn6v2iIk/gSjf9XWbHiDRrPHW
         6Noho6MxHCT1HzWW13rCX+/nyP1ikQqdfAawWXLZ3bbHn0UWwWG64ylL+sprwLuGPdPX
         bc33IKKIvUg6ajpRCdjmunwxHM0fmjI15XX4Jc6NnZAvZTkMcTfGnTpIBtPaqIIi5SUa
         El57b5JtrNJqXGBR/LC1lx42KAzrBcjnQ+/gkVNyTPQlYlmOMbi07Lv+RbHPLvbUcjZb
         5+vhSgW2LwFGr5pYJMY3KYr1lx6/CAXuBopeHlRTXVEomBE/X0uSvm97IiM2DZH5UAIn
         mslg==
X-Forwarded-Encrypted: i=1; AFNElJ+22rdGRQjPHi46c/z3e6o4r/YN1NjC7a5oUNkky8+5PsJ2r7Sx0vMREkTZrgn3JdL98i3GjRKKpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeovOA+L7ZhD4IRgza4JC/3BsWo2R2OXv6fWtZA8rB3pgrxYvA
	X7MZbi/0swwcD3sCOMNHYzV0jwtmmYa7013aRn1axv5MfZc42ngBTBgr1+hG+HSd3U0=
X-Gm-Gg: Acq92OEFW/xwvVWjmoO5Ufx53nS0EZfFPGVA1mBrerasS3Dws6zrmGtjrKRTqd2vWFT
	2ilsFP/FGNIl6xxhpC5bQFFCqVRTchj7bAKePiiZ/30q1o1AYV6tpuVcu+x/ZSP8QdUryTHfd1m
	nO9bpXe5iCvxDr7/E/QzoKaaiZkoYAu3JCAj7w6ehpWJorfjsMvhAWnjUCAZ9M/8qceWeAmcd2h
	9yv1BXLH9ZMHR2huA+1ld3Jlw6j4/UGTe9r4GJfUN9uex3/oTV16vEsEjgxHnRQqmBVhGRqOhfw
	d5bRXk49cQvC1l3gjtXlVTGWgUiDTCSDH8qXRW84SSWo66yP+7qo1/hnbETsfUbE0NOj7jYpnDm
	1Xqbqi7oDVBdNSJZxG9uitRyLlcHi8TacnrfGWI/ONqF7+FXKH8wE+AE82yd3Mol4dejyXn4vqB
	PhYyQ4ZgdecsiM0LZk9WvErevS2qL1XSQ/4wwXc3gZEoNwceFuOb+cOzLu3Ofwk1vUBBfyEAyQO
	w==
X-Received: by 2002:a05:6808:1184:b0:467:1941:1f18 with SMTP id 5614622812f47-482e5609434mr5499724b6e.14.1778942961147;
        Sat, 16 May 2026 07:49:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee331f90sm2473535b6e.4.2026.05.16.07.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:49:20 -0700 (PDT)
Message-ID: <09ecad6c-beb5-4b7c-b52c-ac151e6947a2@baylibre.com>
Date: Sat, 16 May 2026 09:49:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: resolver: ad2s1210: notify trigger and clear state
 on fault read error
To: Jonathan Cameron <jic23@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515133138.32319-1-sozdayvek@gmail.com>
 <20260516122838.163a77d3@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260516122838.163a77d3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/26 6:28 AM, Jonathan Cameron wrote:
> On Fri, 15 May 2026 18:31:38 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
> 
>> ad2s1210_trigger_handler() walks several scan-mask branches and uses
>> "goto error_ret" to land on the iio_trigger_notify_done() teardown at
>> the bottom of the function for every I/O error -- except the
>> MOD_CONFIG fault-register read, which uses a bare "return ret":
>>
>> 	if (st->fixed_mode == MOD_CONFIG) {
>> 		unsigned int reg_val;
>>
>> 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
>> 		if (ret < 0)
>> 			return ret;
>> 		...
>> 	}
>>
>> Two problems on that path:
>>
>>   - the handler returns a negative errno where the prototype expects
>>     an irqreturn_t (IRQ_HANDLED / IRQ_NONE), so the caller in the
>>     IIO core sees a value outside the enum;
>>   - iio_trigger_notify_done() is skipped, leaving the trigger
>>     busy-flag set. A single transient SPI/regmap error on the fault
>>     read then wedges the trigger so subsequent samples are dropped
>>     until the consumer is detached.
>>
>> Convert the error path to "goto error_ret" so the failure path goes
>> through the same notify_done() teardown as every other error in the
>> handler.
>>
>> Fixes: f9b9ff95be8c ("iio: resolver: ad2s1210: add support for adi,fixed-mode")
>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> 
> Not related to this as the fix is good, but I was obviously half asleep
> when guard() got added to this function which is full of gotos :(
> 
> If you have time could you look at factoring out helper that basically lifts
> everything before trigger_notify_done() which should not be done with
> the guard held - at least in this case it's not a deadlock source
> as the device doesn't have any triggers!
> 
> That helper can use guard() and do direct returns to simplify the code flow.

I can do that since my name is all over the driver.

> 
> Anyhow, this fix is good so applied and marked for stable.

Reviewed-by: David Lechner <dlechner@baylibre.com>

