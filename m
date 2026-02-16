Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDA15B971
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231769; cv=none; b=Vv/ne3zGR1x4rM+IlQ0bN+wWcuBf7us+GsS1d3U/tIzwpTW5GdrRqrsjRlg+mx3zbQs78B77tlmaHrWVk3HKqbpiV5hDZxEy2MwppxzLIg+S1TW8bgckWXGaqIKmyRg/+7ctS97wP0TZoaoLHWTtyXi9A66eHi0bvz437TetAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231769; c=relaxed/simple;
	bh=Cor7HsK/95P9OYmVQKxPiJef714zcnB5NS684TqAKxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z55rM5F5JWXWCwg83nQ95AefIcM1iPVrBFJmmDw7/MU5FA6E56mvyLyEA7IR+moKKkZhoWK7hOOLQQS981kMyxubNGk3oZaSRyjReZ7O/X5voAOuofbAhXF471768HdGoszVWzMrq3TGYk5lBfXT7lKtctDXEHH1tKJ9fU5FN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUWReXlZ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUWReXlZ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649db2b6cdcso2637749d50.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771231767; x=1771836567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9irwRjIXxjBxq0jphi8rRViE/s08XJdmfQTbJogTpQ=;
        b=IUWReXlZsgayFGCytaQv6kiJkpaZgKajLEP4OE7FtmfUSQJQ6lkhqMlis/N/rPA4YZ
         epygi/FmQYA6sj6Dlb/yCnEY0uF00zDJblMpxmtmOw+6+46sDOdspWku0k+d9LH1wQtf
         jy8haGmS43Pub1NDmNgwsJI/boVPdLywO5bFSBrXiRXHNsP0Z/gGFH2jZRrgLxoAxk/P
         pftUkAsI9wUb2y25TwN/UQLpGVHS9pihoXFSsQbZPGpROAbhWEKPs14c2xEyQjkiVufO
         +gPQ18PA53FhfCDgP+R/g3p4IPncqnZon4lyTF3BglSPTes7x8M3GR98qOMDKhrOGnGl
         D9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771231767; x=1771836567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9irwRjIXxjBxq0jphi8rRViE/s08XJdmfQTbJogTpQ=;
        b=LcXUd9+UnwhPXLF7NiDR71fWt2/ua1LA3hg2lGeZrdwq1xl/YkKDSqpxD1hW2O37Il
         yR6Pd4gxyf0YocnNn/ifqR/63do/bhOpj+ES2iK1MzQqp67Z80gXVR8J8HhWPcy0x8B2
         IRrxtfhLXo9KpUf9DC4hwe0vs/xD9MtkjwtfwOG3yBLCoRVVHGjE937KPS0rEOEHTWjC
         j7uP48wEWlZWLW8XPtGNGKEGxiVzu+8XfhuJstg+PjQcADqXldaC14FFd6xalL/Qlka8
         a+f4NIm51AYUS2CM5+tFImjfLW/Ihoa8ax6gJfOe4KytWJ4CQOZUyMfb8Y4GDnrelON1
         7O2g==
X-Forwarded-Encrypted: i=1; AJvYcCU+Wno5kv3baFp8eQn6H5nkwDr8PMg3SY7w2LYv+OltkklR7n0jzq9K8LAv0rVpgzbGKOij5WBdnZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuUG1bQAD66CB1x8zgvgC8NfY/LY5KwpjxOkmGUADwB7ssHo1
	PvBfAty+Orw2FtEXWqU36Je0s1Id114x9whsST7hFKZ8/SIDomiu+WSv
X-Gm-Gg: AZuq6aJ6N09ZzOZFEp3VeHb8NAKo+2vCTIoz8IxDzrGSF3kX3kjBRNqwYYKX5ygxxBe
	kXKcYaufdTUGyDCiDrdW+fLzWmYH8OGHTNRW+AlJHgPVsHqgRIWDhScQA4jDrTD57PBoTXdnbsI
	a92k8+uqHDj7pAHOzuez1yQ5hYtzcxG7kz5AbhH+XGVLVbIzFwWJ8s22c2wpmRSN68EAScaohFN
	Ad5L8mODQiAjux3L2GqrcdL1GLeo/worFrs0w3IvSjF+4gZSlmTi8TqeFfl2unUiynvOlBu1Qku
	7CaztslidkaX6UpFFjObzO6uzxQSiVbl4a0BsIIRbC9dcZFJfgrn9E6kpZ3684WhWWCrl3sagfE
	roXNZttaPzPh4vO1ocaI0qo9UgyCiDXqER8S4D1lSL+VXz+WcGQNJiAxnnIcmnAnhk/QnAXA44D
	9BkRK/t2oDOGvb/VIFlYx7ddaRMru6yhPocJXr
X-Received: by 2002:a05:690e:190a:b0:649:bdfa:6338 with SMTP id 956f58d0204a3-64c21a99bbemr5363181d50.35.1771231767487;
        Mon, 16 Feb 2026 00:49:27 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fd6f36sm3122687d50.21.2026.02.16.00.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 00:49:27 -0800 (PST)
Message-ID: <8b539c02-9b39-4451-bc00-2af23d43578d@gmail.com>
Date: Mon, 16 Feb 2026 10:49:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: Krzysztof Kozlowski <krzk@kernel.org>,
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
 <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
 <20260213-unyielding-pistachio-ape-deda74@quoll>
 <3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
 <8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
 <f014078c-6e4d-48b0-a814-45898b005c44@gmail.com>
 <880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
 <eea4cf8c-4126-49a8-ada8-1b1893a406c2@gmail.com>
 <1326c41d-e4cf-493e-a758-364edaddd04f@kernel.org>
Content-Language: en-US
From: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <1326c41d-e4cf-493e-a758-364edaddd04f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/26 9:27 AM, Krzysztof Kozlowski wrote:
> On 15/02/2026 17:16, Erikas Bitovtas wrote:
>>> But CM36686 is fully compatible with CM36672P, right?
>>>
>>> So this would make sense?
>>>
>>>       - items:
>>>           - const: capella,cm36686
>>>           - const: vishay,vcnl4040
>>>           - const: capella,cm36686p
>>>
>>>
>> If you try to use CM36686 compatible for CM36672P, proximity channels
>> will work, but in_illuminance_raw will return 0 and changing illuminance
>> parameters will have no effect. That is because CM36672P is a proximity
>> sensor only and the register fields for ambient light are reserved.
>> And if you try to use CM36672P compatible with CM36686, it will work,
>> but only proximity channel will be available, even though CM36686 also
>> can sense light.
> 
> So clearly CM36672P is the superset and should be used with CM36686
> fallback.
> 
> Lack of the fallback how the patch is written now is a mistake.
> 

Is it not the other way around? CM36686 compatible fully supports
CM36672P, but CM36672P does not fully support CM36686. This would make
CM36672P a subset of CM36686, because CM36672P is the proximity sensor,
and CM36686 is proximity and ambient light sensor, and therefore, a
superset of CM36672P.
