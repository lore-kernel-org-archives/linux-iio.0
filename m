Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77392283FD4
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122316; cv=none; b=LGHgi+wv8V8QMcrk+e5EXRWmlu0MXUCnHQaS9JtDYtZnqjbclWI/BLu8hfxwXCc5xpZJdvEMMwgZL9AfN2Ty3lVVMzCYEeYCPVb8jtv+fgNsogYAas8LKPlceZOKxolwGOT32YTULVBo+auPio/Ye07VckbTRIb0bPrAtJJtgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122316; c=relaxed/simple;
	bh=k7RxD1XoKKrcGiLwIJKxp8oxoxgaidTPAPEq4JledNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbEsDs0Z2zz6MtTawkbMNfqisxTdaFOnr8KmEXlr+d5qUburzRhukj6gRAow69bp9RWeQu9qIDYLlhUaVT6NrTLjZML3b6BPl7JPsEX/vxYFIIC0IiPTaUnOQxWbr/axpzhpC+UhG+Q4hZt+R07A/sD4PJijSWIppuhCMuiTP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=D3KKTgnL; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="D3KKTgnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784122301; x=1784381501;
	bh=wBDrmfjI/WVFFvGBidBnCgOcmiAxpk8y3+epcKcAyj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D3KKTgnLO219nT5sBY44ffIlFP4kMDOwor+Ug3iH/oUw1WSNMXkS/jpI5bfQM9uB4
	 bsNleeRCTvLxx7xFM3ftqIaYyBUtXimF7KXYiZNuqYQhgKZwUyZ9nDMifhK4RitRx5
	 fxCy21B7kW1oqGicZAPCg4pb+qy4/RLbuQGkwqTXIttKTVMNlu35N3mcIUPvW634NT
	 o0oLuh53W5tJEH0kJbnvWNyJNW4W7UQx8XguoLL5mpYN83U9I1NHA1WpEnPMH1Kiyr
	 L3k6M5dV/7aO9RmX+OhtLvgkT/Z8cUT6rc5jgqo/Dm693OMZHaYH/BKyHfsrNe3wal
	 EXkIqSr1b9uqA==
X-Pm-Submission-Id: 4h0cXB2spxz1DDLJ
From: Esben Haabendal <esben@geanix.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
In-Reply-To: <7yhbsguvuodmgpmhb6dgnuxfede4x6x3ducrifymcmqlb5vl4u@rgrjqovq2ife>
	("Nuno =?utf-8?Q?S=C3=A1=22's?= message of "Wed, 15 Jul 2026 15:01:32
 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
	<YNVq2JyJ5AetAiMbwvpiwKO3WN2vtf-sdCy966IwnP92DxD3jwbHgUB_oTX0cWTJIEcSaY9IVHKeTgfbV3upFQ==@protonmail.internalid>
	<7yhbsguvuodmgpmhb6dgnuxfede4x6x3ducrifymcmqlb5vl4u@rgrjqovq2ife>
Date: Wed, 15 Jul 2026 15:31:37 +0200
Message-ID: <87y0fcmlae.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> On Wed, Jul 15, 2026 at 02:27:26PM +0200, Esben Haabendal wrote:
>> In case request irq failed, we were leaving the chip powered instead of
>> powering it down again.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/light/ltr501.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 379e57ac5f5b..9d4de798e5ab 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -1571,7 +1571,7 @@ static int ltr501_probe(struct i2c_client *client)
>>  		if (ret) {
>>  			dev_err(&client->dev, "request irq (%d) failed\n",
>>  				client->irq);
>> -			return ret;
>> +			goto powerdown_on_error;
>
> This looks like a fix so we should have a Fixes: tag. And being it a fix
> it should be the first patch in the series (can come after bindings
> though). Reason is for backports.

Sure.

/Esben
