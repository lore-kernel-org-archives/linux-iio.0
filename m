Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2D8287E;
	Sun, 15 Feb 2026 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771184168; cv=none; b=OEZQL0bC2+xnWIrGO3SjS5s5903ZWJi45cluwcuRXcLBoIi4Kc6qiZjkeamHQejS6sLDiaVo6Qb3ykixs2dk4S/DZZrbYoP1KJQS0v83QOCgowY/T0VqKVNjcCHX9KooI83YusuiDt6EWcpg8AvWhvDeye7DMuB8XbKeMRGiAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771184168; c=relaxed/simple;
	bh=QBiV9NdAm4Ymnf+cZF3juzjoLYiPTM6xuHMwfWmGaww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dox4lyzPl5BAPak3tbogfxx0imIfywKnj2H50FryYLZz4Oa3TWds9++n8/MLyAJu1EvHawZgYbhLynL1guXJj1dunNErg3uXabVgvDpM284KF4voITx5hKCEu0WykaCHgiMnVhnkWOwJiuZYgrFtLlnUrCwk6ce7so4wJ/aHSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7fnWKtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7fnWKtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF1BC4CEF7;
	Sun, 15 Feb 2026 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771184167;
	bh=QBiV9NdAm4Ymnf+cZF3juzjoLYiPTM6xuHMwfWmGaww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V7fnWKtvWUldefWbTPngsOwPVd7oK7xP7VULIiKD957xbVnrW4fTGDrSwNJR09hUF
	 LNwcl816/VG4JtDng0UJG+wMX9YXQ7VD+cZTiB2iQdyG6fguRSGS1hFJZmzvFVA18l
	 Dq6a8JCHtoxMTT5yJN0Le+8WKTZHOhwgqyzrPr8J/7wgxVfIdstmqVP9TgrMggbx+v
	 6ek6eH+Uu47Ft0PdHGhzUtOROccuab8bDedO88Q1hpOXQZdKSeK2X9EPNOugit6+0/
	 ZJkmK8dTmMuq18AW0fYs7mMkkxY0qV5NmJFSJkBeJu38kRwsQEWcHJqh/WYDhoECsG
	 AcJ7xrit+cEFg==
Date: Sun, 15 Feb 2026 19:35:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <20260215193557.1ddd2adf@jic23-huawei>
In-Reply-To: <eea4cf8c-4126-49a8-ada8-1b1893a406c2@gmail.com>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
	<20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
	<20260213-unyielding-pistachio-ape-deda74@quoll>
	<3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
	<8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
	<f014078c-6e4d-48b0-a814-45898b005c44@gmail.com>
	<880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
	<eea4cf8c-4126-49a8-ada8-1b1893a406c2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 18:16:45 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> On 2/14/26 6:44 PM, David Lechner wrote:
> > On 2/13/26 2:56 AM, Erikas Bitovtas wrote:  
> >>
> >>
> >> On 2/13/26 10:51 AM, Krzysztof Kozlowski wrote:  
> >>> On 13/02/2026 09:29, Erikas Bitovtas wrote:  
> >>>>>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> >>>>>> ---
> >>>>>>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
> >>>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>>> index 4d1a225e8868..2ba4d5de4ec4 100644
> >>>>>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>>> @@ -18,12 +18,17 @@ allOf:
> >>>>>>  
> >>>>>>  properties:
> >>>>>>    compatible:
> >>>>>> -    enum:
> >>>>>> -      - vishay,vcnl4000
> >>>>>> -      - vishay,vcnl4010
> >>>>>> -      - vishay,vcnl4020
> >>>>>> -      - vishay,vcnl4040
> >>>>>> -      - vishay,vcnl4200
> >>>>>> +    oneOf:
> >>>>>> +      - enum:
> >>>>>> +          - capella,cm36672p  
> >>>>>
> >>>>> CM36672P is compatible with CM36686, but this is not expressed.
> >>>>> Confusing commit msg and code.   
> >>>>
> >>>> For CM36672P we create a dedicated compatible because it is a
> >>>> proximity-only sensor which has the same proximity sensor configuration,
> >>>> but ambient light sensor registers are missing (reserved).  
> >>>
> >>> I don't understand this. You just wrote "fully compatible with CM36686"
> >>> and now you imply that not.
> >>>
> >>> Decide.
> >>>  
> >> It is not. CM36672P supports only a subset of CM36686 features, in
> >> particular the proximity sensor. That is what I meant initially.
> >> I am sorry if the previous phrasing caused any confusion.  
> > 
> > But CM36686 is fully compatible with CM36672P, right?
> > 
> > So this would make sense?
> > 
> >       - items:
> >           - const: capella,cm36686
> >           - const: vishay,vcnl4040
> >           - const: capella,cm36686p
> > 
> >   
> If you try to use CM36686 compatible for CM36672P, proximity channels
> will work, but in_illuminance_raw will return 0 and changing illuminance
> parameters will have no effect. 

Look at the ordering above.  The key I think is it's not saying the cm36672p can
fallback to the cm36686, but the other way around.

If that fallback was used (because we'd actually had the driver evolve in
a different order and older versions only supported the cm36672p) then we'd
see a proximity only device presented with the ambient light parts hidden
away. 

> That is because CM36672P is a proximity
> sensor only and the register fields for ambient light are reserved.
> And if you try to use CM36672P compatible with CM36686, it will work,
> but only proximity channel will be available, even though CM36686 also
> can sense light.
Understood.  So in one direction it is correctly considered backwards compatible
but not the other way round.  The ambient light can be thought of as 'value add'
new features on a 'newer' device (obviously that's not actually the case but
it's an easier way to think about how fallback compatibles are often used).

Jonathan

> 

