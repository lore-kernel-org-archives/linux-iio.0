Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC737755C;
	Mon, 10 Aug 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342382; cv=none; b=AaAgkzb12bfrnYs25fpqtEQ/g4aadvK7difETwS+cLJFajzl+LTl2UUMG2jI42Ulkq2jIgb2+uRTIiakwr56wZyfJLKZfW2mM56DcQFdoXBNAMGq420fvxoK4pkQYwgsccvF5sLFZfU3n4TgpxZPFc1Vn8twXffI0asGray8fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342382; c=relaxed/simple;
	bh=CwW6ScBIP2J9LWr7PGc32sTjikDE/ThWJJluJfVbCEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+KFbAN2RaJ5NoGgeTPaJn7jH96eVT0Xj23UhGz4sljCTH++3MymIkdn0GLAJwHfzHEIw5wzXOTXYpYA7xBBC9QCTJjfOxLe0bFeohYwdlTvMVuNvZvG5KXGtSwrM0csFbuQ5gzuBhGP9WILKW57L/bPmrhWFOJZLbPh8UdJHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=nhwbUtVP; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="nhwbUtVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786342375; x=1786601575;
	bh=Kun+h4Wgp+wGjAsNv1VA2EXesd4wkQB+P0cixH8JeTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nhwbUtVPFTXusrZ/bibNoBQyEq9NO2AnIcc+DM+hAiDD17hBK17lQ3Hp7I1fxje/j
	 kUjB9LgoXOXZjaGkZ0ELubkX+taBIlH12juzm16dhQbpaibH2JvJ/AqWzLbVWu7wFE
	 Ghad1gvxbH4lewdmp0yi4VevkZh5FJriUOT+ji0wotaWB77mUN02IdbaEb/j+MY/Jf
	 ZY/JI2CP23XEH5AZculKG1lrL0bUrvOJIVV/2rSupiJWjvCjghAiUA1rn6nwxv0y+5
	 xustZbk3geeBOesCzg0Las+b6utWfL5+MxgmkuKmSMXzSnVfyiXbiGFhStHwIIaIyV
	 f6gDh8icnBmJg==
X-Pm-Submission-Id: 4hJPYw1Zm9z1DDrb
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] iio: light: ltr501: Fix sorting order of device
 arrays
In-Reply-To: <anePwmLumk4k8l9e@ashevche-desk.local> (Andy Shevchenko's message
	of "Sat, 08 Aug 2026 23:21:22 +0300")
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
	<20260804-liteon-ltr329-v3-6-c6b768c7c745@geanix.com>
	<XtotGdyhZvQIq-19qWwYJ2t9CGaZ4kcJXvUUcRmfXmC7YVRVj4wVkAttk_2tgzsuymMdFgL7wMAWYgvA8RFcuA==@protonmail.internalid>
	<anT_KYZjkX2Tcnqu@ashevche-desk.local> <87ecgaxt0i.fsf@geanix.com>
	<d2kQjxNMVxr0OuTOEdUL5wGY1EJy6pgRfFwA2E4x7MN8qhB6GexgZnzm7onWALWE4IkhI2JiKkCt7Oia4Xqhyw==@protonmail.internalid>
	<anePwmLumk4k8l9e@ashevche-desk.local>
Date: Mon, 10 Aug 2026 08:12:51 +0200
Message-ID: <87a4quy04c.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Fri, Aug 07, 2026 at 09:57:17AM +0200, Esben Haabendal wrote:
>> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > On Tue, Aug 04, 2026 at 07:02:17PM +0200, Esben Haabendal wrote:
>
> ...
>
>> >>  enum {
>> >> -	ltr501 = 0,
>> >> -	ltr559,
>> >> -	ltr301,
>> >
>> >> +	ltr301 = 0,
>> >
>> > Is the 0 required? Why?
>>
>> As for the code produced, it should not make any difference.
>>
>> I assume it was put here for improved code readability, and I did not
>> see any reason to change that.
>>
>> I don't care about it myself, so will be happy to remove it if that is
>> the preferred style now.
>
> It's not about the style, it's about understanding the C language.
> As per style, we have only one requirement in IIO, if the value is used
> in communication with HW (part of protocol or a bitfield) *all* enum
> values must be explicitly assigned, otherwise (Linux only case) none
> (with, of course some exceptions, which are not the case here).

Ok. I will amend the patch with this change, so that we get rid of this
unneeded and unwanted assignment.

>> >>  	ltr303,
>> >>  	ltr329,
>> >> +	ltr501,
>> >> +	ltr559,
>> >>  };

/Esben
