Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0A1A0BF1
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968644; cv=none; b=TlrqSPTeMhZ/N00qzcUsxXQAc+hVey3Q6aiDYtMce+mVtIGMMDfQ5+1DFfpwhhbFJFOPE4k/lgJY/IrgnOSzcDz3/SDpQtjCWc9Gh4qvH5Go00IMZT/3Mj9VhzwxNBCpWx1g/P7Gnn9Y4M2iavjjP7LUhe4PiAEV5FfRvNyhr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968644; c=relaxed/simple;
	bh=+GFyEruLPpVHhivtOE/9dTjxf+78VADPZmw++4Vb7LY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+bt5Ssqu6Mzay15abOoBuiogFpw7QJ8JGabB2yx/y8B/3+2vcI+SFOFuy+HoN+tLSqLqVvQEkLsB69ODcbKHCp9uG61Jh9srkv2jHv9ZSScbvoh1WuVEQTh9+wcIPXz/I5Z+LIbZq8ZFr7WLgBBIFG97n4xfeQmrPasMQqvZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kE2KZl1I; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kE2KZl1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789968630; x=1790227830;
	bh=i2wIboFCo+kxs04aAU6+cy0CY230tavUIgMU5s1ifaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kE2KZl1IXAuYSx8USsyxZrbIA3M82psf3fGpdj2RAHJt8si+YKLfsPSCR2KGVeduf
	 cFfSl1Xq694rkdQrEaOIDODL5gJRkjzb1Va+BCbI253DdDAZVD+ozu82O948Sc3uNr
	 57ktxsAHz+mFtgTvvwW9u4cyHFQH4DaA2Kg87c4ZNSRLgoRBialP7RFfMdmuZquV93
	 DsRWJuvWyDLBccb9P8NjoZ6ujBJUSeQUpdYVZSMSZeUtxinlZJC2UYUSHHg64Tiebt
	 WFl5Z6MwCFgfkEYexqnTAzOUQ6sXgqahTVRZRfAzZ6WsVSJ/KN/SdPdQcJ0sTHkw1l
	 gx+3nedQQ7h8A==
X-Pm-Submission-Id: 4hpBdd10M2z1DDrL
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Martin Kepplinger" <martink@posteo.de>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Joshua
 Crofts" <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v9 07/10] iio: accel: mma8452: Add comment block for
 struct mma8452_data
In-Reply-To: <178995195773.928090.4574643769779647971.b4-review@b4>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
	<20260916-mma8452-open-drain-v9-7-0dd24fa2f3d7@geanix.com>
	<x2D4xvt8eFZ96xjrBQ2gs1ndmhubt4vjxF6N8-D-mfGU2v0C_e0onChpvBGSClYhr3BLqmPXsVzNjVKDdy0IfA==@protonmail.internalid>
	<178995195773.928090.4574643769779647971.b4-review@b4>
Date: Mon, 21 Sep 2026 07:30:28 +0200
Message-ID: <87fqz39nnv.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

>> The struct mma8452_data is central for this driver, and it makes sense to
>> have a description of the fields in it to make it easier to work with the
>> driver.
>>
>> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index b70bc8638128..223bef4f7baf 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -104,6 +104,21 @@
>>
>>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>>
>> +/**
>> + * struct mma8452_data - IIO device private data structure
>> + * @client:			the I2C client object
>> + * @lock:			mutex for synchronziation of register
>
> From sashiko.
> [Severity: Low]
> This isn't a bug, but there's a typo here (synchronziation).
> -
> If nothing else shows up I'll fix it up whilst applying.

I will fix it in v10.

/Esben
