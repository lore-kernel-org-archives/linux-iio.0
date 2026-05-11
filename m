Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44F3FE65C
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510822; cv=none; b=aTvyZepXzJibWhXJP6QUJecrg9L5WpPv/uDd7Mlis5tTt9AzCWut9YWIP41RAV8Ej7Kbvfl/QwaHwI1KZbMqnQ31139VRz6aCPt930NoNny6yzPGv0tfTFrlJqC7aNisIn82yNCTQgtqtcYc2YQFNmngrHUoSiO7WOlEnriORuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510822; c=relaxed/simple;
	bh=SICTXImZa4mMy4Kgs5BlhwJ8zVJUierNkIzSeoAS2I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dxo23DCkwxzHXPnwz5/bzYCrBGGzCY6fSH7G3sETvTluS/ihoQgzGEG4b+AHSdbJdfDDs7NIazfmsK7CJ+3wiFRnADDj1FZgMqd5r7ijHSnX5M1c0y3g1ePO+8JKtePjgxccUrpasovvwy8hhBv/WZKe3GogI2an5XI/vMoWIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pUfBrgRJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pUfBrgRJ"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463f00cda04so2389473b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778510819; x=1779115619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEELPpISKPMY3OnOVJz/i6LMwFlmgDNP8fOvagl4Uf4=;
        b=pUfBrgRJ+2elUdz0lvJ9Tads7hP5t9qy/4AVVBeZ7Z0meOn48JThSLiseM0PsfCno6
         fD2VQQNCHA9Bxp5gZyRFoiNDrhxvcVUVbNucl7SrI1CmJ1VSnH3R1jWneZlTEkiO/t+k
         KqijGSbF+EVBZEjQ+BURzFJnLfFBf8nseJ+pKVExSKeBxsPSElgt00AgzWnzgEigHrIA
         KLoroSfK5abQMAbOfiu9LaGbBXOjweFxmjYfXAk+SPNMLBAvcZJV5Ouu6zJCFIiQ/F6x
         QUfeBnb+qMh3T0UYCKL51QJFe2oJt8aebs8h/wZwJd2GF8zb/2gsjLJCqY6aD1rxW/6i
         G0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510819; x=1779115619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEELPpISKPMY3OnOVJz/i6LMwFlmgDNP8fOvagl4Uf4=;
        b=U9I72LhOuqYTzi7cHLLCLpV5eAoj2jq/MPOb2X3X/wHKqBPsM3fwW9IduoMSMy+vi6
         IVOlYaUzKVPQJjKsVfeXEZgxPpXrKJhNWt0tfUcARjPEQCeBw645aHzYrsGH4eYJc00u
         VQ4B86+ZW2ijdL6wYL//rxG4LAhk3KlowCdVQmPusib/QdqtCCub+NF0dWArXoorOfxu
         dvTqRcdJjZBrVwYjRZO6uTgZGow0AG/gMV6UszrbqjNR/TRNZRwwiiB+/qZ8Weha8UG4
         nKcE4JGOcPsvc/nYhZYBQdHhDnbduwUoYh/e6m9/gVjUF8m9iydJU2HMBE8OPo9a2qGJ
         54hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gzGqemZnrFfYaSX00eBXZwKuiivhJl0dHs9tttv/UY9Tcj7RAGN1qUEavdi4Qo4TD4mqZKrxnfUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGD8Cxql/ptslNOqE8+vBasRfWQe039yDH1lXAGLgJk5I9UQkD
	3F1V2uwrg4x87jjHKW653E55PYyv+zQ+ukaAU0d9OXA+eIweD9HwW8peEosL1Uv7pPw=
