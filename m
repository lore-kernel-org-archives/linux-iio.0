Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E740DFC6;
	Sun, 19 Apr 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609051; cv=none; b=p9DoU6+0LzSQeDoVAglT56UR5RZaXQ3FDXbyaTZaIenie+My3lxhTQ7NrkcrCBJDGdc/U9RahXOIev8XJItbMvmNbxHDF44YbmKszE1U6g0r+RM6x6EB88Yi4IeraxHRNE3Dvkk7TlpLZhl0Sj0AjQZRJ4fdnlaoZFChZ4+7sR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609051; c=relaxed/simple;
	bh=Q1mpSCTG654r0w7ql2ejT8xE3eizhsUmD5BNUQmv4hQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLF2AiJo4GzwJedTwvOMzFaLkr1jEGOxD0C9xjOU0k1aGa7QGLwgNbrUqjMOsBFT2CwliSQCU880XqX3iPyAsIV1UBuFKdf2w/vEgugOLZ7onjXJFw23aAc391RwgqoAr+65FL4uPNcle6qFAJNUgbj49DndCtnlbvYOGlygubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rYPDPRTO; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rYPDPRTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776609033; x=1776868233;
	bh=3atv76sLcV52AAdzO4Ac2tNGwsLxK7EwiNOZghNVc8I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rYPDPRTOPNi8ZeottOcqGYmHhNjOzGQnw9Kr2J4c2f+1ohjftzlr9K7YFYOmSQzsc
	 IXJY57U+fqrmyRRLdSZwmsuaiUbsYdHiArq4fIaAt5eKwbTJPQIvzfr9WqD4W5k9Uv
	 UiTyrZpE13IBJSqL6CVYWbLrU+FYuuvs8tRChtAR7r8VNFh68cTh1rtBco9XpRQiHn
	 bwGX0sDCeO92oeujXC0q8dz3ugYEcansS9yeCW1muJl32Z8qJE/PGuDc0oU0dkmhpz
	 mzjdJoEg/psiQ6H7Aiib1gUDYnYa8w7TL7L4JF6A8gyZRKZaBu8AUICTkaM/ljmFWk
	 jFlaEw3R7uFcA==
Date: Sun, 19 Apr 2026 14:30:26 +0000
To: David Lechner <dlechner@baylibre.com>, Hardik Phalet <hardik.phalet@pm.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
Message-ID: <DHX7C35VKVWO.1J0YIERHIS502@pm.me>
In-Reply-To: <2d966423-52b5-4b8a-a4d1-0edcd93a841b@baylibre.com>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-4-hardik.phalet@pm.me> <736964f9-1e93-47e7-80ca-1a89f239a353@baylibre.com> <DHR32TA81G99.14OO5FKEDU8CB@pm.me> <2d966423-52b5-4b8a-a4d1-0edcd93a841b@baylibre.com>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: a1c02fe2284ab6a62d3546f796002a7a07f0b6cb
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 13, 2026 at 12:22 AM IST, David Lechner wrote:
> On 4/12/26 4:54 AM, Hardik Phalet wrote:
>> On Sat Apr 11, 2026 at 1:32 AM IST, David Lechner wrote:
>>> On 4/9/26 4:07 PM, Hardik Phalet wrote:
>>>
>>> This is a little bit much to review all in one patch. Could be nice
>>> to split out power management to a separate patch.
>>>
>
> ...
>
>>>> +static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_s=
how,
>>>> +=09=09       downsampling_ratio_store, 0);
>>>> +static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");
>>>
>>> As mentioned in the cover letter, we'd like to know more about what
>>> this actually does. If there is a good reason it doesn't fit with
>>> any existing filter attribute, then we'll need a patch to document
>>> the sysfs ABI as well.
>>>
>> In the device datasheet, OSR2("Down sampling ratio") is mentioned like t=
his:
>> "Another filter is added for better noise performance; the depth can be
>> adjusted through OSR2". OSR2's defintion is called "down sampling ratio"
>> in a table. Nowhere else. I didn't know what attribute to map it to in
>> this case.
>>
> I wonder if there is an application note or something that explains it
> in more detail if the datasheet does not.
>
I could not find any mention of it, in an application note or otherwise.
I cannot confirm what this does, unless I get an oscilloscope and figure
it out.

> We could always omit the feature if no one knows what it actually does.
Yes that's what I am planning to do.

Regards,
Hardik

