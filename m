Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE943254A5
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089721; cv=none; b=F6EpptsUI3afTthH6+TP01fBRKXszf0qWGZpEJ/al19VKzLKWHh6PPFsQVFv5Pr+zKgbYaLNwkffVzLhv5gLbU8LAygX+nyiuS2lztET8Pljgn0cEAw0NO9ZxSffs5AzuZOe7lxJ/de6Cx830CF/43ysz8BOCuwA5zgMbV3MqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089721; c=relaxed/simple;
	bh=xAxy7fO2YlpiPg7YUBfWrXYpsnJqHkDmbkTaqIyM1LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R91Ex3CGnpnOZYuG3rIGZlCUZuzuvH66+uebOtlYhH02CavUDXzXgZyAkNe4o++SUsrqPZDLwvF+m6qweymTC/Z7EIMhKK8hXsdWXfSioO89Qk7y4/iHW2RovoklVrpfPZZ9E0ICjH1+2NnZg0I3p8Zb4p6/1ZEvwQvFye7vXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX61KUrC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX61KUrC"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso18467021fa.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779089719; x=1779694519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWkpCpQ0FJ7/KTqsrEBZy/g0n+sB4k/74RUvdqaLZAk=;
        b=NX61KUrC1uZro1+RMrqjUnudB6XMDVmlpnlDTVMfCkW5Qeuw0Cz1lOdjnS/GkwSTJH
         jq0/621dHTbHSkA7biYG40w66nIKY1OIFQRxklHP64td0bzSq6nvtm5hKwz59baqtIP0
         oTvn09Poe02Ul4MPwp9xDoV0/iwu2lNPPtDxJFP+eRdes4RxKz+Gp6alJTWudRvN9POr
         K9E94ymI5P0N7vZJ3E7n2Z/j/b8m45NVzYBQjiUueJoGH6mbLS1JkcXDR4mYZT60YViz
         07O3f12+ncZzy4J6ofy80CfjxfFASjaPd0tOWRGvJWMRQVsdumc9OwuJFSX228qu3pLF
         QAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089719; x=1779694519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWkpCpQ0FJ7/KTqsrEBZy/g0n+sB4k/74RUvdqaLZAk=;
        b=IBDxY/ErmfP2Dogw7NHH3HApJgumrm+0SX8xg08AHLSqfFcDuTCoNuNrYkoIF7aAIz
         zBYCEWk6gvb4qiTRrzASlEzPZIuCOpszeV5l0h7fHd/Mm+coa7BBG/x3GepMsUEgGOF2
         /XfEth7X8FCLPpVlj5uPA8T+CZ0aEnmr0ce/FGDeBnRUdNKV41bNLqhFx3TufozMhwJZ
         /ilnaqhTx7nyBd4nKKSws4Dc1sMMY7u6a91QOz6mxJ/i/NECjZOIzzU2HaK1lC2A22Nd
         aIntmwAuCzFBWDcAt0Kts4WiEN4+pbKYpBDkzkFLTF3PSNWUgLizRJj+RbvMfBpSw6F9
         +ynQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5d4vfJI8O3i2ifxXdaJjfv6ztNlh3jXKOXgE1dJ5DUTL8NExJ04ExmB6BGb/mWg8eTvgwQkxm96M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVng0ZyhN2x4z1UQPZszTuROm+5QM+GW5QsEN5jrCBbxRenner
	4TRB72URWE/NdP2rnjxrsPyfZU3bJ0gMS0MufBt+SPrFCjrTIV733Di5
X-Gm-Gg: Acq92OFHPg/nPvohTYijcAGrX21gaJoVYfVxb5kLwt+mdveLxy/IW25sVMoXc1a4r2y
	ZMFcZuEtZ6TWZc14W8nXV4moBYMqISHxYISn50SQaE3wg7BQrWaFVYEQJc4qO6610+pkG5P+XPS
	WK6sR5qRYMyAA3MHK7pumScbPR0NHdFRfvhZVObnCUhwtpi3WI/Co9DJUKoBLPc93HAV6EPiLaD
	+v+CMnoXAfHCK9ZpGLeTYFV9Z2CcI1p4SexiDl9n4T3/PMgeVBoMO+wqcxeg2KPBJsIvDafYtxY
	Rww25sjU/SXF+4fGqySO2dG24WVSk3lreVv7dKr0yuNVViiWpP+/B0kI15LQvOoHZM+XftJN56K
	maks3Ec05BPQXrcyYjnZEs0PPWqRMS5NQmmWzVI4VBWf9XRowFCemt8S/61SPjFeAxhvfECJj1H
	LixG79H6qGVkdHM8kDaVjnRRAyd2Jzs3MH
X-Received: by 2002:a05:651c:1503:b0:393:bffa:d815 with SMTP id 38308e7fff4ca-39561fec6ebmr35018191fa.21.1779089718284;
        Mon, 18 May 2026 00:35:18 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b4064sm9563661fa.33.2026.05.18.00.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 00:35:17 -0700 (PDT)
Message-ID: <11ce9c58-25ef-4c47-b3d6-7d189d3757c6@gmail.com>
Date: Mon, 18 May 2026 10:35:16 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
 <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
 <agq4zER5Tv2LErZV@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <agq4zER5Tv2LErZV@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 09:59, Andy Shevchenko wrote:
> On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:
>> On 17/05/2026 20:12, David Lechner wrote:
>>> On 5/17/26 11:08 AM, Stepan Ionichev wrote:
> 
> ...
> 
>> Maybe it would be better to do something like:
>>
>> void iio_trigger_poll_nested(struct iio_trigger *trig)
>> {
>>          int i;
>>
>>          if (!atomic_read(&trig->use_count)) {
>>                  atomic_set(&trig->use_count,
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> 
> Just in case somebody is going to do that, avoid doing atomic_read() followed
> by atomic_set(). This is typical TOCTOU issue. This should be something like
> atomic_xchg() or atomic_add_return() or something like this in a single atomic
> operation.

Well spotted Andy. This is existing code, so perhaps this should be 
fixed if the logic won't be altered after this discussion.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
