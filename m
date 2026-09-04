Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1B4A0F18;
	Fri,  4 Sep 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529279; cv=none; b=dnKNbx27Nu+z7HyJ10gARld2W7IRk+wC+pgC55hdUXtRXkD2lxP4Hcu3VZh778fVzimisRtl5YIsw+FeLNFO5HmzMH6qyzft4OdNn6QKs/5lTPc0TbUJvbfHiZmyfvIAXTlEQJdrwYNlwgeKHX7WkNPFES8XU0QZJzhjkZWK2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529279; c=relaxed/simple;
	bh=QO5N2bP8ynZ2l1v0v8IZ893CXSp/KPjsppZ1r7sOMvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuvBv4Kg7DBBr+3AYY5LteuqrNARL7sNyUs5yeX+FnSGFJlFLZQ7SCdyOLauA+7Gjqcp4srQgkYC2uJw9lvc8DXgeFKq40XqcdZqaoSmowr3xBAkcQQeykH9jvIsDUbwYjimQKWQ8hPlLDJmSfImvLbvof3Qro1zSVbuM2oBwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OPltaXvb; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OPltaXvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788529267; x=1788788467;
	bh=zsIXEeGBHFwCz9O/oHeclAwiZwEmnq/a53wYEa7YW9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OPltaXvbuzorf3mDtIojDIC8ALD/7Zw2mY3l1ZST3NEZymgfOuc29dnG+mu4oUC6a
	 dTfnJbPSvvDuGDg4t/0RJgu7GNMimkbiuxB4K0M+eEaVXQxfL2YZiNWVTdG84jIjss
	 AvPEV4fa0DmhK/nFFwq5ZUEVkdC5cCaOC1H75bW9tm1K8DC5gWF3NdpQBlGfoS7C9Q
	 pVKnAMjNi1y8NCD6cO+ZlXFFqtVfZiOPfF3GPWHEkvmD9fmGI1lINfID9stv/8mVNs
	 Y/sbds0Ua7hOrG7gsizHnu9ljuDTQnwB5FmHWvlhENj9KrlLzucsW+jumHfZWv1y5P
	 tD7zEIRtuPNrw==
X-Pm-Submission-Id: 4hbyKW62Lcz2ScWx
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,  "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/8] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <apZ7DpgQM6v7JbcS@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
	<20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
	<Ncm871ICTmFO0dGlJCPws8DbZwRNawMZGh74FyRieKxOU9C35zNksyV7FWkx97CU50ky9hYms5spg6SF8rATTQ==@protonmail.internalid>
	<apWIJfGoQLtDV4IB@ashevche-desk.local> <87ik4quwhh.fsf@geanix.com>
	<iOBKNhmGPe-qxpTX1UaGjD9wTq1PSJNB24YR3JoTAWeI4zgdhjHM2donldVRgjCbQPYHw0u8zuzvhlr2k-8JWw==@protonmail.internalid>
	<apZ7DpgQM6v7JbcS@ashevche-desk.local>
Date: Fri, 04 Sep 2026 15:41:02 +0200
Message-ID: <8733vpcexd.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Mon, Aug 31, 2026 at 05:43:06PM +0200, Esben Haabendal wrote:
>> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > On Mon, Aug 31, 2026 at 02:17:07PM +0200, Esben Haabendal wrote:
>
> ...
>
>> >> +	WRITE_ONCE(data->suspended, false);
>> >> +
>> >>  	ret = mma8452_active(data);
>> >>  	if (ret < 0)
>> >>  		goto runtime_resume_failed;
>> >
>> >>  	return 0;
>> >>
>> >>  runtime_resume_failed:
>> >> +	WRITE_ONCE(data->suspended, true);
>> >>  	regulator_disable(data->vddio_reg);
>> >>  	regulator_disable(data->vdd_reg);
>> >
>> > But with this, what's the point in having WRITE_ONCE()? It can be read
>> > just in the middle as true and be immediately changed afterwards. It
>> > may be that I am missing something, but I think WRITE_ONCE() should be
>> > done once in this function.
>>
>> Yes, there does look like there is still a race condition after adding
>> this data->suspended flag. An irq handler could just have read
>> data->suspended, gotten false, and thereafter proceeeded with handling
>> the irq, and then we write data->suspended=true and the irq handler
>> would just continue with accessing the device, even though we are now
>> (if possible) powering down the device.
>>
>> I did go through all the pre-existing runtime pm and other race
>> condition issues raised by sashiko-bot during this review, and worked
>> through it all. The result is a quite a bit larger than what I would
>> like to add on top of this series. Among other things, it converts the
>> driver to use regmap for accessing the i2c registers, and after various
>> fixes the data->suspended flag is removed again.
>>
>> So I am a bit hesitant to pull all those changes into this series, the
>> combined series would blow up quite a bit. But if required, I guess I
>> can do that, although I fear that it will not make reviewing easier to
>> mix things more than maybe needed.
>
> Personally I would go with it, or as a compromise, publish somewhere in Git
> (like on GitHub) and share the link to the repo (in a format that one can run
> with `git fetch ...`).

Ok. Let me bite the bullet, and try to rebase the part of the next
series that relates to the data->suspended.

I will try and send a new version to this series with the minimal
changes to get rid the data->suspended handling, so we can avoid
introducing it just to throw it away the next day.

>> Could we find a way to merge this series first in some way, or should I
>> post a new version with all the other fixes added on top?
>
> It's a Q to Jonathan.

/Esben
