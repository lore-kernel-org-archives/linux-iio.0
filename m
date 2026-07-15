Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362522BE65F
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122470; cv=none; b=PoN+2k/RzDsHnrzTy0TG3jMH8ujMTLOSnAbc57dESoH/fAqOEZGd29OF73SendYco6qNX6BgG/5ppV9DnIsF4EEqRkL/AW5ccjfu1rm/rRf5USD+oVYqDOp7lSqf1487lfbC4qs0z2RZdFcv5wvYZUm77SkWS+ku42UnwT27Hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122470; c=relaxed/simple;
	bh=EH95bEevB45vxfH2KqHvjnVJ226QdA1HvBdpeO/qbwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=goQSJSacmw29brSzNRJPOzbfZF/1a4B9KhD8tyc0S1ldj+PBvRre3lTv25y3YJIsbYlJBBh6IufQsY9ukGLf23srwO0KkGQMM0mw27UHYBLKAQX7xstkhPyA/hqtp+JoE68WxCmcEp/xpNdD2veHwpafFi686cB2VGoSuqmGuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kr+XCncP; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kr+XCncP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784122465; x=1784381665;
	bh=echToQREUj3vG9DGTBHTEImDNDMRsG75DxT+FmAyuVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kr+XCncPbRXLzNteWA0HsFtZg+sLXFrZHVJ0eKi/guUuYzvp621RDZAgPjSz9Fdrx
	 4SEQ3gxt4CrBlzihTyfs4uZSAOjBKtYeoou/RyH6/gtnrE4bDHg4oUH8NzHwB95XD0
	 UY+ZQPY67n1HbS8pTjA0INAwVyhV+nECf9oj/uLpI6H7TiDQeJ5N06TZqiPwoJdE5A
	 SF0lBtG/GFDhJ+eNyMZ3KZ2rtvaSV17Dp+cuNiiR/bynzyi6pJcMPniR6Ab4uUTe8x
	 DrroX1CzyDtiypONcXMF1IIw9WbZU+WgiTn+YPt1VipxojbIDOdqTyAHhJHKe12Lcg
	 Y6SHqKyIbiLJw==
X-Pm-Submission-Id: 4h0cbK44JCz1DDp8
From: Esben Haabendal <esben@geanix.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>,  "Jonathan Cameron"
 <jic23@kernel.org>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Nikita Travkin" <nikita@trvn.ru>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: light: ltr501: Add ltr329 support
In-Reply-To: <4bn5dd27ie653f5324pluaoamua4bxdbmxm47rif4yumxxl5un@anbjqozl6ovj>
	("Nuno =?utf-8?Q?S=C3=A1=22's?= message of "Wed, 15 Jul 2026 15:17:33
 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715145546.00005bc8@gmail.com>
	<ogdkxj4ZPDLgQIc_jewPR02n-ZectyMClJB4lA4rGII_4X8v_0xYewFp4giLg9iKesMQBgcKIUVYCLjFnzY9yA==@protonmail.internalid>
	<4bn5dd27ie653f5324pluaoamua4bxdbmxm47rif4yumxxl5un@anbjqozl6ovj>
Date: Wed, 15 Jul 2026 15:34:20 +0200
Message-ID: <87pl0oml5v.fsf@geanix.com>
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

> On Wed, Jul 15, 2026 at 02:55:46PM +0200, Joshua Crofts wrote:
>> On Wed, 15 Jul 2026 14:27:22 +0200
>> Esben Haabendal <esben@geanix.com> wrote:
>>
>> > The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except =
for
>> > interrupt support and related registers, which LTR-329ALS-01 does not =
have.
>> >
>> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>> > ---
>> > Changes in v2:
>> > - Fixed error handling when irq is defined for a chip that does not su=
pport
>> >   irq, powering the chip down again.
>> > - Added simlar fix to error handling of devm_request_threaded_irq() er=
ror
>> >   handling, powering the chip down again on failure.
>> > - Added explicit #include <linux/array_size.h>.
>> > - Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f=
027051594@geanix.com
>> >
>>
>> Quick process thing, please wait at least 24 hours before sending
>> a new version - let it sit on the mailing list so other reviewers
>> can send feedback! Larger series should wait a couple of days.
>
> Yeah, as a nice rule of thumb at least a couple of days.

Fair enough.

/Esben