X-Gm-Gg: Acq92OGYdSdNCf9uZoeK4MB5qNGB+xGvJEdyOhuOaVZMOqObYKfU90QuFjKNKH6MgKz
	JdgFhOpD9lCs9U885xLbyrr8Ew1Z5QJK31/55TIBNii+z/2ty7N6JbONuneCrhFbxmIRPm10hyt
	keH4ogQEcCB3+JDgbupDzhtmtvWkzQleeIGOB70oFbn6zZSE2F6uXJ/D+yKWaIxSRD0rjcKdQqU
	N+a7gqsHhmut1XPc0kpiobujAdiF/o2V9y+ihr3QK1faUU2CmDvAE7fppfF4pFLvYmmh5q7eO6R
	tD4jMlPUccuoZ6F+QBg+lcOkDOjwCbLceon70Ly1x/fotfxQLyFPoPs9hnwBNnRWe2PBPrf4DuH
	HN5Zjv31A8/0nfnuK/trnHC9VN87gOWSFaH6Cs0zaTOQHyZgP5PTalDKPvHcCDUG6elKTSSAmnO
	0DFhG/jMRPPeInj8Jx3tPwdGWeQcyACwC/xlK9HCOYhtxkLgmFX3T2zD0lvrWCnZACuseQnQ5oP
	FS3+eGjwg==
X-Received: by 2002:a05:6808:e40a:b0:467:1212:46eb with SMTP id 5614622812f47-4804249c60dmr10483498b6e.35.1778510819130;
        Mon, 11 May 2026 07:46:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:591:4577:3439:3a1e? ([2600:8803:e7e4:500:591:4577:3439:3a1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be2238sm6968520a34.6.2026.05.11.07.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:46:58 -0700 (PDT)
Message-ID: <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
Date: Mon, 11 May 2026 09:46:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
 <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 4:30 AM, Rodrigo Alencar wrote:
> On 26/05/09 06:42PM, David Lechner wrote:
>> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>
>>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
>>> DDS modes, attributes and ABI usage examples.
> 
> ...
> 
>>> +       must be a power of 2.
>>> +
>>> +   * - ``frequency_offset``
>>> +     - Hz
>>> +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
>>> +
>>> +   * - ``phase_offset``
>>> +     - rad
>>> +     - Base phase for polar modulation. Lower 8 bits of POW register.
>>> +       Range :math:`[0, 2\pi/256)`.
>>> +
>>> +   * - ``scale_offset``
>>> +     - fractional
>>> +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
>>> +       Range :math:`[0, 1/256)`.
>>> +
>>
>> I guess there was some discussion on these attributes. I see some of these in the
>> ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
>> me from the documentation here what they actually do though. I guess they are
>> just basic transformations on the input signal?
> 
> Not sure how the ABI is not clear:
> 
> 	For a channel that allows amplitude control through buffers, this
> 	represents the value for a base amplitude scale. The actual output
> 	amplitude scale is a result with the sum of this value.
> 
> So yes, it is a basic transformation.

I didn't have time to read the ABI docs yet. For scale_offset though,
how is that different from the existing offset attribute?

> 
>>
>> And a practical note, they should be "frequencyscale". I don't like that it is
>> harder to read, but it is easier for a machine to parse.
> 
> Parsers like the ones in libiio is not having problems with that.
> 
>>> +Usage examples
>>> +^^^^^^^^^^^^^^
>>> +
>>> +Set parallel port frequency modulation with a scale of 16 and a 50 MHz
>>> +offset:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +  echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_scale
>>> +  echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_offset
>>> +
>>> +Digital ramp generator (DRG)
>>> +----------------------------
>>> +
>>> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
>>> +hardware. It is controlled through three channels: a parent control channel
>>> +(``digital_ramp_generator``) and two child ramp channels
>>> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
>>> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
>>> +sets the destination to frequency.
>>
>> Would it be better to say that the destination is set when the the
>> value is non-zero? Otherwise, how would one change the destination
>> once set?
> 
> Destination is only one, so you just need to write phase or phase_roc, if you want
> to target phase then. Does that not sound intuitive?

I was thinking about if you needed to change the configuration.
If you set it to phase, then want to change it to frequency, how
could you do that if 0 is a valid value for phase?

Also how could you know which is selected by reading back the
values if 0 is a valid value?

> 
> Zero is a valid value to be written.
> 
>>
