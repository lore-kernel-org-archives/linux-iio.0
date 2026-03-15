Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C74371D01;
	Sun, 15 Mar 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609903; cv=none; b=M0u+eicY0RHbioSl5bfnmysTyZD4b+/mzd91TkxsoISjm+tRcTcVvPg2gAl431M7isAWIBTWpo8EEIRVv9JaDPC+3ZU62ZvFZj8xDQaJSED5Ji4X8OYwyfGEaq+gTIwn4GjT8MWnkmSySHttEXaPf4PhF8j4FL3EZ+C3ujrgvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609903; c=relaxed/simple;
	bh=NG9/BsFQD9fSdaKlgTgR0n8gl/bSvJoKMyv+VsMHC1c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hm5aExh5TjprhWzXtyae2ambbK1OyNe9DpEy5DLoxtC5cX2YJBImZzKh00B5JrOAZli995YatRhlADVh7rna7Gx0UaixZ+jUt/F7GgEE+QaVN06a281SeMbUe25o+vn03c1e2xMkWa6CxaPGPUt39BgYid4D1aNqItYsHXDsZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; dkim=pass (2048-bit key) header.d=jic23.retrosnub.co.uk header.i=@jic23.retrosnub.co.uk header.b=5OlrNzX5; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jic23.retrosnub.co.uk header.i=@jic23.retrosnub.co.uk header.b="5OlrNzX5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=jic23.retrosnub.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=d0bhAwjEo/QnWswJsthoj3+V9ClSGQBFouScMgZDBs8=; b=5OlrNzX5lTzK8WOqaaBfwp3eEb
	gSvMbziqU5KM1gqJNKPQUT9Ub9O77fi2+sRCOLQPxygkQ64ZlUByNdx99RhP4XRyPzLlwK78y3BXw
	qSy10OEGSorEwZmVkCa5vwKYkcOkhi0Ut6aRctEZp60WOhxuEGhWNMjPta+MRp6lISEY5U+ZD/4xH
	YcbwpkSVMXMdm/X5V2KKXW2bHWAShkGxE/sOb+/y821foi86kkLIX18xX/ueWIEZV8arTGvCSjJS4
	u9fBrXuikIGNsONVI2kDHdXfI3QTv8VQYuZc1OqC4rlet9XXzv2YwPNcz/JoQuxPRmmm5V36fyQ+J
	2T2XwOSQ==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1w1sx3-000ck4-2Y;
	Sun, 15 Mar 2026 21:24:46 +0000
Date: Sun, 15 Mar 2026 21:24:18 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_5/6=5D_iio=3A_light=3A_vcnl4000=3A_?=
 =?US-ASCII?Q?remove_error_messages_for_trigger_and_irq?=
User-Agent: K-9 Mail for Android
In-Reply-To: <706a349f-63e5-4f47-9f77-c84db1058f5e@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com> <20260314-vcnl4000-regulators-v3-5-3c4a48d30676@gmail.com> <20260315183127.59036e25@jic23-huawei> <706a349f-63e5-4f47-9f77-c84db1058f5e@gmail.com>
Message-ID: <8D6D8F40-2B7E-46C6-8A24-15717CB70ADD@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 25



On March 15, 2026 7:15:51 PM GMT, Erikas Bitovtas <xerikasxx@gmail=2Ecom> =
wrote:
>
>
>On 3/15/26 8:31 PM, Jonathan Cameron wrote:
>> On Sat, 14 Mar 2026 18:06:34 +0200
>> Erikas Bitovtas <xerikasxx@gmail=2Ecom> wrote:
>>=20
>>> The error code is available in the log after return=2E Remove duplicat=
e
>>> error messages to reduce noise in dmesg=2E
>>>
>>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail=2Ecom>
>>> ---
>>>  drivers/iio/light/vcnl4000=2Ec | 9 ++-------
>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/vcnl4000=2Ec b/drivers/iio/light/vcnl40=
00=2Ec
>>> index e501db7249d7=2E=2Ec8bb1826b916 100644
>>> --- a/drivers/iio/light/vcnl4000=2Ec
>>> +++ b/drivers/iio/light/vcnl4000=2Ec
>>> @@ -2041,11 +2041,8 @@ static int vcnl4000_probe(struct i2c_client *cl=
ient)
>>>  						      NULL,
>>>  						      data->chip_spec->trig_buffer_func,
>>>  						      data->chip_spec->buffer_setup_ops);
>>> -		if (ret < 0) {
>>> -			dev_err(&client->dev,
>>> -				"unable to setup iio triggered buffer\n");
>>=20
>> Is this one a duplicate? I don't recall us being particular verbose
>> in terms of error messages in iio_triggered_buffer_setup_ext() which is
>> where that ends up coming from=2E  I think there is only one path
>> where it can return anything other than -ENOMEM and that one is a dupli=
cate
>> registration check (so fair to not print)=2E  So perhaps all this patch
>> needs is a comment on what errors can surface from this call and why
>> it is therefore not worth printing anything=2E
>>=20
>
>I do not see anything being printed on iio_triggered_buffer_setup_ext(),
>so I guess this is not a duplicate=2E The function can return -EADDRINUSE
>if a buffer is already assigned, to prevent cleanup function being
>called on a buffer that wasn't allocated=2E
>I will add this print back if necessary in v4=2E
>
I think it is fine to drop the print but more detail on why is needed for =
the commit message=2E
