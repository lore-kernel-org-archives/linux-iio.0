Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5002E5B2A
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810027; cv=none; b=Oirp/jDzxPkVFAATtX9pb2pMBTbHGVlUsicySoSLgt3hmuv6HlkhuawB6feoMGPV+lQI1By3TLmbmhXEshu+tIt5Gi4ov1HktW1RZsM7STgRrLMjmdCHriEAO7v6bmco0fv7zqQHQWErqzJQu77S5F+Dw31SszZP2jyMdw/lIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810027; c=relaxed/simple;
	bh=ws38jNJ/EKJMzjgt5yTRqqlpclmC8suspuO9Lro4JNI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kQvTThi/diavaBwk+rKPlCgJ8N2hNVo63NoXzlkzIgUtR8OdynSt3fSEN+7u34tchZ9RYj7e2oTN3P+ByPmmkPOfvfWtzjx0NPJyQathqBjrUKaJhUqZZgCYX5sZsYuaH8ErPOyeYMbgofOvV2nKZqgerT7Xid4irlbpLFvjFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A70E2Phe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A70E2Phe"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c801b30188dso174100a12.3
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810026; x=1778414826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dXVoVASb/STmIjlJBKGmGSoe2gLnIU28O+1SSlhiQLk=;
        b=A70E2PheC13C7yYL3ARtATKs1wevg2nxBRc5YT3VEHW3bQlvg36ocAnHLTu6fXl8BE
         j3KN1JQoQUTe1ETctvp2d5vFUJ+38BdZoYz74Oa3Hir5o1QOyF1UgbrEe2UDUmcc+jKZ
         nSAITswfWPVQu119pa1rbFhTnDwjrwY1wumH5xcpnK+/bqrY3kHwKRSJGZidxATK9KiT
         QgN+JADCysLnFo/q9Dfdt7ElFWkkHH9rm94J4wD006OZbKWSbBav5/hMJE352WUIvdD/
         xApCNowTaWNey9jal1aOW66fQybvhtNM6VMpnJ1Ndv50OzFbQHRoijCleNfd9XHVgfGf
         Ju3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810026; x=1778414826;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXVoVASb/STmIjlJBKGmGSoe2gLnIU28O+1SSlhiQLk=;
        b=V69HC9B1Ga5JgyUev7S+vrv8A93ZsaOmPTrM5ZImdIwRTRkE7FzuxzOvBu9BDt0XwK
         NdRk3LJmQ9TJtBxojii0jqPcW310piC/bZtYhrLjRhJttOz0zo5yl8DaUAqp9yvl14MY
         jDiu+zYvwT3kG4IQxHEp6xOcDbL5NNR6jiRsZD3hfTJ0BRbcB6YhJW8p33nmz93AVXL/
         qaDkbdw493tvo95CjttK0gIAIwvqIsosxlrS7XbuxsYkhWL132yc9Jr/t+1cajJtEaA7
         SFtfVkA/V4zS+armfmVsXVF3Fpntjtu8ZPcH9BN4QjUDm8EOVmPiPAibCm3rJQ96R7rp
         vgrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uEDTIiNBZn8fkoQlGJzwUoPCIupt0F0TnqpKAsVpzeYSF3KbiGXigY+Jh5L2lTjf6sf8BEbqNYyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqQ77qsVFuwcpQ4sPm4I2NSn18Uemy9KoRrqZbG7D0D+idWRh
	OTZ91kxn4/uzIs5hPt+s+dPZkJdSbhgOlM4PA+hta/OS1D5Cs517gDn2
X-Gm-Gg: AeBDietsADVKZeBjGgZtMDU4nGN8eDPz8Az7wDPcxJPZ3U4bZCsNoKGwIAVd2SrWeIc
	Vguc3BFLFCAZb31roaCa8oFMcThFNiw0aLVADEd+RNEM25/DPUPH2VWZpUwnSZlKPiUWROl8iwV
	5GXpJiSVVF+hKRjubPukU0UjJYEPWABwrHyXAzKKAO0/q1z17dOUsAhbY2WWZOnJonSDQ/V2KkM
	VS8VGl2VU7Vpw15/EFvpSKjLlSFi1QQOFCfvAQ6OjFvur5BxQ6Hr+qQISZMARpKQL+K2Pwr6TZr
	dzQ4HHBt9tXDYDWFbOOXtKEH3tKbWQc2v97uGi6OqtMn3zxplqVo+WdKdaVUDH6dn14CLJPr5Rb
	aWqb83VXpJ67NKp0bGLsGrA1D8KjGOMuHxRAvNkqyNJ9hMqseWHYTWYjgczOYVsehfxGA3FVKbv
	lZ6lz60ULnJQZHkFKJ1X0aLlhbavtlkrPvCWGqN9snmBa3zt5BDJFxvbs=
X-Received: by 2002:a17:903:22c1:b0:2b9:493f:61bc with SMTP id d9443c01a7336-2b9f2829c33mr57360035ad.38.1777810025738;
        Sun, 03 May 2026 05:07:05 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c032:ba9d:4953:28:24e7:1e48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3afdasm74320135ad.62.2026.05.03.05.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 05:07:05 -0700 (PDT)
Date: Sun, 03 May 2026 17:36:55 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/9] iio: ssp_sensors: use local struct device
User-Agent: Thunderbird for Android
In-Reply-To: <ae8ZvFokn8EoQMQa@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-6-sanjayembedded@gmail.com> <20260426151651.48a690c9@jic23-huawei> <ae8ZvFokn8EoQMQa@ashevche-desk.local>
Message-ID: <BD0BFEDC-AECC-4972-8515-86289CAD5CE8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27 April 2026 1:39:32=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Sun, Apr 26, 2026 at 03:16:51PM +0100, Jonathan Cameron wrote:
>> On Sun, 26 Apr 2026 14:47:06 +0530
>> Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>=2E=2E=2E
>
>> > Introduce a struct device *dev derived from &spi->dev to improve
>> > readability and reorder variable(s) to follow reversed xmas tree styl=
e=2E
>> It's really minor reordering but generally I'd not do that in a patch
>> that does anything else=2E  So here I'd have put the new variables
>> in as close to correct location as possible, then followed with
>> a reorder if it was worth the churn that results=2E I'm not sure it is
>> in this particular case=2E
>
>+1=2E And ideally that 'i' has to be converted to unsigned type=2E

Thank you Jonathan and Andy for review=2E

I will keep this change specific to dev and drop redundant probe failure l=
og=2E

Also, as a follow-up change will do re-order variables and have unsigned t=
ype change=2E

>
