Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD28632A;
	Sun, 15 Feb 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771177752; cv=none; b=D4B9hUt9t3FrV+AdIWR60DOIta/LHsPhgWy4p53ZdHK1Mrvt4GEjduYPZq/gi7OxzWhE+QSZtAQlQT6J2pN49HPRESSr4PAyR+03EIvAzfF9PpCrPQZphNdiUsl4TGx9BP7i7uPdnoh6zk3p0Xn9CRa3hJBqAR7lLHYUOEc1WqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771177752; c=relaxed/simple;
	bh=H6lxOjHPHAE88MtSDG8NKtWRXd9fHQ/QkuZEw2j7BXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljnV7A7kP4dJh2WbL4bwy/vVQEKQ1Sp+M/60XIYJhkJK2RWjy9cfNDZ8LJORZIjp6GYBAS5ccA8aCJx5TavErytFh6bO22I4Dp674VEFf6ZEgcEizGxrvQqH1uDGiy4oDjXGrt5RMilHp2SmeBU3q6jdmPA9p2r0O1urnov39/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFJCJ53N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFJCJ53N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012F9C4CEF7;
	Sun, 15 Feb 2026 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771177752;
	bh=H6lxOjHPHAE88MtSDG8NKtWRXd9fHQ/QkuZEw2j7BXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFJCJ53NxGZZOPkG6h2iz8XGqWDe8HtcrfGoLupbaYEnyBvaQ9B+D1R71+jrQdm/N
	 0wf9/o6i6WyaQYYrWh88EEpLGWoq8evRxk8FDriUscWuMn0yxi/hwUOLY77xEgymAJ
	 GlF5/DIrmAFqadPJ71QHbnNcgQsuPu7LG0htMWqgUWnZl+7E95siDvkdOHGFT5BByw
	 NFa2LfsnZ48QprW2jEkAYFBXNAW1PR5giv5Q8TJSXERYb1vL8+JolpTOOsHl54TgsM
	 NsvB8cZoD4Kast48Yt4ERWu5YAMQ4WPUNXGo84Xh3UqBtIpNMFJJAEhHwFWHtGf3vB
	 4Vg81iMjwgXmQ==
Date: Sun, 15 Feb 2026 17:49:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Erikas Bitovtas <xerikasxx@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <20260215174901.11f6fd6a@jic23-huawei>
In-Reply-To: <880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
	<20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
	<20260213-unyielding-pistachio-ape-deda74@quoll>
	<3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
	<8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
	<f014078c-6e4d-48b0-a814-45898b005c44@gmail.com>
	<880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 10:44:23 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/13/26 2:56 AM, Erikas Bitovtas wrote:
> > 
> > 
> > On 2/13/26 10:51 AM, Krzysztof Kozlowski wrote:  
> >> On 13/02/2026 09:29, Erikas Bitovtas wrote:  
> >>>>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
> >>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>> index 4d1a225e8868..2ba4d5de4ec4 100644
> >>>>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> >>>>> @@ -18,12 +18,17 @@ allOf:
> >>>>>  
> >>>>>  properties:
> >>>>>    compatible:
> >>>>> -    enum:
> >>>>> -      - vishay,vcnl4000
> >>>>> -      - vishay,vcnl4010
> >>>>> -      - vishay,vcnl4020
> >>>>> -      - vishay,vcnl4040
> >>>>> -      - vishay,vcnl4200
> >>>>> +    oneOf:
> >>>>> +      - enum:
> >>>>> +          - capella,cm36672p  
> >>>>
> >>>> CM36672P is compatible with CM36686, but this is not expressed.
> >>>> Confusing commit msg and code.   
> >>>
> >>> For CM36672P we create a dedicated compatible because it is a
> >>> proximity-only sensor which has the same proximity sensor configuration,
> >>> but ambient light sensor registers are missing (reserved).  
> >>
> >> I don't understand this. You just wrote "fully compatible with CM36686"
> >> and now you imply that not.
> >>
> >> Decide.
> >>  
> > It is not. CM36672P supports only a subset of CM36686 features, in
> > particular the proximity sensor. That is what I meant initially.
> > I am sorry if the previous phrasing caused any confusion.  
> 
> But CM36686 is fully compatible with CM36672P, right?

I'd be clear in this discussion that the P version is a subset.
So it's very much one way compatibility (your ordering below reflects
that right)

> 
> So this would make sense?
> 
>       - items:
>           - const: capella,cm36686
>           - const: vishay,vcnl4040
>           - const: capella,cm36686p

I'm not sure we can do that now given we'd also need the option
of vcnl4040 falling back to cm36686p for it to feel logical and
retrofitting fallbacks is a bit odd.

Jonathan



> 
> 

