Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30803426ED4
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516652; cv=none; b=c3ifbbusbvsXmMJx8YKKp3ErJQuAGlFb+L2+uGOl80zKa0Yo94g/j7uJqsZSkHZXVqZ12b+SeHJ6YY0es7yVSubTCK4TmZtyc8KxIJN/P2G/4Srqmb1p7e5webD/25FwsyTYp+S8q/uqU8+aYn0SR720qhPw2OZ0bqE8yVGA+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516652; c=relaxed/simple;
	bh=4OQTAqTxlFENdvERXoD2aSmqA+TiRfec4EPy8zG8gCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9tmW/uC4HozUM2JKUGHHKDfJLgBFqQh79qdivsBgsBQnrN07WgIc2PQ1Z2i+3TupyJlS6s8aZ1RmPeOrX6CQ8tKonpt1TD89AUY+9DU1ct/np5gGwxgW9ULMS6m+jp/R+7rJFW01F8t08pM9yqalONAj2YF0I27gqYY1TZwJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pNAUTsOE; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pNAUTsOE"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4824176bbbeso978662b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778516649; x=1779121449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRJlnjgoFe7mDl6//dS8Gjps/w53SHPBrqnYZwHQd9U=;
        b=pNAUTsOEgRkt7Q6svAuvxDRbx+u6LfPovstl3KWbiW6rug4DMuZDwyzucAZ4NLM+i0
         QLy2AXI5h0TgNxlkFBgm4qIwdlX/tvzh/L1y2ZBbwtKanjH6w5PN9akDy0m82KHcawwf
         dHMouc/Kn4dNatVyfH+qia/WoLJ4hI7qw0nGKMvufOg9BCA/zysPZQSoajehIOv+7Y01
         TF9enkJwhKZXVLRgbjGLHaCNWkT3RWh/fV/EoY1QGlgflPArPhcH3YttnL5vU4jl2BbN
         KEhqf0NpzOjSUJR5Z6Hgdp69eclk+uzLpzood1gqbGUhPhmOg8T6NRdsB3QpJW/PREoP
         6L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516649; x=1779121449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRJlnjgoFe7mDl6//dS8Gjps/w53SHPBrqnYZwHQd9U=;
        b=VSi7cJWT3jJDEXRz/F27w3IwaXmrvO8Jw2hzjOQVdSNsQdsvbCo+SN0lC5bhKhnc6l
         ZvMDM1SaGWpXwu/PsNLqOD9H/liu07zqnQHKKV8yyV+n94hz7tqwV9NWOqIxmzC8hmAs
         C7rVbkqlcx4+1i46x8eAfJHBZjF4lpm+Q6auC9RxPVusEhCiZHU/kREPqHdpE9pQoHdx
         rlCWNtPgtCaKHuqzsFCzjRnET0s6c2qhdskpFaRV8sEI2a2k7a3J2Ws+z5scc6JjJ4bt
         8DlC7OthEYEac9xWemg3Rrk7xrrqR7j5JTCQTRty845YUS/42ZXPdPF+dJ7S9KaE7NoJ
         TIqw==
X-Forwarded-Encrypted: i=1; AFNElJ/U2MIECR3pky5H+ENxh2VSYYGDaJDaLVWjlSzO/hFchh7L69I6KoowKqRDj/KcMIIZexAbqmRgxmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMseSwx4ZYOiNsuIUQGPHhU2Fb+Zz5l2xKUG82lMouV0PThKP2
	/AifRMPcxUbPd/nDJRVzWfRvA6h254CTvij8D9LwAql88S844sqm+sfc7nUWkF+q0jE=
X-Gm-Gg: Acq92OHBlmtKYDPG+mAwQj0Prn3sfJ/cOBlkfYvj8Z8FTGOwaOlQcc2jf+E/MGK3PbG
	BjtYCUX4yomGUV4pJ66iJZI5ya7alxVs9c4mp5+H6eNOSUrqlN4z82/imS3Z+ZLuIz0jACTk1k/
	8dhhqFMDEcOF4Eq8Xh44N5vE0cd1bg/3sSRy8BZLHI3n0Ke63hUkCqmkKcYKviDlGJMN2h56VeF
	QiVCk3dlZ6nfgdL3yDE/LF703uHPQRT4VkhCdO2PWVXYotnFg7QO88RPh3IUCZGdGmqoOwuPRbP
	L+RB9Rs26xBvN8Xg4QJIGrZ35LWO4PIITnD842ZFx+bkT5Tq9znM2DdqIihx5EczOXYdfU/PXTJ
	PbinHkK6orFFAFoy5Ljl4aYJXFl56Mwp5vhyTMSAwO0+Ezbl3SFaZhNQCyG4EL31fWa+NGjFTAw
	MwktX8UzDiuPlyPrFitcROSG7R5tao3AIGbU7x7U3UoSI6/g9yjKNcWMEQYeTn2cQ4++2Aljg=
X-Received: by 2002:a05:6808:e656:b0:467:2a6e:adad with SMTP id 5614622812f47-4804220b8b9mr10538869b6e.11.1778516648981;
        Mon, 11 May 2026 09:24:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:591:4577:3439:3a1e? ([2600:8803:e7e4:500:591:4577:3439:3a1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e66sm7104662a34.8.2026.05.11.09.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:24:08 -0700 (PDT)
Message-ID: <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com>
Date: Mon, 11 May 2026 11:24:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com>
 <20260511171554.6541042b@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260511171554.6541042b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 11:15 AM, Jonathan Cameron wrote:
> On Sun, 10 May 2026 08:01:36 -0400
> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
> 
>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>> from the legacy plain-text format to a YAML schema, enabling automated
>> validation with dt-schema.
>>
>> The new binding covers the same hardware and compatible strings:
>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>
>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> Hi Pramod,
> 
> Something went wrong with your sending of v3. I have two versions sent
> half a day apart and no idea how they are related.
> 
> Anyhow one of them got feedback from Rob's bot so I'll assume we are
> getting a v4 and wait for that.
> 
> Jonathan

I think Rob will have to fix the bot to make an exception for the
legacy bindings. This should have been called out in the commit message
as requested in a previous revision.

https://lore.kernel.org/linux-iio/20260220053941.611415-6-sai.krishna.potthuri@amd.com/

