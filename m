Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC8377AB9
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115352; cv=none; b=FyIBIo0pNdb7p7JlzzBI5ZfLIPKd04jfLOBwQbRt0ZHj5hWkvlw5V93jQExrd4OvnBk6qRJvB6DpR54AtJRW1kwIs7ROm4UEFJ6/MCeIQ+rI0JKUjcBieTtaRgCBYkQC9Q1iwaz3lhOI4MlQEJmAbaSne31uL7VsSmaWWrnNdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115352; c=relaxed/simple;
	bh=yT4MVaeHQyVB9n7HPL6AfqF1C+RpXIhVO9zZ6Cm40H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rPGhMmZt2fNt6jxFybKcWyBem06Lq35ZlwazRQmD1GlaEoNyF648uZrGoAnUxL/AbxmQ2cvnroJ9zPHIFYl29WVk0DZsLyjmfSr5LsuhmK5lR3/VLRP9yoRhlHAAvabrokJCMcEHLppcgDI9bGdmTRCZU7wA3m0BJVPWRpw3Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WivdqmVR; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WivdqmVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784115345; x=1784374545;
	bh=vw3eiTKMHGN7k4PMh36M/r9ybREuXYjf2b40KXBhK/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WivdqmVRvHFbAn38DXpzLC7sX7CWeBTekytpnuzBvc00Q+iguxkcgzbnlWgef+vu+
	 bglbMc7zXb0CplLO1OHgPO+WCD8G56S/pQYnT6kxIIfetJ6lvxXp0lMIdZdmX9wg91
	 QgbVkacaMfxnjTa2HO5U7eL1TVAXU1uuMn9sPArmOn8W8eNoi5PECZydtaQuYDvBgG
	 yqN7JcUMtLpeCx6Zjla7CLOM59JKB9Qvxn67LmNdQbp59X4iDz/MGTjZy6IB2eA4v6
	 IxWDiwfXX2Kl8WhHSjugZFwkuEJmYvW+viWkEBWyNZE+nxnmzklp7vJeRBU4C/Ejso
	 npXDT1LBpg3QQ==
X-Pm-Submission-Id: 4h0YyQ5SdGz1DDL5
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
In-Reply-To: <aldH3vtk_eKh6oCC@ashevche-desk.local> (Andy Shevchenko's message
	of "Wed, 15 Jul 2026 11:42:06 +0300")
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
	<20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
	<cA7m1VgJxkr39GAxpnMPw9PVIKX2TR8Ju4Q0m6L2SxS_jJNITfZ6AA5LOeMIK0jGFXaUptY1_vPhDd_imWw5FQ==@protonmail.internalid>
	<aldH3vtk_eKh6oCC@ashevche-desk.local>
Date: Wed, 15 Jul 2026 13:35:41 +0200
Message-ID: <87ldbco582.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:
>> When sharing interrupt line with other chips, the interrupt pin most
>> likely needs to be configured in open-drain mode instead of push-pull.
>> If this is needed, you must add drive-open-drain property to the
>> device-tree.
>
> ...
>
>>  	if (client->irq) {
>>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
>> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
>> +					   data->open_drain ? IRQF_SHARED : 0,
>>  					   client->name, indio_dev);
>
> Why do we care?

Care about what exactly?

We need to add IRQF_SHARED flag in order to allow shared interrupt, and
we should not add it when using (the default) push-pull mode.

> The (hidden) problem this will have in the future is that the IRQ core
> will splat a warning in case that other shared IRQs might be
> configured with different flags. Putting that flag conditionally makes
> it a mine field for the users. Instead just unconditionally add that
> flag and we will get reports as soon as there will be a user that
> shares the same interrupt pin with some other devices which drivers do
> not use the same settings.

If we add the IRQF_SHARED flag unconditionally, it will be set also when
push-pull mode is enabled. I don't see how the kernel will be able to
notice that that is not going to work. If you have another device that
uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with the
MMA8452 device when configured as push-pull.

> Also setting to _LOW in the flags unconditionally is a (historic) bug.
> The problem is that we might not fix it without breaking the existing
> users which omit that flag in DT.

Ok. So let's leave that as is for now.

/Esben
