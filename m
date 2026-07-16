Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F72EEE9C;
	Thu, 16 Jul 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199346; cv=none; b=eoNFnVB8rG6CKs40Qn7QilvrPhWSJElkL0nLSeWBPwvLJatzqGAgDbVaSlXVvvtaYH4FyWIk8+A6m3vyPlKgd+ESmEk2aYDhWWq7q5Ea/CEyFN78o/f92LmM2wJdquuXQcw8UX33NvtChZdxN/0wqjEzrWlypgu1vbRWB9lqFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199346; c=relaxed/simple;
	bh=O9lLRvJ/wjIB0DYv9S6+NqKhCxo+SrIThkz2G4CTw9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=qsDJYK4/qNbgP3iAYfKZl6k+tQy5TV+uMx1FahgIz5RMmkQ9uO7QaoFUm8ExHkusC827zV3rYbuxb3ZuvzDc6iM7CZsLcFL1UiNnnqe8jhxf9rJvkBObvBd4IbiXUnznJiFD+Covtb3jjER5EyKRYptsXt/ycXslgoVIYTB9PA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 6AE6A2AA;
	Thu, 16 Jul 2026 12:55:38 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 12:55:37 +0200
Message-Id: <DJZXVOGZ3ZTH.20P8NY7DON0X7@kernel.org>
Cc: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <Michael.Hennerich@analog.com>,
 <afaerber@suse.com>, <andy@kernel.org>, <brgl@kernel.org>,
 <conor+dt@kernel.org>, <cy.huang@realtek.com>,
 <devicetree@vger.kernel.org>, <dlechner@baylibre.com>,
 <james.tai@realtek.com>, <jic23@kernel.org>, <krzk+dt@kernel.org>,
 <lars@metafoo.de>, <linus.walleij@linaro.org>, <linusw@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-realtek-soc@lists.infradead.org>,
 <mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <stanley_chang@realtek.com>, <tychang@realtek.com>,
 <wbg@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
X-Mailer: aerc 0.20.0
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
In-Reply-To: <alim_HGTD5RCupav@ashevche-desk.local>

On Thu Jul 16, 2026 at 11:40 AM CEST, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 11:08:55AM +0200, Michael Walle wrote:
>> On Thu Jul 16, 2026 at 10:27 AM CEST, Andy Shevchenko wrote:
>> > On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:
>
> ...
>
>> > From the above list I tend to the approach 2, but this might require t=
o have
>> > GPIO regmap level of locking. I'm a bit lost in the context, though. I=
 assume
>> > we need a fresh start, id est issue a v6 with approach 2 or 3 in place=
 and
>> > summarize the choices in the cover letter, so we can understand what h=
as been
>> > considered.
>>=20
>> I don't really like approach 3. You'd need to check if the regs of
>> both xlate calls are the same. With the sample code above, you
>> silently drop the first xlate'd reg.
>
> If I rank the proposals, the worst is #1, the best is #2.
>
>> And honestly, it really seems like a one-off. What controllers, are
>> there that need a write enable bit. The real problem seems to be
>> the assumption that we operate on just one bit. IOW we either set
>> mask or don't set mask in gpio_regmap_set().
>
> Yes, we should KISS.

But IMHO #2 and #3 are not KISS. Approach 2 is just a way of adding
some kind of pre op to a gpio set. Just tying it to a write enable
feature. That kinda bothers me. It might also be useful for other
things, too. So don't tie it to just write enable. And who is doing
a write disable if it's not self clearing for example. Probably Some
kind of post op :)

Approach 3 is a way to change the value of the written value - in
a restricted way, as is is just doing a OR with both values.

Also approach 2 might not even work if the hardware requires the
write enable bit set in the *same* write as the gpio set bit. Thus,
we might need both anyway in the future.

>> For a more generic solution, we should be able to control the
>> written value. We could add another .value_xlate().
>
> Maybe not now?

But if not now, then when? I wouldn't add the write enable feature
and later a more generic solution which also covers the write enable
feature.

> As per IPs, Synopsys IPs (not exactly GPIO) likes to
> have that kind of "protection". So, from HW perspective it's kinda
> pattern, and it might be possible to see more IPs (including GPIO)
> that follow it in some cases.

-michael
