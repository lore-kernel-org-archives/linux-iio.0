Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B992EBB8D;
	Mon, 31 Aug 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178552; cv=none; b=V8AG2JTIvBON8VMNFzPwvrSnFRI0BvpeHtKapGd8xtjJdUdyKopME6oV91jVegbS4E2lOjrBrpDCE/mxRoYfkjyb7oYK3VSalwnE0UAGcSxCR0F0QK3J+oJMIlRQJ5mBClwkV6TIj2h/6uAENjapzhOsm9Xk0GoNxMs6mfYYeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178552; c=relaxed/simple;
	bh=s1wZ2c0AfDKuRP/bzpxQiB/gvfog8oW6GEL8GwzB2rM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o+XUO+JnNiPq42NCXqvdQA0Bx0YLrGob/k6yfoJ/tz5wqm5+J+NWoVfwbqQidj0tqfQpjj67py9RuHid6Ntd8a3uSSbR0R4Bj1lMnLf+2KG5TdnzZC9Pw+ehlaDe2SbrGzwovB9EKD2qZF2f2I3135Upg1eeijWt8wo2tU0i+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MuDN+f0h; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MuDN+f0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178538; x=1788437738;
	bh=Y4qfHbSelR1W1n0w0pbKPKZgJ5rYbtRV+/lIG9Gq1bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MuDN+f0hRXsgkH7jNOyogDpvno6Q1PvZnDtCoS3H2+RSPheDdtH3DxrJoqtzfBkA7
	 cz0oXM+FoSDprbZ6QWq7jO36FBT5zEqoYuy8CacxOwSjlsX/+aNdFkqTSS4BceadkW
	 UpZqFrgy4UGEtY6pRB82jDTXhY99EtRKpd0tejzV/Qt/X2EjUsJsruR8HJo/Z/tQhd
	 XSr0tev5NvbltfbmNry1kJLoSPkxthsEuuE2C+qYBXa1u1B7T8ExlIxJEWrU4lfXMk
	 lUafGul935RLeGmgxzHbOm/8VryNa74SN/C7SNumbbZE9O2f1c7XHqPdY1EW+Od484
	 q1B2OLTeovUjQ==
X-Pm-Submission-Id: 4hYScm74y6z2SdHS
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,  "Lars-Peter
 Clausen" <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire
 on read
In-Reply-To: <20260831013425.7803ce1c@jic23-huawei> (Jonathan Cameron's
	message of "Mon, 31 Aug 2026 01:34:25 +0100")
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
	<UFc9cC1VeohKw6lxQ8uulsfj9wJ_OqGUgGPTUnTX-zssKZ97aEC0Xi9nsAxv-tcf2DP5e85ElFZ8wPgxwG8l3g==@protonmail.internalid>
	<20260825121704.00004ed3@gmail.com> <87y0dumiga.fsf@geanix.com>
	<2m3zXurwen7GRVSaBnDu6bY31Gn7dFzO2UEoU4bRNxCGCR86DTyGq-CMmmeEh-U7AcCWC6eBjjFbZSGNltSwWg==@protonmail.internalid>
	<20260825154449.00002f6f@gmail.com> <87pkz6mh07.fsf@geanix.com>
	<d7QLXSH9l60wN2wQRLBVJ_hqyARslMkuBvmhXIarJC_4JkmykwA4t0pyBg6OBkyn4_6EVy9-nexfkzl5rZpbHg==@protonmail.internalid>
	<20260831013425.7803ce1c@jic23-huawei>
Date: Mon, 31 Aug 2026 14:15:36 +0200
Message-ID: <87zey2v63b.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Tue, 25 Aug 2026 16:06:32 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> Great. I have created a local mma8452-next branch where I will continue
>> the work on some of these issues.
>
> Great. It is absolutely fine to postpone (or indeed ignore completely) reports
> from sashiko that are on preexisting issues.  That even applies when I point
> them out or suggest maybe you take a look!  I don't mind folk saying
> they are too busy!  I know I am which is why I try to talk others into doing
> this stuff ;)

Good to know, and thanks :)

>> > Nevertheless this is an issue that will be caused directly by this patch if
>> > applied. If your only goal is to add support for open-drain irq sharing, you
>> > can probably just drop this for the time being and just focus on that.
>>
>> I will drop this particular patch for this series, and work on a proper
>> fix for all these race conditions in my mma8452-next branch.
>
> Excellent!
>
> I'll wait on a fresh shorter version of this series then get that queued
> up to give an upstream base for further work.

v7 on its way.

/Esben
