Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A2347C7;
	Sun, 14 Jun 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444369; cv=none; b=OBp8fjlMvzWfaqQMesrV87wgeBFW4CbV/lkO65moQ4JXoXOepi4IKiboTf8bNNr2fF5lYdGjd6MAAl5YP7TCKwXTp2Va5GENtivdt8nYoZTHgS30TF9mY4Cm6NK+ICT1/brI0uVRZxK+b7D3wWXZmpga9/IQeuw12LOAlFWUqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444369; c=relaxed/simple;
	bh=HpZGGkXYsi3vxXjzZf2W+xqBYI7Wo8mbVvn7zCHuGks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvIqWsI0ViSQwlXSde+jZsYbBMfnoDEqWNKPgjYaDAhbQyq94XQ2xFwKYnwUOMjBR/iXZ9Q6csZJTtgLIozuA6sEBi+tFXWyaThjlFSLfF6gqATylxUfOrc5Kem6Vq2YPEoGqEqwdmW7JFo+m/o1Zbnmia3HYlUKgr2C0wQLo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXMIpy6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXMIpy6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0DF1F000E9;
	Sun, 14 Jun 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781444368;
	bh=j4d1lDnQs76sCGbnk/y4u2KHCdQbl6v6h5JANK8JDl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FXMIpy6DNm8HMIA3gHmxtZeQnSvb1dpMO6g0VpNJI3EshDFePA6EPJ/8xx3sPlra5
	 ZNbppsJTgYi44l/Z+TF4y91UjaOm6unHDL/tL4D3qYbseOfHbTqLT6B+m7ogaJwe8S
	 eZltPeoB/CL+U3yfe9nWZ8XTcpX3o6OYth+AioBZCemqipGgjff7MxOOMT07A21ERz
	 2ZFIMgDsyC8JjZg3xzR/XCVKuJvFV62M+fjJ7hYEln+9BXZsd5SRYT4PVZDhSgh/mE
	 wJ9vKGvtwAukohHM4FMBNBoRq+4EHPu3I0b/FKqR1jgIHLUZZnMhSqx1zc352tSkDb
	 pH60ZYFN5509g==
Date: Sun, 14 Jun 2026 14:39:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
Message-ID: <20260614143918.35503c5a@jic23-huawei>
In-Reply-To: <20260613-sparkling-naughty-tuna-3e9bf1@quoll>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
	<20260612-ads126x-v1-2-894c788d03ed@gmail.com>
	<20260613-sparkling-naughty-tuna-3e9bf1@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +
> > +DEFINE_RUNTIME_DEV_PM_OPS(ads1262_runtime_pm, ads1262_runtime_suspend,
> > +			  ads1262_runtime_resume, NULL);
> > +
> > +static const struct of_device_id ads1262_of_match[] = {
> > +	{ .compatible = "ti,ads1262" },
> > +	{ .compatible = "ti,ads1263" },  
> 
> So devices are fully compatible? Then it should be expressed in the
> binding and drop one entry here.

They aren't. It's relying on one of them having a subnode that spins up an
auxdev for the hardware block they don't share.  A fallback would be fine
but (to the device that has the more minimal feature set). I'd prefer the
driver to have a check on whether the subnode is allowed before blindly
registering it.

Jonathan


> 
> Best regards,
> Krzysztof
> 

